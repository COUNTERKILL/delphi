unit Inet;

interface
uses ExtCtrls,Winsock2,windows;

type
  ///	<summary>
  ///	  ������ ����� ������
  ///	</summary>
  TBlocks = array[1..10, 1..10] of TImage;

  ///	<summary>
  ///	  ��������� �������� ����� ������� �� ���� ������
  ///	</summary>
  TCrBM = procedure(X,Y:integer);

{ ������� � �������� ��������}

///	<summary>
///	  �������� ��������
///	</summary>
///	<param name="x">
///	  ���������� ����� �� X
///	</param>
///	<param name="y">
///	  ���������� ����� �� Y
///	</param>
///	<param name="Blocks">
///	  ������ ������ ������
///	</param>
///	<param name="SockServer">
///	  ����� �������
///	</param>
///	<param name="CrBm">
///	  ��������� �������� ����� ������� �� ���� ������
///	</param>
function RecvFight(var x,y:integer; var Blocks:TBlocks;var SockServer:TSocket;
  CrBm:TCrBM):ansichar;

///	<summary>
///	  �������� ��������
///	</summary>
///	<param name="x">
///	  ���������� ����� X
///	</param>
///	<param name="y">
///	  ���������� ����� Y
///	</param>
///	<returns>
///	  ��������� ��������
///	</returns>
function SendFight(x,y:integer):char;

{ �������� � �������� ��������� � ����������� ���� ��������}

///	<summary>
///	  �������� ��������� � ���, ��� ��� ������� ������ �����������
///	</summary>
procedure SendSeted;

///	<summary>
///	  ����� ��������� � ���, ��� ��������� ��������� ��� ���� �������
///	</summary>
///	<param name="SockServer">
///	  ����� �������
///	</param>
procedure RecvSeted(var SockServer:TSocket);

{ �������� � �������� ��������� � ����� ����}

///	<summary>
///	  �������� ��������� � ������ ����� ����
///	</summary>
procedure SendNew;

///	<summary>
///	  �������� ��������� � ������ ����� ����
///	</summary>
///	<param name="SockServer">
///	  ����� �������
///	</param>
procedure RecvNewFirst(var SockServer:TSocket);

var
  ///	<summary>
  ///	  IP ����������
  ///	</summary>
  IP:SunB;

implementation

const
  PortFrom = 3333;
  PortTo = 3333;
  MAX_CONNECTIONS = 1;
var
  info:WSAData;

//==============================================================================
{ ��������� ��������� � ���, ��� ��� ������� ���������� �����������}

procedure RecvSeted(var SockServer:TSocket);
var
  Sock:TSocket;
  AddrServ,RemoteAddr:TSockAddrIn;
  Res,SizeOfRemAddr:integer;
  buf:ansichar;
begin
  SockServer:=socket(AF_INET,SOCK_STREAM,IPPROTO_IP);
  if SockServer=INVALID_SOCKET then
  begin
    MessageBox(0,PWideChar('������'),PWideChar('������ �������� ������'),MB_OK);
    exit;
  end;
  AddrServ.sin_family:=AF_INET;
  AddrServ.sin_port:=htons(PortFrom);
  AddrServ.sin_addr.S_addr:=INADDR_ANY;
  ZeroMemory(@(AddrServ.sin_zero),SizeOf(AddrServ.sin_zero));
  Res:=bind(SockServer,TSockAddr(AddrServ),SizeOf(AddrServ));
  if Res=SOCKET_ERROR then
  begin
    MessageBox(0,PWideChar('������'),PWideChar('������ ��������'),MB_OK);
    exit;
  end;
  Res:=listen(SockServer,MAX_CONNECTIONS);
  if Res=SOCKET_ERROR then
  begin
    MessageBox(0,PWideChar('������'),PWideChar('������ �������������'),MB_OK);
    exit;
  end;
  SizeOfRemAddr:=SizeOf(TSockAddrIn);
  Sock:=accept(SockServer,@RemoteAddr,@SizeOfRemAddr);
  if Sock=INVALID_SOCKET then
  begin
    MessageBox(0,PWideChar('������'),
      PWideChar('������ �������� ������ �������'),MB_OK);
    exit;
  end;
  repeat
    Res:=Recv(Sock,buf,SizeOf(buf),0);
    if Res=SOCKET_ERROR then
    begin
      MessageBox(0,PWideChar('������'),PWideChar('������ ������ ������'),MB_OK);
      exit;
    end;
  until (buf='s') or (Res=0); // ����������� �������
  closesocket(Sock);
  closesocket(SockServer);
end;

//------------------------------------------------------------------------------
{ �������� ��������� � ���, ��� ��� ������� ������ �����������}

procedure SendSeted;
var
  Sock:TSocket;
  Addr:TSockAddrIn;
  Res:integer;
  buf:ansichar;
begin
  Sock:=socket(AF_INET,SOCK_STREAM,IPPROTO_IP);
  if Sock=INVALID_SOCKET then
  begin
    MessageBox(0,PWideChar('������'),PWideChar('������ �������� ������'),MB_OK);
    exit;
  end;
  Addr.sin_family:=AF_INET;
  Addr.sin_port:=htons(PortTo);
  Addr.sin_addr.S_un_b:=IP;
  ZeroMemory(@(Addr.sin_zero),SizeOf(Addr.sin_zero));
  Res:=connect(Sock,TSockAddr(Addr),Sizeof(Addr));
  if Res=SOCKET_ERROR then
  begin
    MessageBox(0,PWideChar('������'),PWideChar('������ ����������'),MB_OK);
    exit;
  end;
  buf:='s';
  Res:=send(Sock,buf,SizeOf(buf),0);
  if Res<1 then
  begin
    MessageBox(0,PWideChar('������'),
      PWideChar('������ �������� �������'),MB_OK);
    exit;
  end;
  closesocket(Sock);
end;

//==============================================================================
{ �������� ���������� ������ ����� ����}

procedure RecvNewFirst(var SockServer:TSocket);
var
  Sock:TSocket;
  AddrServ,RemoteAddr:TSockAddrIn;
  Res,SizeOfRemAddr:integer;
  buf:ansichar;
begin
  SockServer:=socket(AF_INET,SOCK_STREAM,IPPROTO_IP);
  if SockServer=INVALID_SOCKET then
  begin
    MessageBox(0,PWideChar('������'),PWideChar('������ �������� ������'),MB_OK);
    exit;
  end;
  AddrServ.sin_family:=AF_INET;
  AddrServ.sin_port:=htons(PortFrom);
  AddrServ.sin_addr.S_addr:=INADDR_ANY;
  ZeroMemory(@(AddrServ.sin_zero),SizeOf(AddrServ.sin_zero));
  Res:=bind(SockServer,TSockAddr(AddrServ),SizeOf(AddrServ));
  if Res=SOCKET_ERROR then
  begin
    MessageBox(0,PWideChar('������'),PWideChar('������ ��������'),MB_OK);
    exit;
  end;
  Res:=listen(SockServer,MAX_CONNECTIONS);
  if Res=SOCKET_ERROR then
  begin
    MessageBox(0,PWideChar('������'),PWideChar('������ �������������'),MB_OK);
    exit;
  end;
  SizeOfRemAddr:=SizeOf(TSockAddrIn);
  Sock:=accept(SockServer,@RemoteAddr,@SizeOfRemAddr);
  if Sock=INVALID_SOCKET then
  begin
    MessageBox(0,PWideChar('������'),
      PWideChar('������ �������� ������ �������'),MB_OK);
    exit;
  end;
  repeat
    Res:=Recv(Sock,buf,SizeOf(buf),0);
    if Res=SOCKET_ERROR then
    begin
      MessageBox(0,PWideChar('������'),PWideChar('������ ������ ������'),MB_OK);
      exit;
    end;
  until (buf='n') or (Res=0); // ����������� �������
  closesocket(Sock);
  closesocket(SockServer);
end;

//------------------------------------------------------------------------------
{ �������� ��������� � ������ ����� ����}

procedure SendNew;
var
  Sock:TSocket;
  Addr:TSockAddrIn;
  Res:integer;
  buf:ansichar;
begin
  Sock:=socket(AF_INET,SOCK_STREAM,IPPROTO_IP);
  if Sock=INVALID_SOCKET then
  begin
    MessageBox(0,PWideChar('������'),PWideChar('������ �������� ������'),MB_OK);
    exit;
  end;
  Addr.sin_family:=AF_INET;
  Addr.sin_port:=htons(PortTo);
  Addr.sin_addr.S_un_b:=IP;
  ZeroMemory(@(Addr.sin_zero),SizeOf(Addr.sin_zero));
  Res:=connect(Sock,TSockAddr(Addr),Sizeof(Addr));
  if Res=SOCKET_ERROR then
  begin
    MessageBox(0,PWideChar('������'),PWideChar('������ ����������'),MB_OK);
    exit;
  end;
  buf:='n';
  Res:=send(Sock,buf,SizeOf(buf),0);
  if Res<1 then
  begin
    MessageBox(0,PWideChar('������'),
      PWideChar('������ �������� �������'),MB_OK);
    exit;
  end;
  closesocket(Sock);
end;

//==============================================================================
{ �������� ��������}

function SendFight(x,y:integer):char;
var
  Sock:TSocket;
  Addr:TSockAddrIn;
  Res:integer;
  buf:array[0..1] of integer;
  bufC:char;
begin
  Result:='0';
  Sock:=socket(AF_INET,SOCK_STREAM,IPPROTO_IP);
  if Sock=INVALID_SOCKET then
  begin
    MessageBox(0,PWideChar('������'),PWideChar('������ �������� ������'),MB_OK);
    exit;
  end;
  Addr.sin_family:=AF_INET;
  Addr.sin_port:=htons(PortTo);
  Addr.sin_addr.S_un_b:=IP;
  ZeroMemory(@(Addr.sin_zero),SizeOf(Addr.sin_zero));
  Res:=connect(Sock,TSockAddr(Addr),Sizeof(TSockAddrIn));
  if Res=SOCKET_ERROR then
  begin
    MessageBox(0,PWideChar('������'),PWideChar('������ ����������'),MB_OK);
    exit;
  end;
  buf[0]:=X;
  buf[1]:=Y;
  Res:=send(Sock,buf,SizeOf(buf),0);
  if Res<8 then
  begin
    MessageBox(0,PWideChar('������'),PWideChar('������ �������� ������'),MB_OK);
    exit;
  end;
  Res:=recv(Sock,bufC,1,0);
  if Res<1 then
  begin
    MessageBox(0,PWideChar('������'),PWideChar('������ ������ �������'),MB_OK);
    exit;
  end;
  closesocket(Sock);
  Result:=bufC;
end;

//------------------------------------------------------------------------------
{ �������� ��������}

function RecvFight(var x,y:integer; var Blocks:TBlocks;
  var SockServer:TSocket;CrBm:TCrBM):ansichar;
var
  Sock:TSocket;
  AddrServ,RemoteAddr:TSockAddrIn;
  Res,SizeOfRemAddr,FullLen:integer;
  buf:ansichar;
  FullBuf:ansistring;
  bX:^Integer;
begin
  Result:='0';
  SockServer:=socket(AF_INET,SOCK_STREAM,IPPROTO_IP);
  if SockServer=INVALID_SOCKET then
  begin
    MessageBox(0,PWideChar('������'),PWideChar('������ �������� ������'),MB_OK);
    exit;
  end;
  AddrServ.sin_family:=AF_INET;
  AddrServ.sin_port:=htons(PortFrom);
  AddrServ.sin_addr.S_addr:=INADDR_ANY;
  ZeroMemory(@(AddrServ.sin_zero),SizeOf(AddrServ.sin_zero));
  Res:=bind(SockServer,TSockAddr(AddrServ),SizeOf(AddrServ));
  if Res=SOCKET_ERROR then
  begin
    MessageBox(0,PWideChar('������'),PWideChar('������ ��������'),MB_OK);
    exit;
  end;
  Res:=listen(SockServer,MAX_CONNECTIONS);
  if Res=SOCKET_ERROR then
  begin
    MessageBox(0,PWideChar('������'),PWideChar('������ �������������'),MB_OK);
    exit;
  end;
  SizeOfRemAddr:=SizeOf(TSockAddrIn);
  Sock:=accept(SockServer,@RemoteAddr,@SizeOfRemAddr);
  if Sock=INVALID_SOCKET then
  begin
    MessageBox(0,PWideChar('������'),
      PWideChar('������ �������� ������ �������'),MB_OK);
    exit;
  end;
  FullLen:=0;
  repeat
    ZeroMemory(@buf,SizeOf(buf));
    Res:=Recv(Sock,buf,SizeOf(buf),0);
    if Res=SOCKET_ERROR then
    begin
      MessageBox(0,PWideChar('������'),PWideChar('������ ������ ������'),MB_OK);
      exit;
    end;
    FullLen:=FullLen+Res;
    FullBuf:=FullBuf+buf;
    if buf='n' then // ��������� �������� ����� ����
    begin
      send(Sock,buf,1,0); // ��������� ���������, ������� �� ����� ����������
      closesocket(SockServer);
      Result:=buf;
      exit;
    end;
  until FullLen=8;
  if Length(Fullbuf)<8 then
  begin
    MessageBox(0,PWideChar('������'),PWideChar('������ ������ ������'),MB_OK);
    exit;
  end;
  bX:=@Fullbuf[1];
  X:=bX^;
  bX:=@Fullbuf[5];
  Y:=bX^;
  if Blocks[X,Y]=nil then
  begin
    buf:='m';     //����
    CrBm(X,Y);
  end
  else
  begin
    if Blocks[X,Y].Tag=9 then
      buf:='p';  // ����, �.�. ��� �������,�� ������ �� �����, �.�. ���� �������
                 // ������� ����������� ������� ��������. ��������� ���
                 // �������������| �� ����, �� �� �������� ������, ���������
                 // ������ ��������
    if Blocks[X,Y].Tag=10 then
    begin
      buf:='p';  //�����
      Blocks[X,Y].Picture.LoadFromFile('SheepFire.jpg');
      Blocks[X,Y].Tag:=9;
    end;
  end;
  Res:=send(Sock,buf,1,0);
  if Res<1 then
  begin
    MessageBox(0,PWideChar('������'),
      PWideChar('������ �������� �������'),MB_OK);
    exit;
  end;
  Result:=buf;
  closesocket(Sock);
  closesocket(SockServer);
end;

//==============================================================================

initialization
  WSAStartup(MakeWord(2,0),info);

finalization
  WSACleanup;

end.
