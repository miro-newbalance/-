unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Unit3, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask;

type
  TAvtorizacya = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    MaskEdit1: TMaskEdit;
    MaskEdit2: TMaskEdit;
    Button1: TButton;
    Button2: TButton;
    Label4: TLabel;
    Button3: TButton;
    Button4: TButton;
    procedure MaskEdit1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure CreateParams(var Params: TCreateParams) ; override;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Avtorizacya: TAvtorizacya;

implementation

{$R *.dfm}

uses Unit1;

procedure TAvtorizacya.Button1Click(Sender: TObject);
begin
if MaskEdit1.Text <> 'admin' then
begin
  label4.Visible:=True;
  Button2.Visible:=True;
end
else
if maskedit2.Text<>'1234' then
begin
  label4.Visible:=true;
  button2.Visible:=true;
end
else
begin
showmessage('Данные введены верно, добро пожаловать!');
button3.Visible:=true;
end;
end;

procedure TAvtorizacya.Button2Click(Sender: TObject);
begin
maskedit1.Clear;
maskedit2.Clear;
label4.Visible:=false;
end;

procedure TAvtorizacya.Button3Click(Sender: TObject);
begin
Avtorizacya.visible:=false;
MainWork.visible:=true;
end;

procedure TAvtorizacya.Button4Click(Sender: TObject);
begin
Application.Terminate;
end;

procedure TAvtorizacya.MaskEdit1Change(Sender: TObject);
begin
Button1.Visible:=True;
end;

procedure TAvtorizacya.CreateParams(var Params: TCreateParams) ;
begin
  inherited;
  Params.ExStyle := Params.ExStyle or WS_EX_APPWINDOW;
  Params.WndParent := 0;
end;

end.
