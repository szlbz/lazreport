unit lr_barcodes2d;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, LR_Class, lr_ubarcodes, LR_Const, LR_Utils, LR_DBRel, LResources;

type

  TBarcode2Type = (bcQR, bcMicroQR, bcAztec, bcAztecRune, bcDataMatrix);

const
  cb2DefaultText = 'BarCode2d';
  bc2Names: array[bcQR..bcDataMatrix] of string =
    ('Barcode_QR', 'Barcode_MicroQR', 'Barcode_Aztec', 'Barcode_AztecRune', 'Barcode_DataMatrix');

type

  { TfrBarCode2d }

  TfrBarCode2d = class(TComponent)
  public
    constructor Create(AOwner: TComponent); override;
  end;

  { TfrCustomBarCode2dView }



  TfrCustomBarCode2dView = class(TfrView)
  private
    FBarType: TBarcode2Type;
    procedure SetBarType(AValue: TBarcode2Type);
  public
    BarCode: TLazBarcodeCustomBase;
    constructor Create(AOwnerPage:TfrPage);override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure SaveToStream(Stream: TStream); override;
    procedure LoadFromStream(Stream: TStream); override;
    procedure SaveToXML(XML: TLrXMLConfig; const Path: String); override;
    procedure LoadFromXML(XML: TLrXMLConfig; const Path: String); override;
    procedure UpdateBarcodeValue;
    procedure Draw(aCanvas: TCanvas); override;
    procedure Print(Stream: TStream); override;
    property BarType: TBarcode2Type read FBarType write SetBarType;
  end;

  TfrBarCode2dView = class(TfrCustomBarCode2dView)
  published
    property BarType;
    property Memo;
    property Script;
  end;

  { TBarCode2dForm }

  TBarCode2dForm = class(TfrObjEditorForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    cbType: TComboBox;
    Image1: TImage;
    Memo1: TMemo;
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    procedure ShowEditor(t: TfrView); override;
  end;

var
  BarCode2dForm: TBarCode2dForm;

implementation

uses LR_Flds;

{$R *.lfm}

procedure InitializeBarc2dAddin;
begin
  if not assigned(BarCode2dForm) {and not (csDesigning in ComponentState)} then
  begin
    BarCode2dForm := TBarCode2dForm.Create(nil);
    frSetAddinEditor(TfrBarCode2dView, BarCode2dForm);
    frSetAddinIcon(TfrBarCode2dView, BarCode2dForm.Image1.Picture.Bitmap);
    frSetAddinHint(TfrBarCode2dView, 'Add BarCode 2d');
  end;
end;

{ TBarCode2dForm }

procedure TBarCode2dForm.FormCreate(Sender: TObject);
var
  I: TBarcode2Type;
begin
  for I := bcQR to bcDataMatrix do
    cbType.Items.Add(bc2Names[I]);
end;

procedure TBarCode2dForm.Button3Click(Sender: TObject);
begin
  frFieldsForm := TfrFieldsForm.Create(nil);
  with frFieldsForm do
  if ShowModal = mrOk then
    if DBField <> '' then
      Memo1.Lines.Text := '[' + DBField + ']';
  frFieldsForm.Free;
end;

procedure TBarCode2dForm.ShowEditor(t: TfrView);
begin
  cbType.ItemIndex := ord(TfrCustomBarCode2dView(t).BarType);
  Memo1.Lines.Text := TfrCustomBarCode2dView(t).Memo.Text;
  if ShowModal = mrOK then
  begin
    TfrCustomBarCode2dView(t).BarType := TBarcode2Type(cbType.ItemIndex);
    TfrCustomBarCode2dView(t).Memo.Text := Memo1.Lines.Text;
  end;
end;

{ TfrBarCode2d }

constructor TfrBarCode2d.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  InitializeBarc2dAddin;
end;

{ TfrCustomBarCode2dView }

procedure TfrCustomBarCode2dView.SetBarType(AValue: TBarcode2Type);
begin
  if FBarType <> AValue then
  begin
    BeforeChange;
    FBarType := AValue;
    BarCode.Free;
    case FBarType of
      bcQR: BarCode := TBarcodeQR.Create(nil);
      bcMicroQR: BarCode := TBarcodeMicroQR.Create(nil);
      bcAztec: BarCode := TBarcodeAztec.Create(nil);
      bcAztecRune: BarCode := TBarcodeAztecRune.Create(nil);
      bcDataMatrix: BarCode := TBarcodeDataMatrix.Create(Nil);
    end;
    AfterChange;
  end;
end;

constructor TfrCustomBarCode2dView.Create(AOwnerPage: TfrPage);
begin
  inherited Create(AOwnerPage);
  Typ := gtAddIn;
  BaseName := 'Bar';
  FBarType := bcQR;
  BarCode := TBarcodeQR.Create(nil);
  Memo.Add(cb2DefaultText);
end;

destructor TfrCustomBarCode2dView.Destroy;
begin
  BarCode.Free;
  BarCode := nil;
  inherited Destroy;
end;

procedure TfrCustomBarCode2dView.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TfrCustomBarCode2dView then
  begin
    FBarType := TfrCustomBarCode2dView(Source).BarType;
    BarCode.Free;
    case FBarType of
      bcQR: BarCode := TBarcodeQR.Create(nil);
      bcMicroQR: BarCode := TBarcodeMicroQR.Create(nil);
      bcAztec: BarCode := TBarcodeAztec.Create(nil);
      bcAztecRune: BarCode := TBarcodeAztecRune.Create(nil);
      bcDataMatrix: BarCode := TBarcodeDataMatrix.Create(Nil);
    end;
  end;
end;

procedure TfrCustomBarCode2dView.SaveToStream(Stream: TStream);
begin
  inherited SaveToStream(Stream);
  Stream.Write(FBarType, SizeOf(FBarType));
end;

procedure TfrCustomBarCode2dView.LoadFromStream(Stream: TStream);
var
  bt: TBarcode2Type;
begin
  inherited LoadFromStream(Stream);
  Stream.Read(bt, SizeOf(bt));
  BarType := bt;
end;

procedure TfrCustomBarCode2dView.SaveToXML(XML: TLrXMLConfig; const Path: String
  );
begin
  inherited SaveToXML(XML, Path);
  XML.SetValue(Path+'BarCode2/BarType', GetSaveProperty('BarType'));
end;

procedure TfrCustomBarCode2dView.LoadFromXML(XML: TLrXMLConfig;
  const Path: String);
begin
  inherited LoadFromXML(XML, Path);
  RestoreProperty('BarType',XML.GetValue(Path+'BarCode2/BarType',''));
end;

procedure TfrCustomBarCode2dView.UpdateBarcodeValue;
var
  S: string;
  I: Integer;

  function IsDigitStr(CheckStr: string): Boolean;
  var
    N: Integer;
  begin
    Result := True;
    for N := 1 to Length(CheckStr) do
      if not (CheckStr[N] in ['0'..'9']) then
      begin
        Result := False;
        Break;
      end;
  end;
begin
  if BarCode is TLazBarcodeCustomText then TLazBarcodeCustomText(BarCode).Text := Memo.Text
  else
  if BarCode is TBarcodeAztecRune then
  begin
    S := Trim(Memo1.Text);
    if IsDigitStr(S) then
    begin
      I := StrToInt(S);
      if (I >= 0) and (I <= 999) then TBarcodeAztecRune(BarCode).Value := I;
    end;
  end;
end;

procedure TfrCustomBarCode2dView.Draw(aCanvas: TCanvas);
begin
  BeginDraw(aCanvas);
  CalcGaps;
  try
    UpdateBarcodeValue;

    BarCode.PaintOnCanvas(aCanvas, DRect);
    ShowFrame;
  finally
    RestoreCoord;
  end;
end;

procedure TfrCustomBarCode2dView.Print(Stream: TStream);
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

initialization
  {$I lr_barcodes2d.lrs}
  BarCode2dForm := nil;
  frRegisterObject(TfrBarCode2dView, nil, '', nil, @InitializeBarc2dAddin);

end.

