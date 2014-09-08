program Project1;

uses
  Windows,
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  ProcInfo,
  UMd5,
  SysUtils,
  idHTTP,
  Registry,
  shellapi,
  Unit3 in 'Unit3.pas' {Form3};
{$R *.res}
const
  ERROR_REG_TEXT_START = '��� ����������� �������� ������ ��� ';
  ERROR_REG_TEXT_END = #13#10'C�������� ����������� 250 ������'+#13#10+'��������� �� http://wbot.xedus.ru/';
  ERROR_REG_CAPTION = '������ �� ����������������!';
  VERSION = '0.3.3';
var
  ID,Otvet:string;
  http:TIdHTTP;

function GetKey:string;
var
  Reg:TRegistry;
begin
  Reg:=TRegistry.Create;
  Reg.RootKey:=HKEY_CURRENT_USER;
  Reg.OpenKey('SOFTWARE\Xedus',true);
  Result:=Reg.ReadString('id');
  if Result='' then
  begin
    Randomize;
    Result:=md5(IntToStr(Random(9999999)+555));
    Reg.WriteString('id',Result);
  end;
  Reg.CloseKey;
  Reg.Free;
end;
/// ��� �������������� ���������� ////
function Chokize:string;
var
  CPU:TCPUInfo;
  ID,ID1:string;
  VolumeNameBuffer:array[0..255] of char;
  VolumeSerialNumber: DWORD;
  MaximumComponentLength, FileSystemFlags: DWORD;
  Ser:string;
  D:DWORD;
begin
  ZeroMemory(@CPU,SizeOf(TCPUInfo));
  ZeroMemory(@VolumeNameBuffer,Length(VolumeNameBuffer));
  FileSystemFlags:=0;
  MaximumComponentLength:=0;
  Ser:='';
  ID:='';
  ID1:='';
  if GetVolumeInformation(PWideChar('C:\'), VolumeNameBuffer,
     SizeOf(VolumeNameBuffer), @VolumeSerialNumber, MaximumComponentLength,
     FileSystemFlags, nil, 0) then
  begin
    D:=VolumeSerialNumber;
    Ser:=IntToStr(Integer(D));
    CPUIDInfo(CPU);
    ID:=md5(CPU.IDString+Ser+GetKey);
    ID1:=Copy(ID,1,8);
    ID:=AnsiUpperCase(ID1);
    Result:=ID;
  end;
end;
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

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Otvet:='';
  http:=TIdHTTP.Create(nil);
  Otvet:='';
  try
    Otvet:=http.Get('http://wbot.xedus.ru/version.txt');
  except
    Otvet:='';
  end;
  if (Otvet<>'') and (VERSION<>Copy(Otvet,1,Pos(#13#10,Otvet)-1)) then
    MessageBox(Application.Handle,PWideChar('����� ����� ������ ��������! '+#13#10+'������� ������: '+Copy(Otvet,1,Pos(#13#10,Otvet)-1)+#13#10+'���� ������: '+VERSION+#13#10+'����������, �������� ���������! http://wbot.xedus.ru/'+#13#10+#13#10+Copy(Otvet,Pos(#13#10,Otvet)+2,Length(Otvet))),PWideChar('�������� ���������!'),MB_ICONWARNING or MB_TOPMOST);
  try
    Otvet:=http.Get('http://xedus.ucoz.ru/bot.txt');
  except
    MessageBox(Application.Handle,PWideChar('��������� ����������� � ��������� � ���������� ��� ���!'),PWideChar('������ ����������!'),MB_ICONSTOP or MB_TOPMOST);
    Application.Terminate;
    exit;
  end;
  http.Free;
  ID:=Chokize;
  if Pos(Prf(ID),Otvet)=0 then
  begin
    MessageBox(Application.Handle,PWideChar(ERROR_REG_TEXT_START+ID+ERROR_REG_TEXT_END),PWideChar(ERROR_REG_CAPTION),MB_ICONSTOP or MB_TOPMOST);
    ShellExecute(0,'open','http://wbot.xedus.ru/',nil,nil,SW_SHOW);
    Application.Terminate;
    exit;
  end;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
