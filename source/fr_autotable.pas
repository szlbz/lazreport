unit FR_AUTOTABLE;

{$mode Delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls;

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
    procedure Edit1KeyPress(Sender: TObject; var Key: char);
  private

  public

  end;

var
  AUTOTABLEFORM: TAUTOTABLEFORM;

implementation

{$R *.lfm}

{ TAUTOTABLEFORM }

procedure TAUTOTABLEFORM.Edit1KeyPress(Sender: TObject; var Key: char);
begin
  if key=#13 then
  begin
    key:=#0;
    close;
  end;
end;

end.

