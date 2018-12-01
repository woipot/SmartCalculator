program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, Unit1, Unit2, Unit3, Unit4, Unit6;

{$R *.res}

begin
  Application.Title:='calculator';
  RequireDerivedFormResource:=True;
  Application.Initialize;
  Application.CreateForm(Tcalculator, calculator);
  Application.CreateForm(TAbout_student, About_student);
  Application.CreateForm(Thelp_form, help_form);
  Application.CreateForm(Tsource_form, source_form);
  Application.CreateForm(Tlog_form, log_form);
  Application.Run;
end.

