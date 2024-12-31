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
      ShowMessage('����� ������� ��������!');
    except
      on E: Exception do
        ShowMessage('������ ��� ���������� �����: ' + E.Message);
    end;
  end
  else
  begin
    ShowMessage('���������� ������ ��������.');
  end;
end;

procedure TMainWork.CalculateAdditions;
var
  ComplectationPrice, OptionsPrice, TotalAdditions: Double;
  i: Integer;
begin
  // �������� ���� ������������
  case ComboBox2.ItemIndex of
    0: ComplectationPrice := 0;      // �������
    1: ComplectationPrice := 5000;   // �����������
    2: ComplectationPrice := 10000;  // ����
    3: ComplectationPrice := 12000;  // �������
    4: ComplectationPrice := 20000;  // ������������
  else
    ComplectationPrice := 0;
  end;

  // �������� ���� ���� ��������� �����
  OptionsPrice := 0;
  for i := 0 to CheckListBox1.Count - 1 do
  begin
    if CheckListBox1.Checked[i] then
    begin
      case i of
        0: OptionsPrice := OptionsPrice + 500;  // ���������� ������-��������
        1: OptionsPrice := OptionsPrice + 300;  // �������� �������� ������
        2: OptionsPrice := OptionsPrice + 300;  // �������� �������� ������
        3: OptionsPrice := OptionsPrice + 450;  // �������� �������
        4: OptionsPrice := OptionsPrice + 152;  // ������������� �������
        5: OptionsPrice := OptionsPrice + 321;  // ���������� �����-��������
        6: OptionsPrice := OptionsPrice + 252;  // ������� �������� ������ ���
        7: OptionsPrice := OptionsPrice + 212;  // ������� ��������� � ������
        8: OptionsPrice := OptionsPrice + 150;  // ����������� (�������� � ������)
        9: OptionsPrice := OptionsPrice + 52;   // ������ ������� ����
        10: OptionsPrice := OptionsPrice + 200; // ������ ��������� ������
        11: OptionsPrice := OptionsPrice + 150; // ����������� ������
        12: OptionsPrice := OptionsPrice + 200; // ���������� �����
        13: OptionsPrice := OptionsPrice + 100; // ������� �����
        14: OptionsPrice := OptionsPrice + 500; // ��������� ������
        15: OptionsPrice := OptionsPrice + 450; // ��������� ������ ���
        16: OptionsPrice := OptionsPrice + 200; // �������� ��� �������
      end;
    end;
  end;
  TotalAdditions := ComplectationPrice + OptionsPrice;
  Edit2.Text := FloatToStr(TotalAdditions);
  UpdateTotalPrice;
  RemoveOldTotalPriceFromMemo;
  Memo1.Lines.Add('�������� ����: ' + Edit3.Text);
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
    if Pos('�������� ����: ', Memo1.Lines[i]) = 1 then
    begin
      Memo1.Lines.Delete(i);
      Break; // ������� �� ����� ����� �������� ������
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
    if Pos('����: ', Memo1.Lines[i]) = 1 then
    begin
      Memo1.Lines.Delete(i);
      Break;
    end;
  end;
  Memo1.Lines.Add('����: ' + SelectedColorName);
end;

procedure TMainWork.ComboBox1Change(Sender: TObject);
begin
Memo1.Lines.Clear;
Memo2.Lines.Clear;
   case ComboBox1.ItemIndex of
    0: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz �-�����.jpg');
      Edit1.Text := '29000';
      Memo1.Lines.Add('������: Mercedes-Benz �-�����');
      Memo1.Lines.Add('����: 29.000$');
      Memo2.Lines.Add('������: Mercedes-Benz �-�����');
      Memo2.Lines.Add('��� �������: 2022');
      Memo2.Lines.Add('���������: 1.3L Turbo');
      Memo2.Lines.Add('��������: 163 �.�.');
      Memo2.Lines.Add('������ 0-100 ��/�: 8.0 ���');
      Memo2.Lines.Add('������������ ��������: 225 ��/�');
    end;
    1: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz AMG GT63S E-perfomance.jpg');
      Edit1.Text := '150000';
      Memo1.Lines.Add('������: Mercedes-Benz AMG GT63S E-perfomance');
      Memo1.Lines.Add('����: 150.000$');
      Memo2.Lines.Add('������: Mercedes-Benz AMG GT63S E-perfomance');
      Memo2.Lines.Add('��� �������: 2022');
      Memo2.Lines.Add('���������: 4.0L V8 Biturbo');
      Memo2.Lines.Add('��������: 639 �.�.');
      Memo2.Lines.Add('������ 0-100 ��/�: 3.2 ���');
      Memo2.Lines.Add('������������ ��������: 315 ��/�');
    end;
    2: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz B-�����.jpg');
      Edit1.Text := '25000';
      Memo1.Lines.Add('������: Mercedes-Benz B-�����');
      Memo1.Lines.Add('����: 25.000$');
      Memo2.Lines.Add('������: Mercedes-Benz B-�����');
      Memo2.Lines.Add('��� �������: 2022');
      Memo2.Lines.Add('���������: 1.6L');
      Memo2.Lines.Add('��������: 122 �.�.');
      Memo2.Lines.Add('������ 0-100 ��/�: 10.2 ���');
      Memo2.Lines.Add('������������ ��������: 190 ��/�');
    end;
    3: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz C-�����.jpg');
      Edit1.Text := '42000';
      Memo1.Lines.Add('������: Mercedes-Benz C-�����');
      Memo1.Lines.Add('����: 42.000$');
      Memo2.Lines.Add('������: Mercedes-Benz C-�����');
      Memo2.Lines.Add('��� �������: 2022');
      Memo2.Lines.Add('���������: 2.0L Turbo');
      Memo2.Lines.Add('��������: 255 �.�.');
      Memo2.Lines.Add('������ 0-100 ��/�: 6.0 ���');
      Memo2.Lines.Add('������������ ��������: 250 ��/�');
    end;
    4: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz C-����� AMG.jpg');
      Edit1.Text := '80000';
      Memo1.Lines.Add('������: Mercedes-Benz C-����� AMG');
      Memo1.Lines.Add('����: 80.000$');
      Memo2.Lines.Add('������: Mercedes-Benz C-����� AMG');
      Memo2.Lines.Add('��� �������: 2022');
      Memo2.Lines.Add('���������: 3.0L V6 Turbo');
      Memo2.Lines.Add('��������: 385 �.�.');
      Memo2.Lines.Add('������ 0-100 ��/�: 4.7 ���');
      Memo2.Lines.Add('������������ ��������: 250 ��/�');
    end;
    5: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz CLA.jpg');
      Edit1.Text := '45000';
      Memo1.Lines.Add('������: Mercedes-Benz CLA');
      Memo1.Lines.Add('����: 45.000$');
      Memo2.Lines.Add('������: Mercedes-Benz CLA');
      Memo2.Lines.Add('��� �������: 2022');
      Memo2.Lines.Add('���������: 2.0L Turbo');
      Memo2.Lines.Add('��������: 221 �.�.');
      Memo2.Lines.Add('������ 0-100 ��/�: 6.3 ���');
      Memo2.Lines.Add('������������ ��������: 240 ��/�');
    end;
    6: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz CLA AMG.jpg');
      Edit1.Text := '70000';
      Memo1.Lines.Add('������: Mercedes-Benz CLA AMG');
      Memo1.Lines.Add('����: 70.000$');
      Memo2.Lines.Add('������: Mercedes-Benz CLA AMG');
      Memo2.Lines.Add('��� �������: 2022');
      Memo2.Lines.Add('���������: 2.0L Turbo');
      Memo2.Lines.Add('��������: 382 �.�.');
      Memo2.Lines.Add('������ 0-100 ��/�: 4.1 ���');
      Memo2.Lines.Add('������������ ��������: 270 ��/�');
    end;
       7: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz E-�����.jpg');
      Edit1.Text := '60000';
      Memo1.Lines.Add('������: Mercedes-Benz E-�����');
      Memo1.Lines.Add('����: 60.000$');
      Memo2.Lines.Add('������: Mercedes-Benz E-�����');
      Memo2.Lines.Add('��� �������: 2022');
      Memo2.Lines.Add('���������: 2.0L Turbo');
      Memo2.Lines.Add('��������: 255 �.�.');
      Memo2.Lines.Add('������ 0-100 ��/�: 6.1 ���');
      Memo2.Lines.Add('������������ ��������: 250 ��/�');
    end;
    8: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz E-����� AMG.jpg');
      Edit1.Text := '100000';
      Memo1.Lines.Add('������: Mercedes-Benz E-����� AMG');
      Memo1.Lines.Add('����: 100.000$');
      Memo2.Lines.Add('������: Mercedes-Benz E-����� AMG');
      Memo2.Lines.Add('��� �������: 2022');
      Memo2.Lines.Add('���������: 4.0L V8 Biturbo');
      Memo2.Lines.Add('��������: 603 �.�.');
      Memo2.Lines.Add('������ 0-100 ��/�: 3.3 ���');
      Memo2.Lines.Add('������������ ��������: 300 ��/�');
    end;
    9: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz CLS.jpg');
      Edit1.Text := '70000';
      Memo1.Lines.Add('������: Mercedes-Benz CLS');
      Memo1.Lines.Add('����: 70.000$');
      Memo2.Lines.Add('������: Mercedes-Benz CLS');
      Memo2.Lines.Add('��� �������: 2022');
      Memo2.Lines.Add('���������: 3.0L Turbo');
      Memo2.Lines.Add('��������: 362 �.�.');
      Memo2.Lines.Add('������ 0-100 ��/�: 4.8 ���');
      Memo2.Lines.Add('������������ ��������: 250 ��/�');
    end;
    10: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz CLS AMG.jpg');
      Edit1.Text := '90000';
      Memo1.Lines.Add('������: Mercedes-Benz CLS AMG');
      Memo1.Lines.Add('����: 90.000$');
      Memo2.Lines.Add('������: Mercedes-Benz CLS AMG');
      Memo2.Lines.Add('��� �������: 2022');
      Memo2.Lines.Add('���������: 4.0L V8 Biturbo');
      Memo2.Lines.Add('��������: 603 �.�.');
      Memo2.Lines.Add('������ 0-100 ��/�: 3.3 ���');
      Memo2.Lines.Add('������������ ��������: 300 ��/�');
    end;
    11: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz EQC.jpg');
      Edit1.Text := '110000';
      Memo1.Lines.Add('������: Mercedes-Benz EQC');
      Memo1.Lines.Add('����: 110.000$');
      Memo2.Lines.Add('������: Mercedes-Benz EQC');
      Memo2.Lines.Add('��� �������: 2022');
      Memo2.Lines.Add('����������������: 300 ���');
      Memo2.Lines.Add('��������: 408 �.�.');
      Memo2.Lines.Add('������ 0-100 ��/�: 5.1 ���');
      Memo2.Lines.Add('������������ ��������: 180 ��/�');
    end;
    12: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz EQG.jpg');
      Edit1.Text := '120000';
      Memo1.Lines.Add('������: Mercedes-Benz EQG');
      Memo1.Lines.Add('����: 120.000$');
      Memo2.Lines.Add('������: Mercedes-Benz EQG');
      Memo2.Lines.Add('��� �������: 2022');
      Memo2.Lines.Add('����������������: 350 ���');
      Memo2.Lines.Add('��������: 476 �.�.');
      Memo2.Lines.Add('������ 0-100 ��/�: 4.9 ���');
      Memo2.Lines.Add('������������ ��������: 200 ��/�');
    end;
    13: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz EQS.jpg');
      Edit1.Text := '115521';
      Memo1.Lines.Add('������: Mercedes-Benz EQS');
      Memo1.Lines.Add('����: 115.521$');
      Memo2.Lines.Add('������: Mercedes-Benz EQS');
      Memo2.Lines.Add('��� �������: 2022');
      Memo2.Lines.Add('����������������: 400 ���');
      Memo2.Lines.Add('��������: 536 �.�.');
      Memo2.Lines.Add('������ 0-100 ��/�: 4.1 ���');
      Memo2.Lines.Add('������������ ��������: 210 ��/�');
    end;
    14: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz G-�����.jpg');
      Edit1.Text := '80000';
      Memo1.Lines.Add('������: Mercedes-Benz G-�����');
      Memo1.Lines.Add('����: 80.000$');
      Memo2.Lines.Add('������: Mercedes-Benz G-�����');
      Memo2.Lines.Add('��� �������: 2022');
      Memo2.Lines.Add('���������: 4.0L V8');
      Memo2.Lines.Add('��������: 416 �.�.');
      Memo2.Lines.Add('������ 0-100 ��/�: 5.8 ���');
      Memo2.Lines.Add('������������ ��������: 210 ��/�');
    end;
    15: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz G-����� AMG.jpg');
      Edit1.Text := '105000';
      Memo1.Lines.Add('������: Mercedes-Benz G-����� AMG');
      Memo1.Lines.Add('����: 105.000$');
      Memo2.Lines.Add('������: Mercedes-Benz G-����� AMG');
      Memo2.Lines.Add('��� �������: 2022');
      Memo2.Lines.Add('���������: 4.0L V8 Biturbo');
      Memo2.Lines.Add('��������: 577 �.�.');
      Memo2.Lines.Add('������ 0-100 ��/�: 4.5 ���');
      Memo2.Lines.Add('������������ ��������: 240 ��/�');
    end;
    16: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz GLC.jpg');
      Edit1.Text := '80.000';
      Memo1.Lines.Add('������: Mercedes-Benz GLC');
      Memo1.Lines.Add('����: 80.000$');
      Memo2.Lines.Add('������: Mercedes-Benz GLC');
      Memo2.Lines.Add('��� �������: 2022');
      Memo2.Lines.Add('���������: 2.0L Turbo');
      Memo2.Lines.Add('��������: 255 �.�.');
      Memo2.Lines.Add('������ 0-100 ��/�: 6.2 ���');
      Memo2.Lines.Add('������������ ��������: 240 ��/�');
    end;
    17: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz GLC AMG.jpg');
      Edit1.Text := '120000';
      Memo1.Lines.Add('������: Mercedes-Benz GLC AMG');
      Memo1.Lines.Add('����: 120.000$');
      Memo2.Lines.Add('������: Mercedes-Benz GLC AMG');
      Memo2.Lines.Add('��� �������: 2022');
      Memo2.Lines.Add('���������: 4.0L V8 Biturbo');
      Memo2.Lines.Add('��������: 503 �.�.');
      Memo2.Lines.Add('������ 0-100 ��/�: 3.8 ���');
      Memo2.Lines.Add('������������ ��������: 280 ��/�');
    end;
    18: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz GLE-�����.jpg');
      Edit1.Text := '85000';
      Memo1.Lines.Add('������: Mercedes-Benz GLE-�����');
      Memo1.Lines.Add('����: 85.000$');
      Memo2.Lines.Add('������: Mercedes-Benz GLE-�����');
      Memo2.Lines.Add('��� �������: 2022');
      Memo2.Lines.Add('���������: 3.0L Turbo');
      Memo2.Lines.Add('��������: 362 �.�.');
      Memo2.Lines.Add('������ 0-100 ��/�: 5.5 ���');
      Memo2.Lines.Add('������������ ��������: 250 ��/�');
    end;
    19: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz GLE Coupe.jpg');
      Edit1.Text := '70000';
      Memo1.Lines.Add('������: Mercedes-Benz GLE Coupe');
      Memo1.Lines.Add('����: 70.000$');
      Memo2.Lines.Add('������: Mercedes-Benz GLE Coupe');
      Memo2.Lines.Add('��� �������: 2022');
      Memo2.Lines.Add('���������: 3.0L Turbo');
      Memo2.Lines.Add('��������: 362 �.�.');
      Memo2.Lines.Add('������ 0-100 ��/�: 5.6 ���');
      Memo2.Lines.Add('������������ ��������: 250 ��/�');
    end;
    20: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz GLS.jpg');
      Edit1.Text := '90000';
      Memo1.Lines.Add('������: Mercedes-Benz GLS');
      Memo1.Lines.Add('����: 90.000$');
      Memo2.Lines.Add('������: Mercedes-Benz GLS');
      Memo2.Lines.Add('��� �������: 2022');
      Memo2.Lines.Add('���������: 3.0L Turbo');
      Memo2.Lines.Add('��������: 362 �.�.');
      Memo2.Lines.Add('������ 0-100 ��/�: 5.8 ���');
      Memo2.Lines.Add('������������ ��������: 240 ��/�');
    end;
    21: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz GLS AMG.jpg');
      Edit1.Text := '130000';
      Memo1.Lines.Add('������: Mercedes-Benz GLS AMG');
      Memo1.Lines.Add('����: 130.000$');
      Memo2.Lines.Add('������: Mercedes-Benz GLS AMG');
      Memo2.Lines.Add('��� �������: 2022');
      Memo2.Lines.Add('���������: 4.0L V8 Biturbo');
      Memo2.Lines.Add('��������: 603 �.�.');
      Memo2.Lines.Add('������ 0-100 ��/�: 4.1 ���');
      Memo2.Lines.Add('������������ ��������: 280 ��/�');
    end;
    22: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz M-�����.jpg');
      Edit1.Text := '50000';
      Memo1.Lines.Add('������: Mercedes-Benz M-�����');
      Memo1.Lines.Add('����: 50.000$');
      Memo2.Lines.Add('������: Mercedes-Benz M-�����');
      Memo2.Lines.Add('��� �������: 2022');
      Memo2.Lines.Add('���������: 3.5L V6');
      Memo2.Lines.Add('��������: 302 �.�.');
      Memo2.Lines.Add('������ 0-100 ��/�: 7.5 ���');
      Memo2.Lines.Add('������������ ��������: 224 ��/�');
    end;
    23: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz �-����� AMG.jpg');
      Edit1.Text := '70000';
      Memo1.Lines.Add('������: Mercedes-Benz �-����� AMG');
      Memo1.Lines.Add('����: 70.000$');
      Memo2.Lines.Add('������: Mercedes-Benz �-����� AMG');
      Memo2.Lines.Add('��� �������: 2022');
      Memo2.Lines.Add('���������: 5.5L V8 Biturbo');
      Memo2.Lines.Add('��������: 518 �.�.');
      Memo2.Lines.Add('������ 0-100 ��/�: 4.8 ���');
      Memo2.Lines.Add('������������ ��������: 250 ��/�');
    end;
    24: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz S-�����.jpg');
      Edit1.Text := '120000';
      Memo1.Lines.Add('������: Mercedes-Benz S-�����');
      Memo1.Lines.Add('����: 120.000$');
      Memo2.Lines.Add('������: Mercedes-Benz S-�����');
      Memo2.Lines.Add('��� �������: 2022');
      Memo2.Lines.Add('���������: 3.0L Turbo');
      Memo2.Lines.Add('��������: 429 �.�.');
      Memo2.Lines.Add('������ 0-100 ��/�: 4.9 ���');
      Memo2.Lines.Add('������������ ��������: 250 ��/�');
    end;
    25: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz S-����� AMG.jpg');
      Edit1.Text := '155000';
      Memo1.Lines.Add('������: Mercedes-Benz S-����� AMG');
      Memo1.Lines.Add('����: 155.000$');
      Memo2.Lines.Add('������: Mercedes-Benz S-����� AMG');
      Memo2.Lines.Add('��� �������: 2022');
      Memo2.Lines.Add('���������: 4.0L V8 Biturbo');
      Memo2.Lines.Add('��������: 603 �.�.');
      Memo2.Lines.Add('������ 0-100 ��/�: 3.5 ���');
      Memo2.Lines.Add('������������ ��������: 300 ��/�');
    end;
    26: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz SLK.jpg');
      Edit1.Text := '60.000';
      Memo1.Lines.Add('������: Mercedes-Benz SLK');
      Memo1.Lines.Add('����: 60.000$');
      Memo2.Lines.Add('������: Mercedes-Benz SLK');
      Memo2.Lines.Add('��� �������: 2022');
      Memo2.Lines.Add('���������: 2.0L Turbo');
      Memo2.Lines.Add('��������: 241 �.�.');
      Memo2.Lines.Add('������ 0-100 ��/�: 5.8 ���');
      Memo2.Lines.Add('������������ ��������: 250 ��/�');
    end;
    27: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz SLK AMG.jpg');
      Edit1.Text := '90000';
      Memo1.Lines.Add('������: Mercedes-Benz SLK AMG');
      Memo1.Lines.Add('����: 90.000$');
      Memo2.Lines.Add('������: Mercedes-Benz SLK AMG');
      Memo2.Lines.Add('��� �������: 2022');
      Memo2.Lines.Add('���������: 5.5L V8');
      Memo2.Lines.Add('��������: 415 �.�.');
      Memo2.Lines.Add('������ 0-100 ��/�: 4.6 ���');
      Memo2.Lines.Add('������������ ��������: 280 ��/�');
    end;
     28: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz SL.jpg');
      Edit1.Text := '80000';
      Memo1.Lines.Add('������: Mercedes-Benz SL');
      Memo1.Lines.Add('����: 80.000$');
      Memo2.Lines.Add('������: Mercedes-Benz SL');
      Memo2.Lines.Add('��� �������: 2022');
      Memo2.Lines.Add('���������: 3.0L V6 Turbo');
      Memo2.Lines.Add('��������: 362 �.�.');
      Memo2.Lines.Add('������ 0-100 ��/�: 4.9 ���');
      Memo2.Lines.Add('������������ ��������: 250 ��/�');
    end;
    29: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz SL AMG.jpg');
      Edit1.Text := '100.000';
      Memo1.Lines.Add('������: Mercedes-Benz SL AMG');
      Memo1.Lines.Add('����: 100.000$');
      Memo2.Lines.Add('������: Mercedes-Benz SL AMG');
      Memo2.Lines.Add('��� �������: 2022');
      Memo2.Lines.Add('���������: 4.0L V8 Biturbo');
      Memo2.Lines.Add('��������: 577 �.�.');
      Memo2.Lines.Add('������ 0-100 ��/�: 3.7 ���');
      Memo2.Lines.Add('������������ ��������: 300 ��/�');
    end;
    30: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz Vito.jpg');
      Edit1.Text := '30000';
      Memo1.Lines.Add('������: Mercedes-Benz Vito');
      Memo1.Lines.Add('����: 30.000$');
      Memo2.Lines.Add('������: Mercedes-Benz Vito');
      Memo2.Lines.Add('��� �������: 2022');
      Memo2.Lines.Add('���������: 2.0L Diesel');
      Memo2.Lines.Add('��������: 174 �.�.');
      Memo2.Lines.Add('������ 0-100 ��/�: 10.5 ���');
      Memo2.Lines.Add('������������ ��������: 190 ��/�');
    end;
    31: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz V-�����.jpg');
      Edit1.Text := '60000';
      Memo1.Lines.Add('������: Mercedes-Benz V-�����');
      Memo1.Lines.Add('����: 60.000$');
      Memo2.Lines.Add('������: Mercedes-Benz V-�����');
      Memo2.Lines.Add('��� �������: 2022');
      Memo2.Lines.Add('���������: 2.1L Diesel');
      Memo2.Lines.Add('��������: 190 �.�.');
      Memo2.Lines.Add('������ 0-100 ��/�: 9.1 ���');
      Memo2.Lines.Add('������������ ��������: 199 ��/�');
    end;
    32: begin
      Image2.Picture.LoadFromFile('Mercedes-Benz X-�����.jpg');
      Edit1.Text := '70000';
      Memo1.Lines.Add('������: Mercedes-Benz X-�����');
      Memo1.Lines.Add('����: 70.000$');
      Memo2.Lines.Add('������: Mercedes-Benz X-�����');
      Memo2.Lines.Add('��� �������: 2022');
      Memo2.Lines.Add('���������: 3.0L V6 Turbo Diesel');
      Memo2.Lines.Add('��������: 258 �.�.');
      Memo2.Lines.Add('������ 0-100 ��/�: 7.9 ���');
      Memo2.Lines.Add('������������ ��������: 205 ��/�');
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
    if Pos('������������: ', Memo1.Lines[i]) = 1 then
    begin
      Memo1.Lines.Delete(i);
      Break;
    end;
  end;
  Memo1.Lines.Add('������������: ' + SelectedComplectation);
  CalculateAdditions;
end;

procedure TMainWork.N2Click(Sender: TObject);
var
  i: Integer;
  TextHeight: Integer;
begin
  if PrintDialog1.Execute then
  begin
    // ������ ������
    Printer.BeginDoc;
    try
      // ��������� ��������� ������� ��� ������
      TextHeight := Printer.Canvas.TextHeight('W') + 5; // ������ ������ � ��������
      // ������ ����������� Memo1 ���������
      for i := 0 to Memo1.Lines.Count - 1 do
      begin
        Printer.Canvas.TextOut(100, 100 + i * TextHeight, Memo1.Lines[i]);
      end;
    finally
      // ���������� ������
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
    Close;  // ���� ���������� ���������, ��������� ���������
  end
  else
  begin
    Response := MessageDlg('�� ������������� ������ ������� ��������� ��� ����������?', mtConfirmation, [mbYes, mbNo, mbCancel], 0);
    case Response of
      mrYes: application.Terminate; // ���� ������ "��", ��������� ���������
      mrNo, mrCancel: ;  // ���� ������ "���" ��� "������", ������ �� ������
    end;
  end;
end;

procedure TMainWork.N6Click(Sender: TObject);
begin
ShowMessage('����� ��� ������������ ��������� - ���������� �������� �����������');
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
