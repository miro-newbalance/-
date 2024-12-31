unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Unit2,
  Vcl.Imaging.pngimage, Vcl.Imaging.jpeg, Vcl.ComCtrls, Vcl.StdCtrls;

type
  TZastavka = class(TForm)
    Image1: TImage;
    ProgressBar1: TProgressBar;
    Timer1: TTimer;
    Label1: TLabel;
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Zastavka: TZastavka;


implementation

{$R *.dfm}

procedure TZastavka.Timer1Timer(Sender: TObject);
var i:integer;
begin
  if progressbar1.Position = 100 then
  begin
  Avtorizacya.Show;
  Timer1.Enabled := False;
  Zastavka.Hide;
  end
  else
  for i := 0 to 135 do
  begin
    progressbar1.Position:=i;
    progressbar1.Update;
    sleep(5);
  end;
end;

end.
