unit Unit1;
      //�������� ����� ��������� ����/����� ��������� �� ������/��������
interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, sSkinManager, Vcl.Imaging.jpeg,
  Vcl.ExtCtrls, Vcl.StdCtrls, sButton, sComboBox, Vcl.ComCtrls, sStatusBar,Inet,winsock2,
  sEdit, sLabel;

type
  /// <summary>
  /// ����� �����
  /// </summary>
  TForm1 = class(TForm)

    ///	<summary>
    ///	  ���� ������
    ///	</summary>
    ImagePlayer: TImage;

    ///	<summary>
    ///	  �������� ������ �����
    ///	</summary>
    sSkinManager1: TsSkinManager;

    ///	<summary>
    ///	  ������� �����������
    ///	</summary>
    ImageBack: TImage;

    ///	<summary>
    ///	  ���� ����������
    ///	</summary>
    ImageEnemy: TImage;

    ///	<summary>
    ///	  ������������� ���� ����
    ///	</summary>
    sComboBox1: TsComboBox;

    ///	<summary>
    ///	  ������ ����� ����
    ///	</summary>
    sButton1: TsButton;

    ///	<summary>
    ///	  ������ ������ �������
    ///	</summary>
    sStatusBar1: TsStatusBar;

    ///	<summary>
    ///	  ����� IP
    ///	</summary>
    sLabel1: TsLabel;

    ///	<summary>
    ///	  Edit IP
    ///	</summary>
    sEdit1: TsEdit;

    ///	<summary>
    ///	  �������
    ///	</summary>
    ImageLogo: TImage;

    ///	<summary>
    ///	  ��������� ������
    ///	</summary>
    Timer1: TTimer;

    ///	<summary>
    ///	  ������������ ����������� �������� �� ���� ������
    ///	</summary>
    ///	<param name="Sender">
    ///	  ������, ��������� �����
    ///	</param>
    procedure ImagePlayerClick(Sender: TObject);

    ///	<summary>
    ///	  ������������� IP � ��������� �������� ����������
    ///	</summary>
    ///	<param name="Sender">
    ///	  ������, ��������� �����
    ///	</param>
    procedure FormCreate(Sender: TObject);

    ///	<summary>
    ///	  ������������� ���� ������� ����� ������(����� ��� ������)
    ///	</summary>
    ///	<param name="Sender">
    ///	  ������, ��������� �����
    ///	</param>
    ///	<param name="Button">
    ///	  ������ ����
    ///	</param>
    ///	<param name="Shift">
    ///	  ��������� ������� Shift
    ///	</param>
    ///	<param name="X">
    ///	  ��������� ���� X
    ///	</param>
    ///	<param name="Y">
    ///	  ��������� ���� Y
    ///	</param>
    procedure ImagePlayerMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

    ///	<summary>
    ///	  ������ ����� ����
    ///	</summary>
    ///	<param name="Sender">
    ///	  ������, ��������� �����
    ///	</param>
    procedure sButton1Click(Sender: TObject);

    ///	<summary>
    ///	  ������������ �������� � ������� ����������
    ///	</summary>
    ///	<param name="Sender">
    ///	  ������, ��������� �����
    ///	</param>
    procedure ImageEnemyClick(Sender: TObject);

    ///	<summary>
    ///	  ������������� IP, ���� �� ������� � ����
    ///	</summary>
    ///	<param name="Sender">
    ///	  ������, ��������� �����
    ///	</param>
    procedure sEdit1Change(Sender: TObject);

    ///	<summary>
    ///	  �������� ���� � ��������� ����� �������� ����� ����
    ///	</summary>
    ///	<param name="Sender">
    ///	  ������, ��������� �����
    ///	</param>
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  { ����� ������ ��� �������� ��������}
  /// <summary>
  /// ����� ������ ��� �������� ��������
  /// </summary>
  TRecvThr = class(TThread)
  private
    X,Y:integer;
    B:TBlocks;
    Ret:ansichar;
    Executed:boolean;
  protected
    ///	<summary>
    ///	  ���� ������ �������� ��������
    ///	</summary>
    procedure Execute;override;

    ///	<summary>
    ///	  ���������� ��������� ��������
    ///	</summary>
    procedure WriteRes;

    ///	<summary>
    ///	  ������ ����� ������ � ��������� ���������� ������
    ///	</summary>
    procedure ReadBlocks;
  end;

  { ����� ������ ��� �������� ��������� � ���, ��� ��������� ��������� �������}
  /// <summary>
  /// ����� ������ ��� �������� ��������� � ���, ��� ��������� ��������� �������
  /// </summary>
  TSetedThr = class(TThread)
  protected
    ///	<summary>
    ///	  ���� ������ �������� ����������� �������� �����������
    ///	</summary>
    procedure Execute;override;

    ///	<summary>
    ///	  ���������� � ���������� ���������� ����, ��� ������� ����������
    ///	  �����������
    ///	</summary>
    procedure WriteEnemySeted;
  end;

  { ����� ������ ��� �������� ��������� � ������ ����� ����}
  /// <summary>
  /// ����� ������ ��� �������� ��������� � ������ ����� ����
  /// </summary>
  TNewThr = class(TThread)
  protected
    ///	<summary>
    ///	  ���� ������ �������� ������� ������ ����� ���� �����������
    ///	</summary>
    procedure Execute;override;

    ///	<summary>
    ///	  ��������� ����������� ���������� ��� ������ ����� ����
    ///	</summary>
    procedure NewGame;
  end;

  TOrientation = (vertic, horizont);
  TBlocks = array[1..10, 1..10] of TImage;
var
  Form1: TForm1;
  Img:TImage;
  Blocks:TBlocks;
  BlocksE:TBlocks;
  Palub:integer;
  MLeft:boolean;
  Seted,EnemySeted:boolean;
  Received:boolean;
  X,Y:integer;
  RecvThr:TRecvThr;
  NotSetedThr:TSetedThr;
  SockServer:TSocket;
  Hod,Pobeda,Proigrysh:boolean;
  Res:ansichar;
  NewThr:TNewThr;
  FirstClick:boolean; // true - ����� ��������� ��������� � ����� ����
  ShouldStart:boolean; // ��� �������. ���� true, ������ ������ ����� ����
  Clicked:boolean;
  ClickToEnemy: boolean;
  Field1: Integer;

implementation

{$R *.dfm}

procedure ReceiveNewGame;forward;
//==============================================================================
{ �������� ����������� �����
    X, Y �� 1 �� 10}
///<summary>
/// �������� ����������� �����
///</summary>
///	<param name="X">
///	  ���������� X ����� �� ����. ��������� �������� �� 1 �� 10
///	</param>
///	<param name="Y">
///	  ���������� Y ����� �� ����. ��������� �������� �� 1 �� 10
///	</param>
procedure CreateBlock(X,Y:integer);
begin
  Blocks[X,Y]:=TImage.Create(Form1);
  Blocks[X,Y].Tag:=10;
  Blocks[X,Y].Left:=X*30+Form1.ImagePlayer.Left;
  Blocks[X,Y].Top:=Y*30+Form1.ImagePlayer.Top;
  Blocks[X,Y].Width:=30;
  Blocks[X,Y].Height:=30;
  Blocks[X,Y].Parent:=Form1;
  Blocks[X,Y].Picture.LoadFromFile('Sheep.jpg');
  Blocks[X,Y].Update;
  Form1.Update;
end;

//------------------------------------------------------------------------------
{ �������� ����� ������������� ������ �� ���� ����������}
///<summary>
/// �������� ����� ������������� ������ �� ���� ����������
///</summary>
///	<param name="X">
///	  ���������� X ����� �� ����. ��������� �������� �� 1 �� 10
///	</param>
///	<param name="Y">
///	  ���������� Y ����� �� ����. ��������� �������� �� 1 �� 10
///	</param>
procedure CreateBlockFightEnemy(X,Y:integer);
begin
  BlocksE[X,Y]:=TImage.Create(Form1);
  BlocksE[X,Y].Tag:=9;
  BlocksE[X,Y].Left:=X*30+Form1.ImageEnemy.Left;
  BlocksE[X,Y].Top:=Y*30+Form1.ImageEnemy.Top;
  BlocksE[X,Y].Width:=30;
  BlocksE[X,Y].Height:=30;
  BlocksE[X,Y].Parent:=Form1;
  BlocksE[X,Y].Picture.LoadFromFile('SheepFire.jpg');
  BlocksE[X,Y].Update;
  Form1.Update;
end;

//------------------------------------------------------------------------------
{ �������� �����-������� �� ���� ����������}
///<summary>
/// �������� �����-������� �� ���� ����������
///</summary>
///	<param name="X">
///	  ���������� X ����� �� ����. ��������� �������� �� 1 �� 10
///	</param>
///	<param name="Y">
///	  ���������� Y ����� �� ����. ��������� �������� �� 1 �� 10
///	</param>
procedure CreateBlockMimoEnemy(X,Y:integer);
begin
  BlocksE[X,Y]:=TImage.Create(Form1);
  BlocksE[X,Y].Tag:=100;
  BlocksE[X,Y].Left:=X*30+Form1.ImageEnemy.Left;
  BlocksE[X,Y].Top:=Y*30+Form1.ImageEnemy.Top;
  BlocksE[X,Y].Width:=30;
  BlocksE[X,Y].Height:=30;
  BlocksE[X,Y].Parent:=Form1;
  BlocksE[X,Y].Picture.LoadFromFile('Point.jpg');
  BlocksE[X,Y].Update;
  Form1.Update;
end;

//------------------------------------------------------------------------------
{�������� �����-������� �� ���� ������}
///<summary>
/// �������� �����-������� �� ���� ������
///</summary>
///	<param name="X">
///	  ���������� X ����� �� ����. ��������� �������� �� 1 �� 10
///	</param>
///	<param name="Y">
///	  ���������� Y ����� �� ����. ��������� �������� �� 1 �� 10
///	</param>
procedure CreateBlockMimo(X,Y:integer);
begin
  Blocks[X,Y]:=TImage.Create(Form1);
  Blocks[X,Y].Tag:=100;
  Blocks[X,Y].Left:=X*30+Form1.ImagePlayer.Left;
  Blocks[X,Y].Top:=Y*30+Form1.ImagePlayer.Top;
  Blocks[X,Y].Width:=30;
  Blocks[X,Y].Height:=30;
  Blocks[X,Y].Parent:=Form1;
  Blocks[X,Y].Picture.LoadFromFile('Point.jpg');
  Blocks[X,Y].Update;
  Form1.Update;
end;

//==============================================================================
{ ���������� ������������� ������ �� ���� ������}
///<summary>
/// ���������� ���������� ������������� ������ �� ���� ������
///</summary>
///<returns>
///  ����������� ������������� �����
///</returns>
function GetFightColls:integer;
var
  i,j:integer;
begin
  Result:=0;
  for i:=1 to 10 do
    for j:=1 to 10 do
      if Blocks[i,j]<>nil then
        inc(Result);
end;

//------------------------------------------------------------------------------
{ ���������� ������������� ������ �� ���� ����������}
///<summary>
/// ���������� ������������� ������ �� ���� ����������
///</summary>
///<returns>
///  ����������� ������������� �����
///</returns>
function GetEnemyFightColls:integer;
var
  i,j:integer;
begin
  Result:=0;
  for i:=1 to 10 do
    for j:=1 to 10 do
      if BlocksE[i,j]<>nil then
        inc(Result);
end;

//------------------------------------------------------------------------------
///<summary>
/// ����� �������?
///</summary>
///<returns>
///  true - ���� ����� �������, false - �����
///</returns>
function IsPlayerWin:boolean;
var
  i,j,k:integer;
begin
  k:=0;
  for i:=1 to 10 do
    for j:=1 to 10 do
      if (BlocksE[i,j]<>nil) and (BlocksE[i,j].Tag=9) then
        inc(k);
  if k=20 then
    Result:=true
  else
    Result:=false;
end;

//------------------------------------------------------------------------------
///<summary>
/// ����� ��������?
///</summary>
///<returns>
///  true - ���� ����� �������, false - �����
///</returns>
function IsPlayerLost:boolean;
var
  i,j,k:integer;
begin
  k:=0;
  for i:=1 to 10 do
    for j:=1 to 10 do
      if (Blocks[i,j]<>nil) and (Blocks[i,j].Tag=9) then
        inc(k);
  if k=20 then
    Result:=true
  else
    Result:=false;
end;

//==============================================================================
{ ����� ����. ����� ���� ������ ������ ���� � ������ ���� �����}
///<summary>
/// ����� ����. ����� ���� ������ ������ ���� � ������ ���� �����
///</summary>
procedure NewGame;
var
  i: Integer;
  j: Integer;
begin
  Clicked:=true;
  Form1.sStatusBar1.Panels[0].Text:='������: ����������� ��������';
  if RecvThr<>nil then // ���� �� ���������� �����
    TerminateThread(RecvThr.Handle,0);
  RecvThr.Free;
  RecvThr:=nil;
  if NewThr<>nil then // ���� �� ���������� �����
    TerminateThread(NewThr.Handle,0);
  NewThr.Free;
  NewThr:=nil;
  if NotSetedThr<>nil then // ���� �� ���������� �����
    TerminateThread(NotSetedThr.Handle,0);
  NotSetedThr.Free;
  NotSetedThr:=nil;
  closesocket(SockServer); // ��������� ����� �������
  if FirstClick then
    SendNew;
  Form1.sButton1.Enabled:=false; // ��������� ����� ����, �.�. ��� �� ����� ������
  Pobeda:=false;
  Proigrysh:=false;
  Seted:=false;
  EnemySeted:=false;
  Palub:=0;
  for i:=1 to 10 do
    for j:=1 to 10 do
    begin
        Blocks[i,j].Free;
        Blocks[i,j]:=nil;
        BlocksE[i,j].Free;
        BlocksE[i,j]:=nil;
    end;
  //FirstClick:=false;  // �����?
  if Form1.sComboBox1.ItemIndex=1 then
  begin
    NotSetedThr:=TSetedThr.Create(false);
    while not EnemySeted do
    begin
      Application.ProcessMessages; // ���� ����������� ���������� ������� ������
      if Application.Terminated then
        exit;
      Sleep(10);
    end;
    if Seted then
      Form1.sStatusBar1.Panels[0].Text:='������: ����!';
    Hod:=true;
    Res:='p';
    while Res='p' do
    begin
      ClickToEnemy:=false; // ��� ������� �� ���� ����������
      Received:=false;
      RecvThr:=TRecvThr.Create(false);
      while not Received do      // ���� ����� �� ������ ������ ������� ��������
      begin
        Application.ProcessMessages;
        if Application.Terminated then
          exit;
        if ClickToEnemy then // ���� ������ ������
        begin
          FirstClick:=true;
          exit;
        end;
        Sleep(100);
      end;
      if RecvThr<>nil then
        TerminateThread(RecvThr.Handle,0);
      RecvThr.Free;
      RecvThr:=nil;
      if IsPlayerLost() then
      begin
        Form1.sStatusBar1.Panels[0].Text:='��������!';
        Proigrysh:=true;
        ShowMessage('�� ���������!');
        Form1.sButton1.Enabled:=true;
        ReceiveNewGame;
        exit;
      end;
      Form1.sStatusBar1.Panels[0].Text:='������: ��� ���';
    end;
    FirstClick:=true;
    Form1.sButton1.Enabled:=true;
  end;
end;

//==============================================================================
{ ���� ��������� � ������ ����� ���� � �������� ������}
///<summary>
/// ���� ��������� � ������ ����� ���� � �������� ������
///</summary>
procedure ReceiveNewGame;
begin
  if RecvThr<>nil then
    TerminateThread(RecvThr.Handle,0);
  RecvThr.Free;
  RecvThr:=nil;
  closesocket(SockServer);
  Clicked:=false;
  NewThr:=TNewThr.Create(false);
  ShouldStart:=false;
  while not ShouldStart do // ���� ����� �����, �� �����������
  begin                                  // ���� � ����� ���� ������ �� ��������
    Application.ProcessMessages;
    if Application.Terminated then
      exit;
    if Clicked then
      exit;
    Sleep(100);
  end;
  NewGame;
end;


//==============================================================================
{ ��������� IP ������ ���������� ��� �������� ��������������}
///<summary>
/// ��������� IP ������ ���������� ��� �������� ��������������
///</summary>
///	<param name="s">
///	  IP � ��������� ����
///	</param>
procedure SetIp(s:string);
var
  i,j:integer;
  sB:string;
begin
  sB:='';
  j:=0;
  for i:=1 to Length(s) do
  begin
    if AnsiChar(s[i]) in ['0'..'9'] then
      sB:=sB+s[i]
    else
    begin
      if j=0 then
        IP.s_b1:=Byte(StrToInt(sB));
      if j=1 then
        IP.s_b2:=Byte(StrToInt(sB));
      if j=2 then
        IP.s_b3:=Byte(StrToInt(sB));
        sB:='';
      inc(j);
    end;
  end;
  IP.s_b4:=Byte(StrToInt(sB));
end;

//------------------------------------------------------------------------------
{ ��������, �������� �� ������ IP �������}
///<summary>
/// ��������, �������� �� ������ IP �������
///</summary>
///	<param name="s">
///	  IP � ��������� ����
///	</param>
function IsIp(s:string):boolean;
  var
    i,j:integer;
  begin
    Result:=true;
    j:=0;
    for i:=1 to Length(s) do
    begin
      if (not (AnsiChar(s[i]) in ['0'..'9'])) and (s[i]<>'.') then
        Result:=false;
      if (i>1) and (i<Length(s)) then
        if s[i]='.' then
          inc(j);
    end;
    if j<>3 then
      Result:=false;
  end;

//==============================================================================
{ ���� �������� ��� ��������� �������(� ������ ������ ����)}
///<summary>
/// ���� �������� ��� ��������� �������(� ������ ������ ����)
///</summary>
///	<param name="X">
///	  X - ���������� ���������� �����
///	</param>
///	<param name="Y">
///	  Y - ���������� ���������� �����
///	</param>
///	<param name="Orientation">
///   ���������� �������
///	</param>
///	<param name="Col">
///   ���������� �����
///	</param>
///<returns>
/// ����� �� ��������� �������?
///</returns>
function BlocksIsFree(X,Y:integer; Orientation:TOrientation;Col:integer):boolean;
var
  i,j:integer;
begin
  Result:=true;
  if Orientation=vertic then   // ������������ �������
  if Y+Col<=11 then
  begin
    for j:=-1 to 1 do
    begin
      if (X+j<1) or (X+j>10) then
        Continue;
      for i:=-1 to Col do
      begin
        if (Y+i<1) or (Y+i>10) then
          Continue;
        if Blocks[X+j,Y+i]<>nil then
          Result:=false;
      end;
    end;
  end;
if Orientation=horizont then     // �������������� �������
  if X+Col<=11 then
  begin
    for j:=-1 to 1 do
    begin
      if (Y+j<1) or (Y+j>10) then
        Continue;
      for i:=-1 to Col do
      begin
        if (X+i<1) or (X+i>10) then
          Continue;
        if Blocks[X+i,Y+j]<>nil then
          Result:=false;
      end;
    end;
  end;
end;

//------------------------------------------------------------------------------
{ ���������� ������� ���������� ������� � ���������}
///<summary>
/// ���������� ������� ���������� ������� � ���������
///</summary>
///	<param name="X">
///	  X - ���������� ���������� �����
///	</param>
///	<param name="Y">
///	  Y - ���������� ���������� �����
///	</param>
///	<param name="Orientation">
///   ���������� �������
///	</param>
///	<param name="Col">
///   ���������� �����
///	</param>
///<returns>
/// ����������� �� �������?
///</returns>
function SetShip(X,Y: integer; Orientation: TOrientation;Col: integer):boolean;
var
  i: integer;
begin
  Result:=true;
  if Orientation=vertic then  // ������������ �������
    if Y+Col<=11 then
    begin
      if BlocksIsFree(X,Y,Orientation,Col) then
        for i:=0 to Col-1 do
          CreateBlock(X,Y+i)
      else
        Result:=false;
    end
    else
      Result:=false;
  if Orientation=horizont then    // �������������� �������
    if X+Col<=11 then
    begin
      if BlocksIsFree(X,Y,Orientation,Col) then
        for i:=0 to Col-1 do
          CreateBlock(X+i,Y)
      else
        Result:=false;
    end
    else
      Result:=false;
end;

//==============================================================================
{ ������������� ���������� ���� �� ������ � ���������� ������ �� ���� ������}
///<summary>
/// ������������� ���������� ���� �� ������ � ���������� ������ �� ���� ������
///</summary>
///	<param name="X">
///	  X - ���������� ���������� �����
///	</param>
///	<param name="Y">
///	  Y - ���������� ���������� �����
///	</param>
procedure GetCoords(var X,Y:integer);
begin
  // �� �������� 30(������� � ���������), ����� � ����� ���������� �����
  // �� 1 �� 10, � �� �� 0 �� 9
  X:=(X-Form1.Left-8-Form1.ImagePlayer.Left) div 30;
  Y:=(Y-Form1.Top-30-Form1.ImagePlayer.Top) div 30;
end;

//------------------------------------------------------------------------------
{ ������������� ���������� ���� �� ������ � ���������� ������ �� ����
  ����������}
///<summary>
/// ������������� ���������� ���� �� ������ � ���������� ������ �� ����
///  ����������
///</summary>
///	<param name="X">
///	  X - ���������� ����� �����
///	</param>
///	<param name="Y">
///	  Y - ���������� ����� �����
///	</param>
procedure GetCoordsEnemy(var X,Y:integer);
begin
  // �� �������� 30(������� � ���������), ����� � ����� ���������� �����
  // �� 1 �� 10, � �� �� 0 �� 9
  X:=(X-Form1.Left-8-Form1.ImageEnemy.Left) div 30;
  Y:=(Y-Form1.Top-30-Form1.ImageEnemy.Top) div 30;
end;

//==============================================================================

procedure TForm1.FormCreate(Sender: TObject);
var
  i,j: Integer;
begin
  Palub:=0;
  Seted:=false;
  for i:=1 to 10 do
    for j:=1 to 10 do
      Blocks[i,j]:=nil;
  SetIp('192.168.0.1');
  Pobeda:=true;
  FirstClick:=true;
end;

//------------------------------------------------------------------------------

procedure TForm1.ImageEnemyClick(Sender: TObject);
var
  X,Y:integer;
  Status:char;
begin
  if not Seted then exit;
  if not EnemySeted then exit;
  if not Hod then exit;
  if Pobeda or Proigrysh then exit;
  ClickToEnemy:=true;
  if RecvThr<>nil then
  begin
    TerminateThread(RecvThr.Handle,0);
    RecvThr.Free;
    RecvThr:=nil;
    closesocket(SockServer);
  end;
  X:=Mouse.CursorPos.X;
  Y:=Mouse.CursorPos.Y;
  GetCoordsEnemy(X,Y);
  if (X<1) or (Y<1) then exit;
  Status:=SendFight(X,Y);
  Hod:=false; // ��� ����������
  if Status='p' then
  begin
    CreateBlockFightEnemy(X,Y);
    Hod:=true;
    sButton1.Enabled:=true;
    if IsPlayerWin() then
    begin
      sStatusBar1.Panels[0].Text:='������!';
      Pobeda:=true;
      ShowMessage('�� ��������!');
      sButton1.Enabled:=true;
      ReceiveNewGame;
    end;
    exit;
  end;
  if Status='m' then
    CreateBlockMimoEnemy(X,Y);
  sButton1.Enabled:=false;
  Res:='p';
  while Res='p' do
  begin
    Received:=false;
      RecvThr:=TRecvThr.Create(false);
      sStatusBar1.Panels[0].Text:='������: ��� ����������';
      while not Received do      // ���� ����� �� ������ ������ ������� ��������
      begin
        Application.ProcessMessages;
        if Application.Terminated then exit;
        Sleep(10);
      end;
      if RecvThr<>nil then
        TerminateThread(RecvThr.Handle,0);
      RecvThr:=nil;
      if IsPlayerLost() then
      begin
        sStatusBar1.Panels[0].Text:='��������!';
        Proigrysh:=true;
        ShowMessage('�� ���������!');
        sButton1.Enabled:=true;
        ReceiveNewGame;
        exit;
      end;
      if Res='n' then
      begin
        ShouldStart:=false;
        NewGame;
        exit;
      end;
  end;
  sButton1.Enabled:=true;
  Hod:=true;
  sStatusBar1.Panels[0].Text:='������: ��� ���';
end;

//------------------------------------------------------------------------------

procedure TForm1.ImagePlayerClick(Sender: TObject);
var
  X,Y:integer;
begin
  if Pobeda then exit;
  if Proigrysh then exit;
  if (sComboBox1.ItemIndex=1) then
  begin
    X:=Mouse.CursorPos.X;
    Y:=Mouse.CursorPos.Y;
    GetCoords(X,Y);
    if (X<1) or (X>10) then
      exit;
    if (Y<1) or (Y>10) then
      exit;
    // ������� �� �����������
    if not Seted then
      if MLeft then    // ����� ������
      begin
        case Palub of
          0:if SetShip(X,Y,vertic,4) then
              inc(Palub);
          1,2:if SetShip(X,Y,vertic,3) then
              inc(Palub);
          3,4,5:if SetShip(X,Y,vertic,2) then
              inc(Palub);
          6,7,8:if SetShip(X,Y,vertic,1) then
              inc(Palub);
          9:if SetShip(X,Y,vertic,1) then
            begin
              inc(Palub);
              Seted:=true;
              SendSeted; // �������� ����������
              if EnemySeted then
                sStatusBar1.Panels[0].Text:='������: ����!'
              else
                sStatusBar1.Panels[0].Text:=
                  '������: �������� ����������� �������� �����������!'
            end;
        end;
      end
      else//������ ������
      begin
        case Palub of
          0:if SetShip(X,Y,horizont,4) then
              inc(Palub);
          1,2:if SetShip(X,Y,horizont,3) then
              inc(Palub);
          3,4,5:if SetShip(X,Y,horizont,2) then
              inc(Palub);
          6,7,8:if SetShip(X,Y,horizont,1) then
              inc(Palub);
          9:if SetShip(X,Y,horizont,1) then
            begin
              inc(Palub);
              Seted:=true;
              SendSeted; // �������� ����������
              if EnemySeted then
                sStatusBar1.Panels[0].Text:='������: ����!'
              else
                sStatusBar1.Panels[0].Text:=
                  '������: �������� ����������� �������� �����������!'
            end;
        end;
      end;
  end;
end;

//------------------------------------------------------------------------------

procedure TForm1.ImagePlayerMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button=mbLeft then
    MLeft:=true
  else
  begin
    MLeft:=false;
    ImagePlayerClick(Sender);
  end;
end;

//------------------------------------------------------------------------------

procedure TForm1.sButton1Click(Sender: TObject);
begin
  NewGame;
end;

//------------------------------------------------------------------------------

procedure TForm1.sEdit1Change(Sender: TObject);
begin
  if IsIp(sEdit1.Text) then
    SetIp(sEdit1.Text);
end;

//------------------------------------------------------------------------------

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled:=false;
  ImageLogo.Visible:=false;
  sEdit1.Visible:=true;
  sComboBox1.Visible:=true;
  sButton1.Visible:=true;
  ReceiveNewGame;
end;

//==============================================================================

procedure TRecvThr.Execute;
begin
  Executed:=true;
  Synchronize(ReadBlocks);
  Ret:=RecvFight(X,Y,Inet.TBlocks(Blocks),SockServer,CreateBlockMimo);
  Synchronize(WriteRes);
  Executed:=false;
end;

//------------------------------------------------------------------------------
{ ������ ����� ������ � ��������� ���������� ������}

procedure TRecvThr.ReadBlocks;
var
  i,j:integer;
begin
  for i:=1 to 10 do
    for j:=1 to 10 do
      B[i,j]:=Blocks[i,j];
end;

//------------------------------------------------------------------------------
{ ���������� ��������� ��������}

procedure TRecvThr.WriteRes;
begin
  Received:=true;
  Res:=Ret; // ����� ����������(m,p ��� n) � ���������� ����������
  Unit1.X:=X;
  Unit1.Y:=Y;
end;

//==============================================================================

{ TSetedThr }

procedure TSetedThr.Execute;
begin
  RecvSeted(SockServer);
  Synchronize(WriteEnemySeted);
end;

//------------------------------------------------------------------------------
{ ���������� � ���������� ���������� ����, ��� ������� ���������� �����������}

procedure TSetedThr.WriteEnemySeted;
begin
  EnemySeted:=true;
end;

//==============================================================================

{ TNewThr }

procedure TNewThr.Execute;
begin
  RecvNewFirst(SockServer);
  Synchronize(NewGame);
end;

//------------------------------------------------------------------------------

procedure TNewThr.NewGame;
begin
  FirstClick:=false;
  ShouldStart:=true;
end;

//==============================================================================

end.
