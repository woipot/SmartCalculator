unit Unit5;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Buttons,
  StdCtrls;

type

  { TForm5 }

  TForm5 = class(TForm)
    BitBtn1: TBitBtn;
    Button1: TButton;
    Button2: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form5: TForm5;
  flog : text;

implementation

{$R *.lfm}

{ TForm5 }

procedure TForm5.FormCreate(Sender: TObject);
begin
  memo1.lines.loadFromFile('Log.txt');
end;

procedure TForm5.Button1Click(Sender: TObject);
begin
  memo1.lines.loadFromFile('Log.txt');
end;

procedure TForm5.Button2Click(Sender: TObject);
begin
  assignfile(flog,'Log.txt');
  rewrite(flog);
  closefile(flog);
  memo1.lines.loadFromFile('Log.txt');
end;


end.

