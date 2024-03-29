unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,System.UITypes,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,IniFiles, sSkinManager,Unit2,
  sButton, sMemo,ShellApi, Vcl.ComCtrls, sStatusBar, Vcl.ExtCtrls, sPanel,
  acHeaderControl, sComboBox, sLabel, Vcl.Menus, sCheckBox, sEdit;

type
  TForm1 = class(TForm)
    sSkinManager1: TsSkinManager;
    sStatusBar1: TsStatusBar;
    Button1: TsButton;
    sButton1: TsButton;
    sButton2: TsButton;
    sPanel1: TsPanel;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    sButton3: TsButton;
    sCheckBox1: TsCheckBox;
    sEdit2: TsEdit;
    sLabel6: TsLabel;
    sButton4: TsButton;
    MainMenu1: TMainMenu;
    E1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    procedure Button1Click(Sender: TObject);
    procedure CompClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CompMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
    procedure CompMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CompMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormDestroy(Sender: TObject);
    procedure CreateButton(BtnLeft,BtnTop,Ind:integer; CompName:string);
    procedure sButton1Click(Sender: TObject);
    procedure SetIP(i:integer);
    procedure sButton2Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure sButton3Click(Sender: TObject);
    procedure sButton4Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  {$M+}
  TComp = class(TObject)
    private
      fName:string;
      fId,fLeft,fTop:integer;
      fState:boolean;
      procedure SetName(value:string);
      procedure SetId(value:integer);
      procedure SetLeft(value:integer);
      procedure SetTop(value:integer);
      procedure SetState(value:boolean);
    public
      IP:string;
      constructor Create(Ind,fLeft,fTop:integer; fName,fIP:string;fState:boolean);
      destructor Destroy;override;
    published
      property Name:string read fName write SetName;
      property Id:integer read fId write SetId;
      property Left:integer read fLeft write SetLeft;
      property Top:integer read fTop write SetTop;
      property State:boolean read fState write SetState;
  end;
  TComps = array of TComp;
var
  Form1: TForm1;
  CompButtons:array[0..100] of TsButton;
  CompsCount:integer;
  IniConfig:TIniFile;
  MouseDowned:boolean;
  Comps:TComps;
  TimeClick:cardinal;
  Sdvig:integer;
  PopupButInd:integer;
implementation

{$R *.dfm}

procedure TForm1.CompMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  MouseDowned:=true;
  TimeClick:=GetTickCount;
end;

procedure TForm1.CompMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  MouseDowned:=false;
end;

procedure TForm1.CreateButton(BtnLeft,BtnTop,Ind:integer; CompName:string);
begin
  CompButtons[Ind]:=TsButton.Create(sPanel1);
  CompButtons[Ind].Top := BtnTop;
  CompButtons[Ind].Left := BtnLeft;
  CompButtons[Ind].Parent := sPanel1;
  CompButtons[Ind].Name := 'Comp'+IntToStr(Ind);
  CompButtons[Ind].Caption := CompName;
  CompButtons[Ind].Tag := Ind;
  CompButtons[Ind].Width := 100;
  CompButtons[Ind].Height := 40;
  CompButtons[Ind].OnClick := CompClick;
  CompButtons[Ind].OnMouseDown:=CompMouseDown;
  CompButtons[Ind].OnMouseUp:=CompMouseUp;
  CompButtons[Ind].OnMouseMove:=CompMouseMove;
  CompButtons[Ind].DoubleBuffered:=true;
  CompButtons[Ind].ControlStyle:=CompButtons[Ind].ControlStyle + [csOpaque];
  CompButtons[Ind].ShowFocus:=false;
  CompButtons[Ind].SkinData.CustomFont:=true;
  CompButtons[Ind].PopupMenu:=PopupMenu1;
end;

procedure TForm1.CompMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  Left,Top:integer;
begin
  Left:=Mouse.CursorPos.X-Form1.Left-sPanel1.Left-8-((Sender as TButton).Width div 2);
  Top:=Mouse.CursorPos.Y-Form1.Top-sPanel1.Top-19-((Sender as TButton).Height div 2);
  if MouseDowned and (ssShift in Shift) then  // ���� ������ ����� ������� � shift
  begin
    (Sender as TButton).BringToFront;
    if (Top>10) and (Top<(sPanel1.Height-50)) then   // ���� �� ������� �� ������� ������ �� ������
    begin
      (Sender as TButton).Top:=Top;
      Comps[(Sender as TButton).Tag].Top:=(Sender as TButton).Top;
    end;
    if (Left>10) and (Left<(sPanel1.Width-110)) then    // ���� �� ������� �� ������� ������ �� ������
    begin
      (Sender as TButton).Left:=Left;
      Comps[(Sender as TButton).Tag].Left:=(Sender as TButton).Left;
    end;
    Application.ProcessMessages;
  end;
end;





procedure TForm1.CompClick(Sender: TObject);
begin
  if (GetTickCount-TimeClick)>300 then
    exit;
  Unit2.Name:=Comps[(Sender as TButton).Tag].Name;
  Unit2.IP:=Comps[(Sender as TButton).Tag].IP;
  Unit2.State:=Comps[(Sender as TButton).Tag].State;
  Form2.Left:=Form1.Width div 2-Form2.Width div 2+Form1.Left;
  Form2.Top:=Form1.Height div 2-Form2.Height div 2+Form1.Top;
  if not Form2.Showing then
    Form2.Showmodal;
  Comps[(Sender as TButton).Tag].Name:=Unit2.Name;
  Comps[(Sender as TButton).Tag].IP:=Unit2.IP;
  Comps[(Sender as TButton).Tag].State:=Unit2.State;
  SetIP((Sender as TButton).Tag);
end;




procedure TForm1.FormCreate(Sender: TObject);
var
  i,BtnLeft,BtnTop:integer;
  CompName,CompIP:string;
  State:boolean;
begin
  Sdvig:=0;
  ControlStyle:=ControlStyle + [csOpaque];
  IniConfig:=TIniFile.Create(ExtractFilePath(Application.ExeName)+'config.ini');
  CompsCount:=IniConfig.ReadInteger('Configs','CompsCount',0);
  SetLength(Comps,CompsCount);
  for i:=0 to CompsCount-1 do
  begin
    BtnLeft:=IniConfig.ReadInteger('Comp'+IntToStr(i),'Left',0);
    BtnTop:=IniConfig.ReadInteger('Comp'+IntToStr(i),'Top',0);
    CompName:=IniConfig.ReadString('Comp'+IntToStr(i),'Name',IntToStr(i));
    CompIP:=IniConfig.ReadString('Comp'+IntToStr(i),'IP','');
    State:=IniConfig.ReadBool('Comp'+IntToStr(i),'State',false);
    Comps[i]:=TComp.Create(i,BtnLeft,BtnTop,CompName,CompIP,State);
  end;
  IniConfig.Free;
end;

procedure TForm1.FormDestroy(Sender: TObject);
var
  i:integer;
begin
  IniConfig:=TIniFile.Create(ExtractFilePath(Application.ExeName)+'config.ini');
  IniConfig.WriteInteger('Configs','CompsCount',CompsCount);
  for i:=0 to CompsCount-1 do
  begin
    IniConfig.WriteInteger('Comp'+IntToStr(i),'Left',Comps[i].Left);
    IniConfig.WriteInteger('Comp'+IntToStr(i),'Top',Comps[i].Top);
    IniConfig.WriteString('Comp'+IntToStr(i),'Name',Comps[i].Name);
    IniConfig.WriteString('Comp'+IntToStr(i),'IP',Comps[i].IP);
    IniConfig.WriteBool('Comp'+IntToStr(i),'State',Comps[i].State);
  end;
  IniConfig.Free;
end;



procedure TForm1.N1Click(Sender: TObject);
var
  Tag:integer;
  ButSel:TButton;
begin
  ButSel:=(((Sender as TMenuItem).GetParentComponent as TPopupMenu).PopupComponent as TButton);
  Tag:=ButSel.Tag;
  Comps[Tag].Free;
  Comps[ButSel.Tag]:=Comps[CompsCount-1];
  CompButtons[Tag]:=CompButtons[CompsCount-1];
  CompButtons[Tag].Tag:=Tag;
  dec(CompsCount);
end;

procedure TForm1.N2Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TForm1.sButton1Click(Sender: TObject);
var
  i:integer;
begin
  if sStatusBar1.Panels[0].Text<>'Status:' then exit;
  sButton1.Enabled:=false;
  sButton2.Enabled:=false;
  Button1.Enabled:=false;
  sStatusBar1.Panels[0].Text:='Status: ';
  for i:=0 to CompsCount-1 do
  begin
    Application.ProcessMessages;
    if Application.Terminated then
      exit;
    sStatusBar1.Panels[0].Text:='Status: IP Updating '+Comps[i].Name;
    SetIP(i);
  end;
  sStatusBar1.Panels[0].Text:='Status:';
  sButton1.Enabled:=true;
  sButton2.Enabled:=true;
  Button1.Enabled:=true;
end;

procedure TForm1.sButton2Click(Sender: TObject);
var
  i:integer;
begin
  sButton1.Enabled:=false;
  sButton2.Enabled:=false;
  Button1.Enabled:=false;
  sStatusBar1.Panels[0].Text:='Status:';
  for i:=0 to CompsCount-1 do
  begin
    Application.ProcessMessages;
    if Application.Terminated then
      exit;
    sStatusBar1.Panels[0].Text:='Status: Try connect to '+Comps[i].Name;
    if Comps[i].IP<>'' then
      if OpenPort(Comps[i].IP) then
        Comps[i].State:=true
      else
        Comps[i].State:=false;
  end;
  sStatusBar1.Panels[0].Text:='Status:';
  sButton1.Enabled:=true;
  sButton2.Enabled:=true;
  Button1.Enabled:=true;
end;

procedure TForm1.sButton3Click(Sender: TObject);
var
  i:integer;
  Force:string;
begin
  if MessageDlg('Do you really want restart the computer?',mtConfirmation, mbOKCancel, 0)=mrCancel then
    exit;
  sStatusBar1.Panels[0].Text:='Status: Restarting All Computers!';
  if sCheckBox1.Checked then
    Force:=' /f '
  else
    Force:=' ';
  for i:=0 to CompsCount-1 do
    if Comps[i].State then
      ShellExecute(Handle,PWideChar('open'),PWideChar('shutdown.exe'),PWideChar('/r /t '+sEdit2.Text+Force+' /m \\'+Comps[i].Name),nil,SW_HIDE);
  sStatusBar1.Panels[0].Text:='Status:';
  ShowMessage('All computers will be restarted');
end;

procedure TForm1.sButton4Click(Sender: TObject);
var
  i:integer;
  Force:string;
begin
  if MessageDlg('Do you really want shutdown the computer?',mtConfirmation, mbOKCancel, 0)=mrCancel then
    exit;
  sStatusBar1.Panels[0].Text:='Status: Shutdowning All Computers!';
  if sCheckBox1.Checked then
    Force:=' /f '
  else
    Force:=' ';
  for i:=0 to CompsCount-1 do
    if Comps[i].State then
      ShellExecute(Handle,PWideChar('open'),PWideChar('shutdown.exe'),PWideChar('/s /t '+sEdit2.Text+Force+' /m \\'+Comps[i].Name),nil,SW_HIDE);
  sStatusBar1.Panels[0].Text:='Status:';
  ShowMessage('All computers will be shutdowned');
end;

procedure TForm1.SetIP(i:integer);
var
  Res,sIP:string;
begin
  Res:=Ping(Comps[i].Name+' -n 1 -4');
  if (Pos('�����',Res)=0) then
  begin
    Comps[i].State:=false;
    Comps[i].IP:='';
  end
  else
  begin
    Res:=Copy(Res,Pos('[',Res)+1,Length(Res));
    sIP:=Copy(Res,1,Pos(']',Res)-1);
    Comps[i].IP:=sIP;
    if OpenPort(sIP) then
      Comps[i].State:=true
    else
      Comps[i].State:=false;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  Name:string;
begin
  SetLength(Comps,CompsCount+1);
  Sdvig:=Sdvig+5;
  if (Sdvig+200)>Form1.Height then
    Sdvig:=0;
  Name:=InputBox('Enter name of computer!','NETBIOS name:', IntToStr(CompsCount));
  if Name='' then
    Name:=IntToStr(CompsCount);
  Comps[CompsCount]:=TComp.Create(CompsCount,100+Sdvig,100+Sdvig,Name, '',false);
  Inc(CompsCount);// ����� ����� �������� ����������(� ������), ����� �� ���� ������ ��-�� ��������
  sStatusBar1.Panels[0].Text:='Status: IP Updating '+Name;
  SetIP(CompsCount-1);
  sStatusBar1.Panels[0].Text:='Status:';
end;

{ Comp }

constructor TComp.Create(Ind,fLeft,fTop:integer; fName,fIP:string;fState:boolean);
begin
  Form1.CreateButton(fLeft,fTop,Ind,fName);
  Id:=Ind;
  Name:=fName;
  Left:=fLeft;
  Top:=fTop;
  IP:='';
  State:=fState;
  IP:=fIP;
end;

destructor TComp.Destroy;
begin
  CompButtons[Id].Free;
  Form1.Update;
end;

procedure TComp.SetId(value: integer);
begin
  fId:=value;
  CompButtons[fId].Tag:=value;
end;

procedure TComp.SetLeft(value: integer);
begin
  fLeft:=value;
  CompButtons[fId].Left:=value;
end;

procedure TComp.SetName(value: string);
begin
  fName:=value;
  CompButtons[fId].Caption:=value;
end;

procedure TComp.SetState(value: boolean);
begin
  if value then
    CompButtons[Id].Font.Color:=$00ff00
  else
    CompButtons[Id].Font.Color:=$0000ff;
  fState:=value;
end;

procedure TComp.SetTop(value: integer);
begin
  fTop:=value;
  CompButtons[fId].Top:=value;
end;

end.
