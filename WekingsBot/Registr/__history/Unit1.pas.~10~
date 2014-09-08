unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,UMd5;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
function Prf(s:string):string;
var
  i:integer;
  s1,s2:string;
begin
  Result:=md5(s);
  s1:=Copy(Result,1,16);
  s2:=Copy(Result,17,16);
  for i:=1 to 16 do
    s1[i]:=Chr((Ord(s2[i])+Ord(s1[i])) mod 100);
  Result:=AnsiLowerCase(s1);
  s1:=Copy(Result,1,8);
  s2:=Copy(Result,9,8);
  for i:=1 to 8 do
    s1[i]:=Chr((Ord(s2[i])+Ord(s1[i])) mod 100);
  Result:=AnsiUpperCase(s1);
  Result:=md5(Result);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Edit1.Text:=Prf(Edit1.Text);
end;

end.
