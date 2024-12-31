unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls, Unit4, Vcl.Menus, Printers, Vcl.CheckLst, Vcl.Imaging.jpeg, ShellAPI;

type
  TMainWork = class(TForm)
    Image1: TImage;
    ComboBox1: TComboBox;
    Button1: TButton;
    Label1: TLabel;
    Image2: TImage;
    Memo1: TMemo;
    MainMenu1: TMainMenu;
    Label2: TLabel;
    Edit1: TEdit;
    Label3: TLabel;
    ComboBox2: TComboBox;
    PrintDialog1: TPrintDialog;
    Label4: TLabel;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    SaveDialog1: TSaveDialog;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    Label5: TLabel;
    ColorBox1: TColorBox;
    Memo2: TMemo;
    CheckListBox1: TCheckListBox;
    Label6: TLabel;
    Edit2: TEdit;
    N7: TMenuItem;
    Label7: TLabel;
    Edit3: TEdit;
    Button2: TButton;
    OpenDialog1: TOpenDialog;
    N8: TMenuItem;
    SaveDialog2: TSaveDialog;
    procedure Button1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure ColorBox1Select(Sender: TObject);
    procedure CheckListBox1Click(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure CreateParams(var Params: TCreateParams) ; override;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
  FIsSaved: Boolean;
  procedure CalculateAdditions;
  procedure UpdateTotalPrice;
  procedure RemoveOldTotalPriceFromMemo;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainWork: TMainWork;
  f:file;
implementation

{$R *.dfm}

procedure TMainWork.CreateParams(var Params: TCreateParams) ;
begin
  inherited;
  Params.ExStyle := Params.ExStyle or WS_EX_APPWINDOW;
  Params.WndParent := 0;
end;

procedure TMainWork.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Application.Terminate;
end;

procedure TMainWork.Button2Click(Sender: TObject);
begin
  SaveDialog2.Filter := 'Text Files (*.txt)|*.txt';

  if SaveDialog2.Execute then
  begin
    try
      Memo1.Lines.SaveToFile(SaveDialog2.FileName);
      ShowMessage('Заказ успешно оформлен!');
    except
      on E: Exception do
        ShowMessage('Ошибка при сохранении файла: ' + E.Message);
    end;
  end
  else
  begin
    ShowMessage('Сохранение заказа отменено.');
  end;
end;

procedure TMainWork.CalculateAdditions;
var
  ComplectationPrice, OptionsPrice, TotalAdditions: Double;
  i: Integer;
begin
  // Получаем цену комплектации
  case ComboBox2.ItemIndex of
    0: ComplectationPrice := 0;      // Базовая
    1: ComplectationPrice := 5000;   // Стандартная
    2: ComplectationPrice := 10000;  // Люкс
    3: ComplectationPrice := 12000;  // Премиум
    4: ComplectationPrice := 20000;  // Максимальная
  else
    ComplectationPrice := 0;
  end;

  // Получаем цену всех выбранных опций
  OptionsPrice := 0;
  for i := 0 to CheckListBox1.Count - 1 do
  begin
    if CheckListBox1.Checked[i] then
    begin
      case i of
        0: OptionsPrice := OptionsPrice + 500;  // Двухзонный климат-Контроль
        1: OptionsPrice := OptionsPrice + 300;  // Подогрев рулевого колеса
        2: OptionsPrice := OptionsPrice + 300;  // Подогрев лобового стекла
        3: OptionsPrice := OptionsPrice + 450;  // Подогрев сидений
        4: OptionsPrice := OptionsPrice + 152;  // Навигационная система
        5: OptionsPrice := OptionsPrice + 321;  // Адаптивный круиз-контроль
        6: OptionsPrice := OptionsPrice + 252;  // Система контроля слепых зон
        7: OptionsPrice := OptionsPrice + 212;  // Система удержания в полосе
        8: OptionsPrice := OptionsPrice + 150;  // Парктроники (передние и задние)
        9: OptionsPrice := OptionsPrice + 52;   // Камера заднего вида
        10: OptionsPrice := OptionsPrice + 200; // Камеры кругового обзора
        11: OptionsPrice := OptionsPrice + 150; // Бесключевой доступ
        12: OptionsPrice := OptionsPrice + 200; // Панорамная крыша
        13: OptionsPrice := OptionsPrice + 100; // Датчики дождя
        14: OptionsPrice := OptionsPrice + 500; // Тонировка стекол
        15: OptionsPrice := OptionsPrice + 450; // Тонировка стекол фар
        16: OptionsPrice := OptionsPrice + 200; // Комплект для курящих
      end;
    end;
  end;
  TotalAdditions := ComplectationPrice + OptionsPrice;
  Edit2.Text := FloatToStr(TotalAdditions);
  UpdateTotalPrice;
  RemoveOldTotalPriceFromMemo;
  Memo1.Lines.Add('Итоговая цена: ' + Edit3.Text);
end;

procedure TMainWork.UpdateTotalPrice;
var
  BasePrice, AdditionsPrice, TotalPrice: Double;
begin
  BasePrice := StrToFloatDef(Edit1.Text, 0);
  AdditionsPrice := StrToFloatDef(Edit2.Text, 0);
  TotalPrice := BasePrice + AdditionsPrice;
  Edit3.Text := FloatToStr(TotalPrice);
end;

procedure TMainWork.RemoveOldTotalPriceFromMemo;
var
  i: Integer;
begin
  for i := Memo1.Lines.Count - 1 downto 0 do
  begin
    if Pos('Итоговая цена: ', Memo1.Lines[i]) = 1 then
    begin
      Memo1.Lines.Delete(i);
      Break; // Выходим из цикла после удаления строки
    end;
  end;
end;

procedure TMainWork.Button1Click(Sender: TObject);
begin
MainWork.Visible:=false;
Test.show;
end;


procedure TMainWork.CheckListBox1Click(Sender: TObject);
var
  CheckedItem: string;
  i: Integer;
  e:string;
begin
  CheckedItem := CheckListBox1.Items[CheckListBox1.ItemIndex];

  if CheckListBox1.Checked[CheckListBox1.ItemIndex] then
  begin
    Memo1.Lines.Add(CheckedItem);
  end
  else
  begin
    for i := Memo1.Lines.Count - 1 downto 0 do
    begin
      if Memo1.Lines[i] = CheckedItem then
      begin
        Memo1.Lines.Delete(i);
        Break;
      end;
    end;
  end;
    CalculateAdditions;
 UpdateTotalPrice;
end;

procedure TMainWork.ColorBox1Select(Sender: TObject);
var
  SelectedColorName: string;
  i: Integer;
begin
  SelectedColorName := ColorBox1.Items[ColorBox1.ItemIndex];
  for i := Memo1.Lines.Count - 1 downto 0 do
  begin
    if Pos('Цвет: ', Memo1.Lines[i]) = 1 then
    begin
      Memo1.Lines.Delete(i);
      Break;
    end;
  end;
  Memo1.Lines.Add('Цвет: ' + SelectedColorName);
end;

procedure TMainWork.ComboBox1Change(Sender: TObject);
begin
Memo1.Lines.Clear;
Memo2.Lines.Clear;
   case ComboBox1.ItemIndex of
    0: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz А-Класс.jpg');
      Edit1.Text := '29000';
      Memo1.Lines.Add('Модель: Mercedes-Benz А-Класс');
      Memo1.Lines.Add('Цена: 29.000$');
      Memo2.Lines.Add('Модель: Mercedes-Benz А-Класс');
      Memo2.Lines.Add('Год выпуска: 2022');
      Memo2.Lines.Add('Двигатель: 1.3L Turbo');
      Memo2.Lines.Add('Мощность: 163 л.с.');
      Memo2.Lines.Add('Разгон 0-100 км/ч: 8.0 сек');
      Memo2.Lines.Add('Максимальная скорость: 225 км/ч');
    end;
    1: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz AMG GT63S E-perfomance.jpg');
      Edit1.Text := '150000';
      Memo1.Lines.Add('Модель: Mercedes-Benz AMG GT63S E-perfomance');
      Memo1.Lines.Add('Цена: 150.000$');
      Memo2.Lines.Add('Модель: Mercedes-Benz AMG GT63S E-perfomance');
      Memo2.Lines.Add('Год выпуска: 2022');
      Memo2.Lines.Add('Двигатель: 4.0L V8 Biturbo');
      Memo2.Lines.Add('Мощность: 639 л.с.');
      Memo2.Lines.Add('Разгон 0-100 км/ч: 3.2 сек');
      Memo2.Lines.Add('Максимальная скорость: 315 км/ч');
    end;
    2: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz B-Класс.jpg');
      Edit1.Text := '25000';
      Memo1.Lines.Add('Модель: Mercedes-Benz B-Класс');
      Memo1.Lines.Add('Цена: 25.000$');
      Memo2.Lines.Add('Модель: Mercedes-Benz B-Класс');
      Memo2.Lines.Add('Год выпуска: 2022');
      Memo2.Lines.Add('Двигатель: 1.6L');
      Memo2.Lines.Add('Мощность: 122 л.с.');
      Memo2.Lines.Add('Разгон 0-100 км/ч: 10.2 сек');
      Memo2.Lines.Add('Максимальная скорость: 190 км/ч');
    end;
    3: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz C-Класс.jpg');
      Edit1.Text := '42000';
      Memo1.Lines.Add('Модель: Mercedes-Benz C-Класс');
      Memo1.Lines.Add('Цена: 42.000$');
      Memo2.Lines.Add('Модель: Mercedes-Benz C-Класс');
      Memo2.Lines.Add('Год выпуска: 2022');
      Memo2.Lines.Add('Двигатель: 2.0L Turbo');
      Memo2.Lines.Add('Мощность: 255 л.с.');
      Memo2.Lines.Add('Разгон 0-100 км/ч: 6.0 сек');
      Memo2.Lines.Add('Максимальная скорость: 250 км/ч');
    end;
    4: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz C-Класс AMG.jpg');
      Edit1.Text := '80000';
      Memo1.Lines.Add('Модель: Mercedes-Benz C-Класс AMG');
      Memo1.Lines.Add('Цена: 80.000$');
      Memo2.Lines.Add('Модель: Mercedes-Benz C-Класс AMG');
      Memo2.Lines.Add('Год выпуска: 2022');
      Memo2.Lines.Add('Двигатель: 3.0L V6 Turbo');
      Memo2.Lines.Add('Мощность: 385 л.с.');
      Memo2.Lines.Add('Разгон 0-100 км/ч: 4.7 сек');
      Memo2.Lines.Add('Максимальная скорость: 250 км/ч');
    end;
    5: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz CLA.jpg');
      Edit1.Text := '45000';
      Memo1.Lines.Add('Модель: Mercedes-Benz CLA');
      Memo1.Lines.Add('Цена: 45.000$');
      Memo2.Lines.Add('Модель: Mercedes-Benz CLA');
      Memo2.Lines.Add('Год выпуска: 2022');
      Memo2.Lines.Add('Двигатель: 2.0L Turbo');
      Memo2.Lines.Add('Мощность: 221 л.с.');
      Memo2.Lines.Add('Разгон 0-100 км/ч: 6.3 сек');
      Memo2.Lines.Add('Максимальная скорость: 240 км/ч');
    end;
    6: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz CLA AMG.jpg');
      Edit1.Text := '70000';
      Memo1.Lines.Add('Модель: Mercedes-Benz CLA AMG');
      Memo1.Lines.Add('Цена: 70.000$');
      Memo2.Lines.Add('Модель: Mercedes-Benz CLA AMG');
      Memo2.Lines.Add('Год выпуска: 2022');
      Memo2.Lines.Add('Двигатель: 2.0L Turbo');
      Memo2.Lines.Add('Мощность: 382 л.с.');
      Memo2.Lines.Add('Разгон 0-100 км/ч: 4.1 сек');
      Memo2.Lines.Add('Максимальная скорость: 270 км/ч');
    end;
       7: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz E-Класс.jpg');
      Edit1.Text := '60000';
      Memo1.Lines.Add('Модель: Mercedes-Benz E-Класс');
      Memo1.Lines.Add('Цена: 60.000$');
      Memo2.Lines.Add('Модель: Mercedes-Benz E-Класс');
      Memo2.Lines.Add('Год выпуска: 2022');
      Memo2.Lines.Add('Двигатель: 2.0L Turbo');
      Memo2.Lines.Add('Мощность: 255 л.с.');
      Memo2.Lines.Add('Разгон 0-100 км/ч: 6.1 сек');
      Memo2.Lines.Add('Максимальная скорость: 250 км/ч');
    end;
    8: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz E-Класс AMG.jpg');
      Edit1.Text := '100000';
      Memo1.Lines.Add('Модель: Mercedes-Benz E-Класс AMG');
      Memo1.Lines.Add('Цена: 100.000$');
      Memo2.Lines.Add('Модель: Mercedes-Benz E-Класс AMG');
      Memo2.Lines.Add('Год выпуска: 2022');
      Memo2.Lines.Add('Двигатель: 4.0L V8 Biturbo');
      Memo2.Lines.Add('Мощность: 603 л.с.');
      Memo2.Lines.Add('Разгон 0-100 км/ч: 3.3 сек');
      Memo2.Lines.Add('Максимальная скорость: 300 км/ч');
    end;
    9: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz CLS.jpg');
      Edit1.Text := '70000';
      Memo1.Lines.Add('Модель: Mercedes-Benz CLS');
      Memo1.Lines.Add('Цена: 70.000$');
      Memo2.Lines.Add('Модель: Mercedes-Benz CLS');
      Memo2.Lines.Add('Год выпуска: 2022');
      Memo2.Lines.Add('Двигатель: 3.0L Turbo');
      Memo2.Lines.Add('Мощность: 362 л.с.');
      Memo2.Lines.Add('Разгон 0-100 км/ч: 4.8 сек');
      Memo2.Lines.Add('Максимальная скорость: 250 км/ч');
    end;
    10: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz CLS AMG.jpg');
      Edit1.Text := '90000';
      Memo1.Lines.Add('Модель: Mercedes-Benz CLS AMG');
      Memo1.Lines.Add('Цена: 90.000$');
      Memo2.Lines.Add('Модель: Mercedes-Benz CLS AMG');
      Memo2.Lines.Add('Год выпуска: 2022');
      Memo2.Lines.Add('Двигатель: 4.0L V8 Biturbo');
      Memo2.Lines.Add('Мощность: 603 л.с.');
      Memo2.Lines.Add('Разгон 0-100 км/ч: 3.3 сек');
      Memo2.Lines.Add('Максимальная скорость: 300 км/ч');
    end;
    11: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz EQC.jpg');
      Edit1.Text := '110000';
      Memo1.Lines.Add('Модель: Mercedes-Benz EQC');
      Memo1.Lines.Add('Цена: 110.000$');
      Memo2.Lines.Add('Модель: Mercedes-Benz EQC');
      Memo2.Lines.Add('Год выпуска: 2022');
      Memo2.Lines.Add('Электродвигатель: 300 кВт');
      Memo2.Lines.Add('Мощность: 408 л.с.');
      Memo2.Lines.Add('Разгон 0-100 км/ч: 5.1 сек');
      Memo2.Lines.Add('Максимальная скорость: 180 км/ч');
    end;
    12: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz EQG.jpg');
      Edit1.Text := '120000';
      Memo1.Lines.Add('Модель: Mercedes-Benz EQG');
      Memo1.Lines.Add('Цена: 120.000$');
      Memo2.Lines.Add('Модель: Mercedes-Benz EQG');
      Memo2.Lines.Add('Год выпуска: 2022');
      Memo2.Lines.Add('Электродвигатель: 350 кВт');
      Memo2.Lines.Add('Мощность: 476 л.с.');
      Memo2.Lines.Add('Разгон 0-100 км/ч: 4.9 сек');
      Memo2.Lines.Add('Максимальная скорость: 200 км/ч');
    end;
    13: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz EQS.jpg');
      Edit1.Text := '115521';
      Memo1.Lines.Add('Модель: Mercedes-Benz EQS');
      Memo1.Lines.Add('Цена: 115.521$');
      Memo2.Lines.Add('Модель: Mercedes-Benz EQS');
      Memo2.Lines.Add('Год выпуска: 2022');
      Memo2.Lines.Add('Электродвигатель: 400 кВт');
      Memo2.Lines.Add('Мощность: 536 л.с.');
      Memo2.Lines.Add('Разгон 0-100 км/ч: 4.1 сек');
      Memo2.Lines.Add('Максимальная скорость: 210 км/ч');
    end;
    14: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz G-Класс.jpg');
      Edit1.Text := '80000';
      Memo1.Lines.Add('Модель: Mercedes-Benz G-Класс');
      Memo1.Lines.Add('Цена: 80.000$');
      Memo2.Lines.Add('Модель: Mercedes-Benz G-Класс');
      Memo2.Lines.Add('Год выпуска: 2022');
      Memo2.Lines.Add('Двигатель: 4.0L V8');
      Memo2.Lines.Add('Мощность: 416 л.с.');
      Memo2.Lines.Add('Разгон 0-100 км/ч: 5.8 сек');
      Memo2.Lines.Add('Максимальная скорость: 210 км/ч');
    end;
    15: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz G-Класс AMG.jpg');
      Edit1.Text := '105000';
      Memo1.Lines.Add('Модель: Mercedes-Benz G-Класс AMG');
      Memo1.Lines.Add('Цена: 105.000$');
      Memo2.Lines.Add('Модель: Mercedes-Benz G-Класс AMG');
      Memo2.Lines.Add('Год выпуска: 2022');
      Memo2.Lines.Add('Двигатель: 4.0L V8 Biturbo');
      Memo2.Lines.Add('Мощность: 577 л.с.');
      Memo2.Lines.Add('Разгон 0-100 км/ч: 4.5 сек');
      Memo2.Lines.Add('Максимальная скорость: 240 км/ч');
    end;
    16: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz GLC.jpg');
      Edit1.Text := '80.000';
      Memo1.Lines.Add('Модель: Mercedes-Benz GLC');
      Memo1.Lines.Add('Цена: 80.000$');
      Memo2.Lines.Add('Модель: Mercedes-Benz GLC');
      Memo2.Lines.Add('Год выпуска: 2022');
      Memo2.Lines.Add('Двигатель: 2.0L Turbo');
      Memo2.Lines.Add('Мощность: 255 л.с.');
      Memo2.Lines.Add('Разгон 0-100 км/ч: 6.2 сек');
      Memo2.Lines.Add('Максимальная скорость: 240 км/ч');
    end;
    17: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz GLC AMG.jpg');
      Edit1.Text := '120000';
      Memo1.Lines.Add('Модель: Mercedes-Benz GLC AMG');
      Memo1.Lines.Add('Цена: 120.000$');
      Memo2.Lines.Add('Модель: Mercedes-Benz GLC AMG');
      Memo2.Lines.Add('Год выпуска: 2022');
      Memo2.Lines.Add('Двигатель: 4.0L V8 Biturbo');
      Memo2.Lines.Add('Мощность: 503 л.с.');
      Memo2.Lines.Add('Разгон 0-100 км/ч: 3.8 сек');
      Memo2.Lines.Add('Максимальная скорость: 280 км/ч');
    end;
    18: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz GLE-Класс.jpg');
      Edit1.Text := '85000';
      Memo1.Lines.Add('Модель: Mercedes-Benz GLE-Класс');
      Memo1.Lines.Add('Цена: 85.000$');
      Memo2.Lines.Add('Модель: Mercedes-Benz GLE-Класс');
      Memo2.Lines.Add('Год выпуска: 2022');
      Memo2.Lines.Add('Двигатель: 3.0L Turbo');
      Memo2.Lines.Add('Мощность: 362 л.с.');
      Memo2.Lines.Add('Разгон 0-100 км/ч: 5.5 сек');
      Memo2.Lines.Add('Максимальная скорость: 250 км/ч');
    end;
    19: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz GLE Coupe.jpg');
      Edit1.Text := '70000';
      Memo1.Lines.Add('Модель: Mercedes-Benz GLE Coupe');
      Memo1.Lines.Add('Цена: 70.000$');
      Memo2.Lines.Add('Модель: Mercedes-Benz GLE Coupe');
      Memo2.Lines.Add('Год выпуска: 2022');
      Memo2.Lines.Add('Двигатель: 3.0L Turbo');
      Memo2.Lines.Add('Мощность: 362 л.с.');
      Memo2.Lines.Add('Разгон 0-100 км/ч: 5.6 сек');
      Memo2.Lines.Add('Максимальная скорость: 250 км/ч');
    end;
    20: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz GLS.jpg');
      Edit1.Text := '90000';
      Memo1.Lines.Add('Модель: Mercedes-Benz GLS');
      Memo1.Lines.Add('Цена: 90.000$');
      Memo2.Lines.Add('Модель: Mercedes-Benz GLS');
      Memo2.Lines.Add('Год выпуска: 2022');
      Memo2.Lines.Add('Двигатель: 3.0L Turbo');
      Memo2.Lines.Add('Мощность: 362 л.с.');
      Memo2.Lines.Add('Разгон 0-100 км/ч: 5.8 сек');
      Memo2.Lines.Add('Максимальная скорость: 240 км/ч');
    end;
    21: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz GLS AMG.jpg');
      Edit1.Text := '130000';
      Memo1.Lines.Add('Модель: Mercedes-Benz GLS AMG');
      Memo1.Lines.Add('Цена: 130.000$');
      Memo2.Lines.Add('Модель: Mercedes-Benz GLS AMG');
      Memo2.Lines.Add('Год выпуска: 2022');
      Memo2.Lines.Add('Двигатель: 4.0L V8 Biturbo');
      Memo2.Lines.Add('Мощность: 603 л.с.');
      Memo2.Lines.Add('Разгон 0-100 км/ч: 4.1 сек');
      Memo2.Lines.Add('Максимальная скорость: 280 км/ч');
    end;
    22: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz M-Класс.jpg');
      Edit1.Text := '50000';
      Memo1.Lines.Add('Модель: Mercedes-Benz M-Класс');
      Memo1.Lines.Add('Цена: 50.000$');
      Memo2.Lines.Add('Модель: Mercedes-Benz M-Класс');
      Memo2.Lines.Add('Год выпуска: 2022');
      Memo2.Lines.Add('Двигатель: 3.5L V6');
      Memo2.Lines.Add('Мощность: 302 л.с.');
      Memo2.Lines.Add('Разгон 0-100 км/ч: 7.5 сек');
      Memo2.Lines.Add('Максимальная скорость: 224 км/ч');
    end;
    23: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz М-Класс AMG.jpg');
      Edit1.Text := '70000';
      Memo1.Lines.Add('Модель: Mercedes-Benz М-Класс AMG');
      Memo1.Lines.Add('Цена: 70.000$');
      Memo2.Lines.Add('Модель: Mercedes-Benz М-Класс AMG');
      Memo2.Lines.Add('Год выпуска: 2022');
      Memo2.Lines.Add('Двигатель: 5.5L V8 Biturbo');
      Memo2.Lines.Add('Мощность: 518 л.с.');
      Memo2.Lines.Add('Разгон 0-100 км/ч: 4.8 сек');
      Memo2.Lines.Add('Максимальная скорость: 250 км/ч');
    end;
    24: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz S-Класс.jpg');
      Edit1.Text := '120000';
      Memo1.Lines.Add('Модель: Mercedes-Benz S-Класс');
      Memo1.Lines.Add('Цена: 120.000$');
      Memo2.Lines.Add('Модель: Mercedes-Benz S-Класс');
      Memo2.Lines.Add('Год выпуска: 2022');
      Memo2.Lines.Add('Двигатель: 3.0L Turbo');
      Memo2.Lines.Add('Мощность: 429 л.с.');
      Memo2.Lines.Add('Разгон 0-100 км/ч: 4.9 сек');
      Memo2.Lines.Add('Максимальная скорость: 250 км/ч');
    end;
    25: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz S-Класс AMG.jpg');
      Edit1.Text := '155000';
      Memo1.Lines.Add('Модель: Mercedes-Benz S-Класс AMG');
      Memo1.Lines.Add('Цена: 155.000$');
      Memo2.Lines.Add('Модель: Mercedes-Benz S-Класс AMG');
      Memo2.Lines.Add('Год выпуска: 2022');
      Memo2.Lines.Add('Двигатель: 4.0L V8 Biturbo');
      Memo2.Lines.Add('Мощность: 603 л.с.');
      Memo2.Lines.Add('Разгон 0-100 км/ч: 3.5 сек');
      Memo2.Lines.Add('Максимальная скорость: 300 км/ч');
    end;
    26: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz SLK.jpg');
      Edit1.Text := '60.000';
      Memo1.Lines.Add('Модель: Mercedes-Benz SLK');
      Memo1.Lines.Add('Цена: 60.000$');
      Memo2.Lines.Add('Модель: Mercedes-Benz SLK');
      Memo2.Lines.Add('Год выпуска: 2022');
      Memo2.Lines.Add('Двигатель: 2.0L Turbo');
      Memo2.Lines.Add('Мощность: 241 л.с.');
      Memo2.Lines.Add('Разгон 0-100 км/ч: 5.8 сек');
      Memo2.Lines.Add('Максимальная скорость: 250 км/ч');
    end;
    27: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz SLK AMG.jpg');
      Edit1.Text := '90000';
      Memo1.Lines.Add('Модель: Mercedes-Benz SLK AMG');
      Memo1.Lines.Add('Цена: 90.000$');
      Memo2.Lines.Add('Модель: Mercedes-Benz SLK AMG');
      Memo2.Lines.Add('Год выпуска: 2022');
      Memo2.Lines.Add('Двигатель: 5.5L V8');
      Memo2.Lines.Add('Мощность: 415 л.с.');
      Memo2.Lines.Add('Разгон 0-100 км/ч: 4.6 сек');
      Memo2.Lines.Add('Максимальная скорость: 280 км/ч');
    end;
     28: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz SL.jpg');
      Edit1.Text := '80000';
      Memo1.Lines.Add('Модель: Mercedes-Benz SL');
      Memo1.Lines.Add('Цена: 80.000$');
      Memo2.Lines.Add('Модель: Mercedes-Benz SL');
      Memo2.Lines.Add('Год выпуска: 2022');
      Memo2.Lines.Add('Двигатель: 3.0L V6 Turbo');
      Memo2.Lines.Add('Мощность: 362 л.с.');
      Memo2.Lines.Add('Разгон 0-100 км/ч: 4.9 сек');
      Memo2.Lines.Add('Максимальная скорость: 250 км/ч');
    end;
    29: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz SL AMG.jpg');
      Edit1.Text := '100.000';
      Memo1.Lines.Add('Модель: Mercedes-Benz SL AMG');
      Memo1.Lines.Add('Цена: 100.000$');
      Memo2.Lines.Add('Модель: Mercedes-Benz SL AMG');
      Memo2.Lines.Add('Год выпуска: 2022');
      Memo2.Lines.Add('Двигатель: 4.0L V8 Biturbo');
      Memo2.Lines.Add('Мощность: 577 л.с.');
      Memo2.Lines.Add('Разгон 0-100 км/ч: 3.7 сек');
      Memo2.Lines.Add('Максимальная скорость: 300 км/ч');
    end;
    30: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz Vito.jpg');
      Edit1.Text := '30000';
      Memo1.Lines.Add('Модель: Mercedes-Benz Vito');
      Memo1.Lines.Add('Цена: 30.000$');
      Memo2.Lines.Add('Модель: Mercedes-Benz Vito');
      Memo2.Lines.Add('Год выпуска: 2022');
      Memo2.Lines.Add('Двигатель: 2.0L Diesel');
      Memo2.Lines.Add('Мощность: 174 л.с.');
      Memo2.Lines.Add('Разгон 0-100 км/ч: 10.5 сек');
      Memo2.Lines.Add('Максимальная скорость: 190 км/ч');
    end;
    31: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz V-Класс.jpg');
      Edit1.Text := '60000';
      Memo1.Lines.Add('Модель: Mercedes-Benz V-Класс');
      Memo1.Lines.Add('Цена: 60.000$');
      Memo2.Lines.Add('Модель: Mercedes-Benz V-Класс');
      Memo2.Lines.Add('Год выпуска: 2022');
      Memo2.Lines.Add('Двигатель: 2.1L Diesel');
      Memo2.Lines.Add('Мощность: 190 л.с.');
      Memo2.Lines.Add('Разгон 0-100 км/ч: 9.1 сек');
      Memo2.Lines.Add('Максимальная скорость: 199 км/ч');
    end;
    32: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz X-Класс.jpg');
      Edit1.Text := '70000';
      Memo1.Lines.Add('Модель: Mercedes-Benz X-Класс');
      Memo1.Lines.Add('Цена: 70.000$');
      Memo2.Lines.Add('Модель: Mercedes-Benz X-Класс');
      Memo2.Lines.Add('Год выпуска: 2022');
      Memo2.Lines.Add('Двигатель: 3.0L V6 Turbo Diesel');
      Memo2.Lines.Add('Мощность: 258 л.с.');
      Memo2.Lines.Add('Разгон 0-100 км/ч: 7.9 сек');
      Memo2.Lines.Add('Максимальная скорость: 205 км/ч');
    end;
end;
  CalculateAdditions;
UpdateTotalPrice;
end;

procedure TMainWork.ComboBox2Change(Sender: TObject);
var
  SelectedComplectation: string;
  i: Integer;
  e:string;
begin
  SelectedComplectation := ComboBox2.Items[ComboBox2.ItemIndex];
  for i := Memo1.Lines.Count - 1 downto 0 do
  begin
    if Pos('Комплектация: ', Memo1.Lines[i]) = 1 then
    begin
      Memo1.Lines.Delete(i);
      Break;
    end;
  end;
  Memo1.Lines.Add('Комплектация: ' + SelectedComplectation);
  CalculateAdditions;
end;

procedure TMainWork.N2Click(Sender: TObject);
var
  i: Integer;
  TextHeight: Integer;
begin
  if PrintDialog1.Execute then
  begin
    // Начало печати
    Printer.BeginDoc;
    try
      // Установка начальной позиции для печати
      TextHeight := Printer.Canvas.TextHeight('W') + 5; // Высота строки с отступом
      // Печать содержимого Memo1 построчно
      for i := 0 to Memo1.Lines.Count - 1 do
      begin
        Printer.Canvas.TextOut(100, 100 + i * TextHeight, Memo1.Lines[i]);
      end;
    finally
      // Завершение печати
      Printer.EndDoc;
    end;
  end;
end;


procedure TMainWork.N3Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
  begin
    Memo1.Lines.SaveToFile(SaveDialog1.FileName);
  end;
end;

procedure TMainWork.N4Click(Sender: TObject);
var
  Response: Integer;
begin
  if FIsSaved then
  begin
    Close;  // Если сохранение выполнено, закрываем программу
  end
  else
  begin
    Response := MessageDlg('Вы действительно хотите закрыть программу без сохранения?', mtConfirmation, [mbYes, mbNo, mbCancel], 0);
    case Response of
      mrYes: application.Terminate; // Если нажали "Да", закрываем программу
      mrNo, mrCancel: ;  // Если нажали "Нет" или "Отмена", ничего не делаем
    end;
  end;
end;

procedure TMainWork.N6Click(Sender: TObject);
begin
ShowMessage('Автор сей изумительной программы - Занковский Мирослав Геннадьевич');
end;

procedure TMainWork.N7Click(Sender: TObject);
var
  FileContent: TStringList;
begin
  OpenDialog1.Filter := 'Text Files (*.txt)|*.txt';
  if OpenDialog1.Execute then
  begin
    FileContent := TStringList.Create;
    try
      FileContent.LoadFromFile(OpenDialog1.FileName);
      Memo1.Clear;
      Memo1.Lines.Assign(FileContent);
    finally
      FileContent.Free;
    end;
  end;
end;

procedure TMainWork.N8Click(Sender: TObject);
begin
ShellExecute(0, PChar('Open'),PChar('MyHelpFile.chm'),nil,nil,SW_SHOW);
end;

end.
