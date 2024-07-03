{*
 * Based on C code of Paulo Soares
 * Port to Pascal by Lin Fan
 *}

{*
 * Copyright 2003 by Paulo Soares.
 *
 * The contents of this file are subject to the Mozilla Public License Version 1.1
 * (the "License"); you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the License.
 *
 * The Original Code is 'pdf417lib, a library to generate the bidimensional barcode PDF417'.
 *
 * The Initial Developer of the Original Code is Paulo Soares. Portions created by
 * the Initial Developer are Copyright (C) 2003 by Paulo Soares.
 * All Rights Reserved.
 *
 * Contributor(s): all the names of the contributors are added in the source code
 * where applicable.
 *
 * Alternatively, the contents of this file may be used under the terms of the
 * LGPL license (the "GNU LIBRARY GENERAL PUBLIC LICENSE"), in which case the
 * provisions of LGPL are applicable instead of those above.  If you wish to
 * allow use of your version of this file only under the terms of the LGPL
 * License and not to allow others to use your version of this file under
 * the MPL, indicate your decision by deleting the provisions above and
 * replace them with the notice and other provisions required by the LGPL.
 * If you do not delete the provisions above, a recipient may use your version
 * of this file under either the MPL or the GNU LIBRARY GENERAL PUBLIC LICENSE.
 *
 * This library is free software; you can redistribute it and/or modify it
 * under the terms of the MPL as stated above or under the terms of the GNU
 * Library General Public License as published by the Free Software Foundation;
 * either version 2 of the License, or any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Library general Public License for more
 * details.
 *
 * If you didn't download this code from the following link, you should check if
 * you aren't using an obsolete version:
 * http://sourceforge.net/projects/pdf417lib
 *}

unit lr_pdf417lib;

{$ifdef fpc}
	{$mode delphi}
{$endif}

interface

uses lr_pdf417libimp, SysUtils;

const
	PDF417_USE_ASPECT_RATIO     = 0;
	PDF417_FIXED_RECTANGLE      = 1;
	PDF417_FIXED_COLUMNS        = 2;
	PDF417_FIXED_ROWS           = 4;
	PDF417_AUTO_ERROR_LEVEL     = 8;
	PDF417_USE_ERROR_LEVEL      = 16;
	PDF417_USE_RAW_CODEWORDS    = 64;
	PDF417_INVERT_BITMAP        = 128;

	PDF417_ERROR_SUCCESS        = 0;
	PDF417_ERROR_TEXT_TOO_BIG   = 1;
	PDF417_ERROR_INVALID_PARAMS = 2;

type
	pPdf417param = ^pdf417param;
	_pdf417param = record
		outBits: PAnsiChar;
		lenBits: Integer;
		bitColumns: Integer;
		codeRows: Integer;
		codeColumns: Integer;
		codewords: array[0..927] of Integer;
		lenCodewords: Integer;
		errorLevel: Integer;
		text: PAnsiChar;
		lenText: Integer;
		options: Integer;
		aspectRatio: Double;
		yHeight: Double;
		error: Integer;
	end;
	pdf417param = _pdf417param;

procedure paintCode(p: pPdf417param);
procedure pdf417init(p: pPdf417param);
procedure pdf417free(p: pPdf417param);

implementation

const
  MIXED_SET = '0123456789&'#13#9',:#-.$/+%*=^';
  PUNCTUATION_SET = ';<>@[\]_`~!'#13#9',:'#10'-.$/"|*()?{}''';

type

  TIntArray = array of Integer;

  pListElement = ^listElement;
  _listElement = record
    ctype: AnsiChar;
    cstart: Integer;
    cend: Integer;
  end;
  listElement = _listElement;
  listElementArray = array of listElement;

  pArrayList = ^arrayList;
  _arrayList = record
    carray: pListElement;
    size: Integer;
    capacity: Integer;
  end;
  arrayList = _arrayList;

  pPdf417class = ^pdf417class;
  _pdf417class = record
    bitPtr: Integer;
    cwPtr: Integer;
    param: pPdf417param;
  end;
  pdf417class = _pdf417class;

procedure listInit(list: pArrayList);
begin
  list.capacity := 20;
  list.size := 0;
  list.carray := pListElement(AllocMem(list.capacity * SizeOf(listElement)));
end;

procedure listFree(list: pArrayList);
begin
  FreeMem(list.carray);
  list.carray := nil;
end;

procedure listAdd(list: pArrayList; ctype: AnsiChar; cstart, cend: Integer);
var
  temp: pListElement;
begin
  if list.size = list.capacity then
  begin
    list.capacity := list.capacity * 2;
    temp := pListElement(AllocMem(list.capacity * SizeOf(listElement)));
    Move(list.carray^, temp^, list.size * SizeOf(listElement));
    FreeMem(list.carray);
    list.carray := temp;
  end;
  listElementArray(list.carray)[list.size].ctype := ctype;
  listElementArray(list.carray)[list.size].cstart := cstart;
  listElementArray(list.carray)[list.size].cend := cend;
  Inc(list.size);
end;

function listGet(list: pArrayList; idx: Integer): pListElement;
begin
  if (idx >= list.size) or (idx < 0) then
    Result := nil
  else
    Result := pListElement(@listElementArray(list.carray)[idx]);
end;

procedure listRemove(list: pArrayList; idx: Integer);
var
  src, dst: pListElement;
//  i: Integer;
begin
  if (idx >= list.size) or (idx < 0) then
    Exit;
{  for i := idx to list.size - 2 do
    listElementArray(list.carray)[i] := listElementArray(list.carray)[i + 1];}
  Dec(list.size);
  src := pListElement(@listElementArray(list.carray)[idx + 1]);
  dst := pListElement(@listElementArray(list.carray)[idx]);
  Move(src^, dst^, (list.size - idx) * SizeOf(listElement));
end;

function checkElementType(p: pListElement; ctype: AnsiChar): Integer;
begin
  if (p <> nil) and (p.ctype = ctype) then
    Result := 1
  else
    Result := 0;
end;

function getElementLength(p: pListElement): Integer;
begin
  if p = nil then
    Result := 0
  else
    Result := p.cend - p.cstart;
end;

procedure pdf417init(p: pPdf417param);
begin
  p.options := 0;
  p.outBits := nil;
  p.lenBits := 0;
  p.error := 0;
  p.lenText := -1;
  p.text := '';
  p.yHeight := 3;
  p.aspectRatio := 0.5;
end;

procedure pdf417free(p: pPdf417param);
begin
  if p.outBits <> nil then
  begin
    FreeMem(p.outBits);
    p.outBits := nil;
  end;
end;

procedure outCodeword17(p: pPdf417class; codeword: Integer);
var
  bytePtr: Integer;
  bit: Integer;
begin
  bytePtr := p.bitPtr div 8;
  bit := p.bitPtr - bytePtr * 8;
  p.param.outBits[bytePtr] := AnsiChar(Ord(p.param.outBits[bytePtr]) or (codeword shr (9 + bit)));
  Inc(bytePtr);
  p.param.outBits[bytePtr] := AnsiChar(Ord(p.param.outBits[bytePtr]) or (codeword shr (1 + bit)));
  Inc(bytePtr);
  codeword := codeword shl 8;
  p.param.outBits[bytePtr] := AnsiChar(Ord(p.param.outBits[bytePtr]) or (codeword shr (1 + bit)));
  Inc(p.bitPtr, 17);
end;

procedure outCodeword18(p: pPdf417class; codeword: Integer);
var
  bytePtr: Integer;
  bit: Integer;
begin
  bytePtr := p.bitPtr div 8;
  bit := p.bitPtr - bytePtr * 8;
  p.param.outBits[bytePtr] := AnsiChar(Ord(p.param.outBits[bytePtr]) or (codeword shr (10 + bit)));
  Inc(bytePtr);
  p.param.outBits[bytePtr] := AnsiChar(Ord(p.param.outBits[bytePtr]) or (codeword shr (2 + bit)));
  Inc(bytePtr);
  codeword := codeword shl 8;
  p.param.outBits[bytePtr] := AnsiChar(Ord(p.param.outBits[bytePtr]) or (codeword shr (2 + bit)));
  if bit = 7 then
  begin                                                          
    Inc(bytePtr);
    p.param.outBits[bytePtr] := AnsiChar(Ord(p.param.outBits[bytePtr]) or $80);
  end;
  Inc(p.bitPtr, 18);
end;

procedure outCodeword(p: pPdf417class; codeword: Integer);
begin
    outCodeword17(p, codeword);
end;

procedure outStopPattern(p: pPdf417class);
begin
    outCodeword18(p, STOP_PATTERN);
end;

procedure outStartPattern(p: pPdf417class);
begin
    outCodeword17(p, START_PATTERN);
end;

procedure outPaintCode(p: pPdf417class);
var
  codePtr: Integer;
  row: Integer;
  rowMod: Integer;
  cluster: ^Integer;
  edge: Integer;
  column: Integer;
  i: Integer;
begin
  codePtr := 0;
  p.param.bitColumns := START_CODE_SIZE * (p.param.codeColumns + 3) + STOP_SIZE;
  p.param.lenBits := ((p.param.bitColumns - 1) div 8 + 1) * p.param.codeRows;
  p.param.outBits := PAnsiChar(AllocMem(p.param.lenBits));
  for row := 0 to p.param.codeRows - 1 do
  begin
    p.bitPtr := ((p.param.bitColumns - 1) div 8 + 1) * 8 * row;
    rowMod := row mod 3;
    cluster := @CLUSTERS[rowMod][0];
    outStartPattern(p);
    case rowMod of
      0: edge := 30 * (row div 3) + ((p.param.codeRows - 1) div 3);
      1: edge := 30 * (row div 3) + p.param.errorLevel * 3 + ((p.param.codeRows - 1) mod 3);
      else edge := 30 * (row div 3) + p.param.codeColumns - 1;
    end;
    outCodeword(p, TIntArray(cluster)[edge]);
    for column := 0 to p.param.codeColumns - 1 do
    begin
      outCodeword(p, TIntArray(cluster)[p.param.codewords[codePtr]]);
      Inc(codePtr);
    end;
    case rowMod of
      0: edge := 30 * (row div 3) + p.param.codeColumns - 1;
      1: edge := 30 * (row div 3) + ((p.param.codeRows - 1) div 3);
      else edge := 30 * (row div 3) + p.param.errorLevel * 3 + ((p.param.codeRows - 1) mod 3);
    end;
    outCodeword(p, TIntArray(cluster)[edge]);
    outStopPattern(p);
  end;
  if p.param.options and PDF417_INVERT_BITMAP <> 0 then
    for i := 0 to p.param.lenBits - 1 do
      p.param.outBits[i] := AnsiChar(Ord(p.param.outBits[i]) xor $ff);
end;

procedure calculateErrorCorrection(p: pPdf417class; dest: Integer);
var
  t1, t2, t3: Integer;
  A: ^Integer;
  Alength: Integer;
  E: ^Integer;
  lastE: Integer;
  k, le, j: Integer;
begin
  if (p.param.errorLevel < 0) or (p.param.errorLevel > 8) then
    p.param.errorLevel := 0;
  A := @TIntArray(ERROR_LEVEL[p.param.errorLevel])[0];
  Alength := 2 shl p.param.errorLevel;
  E := @p.param.codewords[dest];
  FillChar(E^, Alength * SizeOf(Integer), 0);
  lastE := Alength - 1;
  for k := 0 to p.param.lenCodewords - 1 do
  begin
    t1 := p.param.codewords[k] + TIntArray(E)[0];
    for le := 0 to lastE do
    begin
      t2 := (t1 * TIntArray(A)[lastE - le]) mod CMOD;
      t3 := CMOD - t2;
      if le = lastE then
        TIntArray(E)[le] := t3 mod CMOD
      else
        TIntArray(E)[le] := (TIntArray(E)[le + 1] + t3) mod CMOD;
    end;
  end;
  for j := 0 to Alength - 1 do
    TIntArray(E)[j] := (CMOD - TIntArray(E)[j]) mod CMOD;
end;

function getTextTypeAndValue(text: PAnsiChar; size: Integer; idx: Integer): Integer;
var
  c: AnsiChar;
  ms, ps: Integer;
begin
  if idx >= size then
  begin
    Result := 0;
    Exit;
  end;
  c := text[idx];
  if (c >= 'A') and (c <= 'Z') then
  begin
    Result := ALPHA + Ord(c) - Ord('A');
    Exit;
  end;
  if (c >= 'a') and (c <= 'z') then
  begin
    Result := LOWER + Ord(c) - Ord('a');
    Exit;
  end;
  if c = ' ' then
  begin
    Result := ALPHA + LOWER + MIXED + SPACE;
    Exit;
  end;
  ms := Pos(c, MIXED_SET);
  ps := Pos(c, PUNCTUATION_SET);
  if (ms = 0) and (ps = 0) then
  begin
    Result := ISBYTE + (Ord(c) and $ff);
    Exit;
  end;
  if ms = ps then
  begin
    Result := MIXED + PUNCTUATION + ms - 1;
    Exit;
  end;
  if ms <> 0 then
  begin
    Result := MIXED + ms - 1;
    Exit;
  end;
  Result := PUNCTUATION + ps - 1;
end;

procedure textCompaction(p: pPdf417class; start, length: Integer);
var
  dest: array[0..ABSOLUTE_MAX_TEXT_SIZE * 2 - 1] of Integer;
  text: PAnsiChar;
  mode: Integer;
  ptr: Integer;
  fullBytes: Integer;
  v: Integer;
  k: Integer;
  size: Integer;
begin
  text := p.param.text;
  mode := ALPHA;
  ptr := 0;
  fullBytes := 0;

  FillChar(dest, SizeOf(dest), 0);
  Inc(length, start);
  k := start;
  while k < length do
  begin
    v := getTextTypeAndValue(text, length, k);
    if v and mode <> 0 then
    begin
      dest[ptr] := v and $ff;
      Inc(ptr);
      Inc(k);
      Continue;
    end;
    if v and ISBYTE <> 0 then
    begin
      if ptr and 1 <> 0 then
      begin
        if mode and PUNCTUATION <> 0 then
          dest[ptr] := PAL
        else
          dest[ptr] := PS;
        Inc(ptr);
        if mode and PUNCTUATION <> 0 then
          mode := ALPHA;
      end;
      dest[ptr] := BYTESHIFT;
      Inc(ptr);
      dest[ptr] := v and $ff;
      Inc(ptr);
      Inc(fullBytes, 2);
      Inc(k);
      Continue;
    end;
    case mode of
      ALPHA:
      begin
        if v and LOWER <> 0 then
        begin
          dest[ptr] := LL;
          Inc(ptr);
          dest[ptr] := v and $ff;
          Inc(ptr);
          mode := LOWER;
        end
        else if v and MIXED <> 0 then
        begin
          dest[ptr] := ML;
          Inc(ptr);
          dest[ptr] := v and $ff;
          Inc(ptr);
          mode := MIXED;
        end
        else if ((getTextTypeAndValue(text, length, k + 1) and getTextTypeAndValue(text, length, k + 2) and PUNCTUATION) <> 0) then
        begin
          dest[ptr] := ML;
          Inc(ptr);
          dest[ptr] := PL;
          Inc(ptr);
          dest[ptr] := v and $ff;
          Inc(ptr);
          mode := PUNCTUATION;
        end
        else
        begin
          dest[ptr] := PS;
          Inc(ptr);
          dest[ptr] := v and $ff;
          Inc(ptr);
        end;
      end;
      LOWER:
      begin
        if v and ALPHA <> 0 then
        begin
          if ((getTextTypeAndValue(text, length, k + 1) and getTextTypeAndValue(text, length, k + 2) and ALPHA) <> 0) then
          begin
            dest[ptr] := ML;
            Inc(ptr);
            dest[ptr] := AL;
            Inc(ptr);
            mode := ALPHA;
          end
          else
          begin
            dest[ptr] := CAS;
            Inc(ptr);
          end;
          dest[ptr] := v and $ff;
          Inc(ptr);
        end
        else if v and MIXED <> 0 then
        begin
          dest[ptr] := ML;
          Inc(ptr);
          dest[ptr] := v and $ff;
          Inc(ptr);
          mode := MIXED;
        end
        else if ((getTextTypeAndValue(text, length, k + 1) and getTextTypeAndValue(text, length, k + 2) and PUNCTUATION) <> 0) then
        begin
          dest[ptr] := ML;
          Inc(ptr);
          dest[ptr] := PL;
          Inc(ptr);
          dest[ptr] := v and $ff;
          Inc(ptr);
          mode := PUNCTUATION;
        end
        else
        begin
          dest[ptr] := PS;
          Inc(ptr);
          dest[ptr] := v and $ff;
          Inc(ptr);
        end;
      end;
      MIXED:
      begin
        if v and LOWER <> 0 then
        begin
          dest[ptr] := LL;
          Inc(ptr);
          dest[ptr] := v and $ff;
          Inc(ptr);
          mode := LOWER;
        end
        else if v and ALPHA <> 0 then
        begin
          dest[ptr] := AL;
          Inc(ptr);
          dest[ptr] := v and $ff;
          Inc(ptr);
          mode := ALPHA;
        end
        else if ((getTextTypeAndValue(text, length, k + 1) and getTextTypeAndValue(text, length, k + 2) and PUNCTUATION) <> 0) then
        begin
          dest[ptr] := PL;
          Inc(ptr);
          dest[ptr] := v and $ff;
          Inc(ptr);
          mode := PUNCTUATION;
        end
        else
        begin
          dest[ptr] := PS;
          Inc(ptr);
          dest[ptr] := v and $ff;
          Inc(ptr);
        end;
      end;
      PUNCTUATION:
      begin
        dest[ptr] := PAL;
        Inc(ptr);
        mode := ALPHA;
        Dec(k);
      end;
    end;
    Inc(k);
  end;
  if ptr and 1 <> 0 then
  begin
    dest[ptr] := PS;
    Inc(ptr);
  end;
  size := (ptr + fullBytes) div 2;
  if size + p.cwPtr > MAX_DATA_CODEWORDS then
  begin
    p.param.error := PDF417_ERROR_TEXT_TOO_BIG;
    Exit;
  end;
  length := ptr;
  ptr := 0;
  while ptr < length do
  begin
    v := dest[ptr];
    Inc(ptr);
    if v >= 30 then
    begin
      p.param.codewords[p.cwPtr] := v;
      Inc(p.cwPtr);
      p.param.codewords[p.cwPtr] := dest[ptr];
      Inc(p.cwPtr);
      Inc(ptr);
    end
    else
    begin
      p.param.codewords[p.cwPtr] := v * 30 + dest[ptr];
      Inc(p.cwPtr);
      Inc(ptr);
    end;
  end;
end;

procedure basicNumberCompaction(p: pPdf417class; start, length: Integer);
var
  text: PAnsiChar;
  ret: ^Integer;
  retLast: Integer;
  ni, k: Integer;
begin
  text := p.param.text;
  ret := @p.param.codewords[p.cwPtr];
  retLast := length div 3;
  Inc(p.cwPtr, retLast + 1);
  FillChar(ret^, (retLast + 1) * SizeOf(Integer), 0);
  TIntArray(ret)[retLast] := 1;
  Inc(length, start);
  for ni := start to length - 1 do
  begin
    for k := retLast downto 0 do
      TIntArray(ret)[k] := TIntArray(ret)[k] * 10;
    Inc(TIntArray(ret)[retLast], Ord(text[ni]) - Ord('0'));
    for k := retLast downto 1 do
    begin
      Inc(TIntArray(ret)[k - 1], TIntArray(ret)[k] div 900);
      TIntArray(ret)[k] := TIntArray(ret)[k] mod 900;
    end;
  end;
end;

procedure numberCompaction(p: pPdf417class; start, length: Integer);
var
  full: Integer;
  size: Integer;
  k: Integer;
begin
  full := (length div 44) * 15;
  size := length mod 44;
  if size = 0 then
    size := full
  else
    size := full + size div 3 + 1;
  if (size + p.cwPtr > MAX_DATA_CODEWORDS) then
  begin
    p.param.error := PDF417_ERROR_TEXT_TOO_BIG;
    Exit;
  end;
  Inc(length, start);
  k := start;
  while k < length do
  begin
    size := length - k;
    if size > 44 then
      size := 44;
    basicNumberCompaction(p, k, size);
    Inc(k, 44);
  end;
end;

procedure byteCompaction6(p: pPdf417class; start: Integer);
var
  length: Integer;
  text: PAnsiChar;
  ret: ^Integer;
  retLast: Integer;
  ni, k: Integer;
begin
  length := 6;
  text := p.param.text;
  ret := @p.param.codewords[p.cwPtr];
  retLast := 4;
  Inc(p.cwPtr, retLast + 1);
  FillChar(ret^, (retLast + 1) * sizeof(Integer), 0);
  Inc(length, start);
  for ni := start to length - 1 do
  begin
    for k := retLast downto 0 do
      TIntArray(ret)[k] := TIntArray(ret)[k] * 256;
    Inc(TIntArray(ret)[retLast], Integer(text[ni]) and $ff);
    for k := retLast downto 0 do
    begin
      Inc(TIntArray(ret)[k - 1], TIntArray(ret)[k] div 900);
      TIntArray(ret)[k] := TIntArray(ret)[k] mod 900;
    end;
  end;
end;

procedure byteCompaction(p: pPdf417class; start, length: Integer);
var
  k, j: Integer;
  size: Integer;
begin
  size := (length div 6) * 5 + (length mod 6);
  if (size + p.cwPtr > MAX_DATA_CODEWORDS) then
  begin
    p.param.error := PDF417_ERROR_TEXT_TOO_BIG;
    Exit;
  end;
  Inc(length, start);
  k := start;
  while k < length do
  begin
    size := length - k;
    if size >= 44 then
      size := 6;
    if size < 6 then
    begin
      for j := 0 to size - 1 do
      begin
        p.param.codewords[p.cwPtr] := Integer(p.param.text[k + j]) and $ff;
        Inc(p.cwPtr);
      end;
    end
    else
      byteCompaction6(p, k);
    Inc(k, 6);
  end;
end;

procedure breakString(p: pPdf417class; list: pArrayList);
var
  text: PAnsiChar;
  textlength: Integer;
  lastP: Integer;
  startN: Integer;
  nd: Integer;
  c: AnsiChar;
  k, j: Integer;
  lastTxt, txt: Boolean;
  v, vp, vn: pListElement;
  redo: Integer;
begin
  text := p.param.text;
  textlength := p.param.lenText;
  lastP := 0;
  startN := 0;
  nd := 0;
  list.size := 0;
  for k := 0 to textLength - 1 do
  begin
    c := text[k];
    if (c >= '0') and (c <= '9') then
    begin
      if nd = 0 then
        startN := k;
      Inc(nd);
      Continue;
    end;
    if nd >= 13 then
    begin
      if lastP <> startN then
      begin
        c := text[lastP];
        lastTxt := ((c >= ' ') and (c < #127)) or (c = #10) or (c = #13) or (c = #9);
        for j := lastP  to startN - 1 do
        begin
          c := text[j];
          txt := ((c >= ' ') and (c < #127)) or (c = #10) or (c = #13) or (c = #9);
          if txt <> lastTxt then
          begin
            if lastTxt then
              listAdd(list, 'T', lastP, j)
            else
              listAdd(list, 'B', lastP, j);
            lastP := j;
            lastTxt := txt;
          end;
        end;
        if lastTxt then
          listAdd(list, 'T', lastP, startN)
        else
          listAdd(list, 'B', lastP, startN);
      end;
      listAdd(list, 'N', startN, k);
      lastP := k;
    end;
    nd := 0;
  end;
  if nd < 13 then
    startN := textLength;
  if lastP <> startN then
  begin
    c := text[lastP];
    lastTxt := ((c >= ' ') and (c < #127)) or (c = #10) or (c = #13) or (c = #9);
    for j := lastP to startN - 1 do
    begin
      c := text[j];
      txt := ((c >= ' ') and (c < #127)) or (c = #10) or (c = #13) or (c = #9);
      if txt <> lastTxt then
      begin
        if lastTxt then
          listAdd(list, 'T', lastP, j)
        else
          listAdd(list, 'B', lastP, j);
        lastP := j;
        lastTxt := txt;
      end;
    end;
    if lastTxt then
      listAdd(list, 'T', lastP, startN)
    else
      listAdd(list, 'B', lastP, startN)
  end;
  if nd >= 13 then
    listAdd(list, 'N', startN, textLength);
  //optimize
  //merge short binary
  k := 0;
  while k < list.size do
  begin
    v := listGet(list, k);
    vp := listGet(list, k - 1);
    vn := listGet(list, k + 1);
    if (checkElementType(v, 'B') = 1) and (getElementLength(v) = 1) then
      if (checkElementType(vp, 'T') = 1) and (checkElementType(vn, 'T') = 1)
        and (getElementLength(vp) + getElementLength(vn) >= 3) then
      begin
        vp.cend := vn.cend;
        listRemove(list, k);
        listRemove(list, k);
        k := -1;
        Inc(k);
        Continue;
      end;
    Inc(k);
  end;
  //merge text sections
  k := 0;
  while k < list.size do
  begin
    v := listGet(list, k);
    vp := listGet(list, k - 1);
    vn := listGet(list, k + 1);
    if (checkElementType(v, 'T') = 1) and (getElementLength(v) >= 5) then
    begin
      redo := 0;
      if ((checkElementType(vp, 'B') = 1) and (getElementLength(vp) = 1)) or (checkElementType(vp, 'T') = 1) then
      begin
        redo := 1;
        v.cstart := vp.cstart;
        listRemove(list, k - 1);
        Dec(k);
      end;
      if ((checkElementType(vn, 'B') = 1) and (getElementLength(vn) = 1)) or (checkElementType(vn, 'T') = 1) then
      begin
        redo := 1;
        v.cend := vn.cend;
        listRemove(list, k + 1);
      end;
      if redo = 1 then
      begin
        k := 0;
        Continue;
      end;
    end;
    Inc(k);
  end;
  //merge binary sections
  k := 0;
  while k < list.size do
  begin
    v := listGet(list, k);
    vp := listGet(list, k - 1);
    vn := listGet(list, k + 1);;
    if checkElementType(v, 'B') = 1 then
    begin
      redo := 0;
      if ((checkElementType(vp, 'T') = 1) and (getElementLength(vp) < 5)) or (checkElementType(vp, 'B') = 1) then
      begin
        redo := 1;
        v.cstart := vp.cstart;
        listRemove(list, k - 1);
        Dec(k);
      end;
      if ((checkElementType(vn, 'T') = 1) and (getElementLength(vn) < 5)) or (checkElementType(vn, 'B') = 1) then
      begin
        redo := 1;
        v.cend := vn.cend;
        listRemove(list, k + 1);
      end;
      if redo = 1 then
      begin
        k := 0;
        Continue;
      end;
    end;
    Inc(k);
  end;
  // check if all numbers
  if list.size = 1 then
  begin
    v := listGet(list, 0);
    if (v.ctype = 'T') and (getElementLength(v) >= 8) then
    begin
      for k := v.cstart to v.cend - 1 do
      begin
        c := text[k];
        if (c < '0') or (c > '9') then
          Break;
      end;
      if k = v.cend then
        v.ctype := 'N';
    end;
  end;
end;

procedure assemble(p: pPdf417class; list: pArrayList);
var
  k: Integer;
  v: pListElement;
begin
  if list.size = 0 then
    Exit;
  p.cwPtr := 1;
  for k := 0 to list.size - 1 do
  begin
    v := listGet(list, k);
    case v.ctype of
      'T':
      begin
        if k <> 0 then
        begin
          p.param.codewords[p.cwPtr] := TEXT_MODE;
          Inc(p.cwPtr);
        end;
        textCompaction(p, v.cstart, v.cend - v.cstart);
      end;
      'N':
      begin
        p.param.codewords[p.cwPtr] := NUMERIC_MODE;
        Inc(p.cwPtr);
        numberCompaction(p, v.cstart, v.cend - v.cstart);
      end;
      'B':
      begin
        if (v.cend - v.cstart) mod 6 <> 0 then
          p.param.codewords[p.cwPtr] := BYTE_MODE
        else
          p.param.codewords[p.cwPtr] := BYTE_MODE_6;
        Inc(p.cwPtr);
        byteCompaction(p, v.cstart, v.cend - v.cstart);
      end;
    end;
    if p.param.error <> 0 then
      Exit;
  end;
end;

function maxPossibleErrorLevel(remain: Integer): Integer;
var
  level: Integer;
  size: Integer;
begin
  level := 8;
  size := 512;
  while level > 0 do
  begin
    if remain >= size then
    begin
      Result := level;
      Exit;
    end;
    Dec(level);
    size := size shr 1;
  end;
  Result := 0;
end;

function getMaxSquare(p: pPdf417param): Integer;
begin
  if p.codeColumns > 21 then
  begin
    p.codeColumns := 29;
    p.codeRows := 32;
  end
  else
  begin
    p.codeColumns := 16;
    p.codeRows := 58;
  end;
  Result := MAX_DATA_CODEWORDS + 2;
end;

procedure paintCode(p: pPdf417param);
var
  pp: pdf417class;
  list: arrayList;
  maxErr, fixedColumn, lenErr, tot, skipRowColAdjust, pad: Integer;
  c, b: Double;
begin
  pp.param := p;
  p.error := 0;
  if (p.options and PDF417_USE_RAW_CODEWORDS) <> 0 then
  begin
    if (p.lenCodewords > MAX_DATA_CODEWORDS) or (p.lenCodewords < 1) or (p.lenCodewords <> p.codewords[0]) then
    begin
      p.error := PDF417_ERROR_INVALID_PARAMS;
      Exit;
    end;
  end
  else
  begin
    if p.lenText < 0 then
      p.lenText := StrLen(p.text);
    if p.lenText > ABSOLUTE_MAX_TEXT_SIZE then
    begin
      p.error := PDF417_ERROR_TEXT_TOO_BIG;
      Exit;
    end;
    listInit(@list);
    breakString(@pp, @list);
    assemble(@pp, @list);
    listFree(@list);
    if p.error <> 0 then
      Exit;
    p.lenCodewords := pp.cwPtr;
    p.codewords[0] := p.lenCodewords;
  end;
  maxErr := maxPossibleErrorLevel(MAX_DATA_CODEWORDS + 2 - p.lenCodewords);
  if p.options and PDF417_USE_ERROR_LEVEL = 0 then
  begin
    if p.lenCodewords < 41 then
      p.errorLevel := 2
    else if p.lenCodewords < 161 then
      p.errorLevel := 3
    else if p.lenCodewords < 321 then
      p.errorLevel := 4
    else
      p.errorLevel := 5;
  end;
  if p.errorLevel < 0 then
    p.errorLevel := 0
  else if p.errorLevel > maxErr then
    p.errorLevel := maxErr;
  if p.codeColumns < 1 then
    p.codeColumns := 1
  else if p.codeColumns > 30 then
    p.codeColumns := 30;
  if p.codeRows < 3 then
    p.codeRows := 3
  else if p.codeRows > 90 then
    p.codeRows := 90;

  lenErr := 2 shl p.errorLevel;
  fixedColumn := not (p.options and PDF417_FIXED_ROWS);
  skipRowColAdjust := 0;
  tot := p.lenCodewords + lenErr;
  if p.options and PDF417_FIXED_RECTANGLE <> 0 then
  begin
    tot := p.codeColumns * p.codeRows;
    if tot > MAX_DATA_CODEWORDS + 2 then
      tot := getMaxSquare(p);
    if tot < p.lenCodewords + lenErr then
      tot := p.lenCodewords + lenErr
    else
      skipRowColAdjust := 1;
  end
  else if (p.options and (PDF417_FIXED_COLUMNS or PDF417_FIXED_ROWS)) = 0 then
  begin
    fixedColumn := 1;
    if p.aspectRatio < 0.001 then
      p.aspectRatio := 0.001
    else if p.aspectRatio > 1000 then
      p.aspectRatio := 1000;
    b := 73 * p.aspectRatio - 4;
    c := (-b + sqrt(b * b + 4 * 17 * p.aspectRatio * (p.lenCodewords + lenErr) * p.yHeight)) / (2 * 17 * p.aspectRatio);
    p.codeColumns := Trunc(c + 0.5);
    if p.codeColumns < 1 then
      p.codeColumns := 1
    else if p.codeColumns > 30 then
      p.codeColumns := 30;
  end;
  if skipRowColAdjust = 0 then
  begin
    if fixedColumn <> 0 then
    begin
      p.codeRows := (tot - 1) div p.codeColumns + 1;
      if p.codeRows < 3 then
        p.codeRows := 3
      else if (p.codeRows > 90) then
      begin
        p.codeRows := 90;
        p.codeColumns := (tot - 1) div 90 + 1;
      end;
    end
    else
    begin
      p.codeColumns := (tot - 1) div p.codeRows + 1;
      if p.codeColumns > 30 then
      begin
        p.codeColumns := 30;
        p.codeRows := (tot - 1) div 30 + 1;
      end;
    end;
    tot := p.codeRows * p.codeColumns;
  end;
  if tot > MAX_DATA_CODEWORDS + 2 then
    tot := getMaxSquare(p);
  p.errorLevel := maxPossibleErrorLevel(tot - p.lenCodewords);
  lenErr := 2 shl p.errorLevel;
  pad := tot - lenErr - p.lenCodewords;
  pp.cwPtr := p.lenCodewords;
  while pad > 0 do
  begin
    Dec(pad);
    p.codewords[pp.cwPtr] := TEXT_MODE;
    Inc(pp.cwPtr);
  end;
  p.lenCodewords := pp.cwPtr;
  p.codewords[0] := p.lenCodewords;
  calculateErrorCorrection(@pp, pp.param.lenCodewords);
  pp.param.lenCodewords := tot;
  outPaintCode(@pp);
end;

end.

