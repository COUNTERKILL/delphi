unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,winsock2, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    Edit1: TEdit;
    Edit2: TEdit;
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


function GetIPAddress(Name:String): ansistring;
var
WSAData : TWSAData;
p : PHostEnt;
begin
WSAStartup(WINSOCK_VERSION, WSAData);
p := GetHostByName(PAnsiChar(Name));
if p=nil then
  Form1.Memo1.Lines.Add(IntTOStr(WSAGetLastError));
Result := inet_ntoa(PInAddr(p^.h_addr_list^)^);
WSACleanup;
end;
procedure TForm1.Button1Click(Sender: TObject);
begin
  Memo1.Lines.Add(GetIPAddress('PC11214.class.local'));
end;

end.
