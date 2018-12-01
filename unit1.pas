unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Menus,
  StdCtrls, Unit2, Unit3, Unit4, Unit6;

type

  { Tcalculator }

  Tcalculator = class(TForm)
    TestEdit: TEdit;
    number7: TButton;
    namberA: TButton;
    NumberB: TButton;
    NumberC: TButton;
    numberD: TButton;
    numberE: TButton;
    numberF: TButton;
    logbutton: TButton;
    inData: TLabel;
    outData: TLabel;
    ErrorEdit: TEdit;
    negativeButton: TButton;
    systembox2: TComboBox;
    systembox1: TComboBox;
    logActivate: TToggleBox;
    zeroButton: TButton;
    pointerButton: TButton;
    ButtonPLus: TButton;
    ButtonMinus: TButton;
    ButtonUmno: TButton;
    enterBUtton: TButton;
    CEButton: TButton;
    CButton: TButton;
    deliteCh: TButton;
    number8: TButton;
    devisionButton: TButton;
    number9: TButton;
    number4: TButton;
    number5: TButton;
    number6: TButton;
    number1: TButton;
    number2: TButton;
    number3: TButton;
    numberEdit: TEdit;
    exampleEdit: TEdit;
    headmenu: TMainMenu;
    Tmainmenu: TMainMenu;
    File_menu: TMenuItem;
    CloseProgramm: TMenuItem;
    help_menu: TMenuItem;
    help: TMenuItem;
    about: TMenuItem;
    source: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure logbuttonClick(Sender: TObject);
    procedure enterBUttonClick(Sender: TObject);
    procedure devisionButtonClick(Sender: TObject);
    procedure numberEditKeyPress(Sender: TObject; var Key: char);
    procedure pointerButtonClick(Sender: TObject);
    procedure negativeButtonClick(Sender: TObject);
    procedure systembox1Change(Sender: TObject);
    procedure zeroButtonClick(Sender: TObject);
    procedure deliteChClick(Sender: TObject);
    procedure CButtonClick(Sender: TObject);
    procedure CEButtonClick(Sender: TObject);
    procedure number1Click(Sender: TObject);
    procedure CloseProgrammClick(Sender: TObject);
    procedure helpClick(Sender: TObject);
    procedure aboutClick(Sender: TObject);
    procedure sourceClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  calculator: Tcalculator;
  first_number, second_number : extended;
  first_tmp_diget : extended;
  Oper_str : string;
  flog : text;

implementation

{$R *.lfm}
{ Tcalculator }

function antigorner(number_to_str : extended; power : integer) : string;
var
  antigorner_str, mantisa_str, not_str : string;
  tmp_number, int_copu_number, not_switch : comp;
  manti_counter : shortint;
  manti_number : extended;
  int_tmp : integer;
begin

  if (number_to_str <> 0) then
  begin

    if (number_to_str < 0) then
    begin
      not_str := '-'; // обнуляем строку дял целой части c миусом
      not_switch := 1;
      number_to_str := abs(number_to_str);
    end else begin
      antigorner_str := '';
      not_switch := 0;
      end;

    if (number_to_str > 2000000000000000000) then begin
      antigorner := '0';
      calculator.ErrorEdit.text := 'very long';
      exit;
    end;

    int_copu_number :=  trunc(number_to_str); // берем целую часть числа

    if (int_copu_number <> 0 ) then
    while (int_copu_number > 0) do //целая часть
    begin
      tmp_number := int_copu_number mod power;

      if ((tmp_number >= 0) and (tmp_number <= 9 )) then
        antigorner_str := chr(tmp_number + 48) + antigorner_str
      else
        antigorner_str := chr(tmp_number + 55) + antigorner_str;

    int_copu_number := int_copu_number div power;
    end else
      antigorner_str := '0';


    manti_number := frac(number_to_str);
    if (manti_number <> 0) then
    begin
      mantisa_str := '.'; //для мантисы

      for manti_counter := 1 to 10 do
      begin
        int_tmp :=  trunc(manti_number * power);
        if (int_tmp < 10) then
          mantisa_str := mantisa_str + chr(int_tmp + 48)
        else
          mantisa_str := mantisa_str + chr(int_tmp + 55);

        manti_number := frac(manti_number * power);
      end;

      if (not_switch = 0) then
        antigorner := antigorner_str + mantisa_str
      else
        antigorner := not_str + antigorner_str + mantisa_str

    end else
      if (not_switch = 0) then
         antigorner := antigorner_str
      else
        antigorner := not_str + antigorner_str;

    end else
      antigorner := '0';

    if length(antigorner) > 23 then begin
    calculator.ErrorEdit.text := 'very long';
    antigorner := '0';
  end;
end;

function gorner(str_to_ext : string; power : integer) : extended;
var
  gorner_ext, mantisa_ext, val_extend : extended;
  i, switch, modul_switch, val_code : shortint;
  divisor : extended;
begin
  gorner_ext := 0;
  switch := 0;
  divisor := power;
  mantisa_ext := 0;

  if (str_to_ext[1] = '-') then begin
    modul_switch := -1;
    delete(str_to_ext, 1, 1);
  end else
    modul_switch := 1;


  for i := 1 to length(str_to_ext) do
  begin
    if (str_to_ext[i] = '.') then
      switch := 1
    else if ((ord(str_to_ext[i]) >= 65) and (ord(str_to_ext[i]) <= 70) and (switch = 0)) then
      gorner_ext := gorner_ext * power + ord(str_to_ext[i]) - 55
    else if ((ord(str_to_ext[i]) >= 48) and (ord(str_to_ext[i]) <= 57) and (switch = 0)) then
      gorner_ext := gorner_ext * power + ord(str_to_ext[i]) - 48
    else if ((switch = 1) and (ord(str_to_ext[i]) >= 65) and (ord(str_to_ext[i]) <= 70)) then
    begin
      mantisa_ext := mantisa_ext + (ord(str_to_ext[i]) - 55) / divisor;
      divisor := divisor * power;
    end
    else if ((switch = 1) and (ord(str_to_ext[i]) >= 48) and (ord(str_to_ext[i]) <= 57) ) then
    begin
      mantisa_ext := mantisa_ext + (ord(str_to_ext[i]) - 48) / divisor;
      divisor := divisor * power;
    end;
  end;

  gorner_ext := (gorner_ext + mantisa_ext) * modul_switch ;
  gorner := gorner_ext;
end;

function operation(operat : string) : string;
begin
  case operat of
  '+' : begin
          first_number := first_number + second_number;
          operation := 'Успешно';
        end;
  '-' : begin
          first_number := first_number - second_number;
          operation := 'Успешно';
        end;
  '*' : begin
          first_number := first_number * second_number;
          operation := 'Успешно';
        end;
  '÷','/' : begin
          if (second_number = 0) then begin
            operation := 'Деление на ноль невозможно';
            first_number := 0 ;
          end
          else begin
            first_number := first_number / second_number;
            operation := 'Успешно';
          end;
        end;
  end;


end;

procedure Tcalculator.number1Click(Sender: TObject);  //для кнопок ввода
begin
  if (numberEdit.Text = '0') then
   numberEdit.text := tButton(Sender).caption
  else
    numberEdit.text := numberEdit.text + tButton(Sender).caption;
end;

procedure Tcalculator.CEButtonClick(Sender: TObject);//ce
begin
  numberEdit.text := '0';
end;

procedure Tcalculator.CButtonClick(Sender: TObject);   //c
begin
  numberEdit.text := '0';
  exampleEdit.text := '';
  oper_str := '';
end;

procedure Tcalculator.deliteChClick(Sender: TObject);//delite
var
  str :string;
begin
  str := numberEdit.text;

  if str <> '' then begin
    delete(str, length(str), 1);
    numberEdit.text := str;
  end;

  if (length(str) = 0) then
    numberEdit.text := '0';
end;

procedure Tcalculator.zeroButtonClick(Sender: TObject); // 0
begin
   if numberEdit.text <> '0' then
    numberEdit.Text := numberEdit.Text + '0'
  else
    numberEdit.text := numberEdit.text + '.0';
end;

procedure Tcalculator.negativeButtonClick(Sender: TObject);  // -+
var
  l_str : string;
  ext_test_tmp : extended;
begin
  if (numberEdit.text <> '') then begin
  l_str := numberEdit.text;
  val(l_str, ext_test_tmp);

  if (ext_test_tmp > 0) then
    numberEdit.text := '-' + numberEdit.text
  else if (strtofloat(numberEdit.text)<0) then begin
    delete(l_str, 1, 1);
    numberEdit.text := l_str;
  end
  else if (numberEdit.text <> '0') then
    numberEdit.text := '-' + numberEdit.text;

  end;
end;

procedure Tcalculator.systembox1Change(Sender: TObject);  //боксы изменять
begin
  numberEdit.text := '0';

  case systembox1.text of
  '10':begin
        number2.Enabled := true; //2
        number3.Enabled := true; //3
        number4.Enabled := true; //4
        number5.Enabled := true; //5
        number6.Enabled := true; //6
        number7.Enabled := true; //7
        number8.Enabled := true; //8
        number9.Enabled := true; //9
        namberA.Enabled := false;
        NumberB.Enabled := false;
        NumberC.Enabled := false;
        numberD.Enabled := false;
        numberE.Enabled := false;
        numberF.Enabled := false;
        //numberEdit.MaxLength := 8;
       end;
  '2':begin
        number2.Enabled := false; //2
        number3.Enabled := false; //3
        number4.Enabled := false; //4
        number5.Enabled := false; //5
        number6.Enabled := false; //6
        number7.Enabled := false; //7
        number8.Enabled := false; //8
        number9.Enabled := false; //9
        namberA.Enabled := false;
        NumberB.Enabled := false;
        NumberC.Enabled := false;
        numberD.Enabled := false;
        numberE.Enabled := false;
        numberF.Enabled := false;
        //numberEdit.Maxlength := 20;
       end;
  '4':begin
        number2.Enabled := true; //2
        number3.Enabled := true; //3
        number4.Enabled := false; //4
        number5.Enabled := false; //5
        number6.Enabled := false; //6
        number7.Enabled := false; //7
        number8.Enabled := false; //8
        number9.Enabled := false; //9
        namberA.Enabled := false;
        NumberB.Enabled := false;
        NumberC.Enabled := false;
        numberD.Enabled := false;
        numberE.Enabled := false;
        numberF.Enabled := false;
        //numberEdit.Maxlength := 16;
      end;
  '8':begin
        number2.Enabled := true; //2
        number3.Enabled := true; //3
        number4.Enabled := true; //4
        number5.Enabled := true; //5
        number6.Enabled := true; //6
        number7.Enabled := true; //7
        number8.Enabled := false; //8
        number9.Enabled := false; //9
        namberA.Enabled := false;
        NumberB.Enabled := false;
        NumberC.Enabled := false;
        numberD.Enabled := false;
        numberE.Enabled := false;
        numberF.Enabled := false;
        //numberEdit.Maxlength := 12;
      end;
  '16':begin
        number2.Enabled := true; //2
        number3.Enabled := true; //3
        number4.Enabled := true; //4
        number5.Enabled := true; //5
        number6.Enabled := true; //6
        number7.Enabled := true; //7
        number8.Enabled := true; //8
        number9.Enabled := true; //9
        namberA.Enabled := true;
        NumberB.Enabled := true;
        NumberC.Enabled := true;
        numberD.Enabled := true;
        numberE.Enabled := true;
        numberF.Enabled := true;
        //numberEdit.Maxlength := 5;
      end;
  end;
end;

procedure Tcalculator.pointerButtonClick(Sender: TObject);  //,
var
  i, k : integer;
begin
  if numberEdit.text <> '' then begin
  for i := 1 to length(numberEdit.text) do
    if numberEdit.text[i] = '.' then
      k:= 1;

  if (k <> 1) then
    numberEdit.text := numberEdit.text + '.';

  end;
end;

procedure Tcalculator.devisionButtonClick(Sender: TObject);  // operations
begin
  {$i-}
    append(flog);
  {$i+}
  if IOResult <> 0 then
   begin
     ErrorEdit.text := 'Error when open file!';
     {$i-}
       rewrite(flog);
     {$i+}
      if IOResult <> 0 then
      begin
        ErrorEdit.text := 'жизнь без логов';
        logActivate.checked := false;
        logActivate.enabled := false;
      end;
   end;

  if (numberEdit.text[1] = '-') then
    exampleEdit.text := exampleEdit.text + '(' + numberEdit.text + ')' + '{' + systembox1.text +'}' + tButton(Sender).caption
  else
    exampleEdit.text := exampleEdit.text + numberEdit.text + '{' + systembox1.text +'}' + tButton(Sender).caption;

  if (oper_str = '') then begin
    oper_str := tButton(Sender).caption;

    first_number := gorner(numberEdit.text, StrToInt(systembox1.text));
    //TestEdit.text := floatToStr(First_number);   //отладка

    if (logActivate.checked = true) then //логи
      write(flog, numberEdit.text +'{' + systembox1.text +'}');

  end else begin
    second_number := gorner (numberEdit.text, StrToInt(systembox1.text));
    if (logActivate.checked = true) then //логи
      write(flog, oper_str + numberEdit.text +'{' + systembox1.text +'}');

    ErrorEdit.text := operation(oper_str);
    TestEdit.text :='= ' + floatToStr(First_number) + ' {10}';//отладка

    oper_str := tButton(SEnder).caption;
  end;
  numberEdit.text := '0';

  closefile(fLog);
end;

procedure Tcalculator.enterBUttonClick(Sender: TObject); // = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
begin
  {$i-}
    append(flog);
  {$i+}
  if IOResult <> 0 then
   begin
     ErrorEdit.text := 'Error when open file!';
     {$i-}
       rewrite(flog);
     {$i+}
      if IOResult <> 0 then
      begin
        ErrorEdit.text := 'жизнь без логов';
        logActivate.checked := false;
        logActivate.enabled := false;
      end;
   end;

  if (oper_str <> '') then begin               //проверяем операцию

    second_number := gorner(numberEdit.text, StrtoInt(systemBox1.text)); // второе число записываем
    if (logActivate.checked = true) then //логи
      write(flog,oper_str + NumberEdit.text + '{' + systembox1.text + '}');

    ErrorEdit.text := operation(oper_str); // производим операцию
    TestEdit.text := '= ' + floatTostr(First_number) + ' {10}';//отладка
    {if (length(numberEdit.text)>15) then begin
      numberEdit.text := '0';
      exampleEdit.text := '';
    end;}


    if (ErrorEdit.text <> 'Деление на ноль невозможно') then begin
      NumberEdit.MaxLength := 20;
      NumberEdit.text := antigorner(first_number, StrToInt(systembox2.text)); //переписываем новое числj

    if (logActivate.checked = true) then //логи
      writeln(flog,' = ' + NumberEdit.text + '{' + systembox2.text + '}');

      systembox1.text := systembox2.text; //вводим новую систему
      case systembox1.text of
  '10':begin
        number2.Enabled := true; //2
        number3.Enabled := true; //3
        number4.Enabled := true; //4
        number5.Enabled := true; //5
        number6.Enabled := true; //6
        number7.Enabled := true; //7
        number8.Enabled := true; //8
        number9.Enabled := true; //9
        namberA.Enabled := false;
        NumberB.Enabled := false;
        NumberC.Enabled := false;
        numberD.Enabled := false;
        numberE.Enabled := false;
        numberF.Enabled := false;
        //numberEdit.MaxLength := 8;
       end;
  '2':begin
        number2.Enabled := false; //2
        number3.Enabled := false; //3
        number4.Enabled := false; //4
        number5.Enabled := false; //5
        number6.Enabled := false; //6
        number7.Enabled := false; //7
        number8.Enabled := false; //8
        number9.Enabled := false; //9
        namberA.Enabled := false;
        NumberB.Enabled := false;
        NumberC.Enabled := false;
        numberD.Enabled := false;
        numberE.Enabled := false;
        numberF.Enabled := false;
        //numberEdit.Maxlength := 20;
       end;
  '4':begin
        number2.Enabled := true; //2
        number3.Enabled := true; //3
        number4.Enabled := false; //4
        number5.Enabled := false; //5
        number6.Enabled := false; //6
        number7.Enabled := false; //7
        number8.Enabled := false; //8
        number9.Enabled := false; //9
        namberA.Enabled := false;
        NumberB.Enabled := false;
        NumberC.Enabled := false;
        numberD.Enabled := false;
        numberE.Enabled := false;
        numberF.Enabled := false;
        //numberEdit.Maxlength := 16;
      end;
  '8':begin
        number2.Enabled := true; //2
        number3.Enabled := true; //3
        number4.Enabled := true; //4
        number5.Enabled := true; //5
        number6.Enabled := true; //6
        number7.Enabled := true; //7
        number8.Enabled := false; //8
        number9.Enabled := false; //9
        namberA.Enabled := false;
        NumberB.Enabled := false;
        NumberC.Enabled := false;
        numberD.Enabled := false;
        numberE.Enabled := false;
        numberF.Enabled := false;
        //numberEdit.Maxlength := 12;
      end;
  '16':begin
        number2.Enabled := true; //2
        number3.Enabled := true; //3
        number4.Enabled := true; //4
        number5.Enabled := true; //5
        number6.Enabled := true; //6
        number7.Enabled := true; //7
        number8.Enabled := true; //8
        number9.Enabled := true; //9
        namberA.Enabled := true;
        NumberB.Enabled := true;
        NumberC.Enabled := true;
        numberD.Enabled := true;
        numberE.Enabled := true;
        numberF.Enabled := true;
        //numberEdit.Maxlength := 5;
      end;
  end;
    end else  begin
      exampleEdit.text := '';
      NumberEdit.text := '0';
    end;

    oper_str := ''; //обнуляем оперцию

  end else
    numberEdit.text := '0';

  closefile(fLog);
  exampleEdit.text := ''; //поле для пример  очищаем
end;

procedure Tcalculator.logbuttonClick(Sender: TObject);
begin
  log_form.ShowModal;
end;

procedure Tcalculator.FormCreate(Sender: TObject);
begin
  assignfile(flog,'Log.txt');
   first_number := 0;
   second_number := 0;

end;

procedure numbers(num : string);
begin
  if (calculator.systembox1.text = '16') then
    num := uppercase(num);

  if (calculator.numberEdit.Text = '0') then
    calculator.numberEdit.text := num
  else
    calculator.numberEdit.text := calculator.numberEdit.text + num;
end;
  //////////// перехват
procedure Tcalculator.numberEditKeyPress(Sender: TObject; var Key: char);
var
  code : integer;
begin
  code := ord(key);
  if (code = 13) then
    enterbuttonclick(self)
  else if (code = 8) then
    deliteChclick(self)
  else if (code = 46) then
    pointerButtonclick(self)
  else if (code = 42) or (code = 43) or (code = 45) or (code = 47) then begin
    devisionButton.caption := chr(code);
    devisionButton.Click;
    devisionButton.caption := '÷';
  end else
  case systembox1.text of
  '10' : if (code in [48..57]) then
           numbers(key);
  '16' : if (code in [48..57]) or (code in [97..102]) then
           numbers(key);
  '8' :  if (code in [48..55]) then
           numbers(key);
  '4' :  if (code in [48..51]) then
           numbers(key);
  '2' :  if (code in [48..49]) then
           numbers(key);
  end;
end;
/////////////////////

/////////////////////меню
procedure Tcalculator.CloseProgrammClick(Sender: TObject);
begin
  close;
end;

procedure Tcalculator.helpClick(Sender: TObject);
begin
  help_form.ShowModal;
end;

procedure Tcalculator.aboutClick(Sender: TObject);
begin
  About_student.ShowModal;
end;

procedure Tcalculator.sourceClick(Sender: TObject);
begin
  source_form.ShowModal;
end;

end.
