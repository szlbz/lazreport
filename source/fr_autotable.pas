unit FR_AUTOTABLE;

interface
{$I LR_Vers.inc}

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls,
  {$ifdef Chinese}lr_const_CN{$else}lr_const{$endif};

type

  { TAUTOTABLEFORM }

  TAUTOTABLEFORM = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    UpDown1: TUpDown;
    UpDown2: TUpDown;
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  AUTOTABLEFORM: TAUTOTABLEFORM;

implementation

{$R *.lfm}

{ TAUTOTABLEFORM }

procedure TAUTOTABLEFORM.FormCreate(Sender: TObject);
begin
  caption:=sFRDesignerFormCellsplitting;
  Label1.Caption:=sFRDesignerFormNumberofrows;
  Label2.Caption:=sFRDesignerFormNumberofcols;
  Button1.Caption:=sOk;
end;

end.

