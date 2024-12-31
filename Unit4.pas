unit Unit4;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TTest = class(TForm)
    RadioGroup1: TRadioGroup;
    RadioGroup2: TRadioGroup;
    Label1: TLabel;
    Button2: TButton;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure CreateParams(var Params: TCreateParams) ; override;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Test: TTest;
  f: text;
  s: string;
  Nvern, ball, totalQuestions: integer;

implementation

uses Unit3;

{$R *.dfm}

procedure TTest.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.ExStyle := Params.ExStyle or WS_EX_APPWINDOW;
  Params.WndParent := 0;
end;

procedure TTest.Button1Click(Sender: TObject);
begin
mainwork.Visible:=true;
test.hide;
end;

procedure TTest.Button2Click(Sender: TObject);
begin
  // Если выбран вариант ответа и не достигнут конец файла
  if (RadioGroup2.ItemIndex > -1) and (not Eof(f)) then
  begin
    totalQuestions := totalQuestions + 1; // Увеличиваем общее количество вопросов
    // Если выбранный вариант соответствует номеру верного ответа, то балл прибавляется
    if RadioGroup2.ItemIndex = Nvern - 1 then
    begin
      ball := ball + 1;
      Label1.Caption := 'Верно!';
    end
    else
    begin
      Label1.Caption := 'Неверно';
    end;
    RadioGroup2.Items.Clear; // Очищается поле для следующего вопроса
    repeat
      if (s[1] = '-') then
      begin
        delete(s, 1, 1);
        RadioGroup2.Caption := s;
      end
      else if s[1] = '*' then
      begin
        delete(s, 1, 1);
        Nvern := StrToInt(s);
      end
      else
        RadioGroup2.Items.Add(s);
      readln(f, s);
    until (s[1] = '-') or Eof(f);
  end
  // Если конец файла достигнут, значит вопросы закончились
  else if Eof(f) then
  begin
    delete(s, 1, 1);
    Nvern := StrToInt(s);
    totalQuestions := totalQuestions + 1; // Увеличиваем общее количество вопросов
    if RadioGroup2.ItemIndex = Nvern - 1 then
    begin
      ball := ball + 1;
      Label1.Caption := 'Верно!';
    end
    else
    begin
      Label1.Caption := 'Неверно';
    end;
    // Вычисляем процент правильных ответов
    Label1.Caption := Label1.Caption + Format('. Ваш результат: %d%% правильных ответов', [Round(ball / totalQuestions * 100)]);
    CloseFile(f);
    Button1.Enabled := False; // Кнопка становится недоступной в завершении проекта
    Button2.Enabled:=True;
  end;
end;

procedure TTest.RadioGroup1Click(Sender: TObject);
begin
  RadioGroup1.Enabled := false; // Выбор варианта становится недоступен
  RadioGroup2.Enabled := true; // Доступным становится поле с вопросом
  Button1.Enabled := true; // Кнопка Далее
  case RadioGroup1.ItemIndex of
    // В зависимости от выбранного варианта переменная f
    0: AssignFile(f, (ExtractFilePath(Application.ExeName) + 'variant1.txt')); // связывается с разными файлами
    1: AssignFile(f, (ExtractFilePath(Application.ExeName) + 'variant2.txt'));
  end;
  reset(f); // Открываем файл для чтения
  readln(f, s); // Считываем первую строку из файла
  ball := 0; // изначально количество баллов 0
  totalQuestions := 0; // изначально количество вопросов 0
  repeat
    if (s[1] = '-') then
    begin
      // Если первый символ строки ‘-’ значит это вопрос
      delete(s, 1, 1);
      RadioGroup2.Caption := s;
    end
    else if s[1] = '*' then
    begin
      // Если первый символ ‘*’ значит это номер верного ответа
      delete(s, 1, 1);
      Nvern := StrToInt(s);
    end
    else
      RadioGroup2.Items.Add(s); // Иначе это вариант ответа
    readln(f, s); // Считываем следующую строку из файла
  until (s[1] = '-') or Eof(f); // Считывание и отправление вариантов ответов в RadiGroup до тех пор
  // пока не достигнут следующий вопрос или конец файла
end;

end.
