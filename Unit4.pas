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
  // ���� ������ ������� ������ � �� ��������� ����� �����
  if (RadioGroup2.ItemIndex > -1) and (not Eof(f)) then
  begin
    totalQuestions := totalQuestions + 1; // ����������� ����� ���������� ��������
    // ���� ��������� ������� ������������� ������ ������� ������, �� ���� ������������
    if RadioGroup2.ItemIndex = Nvern - 1 then
    begin
      ball := ball + 1;
      Label1.Caption := '�����!';
    end
    else
    begin
      Label1.Caption := '�������';
    end;
    RadioGroup2.Items.Clear; // ��������� ���� ��� ���������� �������
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
  // ���� ����� ����� ���������, ������ ������� �����������
  else if Eof(f) then
  begin
    delete(s, 1, 1);
    Nvern := StrToInt(s);
    totalQuestions := totalQuestions + 1; // ����������� ����� ���������� ��������
    if RadioGroup2.ItemIndex = Nvern - 1 then
    begin
      ball := ball + 1;
      Label1.Caption := '�����!';
    end
    else
    begin
      Label1.Caption := '�������';
    end;
    // ��������� ������� ���������� �������
    Label1.Caption := Label1.Caption + Format('. ��� ���������: %d%% ���������� �������', [Round(ball / totalQuestions * 100)]);
    CloseFile(f);
    Button1.Enabled := False; // ������ ���������� ����������� � ���������� �������
    Button2.Enabled:=True;
  end;
end;

procedure TTest.RadioGroup1Click(Sender: TObject);
begin
  RadioGroup1.Enabled := false; // ����� �������� ���������� ����������
  RadioGroup2.Enabled := true; // ��������� ���������� ���� � ��������
  Button1.Enabled := true; // ������ �����
  case RadioGroup1.ItemIndex of
    // � ����������� �� ���������� �������� ���������� f
    0: AssignFile(f, (ExtractFilePath(Application.ExeName) + 'variant1.txt')); // ����������� � ������� �������
    1: AssignFile(f, (ExtractFilePath(Application.ExeName) + 'variant2.txt'));
  end;
  reset(f); // ��������� ���� ��� ������
  readln(f, s); // ��������� ������ ������ �� �����
  ball := 0; // ���������� ���������� ������ 0
  totalQuestions := 0; // ���������� ���������� �������� 0
  repeat
    if (s[1] = '-') then
    begin
      // ���� ������ ������ ������ �-� ������ ��� ������
      delete(s, 1, 1);
      RadioGroup2.Caption := s;
    end
    else if s[1] = '*' then
    begin
      // ���� ������ ������ �*� ������ ��� ����� ������� ������
      delete(s, 1, 1);
      Nvern := StrToInt(s);
    end
    else
      RadioGroup2.Items.Add(s); // ����� ��� ������� ������
    readln(f, s); // ��������� ��������� ������ �� �����
  until (s[1] = '-') or Eof(f); // ���������� � ����������� ��������� ������� � RadiGroup �� ��� ���
  // ���� �� ��������� ��������� ������ ��� ����� �����
end;

end.
