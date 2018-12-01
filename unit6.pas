unit Unit6;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Buttons;

type

  { Tlog_form }

  Tlog_form = class(TForm)
    exitButt: TBitBtn;
    clear_logmemo: TButton;
    Show_logMemo: TButton;
    logMemo: TMemo;
    procedure clear_logmemoClick(Sender: TObject);
    procedure Show_logMemoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  log_form: Tlog_form;
  flog : text;

implementation

{$R *.lfm}

{ Tlog_form }

procedure Tlog_form.FormCreate(Sender: TObject);
begin
   logMemo.lines.loadFromFile('Log.txt');
end;

procedure Tlog_form.clear_logmemoClick(Sender: TObject);
begin
  assignfile(flog, 'Log.txt');
  rewrite(flog);
  closefile(flog);
  logMemo.lines.loadFromFile('Log.txt');
end;

procedure Tlog_form.Show_logMemoClick(Sender: TObject);
begin
  logMemo.lines.loadFromFile('Log.txt');
end;

end.

