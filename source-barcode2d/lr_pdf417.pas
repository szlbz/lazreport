unit lr_PDF417;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ExtCtrls, LR_Class, LR_Utils, lr_pdf417lib;

const
  cbPDF417faultText = 'BarCode PDF417';

type

  TPDF417Option = (poAutoErrorLevel, poFixedColumn, poFixedRow);
  TPDF417Options = set of TPDF417Option;
  TPDF417Encode = (peUTF8, peCP1250, peCP1251, peCP1252, peCP1253, peCP1254,
                peCP1255, peCP1256, peCP1257, peCP1258, peCP437, peCP850,
                peCP852, peCP866, peCP874, peCP932, peCP936, peCP949, peCP950);

  { TfrPDF417 }

  TfrPDF417 = class(TComponent)
  public
    constructor Create(AOwner: TComponent); override;
  end;

  { TfrCustomPDF417View }

  TfrCustomPDF417View = class(TfrView)
  private
    FMemoryBitmap: TBitmap;
    FOptions: TPDF417Options;
    FFixedColumn: Integer;
    FFixedRow: Integer;
    FErrorLevel: Integer;
    FVerticalView: Boolean;
    FTextEncode: TPDF417Encode;
    procedure SetTextEncode(AValue: TPDF417Encode);
  protected
    procedure SetOptions(Value: TPDF417Options);
    procedure SetFixedColumn(Value: Integer);
    procedure SetFixedRow(Value: Integer);
    procedure SetErrorLevel(Value: Integer);
    procedure SetVerticalView(AValue: Boolean);
    procedure RataiteBarcodeBitmap;
  public
    constructor Create(AOwnerPage:TfrPage);override;
    destructor Destroy; override;
    procedure UpdateBarcode;
    procedure Assign(Source: TPersistent); override;
    procedure PaintOnCanvas(const aTargetCanvas: TCanvas; const aRect: TRect);
    procedure Draw(aCanvas: TCanvas); override;
    procedure Print(Stream: TStream); override;
    procedure SaveToXML(XML: TLrXMLConfig; const Path: String); override;
    procedure LoadFromXML(XML: TLrXMLConfig; const Path: String); override;
    procedure SaveToStream(Stream: TStream); override;
    procedure LoadFromStream(Stream: TStream); override;
    property MemoryBitmap: TBitmap read FMemoryBitmap;
    property Options: TPDF417Options read FOptions write SetOptions default [poAutoErrorLevel];
    property FixedColumn: Integer read FFixedColumn write SetFixedColumn default 0;
    property FixedRow: Integer read FFixedRow write SetFixedRow default 0;
    property ErrorLevel: Integer read FErrorLevel write SetErrorLevel default 3;
    property VerticalView: Boolean read FVerticalView write SetVerticalView default False;
    property TextEncode: TPDF417Encode read FTextEncode write SetTextEncode default peUTF8;
  end;

  TfrPDF417View = class(TfrCustomPDF417View)
  published
    property Memo;
    property Script;
    property FixedColumn;
    property FixedRow;
    property Options;
    property VerticalView;
    property TextEncode;
  end;

  { TPDF417Form }

  TPDF417Form = class(TfrObjEditorForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Image1: TImage;
    Memo1: TMemo;
    procedure Button3Click(Sender: TObject);
  private
    { private declarations }
  public
    procedure ShowEditor(t: TfrView); override;
  end;

var
  PDF417Form: TPDF417Form;

implementation

uses LR_Flds, LConvEncoding;

procedure InitializePDF417Addin;
begin
  if not assigned(PDF417Form) {and not (csDesigning in ComponentState)} then
  begin
    PDF417Form := TPDF417Form.Create(nil);
    frSetAddinEditor(TfrPDF417View, PDF417Form);
    frSetAddinIcon(TfrPDF417View, PDF417Form.Image1.Picture.Bitmap);
    frSetAddinHint(TfrPDF417View, 'Add BarCode PDF417');
  end;
end;

{ TfrCustomPDF417View }

procedure TfrCustomPDF417View.SetVerticalView(AValue: Boolean);
begin
  if FVerticalView = AValue then Exit;
  FVerticalView := AValue;
  UpdateBarcode;
end;

procedure TfrCustomPDF417View.SetTextEncode(AValue: TPDF417Encode);
begin
  if FTextEncode = AValue then Exit;
  FTextEncode := AValue;
  UpdateBarcode;
end;

procedure TfrCustomPDF417View.SetOptions(Value: TPDF417Options);
begin
  FOptions := Value;
  UpdateBarcode;
end;

procedure TfrCustomPDF417View.SetFixedColumn(Value: Integer);
begin
  if Value < 0 then Value := 0;
  FFixedColumn := Value;
  if poFixedColumn in FOptions then  UpdateBarcode;
end;

procedure TfrCustomPDF417View.SetFixedRow(Value: Integer);
begin
  if Value < 0 then Value := 0;
  FFixedRow := Value;
  if poFixedRow in FOptions then UpdateBarcode;
end;

procedure TfrCustomPDF417View.SetErrorLevel(Value: Integer);
begin
  if (Value < 0) or (Value > 8) then Value := 0;
  FErrorLevel := Value;
  UpdateBarcode;
end;

procedure TfrCustomPDF417View.RataiteBarcodeBitmap;
var
  TmpBmp: TBitmap;
  BX, BY, AX, AY: Integer;
begin
  TmpBmp := TBitmap.Create;
  TmpBmp.Width := FMemoryBitmap.Height;
  TmpBmp.Height := FMemoryBitmap.Width;
  for BX := 0 to FMemoryBitmap.Width - 1 do
  begin
    for BY := 0 to FMemoryBitmap.Height - 1 do
    begin
      AY := TmpBmp.Height - BX - 1;
      AX := BY;
      TmpBmp.Canvas.Pixels[AX, AY] := FMemoryBitmap.Canvas.Pixels[BX, BY];
    end;
  end;
  FMemoryBitmap.Free;
  FMemoryBitmap := TmpBmp;
end;

constructor TfrCustomPDF417View.Create(AOwnerPage: TfrPage);
begin
  inherited Create(AOwnerPage);
  BaseName := 'BarPDF417';
  Memo.Add(cbPDF417faultText);
  FFixedColumn := 0;
  FFixedRow := 0;
  FErrorLevel := 3;
  FOptions := [poAutoErrorLevel];
  FVerticalView := False;
  FTextEncode := peUTF8;
  FMemoryBitmap := TBitmap.Create;
  Stretched := True;
end;

destructor TfrCustomPDF417View.Destroy;
begin
  FMemoryBitmap.Free;
  inherited Destroy;
end;

procedure TfrCustomPDF417View.UpdateBarcode;
var
  p: pdf417param;
  cols: Integer;
  k, i: Integer;
  ax, ay: Integer;
  pclr: TColor;
  textstring: string;
  TmpBmp: TBitmap;
begin
  textstring := '';
  for i := 0 to Memo.Count - 1 do
  begin
    textstring := textstring + Memo[i];
    if i < Memo.Count - 1 then
      textstring := textstring + #13#10;
  end;

  if FTextEncode <> peUTF8 then
  begin
    case FTextEncode of
      peCP1250: textstring := UTF8ToCP1250(textstring);
      peCP1251: textstring := UTF8ToCP1251(textstring);
      peCP1252: textstring := UTF8ToCP1252(textstring);
      peCP1253: textstring := UTF8ToCP1253(textstring);
      peCP1254: textstring := UTF8ToCP1254(textstring);
      peCP1255: textstring := UTF8ToCP1255(textstring);
      peCP1256: textstring := UTF8ToCP1256(textstring);
      peCP1257: textstring := UTF8ToCP1257(textstring);
      peCP1258: textstring := UTF8ToCP1258(textstring);
      peCP437: textstring := UTF8ToCP437(textstring);
      peCP850: textstring := UTF8ToCP850(textstring);
      peCP852: textstring := UTF8ToCP852(textstring);
      peCP866: textstring := UTF8ToCP866(textstring);
      peCP874: textstring := UTF8ToCP874(textstring);
      peCP932: textstring := UTF8ToCP932(textstring);
      peCP936: textstring := UTF8ToCP936(textstring);
      peCP949: textstring := UTF8ToCP949(textstring);
      peCP950: textstring := UTF8ToCP950(textstring);
    end;
  end;


  if textstring = '' then
  begin
    FMemoryBitmap.Free;
    FMemoryBitmap := TBitmap.Create;
    //FMemoryBitmap.PixelFormat := pf1bit;
    Exit;
  end;

  pdf417init(@p);
  p.text := PAnsiChar(textstring);

  if poAutoErrorLevel in FOptions then
    p.options := p.options or PDF417_AUTO_ERROR_LEVEL and (not PDF417_USE_ERROR_LEVEL)
  else
  begin
    p.options := p.options or PDF417_USE_ERROR_LEVEL;
    p.errorLevel := FErrorLevel;
  end;

  p.codeColumns := FFixedColumn;
  p.codeRows := FFixedRow;
  if (poFixedColumn in FOptions) and (poFixedRow in FOptions) then
    p.options := p.options or PDF417_FIXED_RECTANGLE
  else if poFixedColumn in FOptions then
    p.options := p.options or PDF417_FIXED_COLUMNS
  else if poFixedRow in FOptions then
    p.options := p.options or PDF417_FIXED_ROWS;

  paintCode(@p);
  if p.error <> PDF417_ERROR_SUCCESS then
  begin
    case p.error of
      PDF417_ERROR_TEXT_TOO_BIG: raise Exception.Create('The text is too big');
    end;
    pdf417free(@p);
    Exit;
  end;

  FMemoryBitmap.Width := p.bitColumns;
  FMemoryBitmap.Height := p.codeRows;

  cols := p.bitColumns div 8;
  if p.bitColumns mod 8 <> 0 then
    Inc(cols);
  ax := 0; ay := 0;
  for k := 0 to p.lenBits - 1 do
  begin
    if (k mod cols = 0) and (k <> 0) then
    begin
      ax := 0;
      Inc(ay);
    end;
    for i := 0 to 7 do
    begin
      if Ord(p.outBits[k]) and (1 shl (7 - i)) <> 0 then
        pclr := clBlack
      else
        pclr := clWhite;
      FMemoryBitmap.Canvas.Pixels[ax, ay] := pclr;
      Inc(ax);
    end;
  end;

  pdf417free(@p);

  if FVerticalView then RataiteBarcodeBitmap;
  //Picture.Bitmap := FMemoryBitmap;
end;

procedure TfrCustomPDF417View.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TfrCustomPDF417View then
  begin
    FFixedColumn := TfrCustomPDF417View(Source).FixedColumn;
    FFixedRow := TfrCustomPDF417View(Source).FixedRow;
    FErrorLevel := TfrCustomPDF417View(Source).ErrorLevel;
    FOptions := TfrCustomPDF417View(Source).Options;
    FVerticalView := TfrCustomPDF417View(Source).VerticalView;
    FTextEncode := TfrCustomPDF417View(Source).TextEncode;
  end;
end;

procedure TfrCustomPDF417View.PaintOnCanvas(const aTargetCanvas: TCanvas;
  const aRect: TRect);
var
  xW, xH, aX, aY: Integer;
  bmpW, bmpH: Integer;
  xDotSize, yDotSize: Integer;
  R: TRect;
begin
  xW := aRect.Right - aRect.Left;
  xH:= aRect.Bottom - aRect.Top;
  bmpW := FMemoryBitmap.Width;
  bmpH := FMemoryBitmap.Height;
  if (xW >= bmpW) and (xH > bmpH) then
  begin
    xDotSize := 1;
    if xw > bmpW then
    begin
      xDotSize := xW div bmpW;
      if xDotSize < 1 then xDotSize := 1;
    end;
    yDotSize := 1;
    if xH > bmpH then
    begin
      yDotSize := xH div bmpH;
      if yDotSize < 1 then yDotSize := 1;
    end;
    R := aRect;
    R.Right:= R.Left + xDotSize;
    R.Bottom := R.Top + yDotSize;

    aTargetCanvas.Brush.Color:= clWhite;
    aTargetCanvas.FillRect(aRect);

    for aX:= 0 to bmpW - 1 do
    begin
      for aY:= 0 to bmpH - 1 do
      begin
        aTargetCanvas.Brush.Color := FMemoryBitmap.Canvas.Pixels[aX, aY];
        aTargetCanvas.FillRect(R);
        R.Top := R.Bottom;
        R.Bottom := R.Top + yDotSize;
      end;
      R.Top:= aRect.Top;
      R.Bottom:= R.Top + yDotSize;
      R.Left:= R.Right;
      R.Right := R.Left + xDotSize;
    end;
  end
  else
  begin
    aTargetCanvas.Brush.Color:= clWhite;
    aTargetCanvas.FillRect(aRect);
  end;
end;

procedure TfrCustomPDF417View.Draw(aCanvas: TCanvas);
begin
  Memo1.Assign(Memo);
  UpdateBarcode;
  BeginDraw(aCanvas);
  CalcGaps;
  try
    Memo1.Assign(Memo);
    UpdateBarcode;
    PaintOnCanvas(aCanvas, DRect);
    ShowFrame;
  finally
    RestoreCoord;
  end;
end;

procedure TfrCustomPDF417View.Print(Stream: TStream);
begin
  BeginDraw(Canvas);
  Memo1.Assign(Memo);
  CurReport.InternalOnEnterRect(Memo1, Self);
  frInterpretator.DoScript(Script);
  if not Visible then Exit;

  if Memo1.Count > 0 then
    if (Length(Memo1[0]) > 0) and (Pos('[',Memo1[0])<>0) then
      Memo1[0] := frParser.Calc(Memo1[0]);
  Stream.Write(Typ, 1);
  frWriteString(Stream, ClassName);
  SaveToStream(Stream);
end;

procedure TfrCustomPDF417View.SaveToXML(XML: TLrXMLConfig; const Path: String);
begin
  //Picture.Clear;
  inherited SaveToXML(XML, Path);
  XML.SetValue(Path+'PDF417/FixedColumn', GetSaveProperty('FixedColumn'));
  XML.SetValue(Path+'PDF417/FixedRow', GetSaveProperty('FixedRow'));
  XML.SetValue(Path+'PDF417/ErrorLevel', GetSaveProperty('ErrorLevel'));
  XML.SetValue(Path+'PDF417/Options', GetSaveProperty('Options'));
  XML.SetValue(Path+'PDF417/VerticalView', GetSaveProperty('VerticalView'));
  XML.SetValue(Path+'PDF417/TextEncode', GetSaveProperty('TextEncode'));
  UpdateBarcode;
end;

procedure TfrCustomPDF417View.LoadFromXML(XML: TLrXMLConfig; const Path: String
  );
begin
  inherited LoadFromXML(XML, Path);
  RestoreProperty('FixedColumn', XML.GetValue(Path+'PDF417/FixedColumn', '0'));
  RestoreProperty('FixedRow', XML.GetValue(Path+'PDF417/FixedRow', '0'));
  RestoreProperty('ErrorLevel', XML.GetValue(Path+'PDF417/ErrorLevel', '3'));
  RestoreProperty('Options', XML.GetValue(Path+'PDF417/Options', '[poAutoErrorLevel]'));
  RestoreProperty('VerticalView', XML.GetValue(Path+'PDF417/VerticalView', 'False'));
  RestoreProperty('TextEncode', XML.GetValue(Path+'PDF417/TextEncode', 'peUTF8'));
end;

procedure TfrCustomPDF417View.SaveToStream(Stream: TStream);
begin
  //Picture.Clear;
  inherited SaveToStream(Stream);
  Stream.Write(FFixedColumn, SizeOf(FFixedColumn));
  Stream.Write(FFixedRow, SizeOf(FFixedRow));
  Stream.Write(FErrorLevel, SizeOf(FErrorLevel));
  Stream.Write(FOptions, SizeOf(FOptions));
  Stream.Write(FVerticalView, SizeOf(FVerticalView));
  Stream.Write(FTextEncode, SizeOf(FTextEncode));
end;

procedure TfrCustomPDF417View.LoadFromStream(Stream: TStream);
var
  I: Integer;
  B: Boolean;
  TE: TPDF417Encode;
  Opt: TPDF417Options;
begin
  inherited LoadFromStream(Stream);
  Stream.Read(I, SizeOf(I));
  FixedColumn := I;
  Stream.Read(I, SizeOf(I));
  FixedRow := I;
  Stream.Read(I, SizeOf(I));
  ErrorLevel := I;
  Stream.Read(Opt, SizeOf(Opt));
  Options := Opt;
  Stream.Read(B, SizeOf(B));
  VerticalView := B;
  Stream.Read(TE, SizeOf(TE));
  TextEncode := TE;
end;

{ TfrPDF417 }

constructor TfrPDF417.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  InitializePDF417Addin;
end;

{ TPDF417Form }

procedure TPDF417Form.Button3Click(Sender: TObject);
begin
  frFieldsForm := TfrFieldsForm.Create(nil);
  with frFieldsForm do
  if ShowModal = mrOk then
    if DBField <> '' then
      Memo1.Lines.Text := '[' + DBField + ']';
  frFieldsForm.Free;
end;

procedure TPDF417Form.ShowEditor(t: TfrView);
begin
  Memo1.Lines.Text := TfrCustomPDF417View(t).Memo.Text;
  if ShowModal = mrOK then
    TfrCustomPDF417View(t).Memo.Text := Memo1.Lines.Text;
end;

initialization
  {$I lr_PDF417.lrs}
  {$I lr_PDF417icon.lrs}
  PDF417Form := nil;
  frRegisterObject(TfrPDF417View, nil, '', nil, @InitializePDF417Addin);
end.

