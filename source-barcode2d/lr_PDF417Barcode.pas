{*
 * Based on C code of Paulo Soares
 * Port to Delphi and create VCL control by Axe Lin
 *}

unit lr_PDF417Barcode;

interface

uses
  sysutils, Classes, Controls, Graphics, lr_pdf417lib, LCLType;

type
{$IFNDEF ACTIVEX}
  TPDF417Option = (poAutoErrorLevel, poFixedColumn, poFixedRow);
  TPDF417Options = set of TPDF417Option;
{$ENDIF}

  { TfrPDF417Barcode }

  TfrPDF417Barcode = class({$IFDEF ACTIVEX}TCustomControl{$ELSE}TGraphicControl{$ENDIF})
  private
{$IFDEF ACTIVEX}
    FLines: string;
{$ELSE}
    FLines: TStrings;
{$ENDIF}
    FErrorLevel: Integer;
    FAutoSize: Boolean;
{$IFDEF ACTIVEX}
    FAutoErrorLevel, FDrawWithFixedColumn, FDrawWithFixedRow: Boolean;
{$ELSE}
    FOptions: TPDF417Options;
{$ENDIF}
    FFixedColumn, FFixedRow: Integer;
    FLineHeight: Integer;
    FDotSize: Integer;

    FMemoryBitmap: TBitmap;
{$IFNDEF ACTIVEX}
    FBitmap: TBitmap;
{$ENDIF}

{$IFDEF ACTIVEX}
    procedure SetLines(Value: string);
{$ELSE}
    procedure SetLines(Value: TStrings);
    procedure TextChanged(Sender: TObject);
{$ENDIF}
    procedure SetErrorLevel(Value: Integer);
    procedure SetFixedColumn(Value: Integer);
    procedure SetFixedRow(Value: Integer);
    procedure SetLineHeight(Value: Integer);
    procedure SetDotSize(Value: Integer);

{$IFDEF ACTIVEX}
    procedure SetAutoErrorLevel(Value: Boolean);
    procedure SetDrawWithFixedColumn(Value: Boolean);
    procedure SetDrawWithFixedRow(Value: Boolean);

    function GetBarcodeWidth: Integer;
    function GetBarcodeHeight: Integer;
    procedure DummyInteger(Value: Integer);
{$ELSE}
    procedure SetOptions(Value: TPDF417Options);
    function GetBitmap: TBitmap;
    procedure DummyBitmap(Value: TBitmap);
{$ENDIF}

    procedure UpdateBarcode;
    { Private declarations }
  protected
    procedure SetAutoSize(Value: Boolean); override;
    procedure Paint; override;
    { Protected declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  {$IFDEF ACTIVEX}
    procedure SaveToFile(AFileName: string);
  {$ENDIF}
    //function DrawTo(DC: HDC; X, Y: Integer; Zoom: Integer; AutoZoom: Boolean): Boolean;
    //function DrawToRect(DC: HDC; R: TRect; Zoom: Integer; AutoZoom: Boolean): Boolean;
    procedure PaintOnCanvas(const aTargetCanvas: TCanvas; const aRect: TRect);
{$IFDEF ACTIVEX}
    property BarcodeWidth: Integer read GetBarcodeWidth write DummyInteger;
    property BarcodeHeight: Integer read GetBarcodeHeight write DummyInteger;
{$ELSE}
    property Bitmap: TBitmap read GetBitmap write DummyBitmap;
{$ENDIF}
    { Public declarations }
  published
{$IFDEF ACTIVEX}
    property Lines: string read FLines write SetLines;
{$ELSE}
    property Lines: TStrings read FLines write SetLines;
{$ENDIF}
    property ErrorLevel: Integer read FErrorLevel write SetErrorLevel default 3;
    property AutoSize: Boolean read FAutoSize write SetAutoSize default True;
{$IFDEF ACTIVEX}
    property AutoErrorLevel: Boolean read FAutoErrorLevel write SetAutoErrorLevel default True;
    property DrawWithFixedColumn: Boolean read FDrawWithFixedColumn write SetDrawWithFixedColumn default False;
    property DrawWithFixedRow: Boolean read FDrawWithFixedRow write SetDrawWithFixedRow default False; 
{$ELSE}
    property Options: TPDF417Options read FOptions write SetOptions default [poAutoErrorLevel];
{$ENDIF}
    property FixedColumn: Integer read FFixedColumn write SetFixedColumn default 0;
    property FixedRow: Integer read FFixedRow write SetFixedRow default 0;
    property LineHeight: Integer read FLineHeight write SetLineHeight default 3;
    property DotSize: Integer read FDotSize write SetDotSize default 1;
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Linasoft', [TfrPDF417Barcode]);
end;

{ TfrPDF417Barcode }

constructor TfrPDF417Barcode.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAutoSize := True;
  FErrorLevel := 3;
{$IFDEF ACTIVEX}
  FAutoErrorLevel := True;
  FDrawWithFixedColumn := False;
  FDrawWithFixedRow := False;
{$ELSE}
  FOptions := [poAutoErrorLevel];
{$ENDIF}
  FFixedColumn := 0;
  FFixedRow := 0;
  FLineHeight := 3;
  FDotSize := 1;
  FMemoryBitmap := TBitmap.Create;
  FMemoryBitmap.PixelFormat := pf1bit;
{$IFNDEF ACTIVEX}
  FBitmap := TBitmap.Create;
  FBitmap.PixelFormat := pf1bit;
{$ENDIF}
{$IFDEF ACTIVEX}
  FLines := 'PDF417 BARCODE';
{$ELSE}
  FLines := TStringList.Create;
  FLines.Add('PDF417 BARCODE');
  TStringList(FLines).OnChange := @TextChanged;
{$ENDIF}
  UpdateBarcode;
end;

destructor TfrPDF417Barcode.Destroy;
begin
{$IFNDEF ACTIVEX}
  FLines.Free;
{$ENDIF}

  FMemoryBitmap.Free;
{$IFNDEF ACTIVEX}
  FBitmap.Free;
{$ENDIF}
  inherited Destroy;
end;

procedure TfrPDF417Barcode.PaintOnCanvas(const aTargetCanvas: TCanvas;
  const aRect: TRect);
begin
  if not aTargetCanvas.HandleAllocated then exit;

  aTargetCanvas.StretchDraw(aRect, FMemoryBitmap);
end;

{$IFNDEF ACTIVEX}
function TfrPDF417Barcode.GetBitmap: TBitmap;
begin
  if FBitmap = nil then
  begin
    FBitmap := TBitmap.Create;
    FBitmap.PixelFormat := pf1bit;
  end;
  FBitmap.Width := FMemoryBitmap.Width * FDotSize;
  FBitmap.Height := FMemoryBitmap.Height * FLineHeight * FDotSize;
  FBitmap.Canvas.StretchDraw(Rect(0, 0, FBitmap.Width, FBitmap.Height), FMemoryBitmap);
  Result := FBitmap;
end;
{$ENDIF}

procedure TfrPDF417Barcode.Paint;
var
  x, y, w, h: Integer;
begin
  Canvas.Brush.Color := clWhite;
  Canvas.FillRect(ClientRect);
  if FMemoryBitmap.Empty then Exit;
  w := FMemoryBitmap.Width * FDotSize;
  h := FMemoryBitmap.Height * FLineHeight * FDotSize;
  if AutoSize then
  begin
    Width := w;
    Height := h;
  end;
  if (Width <= w) or (Height <= h) then
  begin
    x := 0;
    y := 0;
  end
  else
  begin
    x := (Width - w) div 2;
    y := (Height - h) div 2;
  end;
  Canvas.StretchDraw(Rect(x, y, x + w, y + h), FMemoryBitmap);
end;

procedure TfrPDF417Barcode.SetAutoSize(Value: Boolean);
begin
  FAutoSize := Value;
  if FAutoSize then
    Invalidate;
end;

procedure TfrPDF417Barcode.SetLineHeight(Value: Integer);
begin
  if (Value < 1) or (Value > 10) then Value := 3;
  FLineHeight := Value;
  Invalidate;
end;

procedure TfrPDF417Barcode.SetDotSize(Value: Integer);
begin
  if Value < 1 then Value := 1;
  FDotSize := Value;
  Invalidate;
end;

procedure TfrPDF417Barcode.SetErrorLevel(Value: Integer);
begin
  if (Value < 0) or (Value > 8) then Value := 0;
  FErrorLevel := Value;
  UpdateBarcode;
end;

procedure TfrPDF417Barcode.SetFixedColumn(Value: Integer);
begin
  if Value < 0 then Value := 0;
  FFixedColumn := Value;
{$IFDEF ACTIVEX}
  if FDrawWithFixedColumn then
{$ELSE}
  if poFixedColumn in FOptions then
{$ENDIF}
    UpdateBarcode;
end;

procedure TfrPDF417Barcode.SetFixedRow(Value: Integer);
begin
  if Value < 0 then Value := 0;
  FFixedRow := Value;
{$IFDEF ACTIVEX}
  if FDrawWithFixedRow then
{$ELSE}
  if poFixedRow in FOptions then
{$ENDIF}
    UpdateBarcode;
end;
{$IFDEF ACTIVEX}
procedure TPDF417BarcodeVCL.SetAutoErrorLevel(Value: Boolean);
begin
  FAutoErrorLevel := Value;
  UpdateBarcode;
end;

procedure TPDF417BarcodeVCL.SetDrawWithFixedColumn(Value: Boolean);
begin
  FDrawWithFixedColumn := Value;
  UpdateBarcode;
end;

procedure TPDF417BarcodeVCL.SetDrawWithFixedRow(Value: Boolean);
begin
  FDrawWithFixedRow := Value;
  UpdateBarcode;
end;
{$ELSE}
procedure TfrPDF417Barcode.SetOptions(Value: TPDF417Options);
begin
  FOptions := Value;
  UpdateBarcode;
end;
{$ENDIF}

{$IFDEF ACTIVEX}
procedure TPDF417BarcodeVCL.SetLines(Value: string);
begin
  FLines := Value;
  UpdateBarcode;
end;
{$ELSE}
procedure TfrPDF417Barcode.SetLines(Value: TStrings);
begin
  FLines.Assign(Value);
end;
{$ENDIF}

procedure TfrPDF417Barcode.UpdateBarcode;
var
  p: pdf417param;
  cols: Integer;
  k, i: Integer;
  x, y: Integer;
  pclr: TColor;
  textstring: string;
begin
  textstring := '';
{$IFDEF ACTIVEX}
  textstring := FLines;
{$ELSE}
  for i := 0 to FLines.Count - 1 do
  begin
    textstring := textstring + FLines[i];
    if i < FLines.Count - 1 then
      textstring := textstring + #13#10;
  end;
{$ENDIF}

  if textstring = '' then
  begin
    FMemoryBitmap.Free;
    FMemoryBitmap := TBitmap.Create;
    FMemoryBitmap.PixelFormat := pf1bit;
    Invalidate;
    Exit;
  end;
  
  pdf417init(@p);
  p.text := PAnsiChar(AnsiString(textstring));

{$IFDEF ACTIVEX}
  if FAutoErrorLevel then
{$ELSE}
  if poAutoErrorLevel in FOptions then
{$ENDIF}
    p.options := p.options or PDF417_AUTO_ERROR_LEVEL and (not PDF417_USE_ERROR_LEVEL)
  else
  begin
    p.options := p.options or PDF417_USE_ERROR_LEVEL;
    p.errorLevel := FErrorLevel;
  end;

  p.codeColumns := FFixedColumn;
  p.codeRows := FFixedRow;
{$IFDEF ACTIVEX}
  if FDrawWithFixedColumn and FDrawWithFixedRow then
{$ELSE}
  if (poFixedColumn in FOptions) and (poFixedRow in FOptions) then
{$ENDIF}
    p.options := p.options or PDF417_FIXED_RECTANGLE
{$IFDEF ACTIVEX}
  else if FDrawWithFixedColumn then
{$ELSE}
  else if poFixedColumn in FOptions then
{$ENDIF}
    p.options := p.options or PDF417_FIXED_COLUMNS
{$IFDEF ACTIVEX}
  else if FDrawWithFixedRow then
{$ELSE}
  else if poFixedRow in FOptions then
{$ENDIF}  
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
  x := 0; y := 0;
  for k := 0 to p.lenBits - 1 do
  begin
    if (k mod cols = 0) and (k <> 0) then
    begin
      x := 0;
      Inc(y);
    end;
    for i := 0 to 7 do
    begin
      if Ord(p.outBits[k]) and (1 shl (7 - i)) <> 0 then
        pclr := clBlack
      else
        pclr := clWhite;
      FMemoryBitmap.Canvas.Pixels[x, y] := pclr;
      Inc(x);
    end;
  end;

  pdf417free(@p);

  Invalidate;
end;

{$IFNDEF ACTIVEX}
procedure TfrPDF417Barcode.DummyBitmap(Value: TBitmap);
begin
{Dummy Procedure}
end;

procedure TfrPDF417Barcode.TextChanged(Sender: TObject);
begin
  UpdateBarcode;
end;
{$ENDIF}

{$IFDEF ACTIVEX}
procedure TPDF417BarcodeVCL.SaveToFile(AFileName: string);
var
  B: TBitmap;
begin
  B := TBitmap.Create;
  B.PixelFormat := pf1bit;
  B.Width := FMemoryBitmap.Width * FDotSize;
  B.Height := FMemoryBitmap.Height * FLineHeight * FDotSize;
  B.Canvas.StretchDraw(Rect(0, 0, B.Width, B.Height), FMemoryBitmap);
  B.SaveToFile(AFileName);
end;
{$ENDIF}

//function TfrPDF417Barcode.DrawTo(DC: HDC; X, Y: Integer; Zoom: Integer; AutoZoom: Boolean): Boolean;
//var
//  ZoomX, ZoomY: Integer;
//begin
//  Result := False;
//
//  if Zoom <= 0 then Exit;
//
//  if AutoZoom then
//  begin
//    //ZoomX := Round(GetDeviceCaps(DC, LOGPIXELSX) / 100);
//    //ZoomY := Round(GetDeviceCaps(DC, LOGPIXELSY) / 100);
//    ZoomX := 1;
//    ZoomY := 1;
//    if ZoomX < 1 then ZoomX := 1;
//    if ZoomY < 1 then ZoomY := 1;
//  end
//  else
//  begin
//    ZoomX := Zoom * FDotSize;
//    ZoomY := ZoomX;
//  end;
//  Result := StretchBlt(DC, X, Y, FMemoryBitmap.Width * ZoomX, Y + FMemoryBitmap.Height * ZoomY,
//    FMemoryBitmap.Canvas.Handle, 0, 0, FMemoryBitmap.Width, FMemoryBitmap.Height, SRCCOPY);
//end;
//
//function TfrPDF417Barcode.DrawToRect(DC: HDC; R: TRect; Zoom: Integer; AutoZoom: Boolean): Boolean;
//var
//  ZoomX, ZoomY: Integer;
//  X, Y: Integer;
//begin
//  Result := False;
//
//  if Zoom <= 0 then Exit;
//
//  if AutoZoom then
//  begin
//    ZoomX := Round(GetDeviceCaps(DC, LOGPIXELSX) / 100);
//    ZoomY := Round(GetDeviceCaps(DC, LOGPIXELSY) / 100);
//    if ZoomX < 1 then ZoomX := 1;
//    if ZoomY < 1 then ZoomY := 1;
//  end
//  else
//  begin
//    ZoomX := Zoom * FDotSize;
//    ZoomY := ZoomX;
//  end;
//  X := (R.Right - R.Left - FMemoryBitmap.Width * ZoomX) div 2;
//  Y := (R.Bottom - R.Top - FMemoryBitmap.Height * ZoomY) div 2;
//  Result := StretchBlt(DC, X, Y, FMemoryBitmap.Width * ZoomX, Y + FMemoryBitmap.Height * ZoomY,
//    FMemoryBitmap.Canvas.Handle, 0, 0, FMemoryBitmap.Width, FMemoryBitmap.Height, SRCCOPY);
//end;

{$IFDEF ACTIVEX}
function TPDF417BarcodeVCL.GetBarcodeWidth: Integer;
begin
  Result := FMemoryBitmap.Width * FDotSize;
end;

function TPDF417BarcodeVCL.GetBarcodeHeight: Integer;
begin
  Result := FMemoryBitmap.Height * FDotSize;
end;

procedure TPDF417BarcodeVCL.DummyInteger(Value: Integer);
begin
  {Dummy Procedure}
end;
{$ENDIF}

end.

