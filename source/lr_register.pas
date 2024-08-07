unit LR_Register;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources,
  {$ifdef Chinese}lr_const_CN{$else}lr_const{$endif},
  LR_Class,
  LR_Desgn,
  LR_Barc,
  LR_DBSet,
  LR_DSet,
  LR_RRect,
  LR_Shape,
  LR_ChBox,
  
  LR_E_TXT,
  LR_E_HTM,
  LR_E_CSV,

  LR_PGrid,
  LR_View,
  lr_CrossTab,
  lr_barcodes2d,
  lr_PDF417,
  ComponentEditors,
  LazarusPackageIntf;

{$IFNDEF LCLNOGUI}
type

  { TfrRepEditor }

  TfrRepEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb({%H-}Index: Integer); override;
    function GetVerb({%H-}Index: Integer): string; override;
    function GetVerbCount: Integer; override;
    procedure DoDesign;
  end;
{$ENDIF}
  procedure register;

implementation

{$IFNDEF LCLNOGUI}

{$R lr_register.res}

procedure Register;
begin
  RegisterComponents('LazReport', [TfrReport,TfrDBDataSet,
     TfrBarCodeObject,TfrRoundRectObject,TfrShapeObject,
     TfrCheckBoxObject,TfrCompositeReport,TfrUserDataset,
     TfrTextExport,TfrHTMExport,TfrCSVExport,
     TfrPrintGrid,TfrDesigner,TfrPreview,
     TlrCrossObject,
     TfrBarCode2d, TfrPDF417
     ]);
  RegisterComponentEditor(TfrReport, TfrRepEditor);
end;

{ TfrRepEditor }

procedure TfrRepEditor.ExecuteVerb(Index: Integer);
begin
  doDesign;
end;

function TfrRepEditor.GetVerb(Index: Integer): String;
begin
  Result := sDesignReport;
end;

function TfrRepEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

procedure TfrRepEditor.DoDesign;
begin
  TfrReport(Component).DesignReport;
  if frDesigner <> nil then
    if TfrReportDesigner(frDesigner).Modified then
      Designer.Modified;
end;
{$ELSE}

procedure Register;
begin
end;

{$ENDIF}
end.

