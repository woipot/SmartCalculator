unit Unit3;

{$mode objfpc}{$H+}

interface
uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Buttons;

type

  { Thelp_form }

  Thelp_form = class(TForm)
    exitBut: TBitBtn;
    help_text: TMemo;
    procedure BitBtn1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  help_form: Thelp_form;

implementation

{$R *.lfm}

{ Thelp_form }

procedure Thelp_form.BitBtn1Click(Sender: TObject);
begin

end;

end.

