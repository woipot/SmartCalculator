unit Unit4;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, StdCtrls;

type

  { Tsource_form }

  Tsource_form = class(TForm)
    Exitnut: TBitBtn;
    UnitMemo: TMemo;
    UnitGroup: TRadioGroup;
    procedure UnitGroupClick(Sender: TObject);
    procedure UnitMemoChange(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  source_form: Tsource_form;

implementation

{$R *.lfm}

{ Tsource_form }

procedure Tsource_form.UnitGroupClick(Sender: TObject);
begin
  UnitMemo.lines.loadFromFile(UnitGroup.Items[UnitGroup.ItemIndex]);
end;

procedure Tsource_form.UnitMemoChange(Sender: TObject);
begin

end;


end.

