unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Buttons;

type

  { TAbout_student }

  TAbout_student = class(TForm)
    exitBut: TBitBtn;
    Headpicture: TImage;
    student_name: TLabel;
    procedure exitButClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  About_student: TAbout_student;

implementation

{$R *.lfm}

{ TAbout_student }


procedure TAbout_student.exitButClick(Sender: TObject);
begin

end;

end.

