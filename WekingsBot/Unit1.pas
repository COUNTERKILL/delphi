unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, sSkinManager,
  Vcl.StdCtrls, sButton, Vcl.ComCtrls, sPageControl, Vcl.OleCtrls,
  sStatusBar, sGroupBox, sRadioButton, sEdit, sComboBox, sLabel, sCheckBox,mshtml,
  Vcl.ExtCtrls, sPanel, sSpinEdit,clipbrd,pngimage,jpeg, IniFiles, ac, SHDocVw,
  sSkinProvider,SyncObjs,uPanelType, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, IdAntiFreezeBase, Vcl.IdAntiFreeze;
type
  //����� ///////////
  TCard = record
    Vid:byte;
    Value:integer;
    Isset:boolean;
    iElement:IHTMLElement;
  end;
  TCards = array[0..2] of TCard;
  TBitMaps = array of TBitMap;
  TAction = record
    Action:string;
    Prior:integer;
  end;
  TEvents = record
    Pohod,Shahta,Kopat,Spusk,Vlad:boolean;
  end;
  //////// ����� ������� ////////////////////////
  TPet = class
    Param: record Sila,Zashita,Lovkost,Masterstvo,Zhivuchest:integer end;
    Health,Sila,Zashita,Lovkost,Masterstvo,Zhivuchest:integer;
    SilaCost,ZashitaCost,LovkostCost,MasterstvoCost,ZhivuchestCost:integer;
    Status:integer; // 0 - ���, 1 - � ������, 2 - �� �������
    procedure GetTrainCost;
    procedure GoToCell(inCell:boolean);
  end;
  TRichWeking = record
    id:string;
    time:Cardinal;
    Sera:integer;
  end;
  ///////// ����� ������ /////////////////////////////////////
  TPlayer = class
    Param: record Sila,Zashita,Lovkost,Masterstvo,Zhivuchest:integer end;
    Health,Fights,Sera,Golds,Kris:integer;
    SilaCost,ZashitaCost,LovkostCost,MasterstvoCost,ZhivuchestCost:integer;
    Level:integer;
    PohodIsset,ShahtaIsset,MechShitSvitokIsset:boolean;
    Nagrab,Lost,NagrabKris,LostKris,NagrabGolds:integer;
    Pet:TPet;
    SvitkiTime:Cardinal;
    SvitokOdet:boolean;
    procedure GetTrainCost;
    constructor Create;
  end;
  ///// ����� ���������� ///////////////////////////////////
  TProtivnik = class
    Param: record Sila,Zashita,Lovkost,Masterstvo,Zhivuchest:integer end;
    IsMyClan:boolean;
    id:string;
  end;
  ////// ����� ///////////////////////////
  TForm1 = class(TForm)
    sPageControl1: TsPageControl;
    sTabSheet1: TsTabSheet;
    sTabSheet2: TsTabSheet;
    sTabSheet3: TsTabSheet;
    sTabSheet4: TsTabSheet;
    sTabSheet5: TsTabSheet;
    sButton1: TsButton;
    sStatusBar1: TsStatusBar;
    WebBrowser1: TWebBrowser;
    sRadioGroup1: TsRadioGroup;
    sGroupBox1: TsGroupBox;
    sRadioButton1: TsRadioButton;
    sRadioButton2: TsRadioButton;
    sRadioButton3: TsRadioButton;
    sRadioButton4: TsRadioButton;
    sComboBox1: TsComboBox;
    sRadioButton5: TsRadioButton;
    sEdit1: TsEdit;
    sPanel1: TsPanel;
    sCheckBox1: TsCheckBox;
    sCheckBox2: TsCheckBox;
    sCheckBox3: TsCheckBox;
    sGroupBox2: TsGroupBox;
    sEdit2: TsEdit;
    sLabel1: TsLabel;
    sLabel2: TsLabel;
    sLabel3: TsLabel;
    sEdit3: TsEdit;
    sLabel4: TsLabel;
    sEdit4: TsEdit;
    sLabel5: TsLabel;
    sGroupBox3: TsGroupBox;
    sLabel6: TsLabel;
    sDecimalSpinEdit1: TsDecimalSpinEdit;
    sCheckBox6: TsCheckBox;
    sButton2: TsButton;
    sSkinManager1: TsSkinManager;
    sCheckBox7: TsCheckBox;
    sRadioButton6: TsRadioButton;
    sRadioButton7: TsRadioButton;
    sRadioGroup2: TsRadioGroup;
    AC1: TAC;
    sGroupBox4: TsGroupBox;
    sCheckBox8: TsCheckBox;
    sEdit5: TsEdit;
    sGroupBox5: TsGroupBox;
    sComboBox2: TsComboBox;
    sGroupBox6: TsGroupBox;
    sCheckBox9: TsCheckBox;
    sCheckBox10: TsCheckBox;
    sGroupBox7: TsGroupBox;
    sEdit6: TsEdit;
    sCheckBox11: TsCheckBox;
    sButton3: TsButton;
    sGroupBox8: TsGroupBox;
    sLabel7: TsLabel;
    sEdit7: TsEdit;
    sCheckBox12: TsCheckBox;
    sLabel8: TsLabel;
    sEdit8: TsEdit;
    sLabel9: TsLabel;
    sEdit9: TsEdit;
    sLabel10: TsLabel;
    sEdit10: TsEdit;
    sLabel11: TsLabel;
    sEdit11: TsEdit;
    sTabSheet6: TsTabSheet;
    sGroupBox9: TsGroupBox;
    sCheckBox14: TsCheckBox;
    sCheckBox16: TsCheckBox;
    sCheckBox17: TsCheckBox;
    sCheckBox18: TsCheckBox;
    sCheckBox19: TsCheckBox;
    sCheckBox20: TsCheckBox;
    sCheckBox21: TsCheckBox;
    sGroupBox10: TsGroupBox;
    sCheckBox5: TsCheckBox;
    sCheckBox4: TsCheckBox;
    sCheckBox13: TsCheckBox;
    sCheckBox22: TsCheckBox;
    sButton4: TsButton;
    Timer1: TTimer;
    sCheckBox23: TsCheckBox;
    sRadioGroup3: TsRadioGroup;
    sCheckBox24: TsCheckBox;
    sLabel12: TsLabel;
    sEdit12: TsEdit;
    sLabel13: TsLabel;
    sEdit13: TsEdit;
    sEdit14: TsEdit;
    sEdit15: TsEdit;
    sEdit16: TsEdit;
    sEdit17: TsEdit;
    sCheckBox25: TsCheckBox;
    sCheckBox15: TsCheckBox;
    sLabel14: TsLabel;
    sEdit18: TsEdit;
    sLabel15: TsLabel;
    sCheckBox26: TsCheckBox;
    sButton5: TsButton;
    http: TIdHTTP;
    IdAntiFreeze1: TIdAntiFreeze;
    procedure FormCreate(Sender: TObject);
    procedure SetComponentsSize;
    procedure sButton1Click(Sender: TObject);
    procedure WebBrowser1DocumentComplete(ASender: TObject;
      const pDisp: IDispatch; const URL: OleVariant);
    procedure sCheckBox7Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure sButton2Click(Sender: TObject);
    procedure sComboBox2Change(Sender: TObject);
    procedure sButton3Click(Sender: TObject);
    procedure sButton4Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure sRadioButton4Click(Sender: TObject);
    procedure sButton5Click(Sender: TObject);
    procedure sEdit12Change(Sender: TObject);

  private

    { Private declarations }
  public
    { Public declarations }
  end;
  procedure Decaptcha;
var
  Form1: TForm1;
  Player:TPlayer;
  Events:TEvents;
  ActionList:array of TAction;
  Zagrujeno:boolean;
  GlobTime:integer;
  Protivnik:TProtivnik;
  SERVER:string;
  Protivnik_MAX,Protivnik_MIN:TProtivnik;
  Sect:TCriticalSection;
  fLog:Text;
  StavkaNum:integer;
  LastWin:boolean;
  Stavki:array[0..2] of integer;
  TIMEOUT:integer = 40000;
  CapErr:byte;
  RichWekings: array of TRichWeking;
  timeToOdetSvit:integer;
  oldLogTime:cardinal;
implementation
uses Unit3;
{$R *.dfm}
{$R captcha.res}
procedure SetSvitki;forward;

///////// ��������(��� sleep, �� ��� ���������)
procedure Delay(mSec:Cardinal);
var
 TargetTime:Cardinal;
 Time:cardinal;
begin
  TargetTime:=GetTickCount+mSec;
  Time:=GetTickCount;
  while TargetTime>GetTickCount do
  begin
    Application.ProcessMessages;
    sleep(1);
    if ((GetTickCount-Time) div 1000)>0 then
    begin
      if timeToOdetSvit<>-1 then
      begin
        if timeToOdetSvit>TargetTime then
          timeToOdetSvit:=-1;
        if timeToOdetSvit<GetTickCount then
        begin
          timeToOdetSvit:=-1;
          SetSvitki;
        end;
      end;
      Time:=GetTickCount;
      if TargetTime>GetTickCount then
        Form1.sStatusBar1.Panels[0].Text:=IntToStr(round((TargetTime-GetTickCount)/1000));
    end;
    if Application.Terminated then Exit;
  end;
  Form1.sStatusBar1.Panels[0].Text:='';
end;



///// �������� ������� � ������������ �����, ������� � ������� ������ ///////////
procedure GetElement(var iElement:IHTMLElement;tag:string;Text:string;Cla:string);
var
  i: integer;
  iDoc: IHtmlDocument2;
  iDisp: IDispatch;
  Doc:IHTMLElementCollection;
  S: string;
begin
  iDoc := Form1.WebBrowser1.Document as IHtmlDocument2;
  Doc:=iDoc.all.tags(tag) as IHTMLElementCollection;
  for i := 1 to Doc.length do
  begin
    iDisp := Doc.item(pred(i), 0);
    iDisp.QueryInterface(IHTMLElement, iElement);
    S:='';
    if assigned(iElement) then
    begin
      if (iElement.className=Cla) or (Cla='') then
        if (iElement.innerText=Text) or (Text='') then
          exit;
    end;
  end;
  iElement:=nil;
end;
procedure GetElementFromId(var iElement:IHTMLElement;tag:string;Text:string;Cla:string;id:string);
var
  i: integer;
  iDoc: IHtmlDocument2;
  iDisp: IDispatch;
  Doc:IHTMLElementCollection;
  S: string;
begin
  iDoc := Form1.WebBrowser1.Document as IHtmlDocument2;
  Doc:=iDoc.all.tags(tag) as IHTMLElementCollection;
  for i := 1 to Doc.length do
  begin
    iDisp := Doc.item(pred(i), 0);
    iDisp.QueryInterface(IHTMLElement, iElement);
    S:='';
    if assigned(iElement) then
    begin
      if (iElement.className=Cla) or (Cla='') then
        if (iElement.innerText=Text) or (Text='') then
          if iElement.getAttribute('id',0)=id then
            exit;
    end;
  end;
  iElement:=nil;
end;

/// �������� �������� �� ������ �������� ��� ���������� ��������� ������ ����� ����� �������� �������� ////
procedure AfterLoad;
var
  iElement:IHTMLElement;
begin
  ///// �������� � �������? ///////////
    GetElement(iElement,'div','','captcha_images_row');
    if iElement<>nil then     //���� ������
      if Form1.sCheckBox8.Checked then      // ���� �������� �����������������
        while iElement<>nil do
        begin
          Application.ProcessMessages;
          if Application.Terminated then
            exit;
          DeCaptcha;
          GetElement(iElement,'div','','captcha_images_row');
          if iElement<>nil then
            Delay(5000);
        end
      else     // ��������� �����������������, �� ���� ������
      begin
        while iElement<>nil do   // ���� ����� ������
        begin
           Winapi.Windows.Beep(1000,500);
           Delay(5000);
           GetElement(iElement,'div','','captcha_images_row');
        end;
      end;
end;

////////����� ���� Event �� ����� true /////////////////
procedure WaitEvent(var Event:boolean);
var
  i:Cardinal;
begin
  i:=GetTickCount+TIMEOUT;
  while not Event do
  begin
    if i<GetTickCount then
    begin
      Event:=true;
      Form1.WebBrowser1.Stop;
    end;
    Application.ProcessMessages;
    sleep(1);
    if Application.Terminated then Exit;
  end;
  AfterLoad;
end;

//////////////////////////////////////////////
///////// ������������ �������� ���� ��� �� ������������ /////////
procedure SetAction(s:string; prior:integer);
var
  i:integer;
begin
  for i:=0 to Length(ActionList)-1 do
  begin
    if ActionList[i].Action=s then
      exit;
  end;
  SetLength(ActionList,Length(ActionList)+1);
  ActionList[Length(ActionList)-1].Action:=s;
  ActionList[Length(ActionList)-1].Prior:=Prior;
end;

//////////////////////////////////////////
//// �������������� �������� /////////////////
procedure UnsetAction(s:string);
var
  i:integer;
begin
  for i:=0 to Length(ActionList)-1 do
  begin
    if ActionList[i].Action=s then
    begin
      ActionList[i]:=ActionList[Length(ActionList)-1];
      SetLength(ActionList,Length(ActionList)-1);
      exit;
    end;
  end;

end;

///////////////////////////////////////////////////////////
////////// ���� � ����� /////////////
procedure GoToPohod;
var
  ovElements: OleVariant;
  i: integer;
begin
  Zagrujeno:=false;
  Form1.WebBrowser1.Navigate('http://'+SERVER+'/game/patrol');
  WaitEvent(Zagrujeno);
  /////// ���� � �����
  if Form1.WebBrowser1.OleObject.Document.forms.Length<>0 then
  begin
    ovElements := Form1.WebBrowser1.OleObject.Document.forms.item(0).elements;
    for i := 0 to ovElements.Length-1 do
      if (ovElements.item(i).type='submit') then
      begin
        Zagrujeno:=false;
        ovElements.item(i).click;
        WaitEvent(Zagrujeno);
      end;
  end
  else
    Player.PohodIsset:=false;
end;

// �������� �������� � ������, ���� �� ��������
procedure  AddRich(Money:integer);
var
  i:integer;
begin
  for i:=0 to Length(RichWekings)-1 do
    if RichWekings[i].id = Protivnik.id then
    begin
      RichWekings[i].Sera:=Money;
      RichWekings[Length(RichWekings)-1].time:= GetTickCount+1800000;
      exit;
    end;
  SetLength(RichWekings,Length(RichWekings)+1);
  RichWekings[Length(RichWekings)-1].id:= Protivnik.id;
  RichWekings[Length(RichWekings)-1].time:= GetTickCount+1800000;   // ��������� �����. 1800 ��?
  RichWekings[Length(RichWekings)-1].Sera:= Money;
end;

procedure DelRich;
var
  i:integer;
begin
  for i:=0 to Length(RichWekings)-1 do
    if RichWekings[i].id = Protivnik.id then
    begin
      RichWekings[i]:=RichWekings[Length(RichWekings)-1];
      SetLength(RichWekings,Length(RichWekings)-1);
      exit;
    end;
end;

function GetRich:string;
var
  i,j:integer;
  buf:TRichWeking;
begin
  Result:='';
  for i:=0 to Length(RichWekings)-2 do
    for j:=i+1 to Length(RichWekings)-1 do
      if RichWekings[j].Sera>RichWekings[i].Sera then
      begin
        buf:=RichWekings[i];
        RichWekings[i]:=RichWekings[j];
        RichWekings[j]:=buf;
      end;
  for i:=0 to Length(RichWekings)-1 do
    if RichWekings[i].time<=GetTickCount then
    begin
      Result:=RichWekings[i].id;
    end;
end;

procedure UpdateRich(time:integer);
var
  i:integer;
begin
  for i:=0 to Length(RichWekings)-1 do
    if RichWekings[i].id = Protivnik.id then
    begin
      RichWekings[i].time:=time;    
    end;
end;

/////////////////////////////////////////////////////////////////////
////////// ������� �������/������ ������� �� ��� /////////
procedure ParsNagrad;
  function Num(str:string):string;
  var
    i:integer;
  begin
    for i :=1 to Length(str) do
      if not (Byte(str[i]) in [48..57]) then
        break;
    Result:=Copy(str,1,i-1);
  end;
var
  i,Money,Kris,Gold,time: integer;
  iDoc: IHtmlDocument2;
  iDisp: IDispatch;
  iElement: IHTMLElement;
  Doc,Doc1:IHTMLElementCollection;
  S: string;
  Lose:boolean;
begin
  Money:=0;
  Kris:=0;
  Gold:=0;
  time:=0;
  iDoc := Form1.WebBrowser1.Document as IHtmlDocument2;
  Doc:=iDoc.all.tags('h4') as IHTMLElementCollection;
  Doc1:=iDoc.all.tags('div') as IHTMLElementCollection;
  Lose:=false;
  for i := 1 to Doc.length do
  begin
    iDisp := Doc.item(pred(i), 0);
    iDisp.QueryInterface(IHTMLElement, iElement);
    S:='';
    if assigned(iElement) then
    begin
      if iElement.className='fight_lose' then
        Lose:=true;
    end;
  end;
  for i := 1 to Doc1.length do
  begin
    iDisp := Doc1.item(pred(i), 0);
    iDisp.QueryInterface(IHTMLElement, iElement);
    S:='';
    if assigned(iElement) then
    begin
      if iElement.className='props' then
      begin
        S:=iElement.innerText;
        if Pos('�������',S)<>0 then
        begin
          S:=Copy(S,Pos('�������',S)+10,Length(S));
          Money:=StrToInt(Num(S));
        end;
        S:=iElement.innerText;
        if Pos('���������',S)<>0 then
        begin
          S:=Copy(S,Pos('���������',S)+12,Length(S));
          Kris:=StrToInt(Num(S));
        end;
        S:=iElement.innerText;
        if Pos('������ :',S)<>0 then
        begin
          S:=Copy(S,Pos('������',S)+9,Length(S));
          Gold:=StrToInt(Num(S));
        end;
      end;

    end;
  end;
  if Lose then
  begin
    Player.Lost:=Player.Lost+Money;
    Player.LostKris:=Player.LostKris+Kris;
    DelRich;
  end
  else
  begin
    Player.Nagrab:=Player.Nagrab+Money;
    Player.NagrabKris:=Player.NagrabKris+Kris;
    Player.NagrabGolds:=Player.NagrabGolds+Gold;
    if (Money>StrToInt(Form1.sEdit18.Text)) and Form1.sCheckBox26.Checked then
        AddRich(Money)
    else
      if Form1.sCheckBox26.Checked then
      begin
        GetElement(iElement,'div','','notifications_block');
        if iElement<>nil then
        begin
          S:=iElement.innerText;
          i:=Pos('��� �����',S);
          if (Pos('������',S)=0) and (i=0) then
            DelRich;
          if (Pos('6 ���',S)<>0) then
            DelRich;
          if (Pos('������',S)<>0) then
            UpdateRich(GetTickCount+300000);
          if i<>0 then
          begin
            i:=i+10;
            s:=Copy(S,i,Length(S));
            time:=time+(StrToInt(Copy(S,1,Pos(':',S)-1)))*3600000;
            S:=Copy(S,Pos(':',S)+1,Length(S));
            time:=time+(StrToInt(Copy(S,1,Pos(':',S)-1)))*60000;
            S:=Copy(S,Pos(':',S)+1,Length(S));
            time:=time+(StrToInt(Copy(S,1,Pos(' ',S)-1)))*1000;
            UpdateRich(GetTickCount+time);
          end;
        end;
      end;
  end;
  if PanelType=0 then
  begin
    Form1.sStatusBar1.Panels[2].Text:='���������: '+IntToStr(Player.Lost);
    Form1.sStatusBar1.Panels[1].Text:='��������: '+IntToStr(Player.Nagrab);
  end;
  if PanelType=1 then
  begin
    Form1.sStatusBar1.Panels[2].Text:='���������: '+IntToStr(Player.LostKris);
    Form1.sStatusBar1.Panels[1].Text:='��������: '+IntToStr(Player.NagrabKris);
  end;
  if PanelType=2 then
  begin
    Form1.sStatusBar1.Panels[1].Text:='��������: '+IntToStr(Player.NagrabGolds);
  end;

end;

/////////////////////////////////////////////////////////////////////////////
/////// ������� ���������� ���������� ////////////////////////
procedure ParsProtivnikStats;
var
  i,tdc: integer;
  iDoc: IHtmlDocument2;
  iDisp: IDispatch;
  iElement: IHTMLElement;
  Doc:IHTMLElementCollection;
  S: string;
  Stats:array[0..4] of integer;
begin
  GetElement(iElement,'a','���������','button_medium');
  if iElement=nil then
    exit;
  s:=iElement.getAttribute('href',0);
  s:=Copy(s,Pos('opponent_id',s)+12,Length(s));
  s:=Copy(s,1,Pos('&',s)-1);
  Protivnik.id:= s;
  tdc:=0;
  Protivnik.IsMyClan:=false;
  iDoc := Form1.WebBrowser1.Document as IHtmlDocument2;
  Doc:=iDoc.all.tags('td') as IHTMLElementCollection;
  for i := 1 to Doc.length do
  begin
    iDisp := Doc.item(pred(i), 0);
    iDisp.QueryInterface(IHTMLElement, iElement);
    S:='';
    if assigned(iElement) then
    begin
      if iElement.className='tdc' then
      begin
        inc(tdc);
        if tdc>2 then
          if (tdc mod 2)=0 then
          begin
          S:=iElement.innerText;
            Stats[(tdc div 2)-2]:=StrToInt(S);
          end;
      end;
    end;
  end;
  Doc:=iDoc.all.tags('span') as IHTMLElementCollection;
  for i := 1 to Doc.length do
  begin
    iDisp := Doc.item(pred(i), 0);
    iDisp.QueryInterface(IHTMLElement, iElement);
    S:='';
    if assigned(iElement) then
    begin
      if iElement.className='green' then
      begin
        S:=iElement.innerText;
        if (S='(����)') or (S='(����)') then
          Protivnik.IsMyClan:=true;
      end;
    end;
  end;
  Protivnik.Param.Sila:=Stats[0];
  Protivnik.Param.Zashita:=Stats[1];
  Protivnik.Param.Lovkost:=Stats[2];
  Protivnik.Param.Masterstvo:=Stats[3];
  Protivnik.Param.Zhivuchest:=Stats[4];
end;

/////////////////////////////////////
//// �������� �������� //////////////
function IssetGifts:boolean;
var
  iElement:IHTMLElement;
  s,s1:string;
  iDoc:IHTMLDocument2;
  iDisp: IDispatch;
  Doc:IHTMLElementCollection;
  i:integer;
begin
  Result:=false;
  GetElement(iElement,'a','���������','button_medium');
  if iElement=nil then
    exit;
  s:=iElement.getAttribute('href',0);
  s:=Copy(s,Pos('opponent_id',s)+12,Length(s));
  s:=Copy(s,1,Pos('&',s)-1);
  Zagrujeno:=false;
  Form1.WebBrowser1.Navigate('http://'+SERVER+'/game/relation/presents/'+s+'?show=gift');
  WaitEvent(Zagrujeno);
  iDoc := Form1.WebBrowser1.Document as IHtmlDocument2;
  Doc:=iDoc.all.tags('span') as IHTMLElementCollection;
  for i := 1 to Doc.length do
  begin
    iDisp := Doc.item(pred(i), 0);
    iDisp.QueryInterface(IHTMLElement, iElement);
    s1:='';
    if assigned(iElement) then
    begin
      if iElement.className='' then
      begin
        s1:=iElement.innerText;
        if Form1.sCheckBox16.Checked then
          if s1=Form1.sCheckBox16.Caption then
            Result:=true;
        if Form1.sCheckBox17.Checked then
          if s1=Form1.sCheckBox17.Caption then
            Result:=true;
        if Form1.sCheckBox18.Checked then
          if s1=Form1.sCheckBox18.Caption then
            Result:=true;
        if Form1.sCheckBox19.Checked then
          if s1=Form1.sCheckBox19.Caption then
            Result:=true;
        if Form1.sCheckBox20.Checked then
          if s1=Form1.sCheckBox20.Caption then
            Result:=true;
        if Form1.sCheckBox21.Checked then
          if s1=Form1.sCheckBox21.Caption then
            Result:=true;
      end;
    end;
  end;
  Zagrujeno:=false;
  Form1.WebBrowser1.Navigate('http://'+SERVER+'/game/battle/player/new?opponent_id='+s);
  WaitEvent(Zagrujeno);
end;

///////////////////////////////////////////////
///// �������� ���������� /////////////////////
function OverStats:boolean;  // ���� true, �� �� ����
begin
  ParsProtivnikStats;
  Result:=false;
  if Form1.sRadioGroup1.ItemIndex=1 then
    begin
      if Player.Param.Sila<Protivnik.Param.Sila then
         Result:=true;
    end;
    if Form1.sCheckBox12.Checked then
    begin
      if (Protivnik.Param.Sila>Protivnik_MAX.Param.Sila) or (Protivnik.Param.Sila<Protivnik_MIN.Param.Sila) then
        Result:=true;
      if (Protivnik.Param.Zashita>Protivnik_MAX.Param.Zashita) or (Protivnik.Param.Zashita<Protivnik_MIN.Param.Zashita) then
        Result:=true;
      if (Protivnik.Param.Lovkost>Protivnik_MAX.Param.Lovkost) or (Protivnik.Param.Lovkost<Protivnik_MIN.Param.Lovkost) then
        Result:=true;
      if (Protivnik.Param.Masterstvo>Protivnik_MAX.Param.Masterstvo) or (Protivnik.Param.Masterstvo<Protivnik_MIN.Param.Masterstvo) then
        Result:=true;
      if (Protivnik.Param.Zhivuchest>Protivnik_MAX.Param.Zhivuchest) or (Protivnik.Param.Zhivuchest<Protivnik_MIN.Param.Zhivuchest) then
        Result:=true;
    end;
    if Form1.sCheckBox13.Checked and Protivnik.IsMyClan then
      Result:=true;
end;
//-------------------------------------------------------------------------------
//����� ������
//-------------------------------------------------------------------------------------
procedure SetSvitki;
var
  iElement:IHTMLElement;
  str:string;
  i,time:integer;
begin
  if Player.SvitkiTime>GetTickCount then
    exit;
 { Zagrujeno:=false;
  Form1.WebBrowser1.Navigate('http://'+SERVER+'/game/shop/category?category=scroll');
  WaitEvent(Zagrujeno);  }
  if Form1.sRadioGroup3.ItemIndex=0 then //����
  begin
    {GetElementFromId(iElement,'a','','button_medium','buy_item_vali_scroll');
    if iElement=nil then
      exit;
    Zagrujeno:=false;
    iElement.click;
    WaitEvent(Zagrujeno);
    GetElement(iElement,'a','������','button_medium');
    if iElement=nil then
      exit;
    Zagrujeno:=false;
    iElement.click;
    WaitEvent(Zagrujeno);}
    Zagrujeno:=false;
    Form1.WebBrowser1.Navigate('http://'+SERVER+'/game/inventories/use?id=vali_scroll');
    WaitEvent(Zagrujeno);
    GetElement(iElement,'tr','','notice');
    if iElement<>nil then
    begin
      str:=iElement.innerText;
      if Pos('������',str)<>0 then
      begin
        Player.SvitkiTime:=GetTickCount+30*60000;
        Player.SvitokOdet:=true;
      end;
    end;
  end;
  if Form1.sRadioGroup3.ItemIndex=1 then   // ����
  begin
   { GetElementFromId(iElement,'a','','button_medium','buy_item_modi_scroll');
    if iElement=nil then
      exit;
    Zagrujeno:=false;
    iElement.click;
    WaitEvent(Zagrujeno);
    GetElement(iElement,'a','������','button_medium');
    if iElement=nil then
      exit;
    Zagrujeno:=false;
    iElement.click;
    WaitEvent(Zagrujeno); }
    Zagrujeno:=false;
    Form1.WebBrowser1.Navigate('http://'+SERVER+'/game/inventories/use?id=modi_scroll');
    WaitEvent(Zagrujeno);
  end;
  if Form1.sRadioGroup3.ItemIndex=2 then // ����
  begin
   { GetElementFromId(iElement,'a','','button_medium','buy_item_loki_scroll');
    if iElement=nil then
      exit;
    Zagrujeno:=false;
    iElement.click;
    WaitEvent(Zagrujeno);
    GetElement(iElement,'a','������','button_medium');
    if iElement=nil then
      exit;
    Zagrujeno:=false;
    iElement.click;
    WaitEvent(Zagrujeno);  }
    Zagrujeno:=false;
    Form1.WebBrowser1.Navigate('http://'+SERVER+'/game/inventories/use?id=loki_scroll');
    WaitEvent(Zagrujeno);
    GetElement(iElement,'tr','','notice');
    if iElement<>nil then
    begin
      str:=iElement.innerText;
      if Pos('������',str)<>0 then
      begin
        Player.SvitkiTime:=GetTickCount+30*60000;
        Player.SvitokOdet:=true;
      end;
    end;
  end;
  if Form1.sRadioGroup3.ItemIndex=3 then // �����
  begin
    {GetElementFromId(iElement,'a','','button_medium','buy_item_odin_scroll');
    if iElement=nil then
      exit;
    Zagrujeno:=false;
    iElement.click;
    WaitEvent(Zagrujeno);
    GetElement(iElement,'a','������','button_medium');
    if iElement=nil then
      exit;
    Zagrujeno:=false;
    iElement.click;
    WaitEvent(Zagrujeno);  }
    Zagrujeno:=false;
    Form1.WebBrowser1.Navigate('http://'+SERVER+'/game/inventories/use?id=odin_scroll');
    WaitEvent(Zagrujeno);
    GetElement(iElement,'tr','','notice');
    if iElement<>nil then
    begin
      str:=iElement.innerText;
      if Pos('������',str)<>0 then
      begin
        Player.SvitkiTime:=GetTickCount+30*60000;
        Player.SvitokOdet:=true;
      end;
    end;
  end;
  if Form1.sRadioGroup3.ItemIndex=4 then // ���
  begin
   { GetElementFromId(iElement,'a','','button_medium','buy_item_heda_scroll');
    if iElement=nil then
      exit;
    Zagrujeno:=false;
    iElement.click;
    WaitEvent(Zagrujeno);
    GetElement(iElement,'a','������','button_medium');
    if iElement=nil then
      exit;
    Zagrujeno:=false;
    iElement.click;
    WaitEvent(Zagrujeno);  }
    Zagrujeno:=false;
    Form1.WebBrowser1.Navigate('http://'+SERVER+'/game/inventories/use?id=heda_scroll');
    WaitEvent(Zagrujeno);
    GetElement(iElement,'tr','','notice');
    if iElement<>nil then
    begin
      str:=iElement.innerText;
      if Pos('������',str)<>0 then
      begin
        Player.SvitkiTime:=GetTickCount+30*60000;
        Player.SvitokOdet:=true;
      end;
    end;
  end;
  if Form1.sRadioGroup3.ItemIndex=5 then // ���
  begin
   { GetElementFromId(iElement,'a','','button_medium','buy_item_bora_scroll');
    if iElement=nil then
      exit;
    Zagrujeno:=false;
    iElement.click;
    WaitEvent(Zagrujeno);
    GetElement(iElement,'a','������','button_medium');
    if iElement=nil then
      exit;
    Zagrujeno:=false;
    iElement.click;
    WaitEvent(Zagrujeno);  }
    Zagrujeno:=false;
    Form1.WebBrowser1.Navigate('http://'+SERVER+'/game/inventories/use?id=bora_scroll');
    WaitEvent(Zagrujeno);
    GetElement(iElement,'tr','','notice');
    if iElement<>nil then
    begin
      str:=iElement.innerText;
      if Pos('������',str)<>0 then
      begin
        Player.SvitkiTime:=GetTickCount+30*60000;
        Player.SvitokOdet:=true;
      end;
    end;
  end;
  GetElement(iElement,'div','','notifications_block');
  str:=iElement.innerText;
  i:=Pos('������������ �����',str);
  timeToOdetSvit:=-1;
  if Form1.sCheckBox15.Checked then
    if i<>0 then
    begin
      time:=0;
      i:=i+19;
      str:=Copy(str,i,Length(str));
      time:=time+(StrToInt(Copy(str,1,Pos(':',str)-1)))*3600000;
      str:=Copy(str,Pos(':',str)+1,Length(str));
      time:=time+(StrToInt(Copy(str,1,Pos(':',str)-1)))*60000;
      str:=Copy(str,Pos(':',str)+1,Length(str));
      time:=time+(StrToInt(Copy(str,1,Pos(' ',str)-1)))*1000;
      timeToOdetSvit:=GetTickCount+time;
    end;
end;

//-------------------------------------------------------------------------------
//����� ������
//-------------------------------------------------------------------------------------
procedure UnSetSvitki;
begin
  if not Player.SvitokOdet then
    exit;
  if Form1.sRadioGroup3.ItemIndex=0 then //����
  begin
    Zagrujeno:=false;
    Form1.WebBrowser1.Navigate('http://'+SERVER+'/game/inventories/disuse?id=vali_scroll');
    WaitEvent(Zagrujeno);
    Player.SvitkiTime:=GetTickCount;
  end;
  if Form1.sRadioGroup3.ItemIndex=1 then   // ����
  begin
    Zagrujeno:=false;
    Form1.WebBrowser1.Navigate('http://'+SERVER+'/game/inventories/disuse?id=modi_scroll');
    WaitEvent(Zagrujeno);
    Player.SvitkiTime:=GetTickCount;
  end;
  if Form1.sRadioGroup3.ItemIndex=2 then // ����
  begin
    Zagrujeno:=false;
    Form1.WebBrowser1.Navigate('http://'+SERVER+'/game/inventories/disuse?id=loki_scroll');
    WaitEvent(Zagrujeno);
    Player.SvitkiTime:=GetTickCount;
  end;
  if Form1.sRadioGroup3.ItemIndex=3 then // �����
  begin
    Zagrujeno:=false;
    Form1.WebBrowser1.Navigate('http://'+SERVER+'/game/inventories/disuse?id=odin_scroll');
    WaitEvent(Zagrujeno);
    Player.SvitkiTime:=GetTickCount;
  end;
  if Form1.sRadioGroup3.ItemIndex=4 then // ���
  begin
    Zagrujeno:=false;
    Form1.WebBrowser1.Navigate('http://'+SERVER+'/game/inventories/disuse?id=heda_scroll');
    WaitEvent(Zagrujeno);
    Player.SvitkiTime:=GetTickCount;
  end;
  if Form1.sRadioGroup3.ItemIndex=5 then // ���
  begin
    Zagrujeno:=false;
    Form1.WebBrowser1.Navigate('http://'+SERVER+'/game/inventories/disuse?id=bora_scroll');
    WaitEvent(Zagrujeno);
    Player.SvitkiTime:=GetTickCount;
  end;
  Player.SvitokOdet:=false;
end;

/////////////////////////////////////////////////////////////////////////////
//�������� ����� �� �����///////////////////////////////////////////
function IsFriend:boolean;
var
  i:integer;
  ImageHref,url:string;
begin
  Result:=false;
  url:='friend';
  for i:=0 to Form1.WebBrowser1.OleObject.Document.Images.Length - 1 do
     begin
       ImageHref := Form1.WebBrowser1.OleObject.Document.Images.Item(i).href;
       if Pos(url,ImageHref)<>0 then
        Result:=true;
     end;
end;
/////////////////////////////////////////////////////////////////////////////
/////////// ����� ���������� � ��������� ///////////////////
procedure DoFight;
var
  Level:integer;
  iElement:IHTMLElement;
  Vlad:boolean;
  id:string;
begin
  if Form1.sCheckbox23.Checked then
    SetSvitki;
  if Form1.sCheckBox9.Checked then
    if ((Player.Pet.Health>=StrToInt(Form1.sEdit6.Text)) or (not Form1.sCheckBox10.Checked)) and (Player.Pet.Status=1) then
      Player.Pet.GoToCell(false);
  Vlad:=false;
  /// �������
  if Events.Vlad and Form1.sCheckBox22.Checked then
  begin
    Zagrujeno:=false;
    Form1.WebBrowser1.Navigate('http://'+SERVER+'/game/battle/lords/new_bot?kind=master_silver');
    WaitEvent(Zagrujeno);
    Vlad:=true;
  end
  else
  begin
    if Form1.sRadioButton4.Checked then
    begin
    /////��������/////
      Zagrujeno:=false;
      if Form1.sComboBox1.ItemIndex=0 then
        Form1.WebBrowser1.Navigate('http://'+SERVER+'/game/battle/mercenary/new');
      if Form1.sComboBox1.ItemIndex=1 then
        Form1.WebBrowser1.Navigate('http://'+SERVER+'/game/battle/mercenary/new?type=crystal');
      if Form1.sComboBox1.ItemIndex=2 then
        Form1.WebBrowser1.Navigate('http://'+SERVER+'/game/battle/mercenary/new?type=gold');
      WaitEvent(Zagrujeno);
      if OverStats then
        exit;
    end;
    if Form1.sRadioButton2.Checked then
    begin
    ///////�����///////
      id:=GetRich;
      if Form1.sCheckBox26.Checked and (id<>'') then
      begin
        Zagrujeno:=false;
        Form1.WebBrowser1.Navigate('http://'+SERVER+'/game/battle/player/new?opponent_id='+id);
        WaitEvent(Zagrujeno);
      end
      else
      begin
        Zagrujeno:=false;
        Form1.WebBrowser1.Navigate('http://'+SERVER+'/game/battle/player/find?level='+IntToStr(Player.Level));
        WaitEvent(Zagrujeno);
      end;
      if OverStats then
      begin
        DelRich;
        exit;
      end;
      if Form1.sCheckBox14.Checked and IssetGifts then
      begin
        DelRich;
        exit;
      end;
    end;
    if Form1.sRadioButton1.Checked then
    begin
    ///////������///////
      id:=GetRich;
      if Form1.sCheckBox26.Checked and (id<>'') then
      begin
        Zagrujeno:=false;
        Form1.WebBrowser1.Navigate('http://'+SERVER+'/game/battle/player/new?opponent_id='+id);
        WaitEvent(Zagrujeno);
      end
      else
      begin
        Zagrujeno:=false;
        Form1.WebBrowser1.Navigate('http://'+SERVER+'/game/battle/player/find?level='+IntToStr(Player.Level-1));
        WaitEvent(Zagrujeno);
      end;
      if OverStats then
      begin
        DelRich;
        exit;
      end;
      if Form1.sCheckBox14.Checked and IssetGifts then
      begin
        DelRich;
        exit;
      end;
    end;
    if Form1.sRadioButton3.Checked then
    begin
    ///////������///////
      id:=GetRich;
      if Form1.sCheckBox26.Checked and (id<>'') then
      begin
        Zagrujeno:=false;
        Form1.WebBrowser1.Navigate('http://'+SERVER+'/game/battle/player/new?opponent_id='+id);
        WaitEvent(Zagrujeno);
      end
      else
      begin
        Zagrujeno:=false;
        Form1.WebBrowser1.Navigate('http://'+SERVER+'/game/battle/player/find?level='+IntToStr(Player.Level+1));
        WaitEvent(Zagrujeno);
        if OverStats then
        begin
          DelRich;
          exit;
        end;
        if Form1.sCheckBox14.Checked and IssetGifts then
        begin
          DelRich;
          exit;
        end;
      end;
    end;
    if Form1.sRadioButton5.Checked then
    begin
      ///�� ������///
      try
        Level:=StrToInt(Form1.sEdit1.Text);
      except
      Level:=1;
      end;
      id:=GetRich;
      if Form1.sCheckBox26.Checked and (id<>'') then
      begin
        Zagrujeno:=false;
        Form1.WebBrowser1.Navigate('http://'+SERVER+'/game/battle/player/new?opponent_id='+id);
        WaitEvent(Zagrujeno);
      end
      else
      begin
        Zagrujeno:=false;
        Form1.WebBrowser1.Navigate('http://'+SERVER+'/game/battle/player/find?level='+IntToStr(Level));
        WaitEvent(Zagrujeno);
      end;
      if OverStats then
      begin
        DelRich;
        exit;
      end;
      if Form1.sCheckBox14.Checked and IssetGifts then
      begin
        DelRich;
        exit;
      end;
    end;
  end;
  if Form1.sCheckBox25.Checked and IsFriend then
    exit;
  GetElement(iElement,'a','���������','');
  if iElement=nil then
  begin
    if Vlad then
      Events.Vlad:=false;
    exit;
  end;
  Zagrujeno:=false;
  iElement.click;
  WaitEvent(Zagrujeno);
  if not Vlad then
    ParsNagrad;
  if (Player.Fights=0) and (Player.Pet.Status=2) and Form1.sCheckBox11.Checked then
    SetAction('pet_in',0);
end;

/////////////////////////////////////////////////////////////////////
/////////////// ����������� �����/�������������  /////////
procedure DoTrain;
var
  Param:string;
  i: integer;
  iDoc: IHtmlDocument2;
  iDisp: IDispatch;
  iElement: IHTMLElement;
  Doc:IHTMLElementCollection;
  S: string;
begin
  if Form1.sCheckBox7.Checked  then
  begin
    if Form1.sRadioButton6.Checked then //����������� �����
    begin
      Zagrujeno:=false;
      Form1.WebBrowser1.Navigate('http://'+SERVER+'/game/buildup/user');
      WaitEvent(Zagrujeno);
    end
    else
    begin              //�����
      Zagrujeno:=false;
      Form1.WebBrowser1.Navigate('http://'+SERVER+'/game/buildup/pet');
      WaitEvent(Zagrujeno);
    end;
  end;
  if Form1.sRadioGroup2.ItemIndex=0 then
    Param:='train_power';
  if Form1.sRadioGroup2.ItemIndex=1 then
    Param:='train_protection';
  if Form1.sRadioGroup2.ItemIndex=2 then
    Param:='train_dexterity';
  if Form1.sRadioGroup2.ItemIndex=3 then
    Param:='train_skill';
  if Form1.sRadioGroup2.ItemIndex=4 then
    Param:='train_weight';
  iDoc := Form1.WebBrowser1.Document as IHtmlDocument2;
  Doc:=iDoc.all.tags('a') as IHTMLElementCollection;
  for i := 1 to Doc.length do
  begin
    iDisp := Doc.item(pred(i), 0);
    iDisp.QueryInterface(IHTMLElement, iElement);
    S:='';
    if assigned(iElement) then
    begin
      if iElement.id=Param then
      begin
        Zagrujeno:=false;
        iElement.click;
        WaitEvent(Zagrujeno);
        exit;
      end;
    end;
  end;

end;

///////////////////////////////////////////////////
//// ����� ////////////////////////////////////
procedure DoShahta;
var
  iElement:IHTMLElement;
  Glub,Dob,DobMax,s:string;
begin
  Zagrujeno:=false;
  Form1.WebBrowser1.Navigate('http://'+SERVER+'/game/mine');
  WaitEvent(Zagrujeno);
  GetElement(iElement,'ul','','block');
  if iElement<>nil then
  begin
    Glub:=iElement.innerText;
    DobMax:=iElement.innerText;
    Glub:=Copy(Glub,Pos('�������:',Glub)+9,Length(Glub));
    DobMax:=Copy(DobMax,Pos('������:',DobMax)+8,Length(DobMax));
    Glub:=Copy(Glub,1,Pos('/',Glub)-1);
    DobMax:=Copy(DobMax,Pos('/',DobMax)+1,Length(DobMax));
    DobMax:=Copy(DobMax,1,Pos(' ',DobMax)-1);
  end
  else
  begin
    GetElement(iElement,'a','����������','');
    if iElement=nil then
    begin
      Player.ShahtaIsset:=false;
      exit;
    end;
    Glub:='0';
    DobMax:='10';
  end;
  s:=Form1.sDecimalSpinEdit1.Text;
  if StrToInt(s)>StrToInt(Glub) then   //!!!!!! ��������� ���� ����� �����, �� ������!!!!!!!!!!!!!!!!
  begin
    GetElement(iElement,'a','����������','');
    if iElement<>nil then
    begin
      Zagrujeno:=false;
      iElement.click;
      WaitEvent(Zagrujeno);
    end
    else
    begin
      Player.ShahtaIsset:=false;
      exit;
    end;
  end
  else
  begin
    //������ � ��������� �������� �� ������������ �����������
    repeat
      GetElement(iElement,'a','������','');
      if iElement<>nil then
      begin
        Zagrujeno:=false;
        iElement.click;
        Delay(4000);
        WaitEvent(Zagrujeno);
        GetElement(iElement,'ul','','block');
        if iElement=nil then
          exit;
        Dob:=iElement.innerText;
        Dob:=Copy(Dob,Pos('������:',Dob)+8,Length(Dob));
        Dob:=Copy(Dob,1,Pos('/',Dob)-1);
      end;
    until StrToInt(Dob)>=StrToInt(DobMax);
    GetElement(iElement,'a','�����','');
    if iElement<>nil then
    begin
      Zagrujeno:=false;
      iElement.click;
      WaitEvent(Zagrujeno);
      Player.ShahtaIsset:=false;
    end;
  end;
end;

//-------------------------------------------------------------------------------------------------------------------------------
//���-���-������
//-------------------------------------------------------------------------------------------------------------------------------
procedure MechShitSvitok;

var
  iElement:IHTMLElement;
  s:string;
  iDoc: IHtmlDocument2;
  iDisp: IDispatch;
  Doc:IHTMLElementCollection;
  i:integer;
  FightsCount:integer;
  PerCent:integer;
  MaxPercent:real;
  Res:integer;

    procedure DeleteCard(var Player:TCards; i:integer);
    begin
      Player[i].Isset:=false;
    end;

    procedure Fight(var Player,Protivnik:TCards;i,j:integer;var Pobeda:boolean);
    var
      PlayerCard,ProtivnikCard:TCard;
      PlayerBon:integer;
    begin
      PlayerCard:=Player[i];
      ProtivnikCard:=Protivnik[j];
      PlayerBon:=0;
      if (PlayerCard.Vid=0) and (ProtivnikCard.Vid=1) then
        PlayerBon:=2;
      if (PlayerCard.Vid=1) and (ProtivnikCard.Vid=0) then
        PlayerBon:=-2;
      if (PlayerCard.Vid=2) and (ProtivnikCard.Vid=0) then
        PlayerBon:=2;
      if (PlayerCard.Vid=0) and (ProtivnikCard.Vid=2) then
        PlayerBon:=-2;
       if (PlayerCard.Vid=1) and (ProtivnikCard.Vid=2) then
        PlayerBon:=2;
       if (PlayerCard.Vid=2) and (ProtivnikCard.Vid=1) then
        PlayerBon:=-2;
      PlayerCard.Value:=PlayerCard.Value+PlayerBon;
      if PlayerCard.Value>=ProtivnikCard.Value then
      begin
        if (PlayerCard.Vid=ProtivnikCard.Vid) and (PlayerCard.Value=ProtivnikCard.Value) then
        begin
          if PlayerCard.Vid=2 then
            Pobeda:=true
          else
            Pobeda:=false;
        end
        else
        begin
          if PlayerCard.Value=ProtivnikCard.Value then
            Pobeda:=false
          else
            Pobeda:=true;
        end
      end
      else
      begin
        Pobeda:=false;
      end;
      if Pobeda then
      begin
        DeleteCard(Protivnik,j);
        Player[i].Value:=Player[i].Value-1;
      end
      else
      begin
        DeleteCard(Player,i);
        Protivnik[j].Value:=Protivnik[j].Value-1;
      end;
    end;
    function Empty(Player:TCards):boolean;
    var
      i:integer;
    begin
      Result:=true;
      for i:=0 to 2 do
        if Player[i].Isset then
          Result:=false;
    end;
    procedure Pobeditel(Player,Protivnik:TCards;S:string;var pobedil:boolean;Ind:integer;var Last,PobedaOnly:boolean);
    var
      i,j,PobedsCount:integer;
      Str:string;
      PlayerBuf,ProtivnikBuf:TCards;
      Pobeda:boolean;
    begin
      if Empty(Player) then
      begin
       // Form1.Memo1.Lines.Add(S+ ' - ��������');
        Last:=true;
        exit;
      end;
       if Empty(Protivnik) then
      begin
        Pobedil:=true;
        PobedaOnly:=true;
        Last:=true;
        exit;
      end;
      for i:=0 to Length(Player)-1 do
      begin
        if Ind=0 then
        begin
          PerCent:=0;
          FightsCount:=0;
        end;
        PobedsCount:=0;
        for j:=0 to Length(Protivnik)-1 do
        begin
          if Player[i].Isset and Protivnik[j].Isset then
          begin
            PlayerBuf:=Player;
            ProtivnikBuf:=Protivnik;
            Fight(PlayerBuf,ProtivnikBuf,i,j,Pobeda);
            Pobeditel(PlayerBuf,ProtivnikBuf,Str,Pobedil,Ind+1,Last,PobedaOnly);
            Dec(PobedsCount);
            if Pobeda then
              inc(PobedsCount);
            if Pobedil then
            begin
               inc(PerCent);
               pobedil:=false;
            end;
            if Last then
            begin
               inc(FightsCount);
               Last:=false;
            end;
          end;
        end;
        if (PobedsCount=0) and PobedaOnly then
          PobedaOnly:=true
        else
          PobedaOnly:=false;
        if Ind=0 then
          if FightsCount<>0 then
            if Player[i].Isset then
              if MaxPercent<(PerCent/FightsCount) then
              begin
                MaxPercent:=PerCent/FightsCount;
                Res:=i;
              end;
      end;
    end;
var
  PlayerCards,ProtivnikCards:TCards;
  pobedil,Last,PobedaOnly:boolean;
  opponent:array[0..4] of string;
begin
  opponent[0]:='strannik';
  opponent[1]:='pirupka';
  opponent[2]:='orlan_borod';
  opponent[3]:='iking_trus';
  Randomize;
  while true do
    begin
    Zagrujeno:=false;
    Form1.WebBrowser1.Navigate('http://'+SERVER+'/game/card_tables?type=rps');
    WaitEvent(Zagrujeno);
    GetElement(iElement,'div','','desc');
    if iElement=nil then
      exit;
    s:=iElement.innerText;
    if Pos('���: 0',s)<>0 then
    begin
      Player.MechShitSvitokIsset:=false;
      exit;
    end;
    Zagrujeno:=false;
    if Player.Kris<2 then
    begin
      UnsetAction('MechShitSvitok');
      exit;
    end;
    i:=2;
    Form1.WebBrowser1.Navigate('http://'+SERVER+'/game/card_tables/init?bet='+IntToStr(Stavki[StavkaNum])+'&opponent='+opponent[i]+'&type=rps');
    WaitEvent(Zagrujeno);
    while true do
    begin
      Delay(1000);
      Application.ProcessMessages;
      if Application.Terminated then
        exit;
      iDoc := Form1.WebBrowser1.Document as IHtmlDocument2;
      Doc:=iDoc.all.tags('span') as IHTMLElementCollection;
      FightsCount:=0;
      PerCent:=0;
      Res:=0;
      PobedaOnly:=false;
      MaxPercent:=-1;
      Pobedil:=false;
      PlayerCards[0].Vid:=0;
      PlayerCards[1].Vid:=1;
      PlayerCards[2].Vid:=2;
      PlayerCards[0].Isset:=false;
      PlayerCards[1].Isset:=false;
      PlayerCards[2].Isset:=false;
      ProtivnikCards[0].Vid:=0;
      ProtivnikCards[1].Vid:=1;
      ProtivnikCards[2].Vid:=2;
      ProtivnikCards[0].Isset:=false;
      ProtivnikCards[1].Isset:=false;
      ProtivnikCards[2].Isset:=false;
      for i := 1 to Doc.length do
      begin
        iDisp := Doc.item(pred(i), 0);
        iDisp.QueryInterface(IHTMLElement, iElement);
        s:='';
        if assigned(iElement) then
        begin
          if (iElement.className='card shield') then
          begin
            s:=iElement.innerText;
            ProtivnikCards[1].Isset:=true;
            ProtivnikCards[1].Value:=StrToInt(s);
          end;
          if (iElement.className='card sword') then
          begin
            s:=iElement.innerText;
            ProtivnikCards[2].Isset:=true;
            ProtivnikCards[2].Value:=StrToInt(s);
          end;
          if (iElement.className='card scroll') then
          begin
            s:=iElement.innerText;
            ProtivnikCards[0].Isset:=true;
            ProtivnikCards[0].Value:=StrToInt(s);
          end;
        end;
      end;
      Doc:=iDoc.all.tags('a') as IHTMLElementCollection;
      for i := 1 to Doc.length do
      begin
        iDisp := Doc.item(pred(i), 0);
        iDisp.QueryInterface(IHTMLElement, iElement);
        s:='';
        if assigned(iElement) then
        begin
          if (iElement.className='card shield') then
          begin
            s:=iElement.innerText;
            PlayerCards[1].Isset:=true;
            PlayerCards[1].Value:=StrToInt(s);
            PlayerCards[1].iElement:=iElement;
          end;
          if (iElement.className='card sword') then
          begin
            s:=iElement.innerText;
            PlayerCards[2].Isset:=true;
            PlayerCards[2].Value:=StrToInt(s);
            PlayerCards[2].iElement:=iElement;
          end;
          if (iElement.className='card scroll') then
          begin
            s:=iElement.innerText;
            PlayerCards[0].Isset:=true;
            PlayerCards[0].Value:=StrToInt(s);
            PlayerCards[0].iElement:=iElement;
          end;
        end;
      end;
      if Empty(PlayerCards) or Empty(ProtivnikCards) then
      begin
        GetElement(iElement,'div','','description');
        if iElement<>nil then
        begin
          s:=iElement.innerText;
          if Pos('������',s)=0 then // ��������
          begin
            inc(StavkaNum);
            if StavkaNum>=Length(Stavki) then
              StavkaNum:=Length(Stavki)-1;
            if (Stavki[StavkaNum]>Player.Kris) and (StavkaNum>0) then
            begin
              Dec(StavkaNum);
              if (Stavki[StavkaNum]>Player.Kris) and (StavkaNum>0) then
              begin
                Dec(StavkaNum);
                if Stavki[StavkaNum]>Player.Kris then
                  exit;
              end;
            end;
          end
          else //�������
            StavkaNum:=0;
        end;
        break;
      end;
      Pobeditel(PlayerCards,ProtivnikCards,'',pobedil,0,Last,PobedaOnly);
      if PobedaOnly then
        MaxPercent:=1;
      Zagrujeno:=false;
      PlayerCards[Res].iElement.click;
      WaitEvent(Zagrujeno);
      GetElement(iElement,'a','�����','button_small');
      if iElement<>nil then
      begin
        Zagrujeno:=false;
        iElement.click;
        WaitEvent(Zagrujeno);
      end;
    end;
  end;

end;
////////////////////////////////////////////////////////////////////
////////// ��������� �������� ////////////////////
procedure DoAction(Action:TAction);
var
  sAct:string;
begin
  sAct:=Action.Action;
  if sAct='pohod' then
  begin
    GoToPohod;
  end;
  if sAct='fight' then
    DoFight;
  if sAct='train' then
    DoTrain;
  if sAct='shahta' then
    DoShahta;
  if sAct='pet_in' then
    Player.Pet.GoToCell(true);
  if sAct='MechShitSvitok' then
    MechShitSvitok;
  //������ �������
end;


//////////////////////////////////////////////////////////////////
/////////// �������� ������� �����  //////////////////
procedure TForm1.FormCreate(Sender: TObject);
var
  IniFile:TIniFile;
  i,count:integer;
begin
  Player:=TPlayer.Create;
  Stavki[0]:=2;
  Stavki[1]:=5;
  Stavki[2]:=10;
  LastWin:=true;
  StavkaNum:=0;
  timeToOdetSvit:=-1;
  Protivnik:=TProtivnik.Create;
  Protivnik_MAX:=TProtivnik.Create;
  Protivnik_MIN:=TProtivnik.Create;
  Sect:=TCriticalSection.Create;
  SetType:=false;
  AssignFile(fLog,'log.txt');
  Rewrite(fLog);
  CloseFile(fLog);
  IniFile:=TIniFile.Create(ExtractFilePath(Application.ExeName)+'config.ini');
  sRadioGroup1.ItemIndex:=IniFile.ReadInteger('Game','onPower',0);
  sRadioButton1.Checked:=IniFile.ReadBool('Game','LevelLow',true);
  sRadioButton2.Checked:=IniFile.ReadBool('Game','LevelSame',false);
  sRadioButton3.Checked:=IniFile.ReadBool('Game','LevelHight',false);
  sRadioButton4.Checked:=IniFile.ReadBool('Game','Naim',false);
  sComboBox1.ItemIndex:=IniFile.ReadInteger('Game','NaimType',0);
  sRadioButton5.Checked:=IniFile.ReadBool('Game','OnLevel',false);
  sEdit1.Text:=IniFile.ReadString('Game','Level','10');
  sCheckBox1.Checked:=IniFile.ReadBool('Game','FromMain',true);
  sCheckBox14.Checked:=IniFile.ReadBool('Arena','Gifts',false);
  sCheckBox16.Checked:=IniFile.ReadBool('Arena','Gift2',false);
  sCheckBox17.Checked:=IniFile.ReadBool('Arena','Gift3',false);
  sCheckBox18.Checked:=IniFile.ReadBool('Arena','Gift4',false);
  sCheckBox19.Checked:=IniFile.ReadBool('Arena','Gift5',false);
  sCheckBox20.Checked:=IniFile.ReadBool('Arena','Gift6',false);
  sCheckBox21.Checked:=IniFile.ReadBool('Arena','Gift7',false);
  sCheckBox26.Checked:=IniFile.ReadBool('Arena','RememberRich',false);
  count:=IniFile.ReadInteger('Arena','RichCount',0);
  sEdit18.Text:=IniFile.ReadString('Arena','RichBarier','1000');
  sCheckBox22.Checked:=IniFile.ReadBool('Game','FightVlad',true);
  sCheckBox2.Checked:=IniFile.ReadBool('Game','GoToAren',true);
  sCheckBox3.Checked:=IniFile.ReadBool('Game','GoToPohod',true);
  sCheckBox4.Checked:=IniFile.ReadBool('Game','CoolEnemyInFriend',false);
  sCheckBox24.Checked:=IniFile.ReadBool('Game','MechShitSvitok',false);
  sCheckBox25.Checked:=IniFile.ReadBool('Arena','FriendNotAtack',true);
  sCheckBox13.Checked:=IniFile.ReadBool('Game','NoFightFriends',true);
  sCheckBox5.Checked:=IniFile.ReadBool('Game','NotBeatOnline',true);
  sEdit2.Text:=IniFile.ReadString('Game','Waiting','30');
  sEdit3.Text:=IniFile.ReadString('Game','MinTime','1');
  sEdit4.Text:=IniFile.ReadString('Game','MaxTime','3');
  sDecimalSpinEdit1.Text:=IniFile.ReadString('Game','Glub','100,0');
  sCheckBox6.Checked:=IniFile.ReadBool('Game','GoDownDig',true);
  sCheckBox7.Checked:=IniFile.ReadBool('AutoIncrement','AutoIncrement',true);
  sRadioButton6.Checked:=IniFile.ReadBool('AutoIncrement','Pers',true);
  sRadioButton7.Checked:=IniFile.ReadBool('AutoIncrement','Pet',false);
  sRadioGroup2.ItemIndex:=IniFile.ReadInteger('AutoIncrement','Param',0);
  sCheckBox8.Checked:=IniFile.ReadBool('ProgramSettings','UseAntigate',false);
  sEdit5.Text:=IniFile.ReadString('ProgramSettings','ApiKey','');
  Player.Nagrab:=IniFile.ReadInteger('Player','Nagrab',0);
  Player.Lost:=IniFile.ReadInteger('Player','Lost',0);
  Player.NagrabKris:=IniFile.ReadInteger('Player','NagrabKris',0);
  Player.LostKris:=IniFile.ReadInteger('Player','LostKris',0);
  sComboBox2.ItemIndex:=IniFile.ReadInteger('ProgramSettings','Server',0);
  sPageControl1.ActivePageIndex:=IniFile.ReadInteger('ProgramSettings','AP',0);
  sCheckBox12.Checked:=IniFile.ReadBool('Other','Prover',false);
  sCheckBox23.Checked:=IniFile.ReadBool('Other','SvitkiUse',false);
  sRadioGroup3.ItemIndex:=IniFile.ReadInteger('Other','Svitok',0);
  Player.NagrabGolds:=IniFile.ReadInteger('Player','NagrabGolds',0);
  sEdit7.Text:=IniFile.ReadString('Other','ProtivnikMaxPower','100');
  sEdit8.Text:=IniFile.ReadString('Other','ProtivnikMaxZashita','100');
  sEdit9.Text:=IniFile.ReadString('Other','ProtivnikMaxAgility','100');
  sEdit10.Text:=IniFile.ReadString('Other','ProtivnikMaxSkill','100');
  sEdit11.Text:=IniFile.ReadString('Other','ProtivnikMaxZhivuchest','100');
  sEdit13.Text:=IniFile.ReadString('Other','ProtivnikMinPower','0');
  sEdit14.Text:=IniFile.ReadString('Other','ProtivnikMinZashita','0');
  sEdit15.Text:=IniFile.ReadString('Other','ProtivnikMinAgility','0');
  sEdit16.Text:=IniFile.ReadString('Other','ProtivnikMinSkill','0');
  sEdit17.Text:=IniFile.ReadString('Other','ProtivnikMinZhivuchest','0');
  sCheckBox15.Checked:=IniFile.ReadBool('Other','PrikryvatSvit',false);
  sCheckBox9.Checked:=IniFile.ReadBool('Pet','Out',false);
  sCheckBox10.Checked:=IniFile.ReadBool('Pet','InLowHealth',false);
  sCheckBox11.Checked:=IniFile.ReadBool('Pet','InAfterArena',false);
  sEdit6.Text:=IniFile.ReadString('Pet','MinHealth','500');
  PanelType:=IniFile.ReadInteger('Statistic','PanelType',0);
  TIMEOUT:=IniFile.ReadInteger('Other','Timeout',40)*1000;
  SetLength(RichWekings,count);
  for i:=0 to count-1 do
  begin  
    RichWekings[i].Sera:=IniFile.ReadInteger('Rich'+IntToStr(i),'Sera',0);
    RichWekings[i].time:=IniFile.ReadInteger('Rich'+IntToStr(i),'Time',0);
    RichWekings[i].id:=IniFile.ReadString('Rich'+IntToStr(i),'Id','0');
  end;
  IniFile.Free;
  sEdit12.Text:=IntToStr(TIMEOUT div 1000);
  if PanelType=0 then
  begin
    sStatusBar1.Panels[1].Text:='��������: '+IntToStr(Player.Nagrab);
    sStatusBar1.Panels[2].Text:='���������: '+IntToStr(Player.Lost);
  end;
  if PanelType=1 then
  begin
    sStatusBar1.Panels[1].Text:='��������: '+IntToStr(Player.NagrabKris);
    sStatusBar1.Panels[2].Text:='���������: '+IntToStr(Player.LostKris);
  end;
  if PanelType=2 then
  begin
    sStatusBar1.Panels[1].Text:='��������: '+IntToStr(Player.NagrabGolds);
    sStatusBar1.Panels[2].Text:='';
  end;
  SERVER:=sComboBox2.Items[sComboBox2.ItemIndex];
  Form1.AC1.Apikey:=Form1.sEdit5.Text;
  if sRadioButton4.Checked then
  begin
    sCheckBox26.Checked:=false;
    sCheckBox26.Enabled:=false;
  end
  else
  begin
    sCheckBox26.Enabled:=true;
  end;
  WebBrowser1.Navigate('http://'+SERVER+'/');
end;

//////////////////////////////////////////////////////////////
/////// ���������� ����� ////////
procedure TForm1.FormDestroy(Sender: TObject);
var
  IniFile:TIniFile;
  i,count:integer;
  fConfig:textfile;
begin
  Protivnik.Free;
  Protivnik_MAX.Free;
  Protivnik_MIN.Free;
  count:=Length(RichWekings);
  AssignFile(fConfig,'config.ini');
  Rewrite(fConfig);
  CloseFile(fConfig);
  IniFile:=TIniFile.Create(ExtractFilePath(Application.ExeName)+'config.ini');
  IniFile.WriteInteger('Game','onPower',sRadioGroup1.ItemIndex);
  IniFile.WriteBool('Game','LevelLow',sRadioButton1.Checked);
  IniFile.WriteBool('Game','LevelSame',sRadioButton2.Checked);
  IniFile.WriteBool('Game','LevelHight',sRadioButton3.Checked);
  IniFile.WriteBool('Game','Naim',sRadioButton4.Checked);
  IniFile.WriteInteger('Game','NaimType',sComboBox1.ItemIndex);
  IniFile.WriteBool('Game','OnLevel',sRadioButton5.Checked);
  IniFile.WriteString('Game','Level',sEdit1.Text);
  IniFile.WriteBool('Game','FromMain',sCheckBox1.Checked);
  IniFile.WriteBool('Game','GoToAren',sCheckBox2.Checked);
  IniFile.WriteBool('Game','GoToPohod',sCheckBox3.Checked);
  IniFile.WriteBool('Game','CoolEnemyInFriend',sCheckBox4.Checked);
  IniFile.WriteBool('Game','NoFightFriends',sCheckBox13.Checked);
  IniFile.WriteBool('Game','NotBeatOnline',sCheckBox5.Checked);
  IniFile.WriteString('Game','Waiting',sEdit2.Text);
  IniFile.WriteString('Game','MinTime',sEdit3.Text);
  IniFile.WriteString('Game','MaxTime',sEdit4.Text);
  IniFile.WriteBool('Game','MechShitSvitok',sCheckBox24.Checked);
  IniFile.WriteString('Game','Glub',sDecimalSpinEdit1.Text);
  IniFile.WriteBool('Game','GoDownDig',sCheckBox6.Checked);
  IniFile.WriteBool('AutoIncrement','AutoIncrement',sCheckBox7.Checked);
  IniFile.WriteBool('AutoIncrement','Pers',sRadioButton6.Checked);
  IniFile.WriteBool('AutoIncrement','Pet',sRadioButton7.Checked);
  IniFile.WriteInteger('AutoIncrement','Param',sRadioGroup2.ItemIndex);
  IniFile.WriteBool('ProgramSettings','UseAntigate',sCheckBox8.Checked);
  IniFile.WriteString('ProgramSettings','ApiKey',sEdit5.Text);
  IniFile.WriteInteger('Player','Nagrab',Player.Nagrab);
  IniFile.WriteInteger('Player','Lost',Player.Lost);
  IniFile.WriteInteger('Player','NagrabKris',Player.NagrabKris);
  IniFile.WriteInteger('Player','LostKris',Player.LostKris);
  IniFile.WriteInteger('ProgramSettings','Server',sComboBox2.ItemIndex);
  IniFile.WriteInteger('ProgramSettings','AP',sPageControl1.ActivePageIndex);
  IniFile.WriteBool('Other','Prover',sCheckBox12.Checked);
  IniFile.WriteString('Other','ProtivnikMaxPower',sEdit7.Text);
  IniFile.WriteString('Other','ProtivnikMaxZashita',sEdit8.Text);
  IniFile.WriteString('Other','ProtivnikMaxAgility',sEdit9.Text);
  IniFile.WriteString('Other','ProtivnikMaxSkill',sEdit10.Text);
  IniFile.WriteString('Other','ProtivnikMaxZhivuchest',sEdit11.Text);
  IniFile.WriteString('Other','ProtivnikMinPower',sEdit13.Text);
  IniFile.WriteString('Other','ProtivnikMinZashita',sEdit14.Text);
  IniFile.WriteString('Other','ProtivnikMinAgility',sEdit15.Text);
  IniFile.WriteString('Other','ProtivnikMinSkill',sEdit16.Text);
  IniFile.WriteString('Other','ProtivnikMinZhivuchest',sEdit17.Text);
  IniFile.WriteBool('Other','PrikryvatSvit',sCheckBox15.Checked);
  IniFile.WriteBool('Pet','Out',sCheckBox9.Checked);
  IniFile.WriteBool('Pet','InLowHealth',sCheckBox10.Checked);
  IniFile.WriteBool('Pet','InAfterArena',sCheckBox11.Checked);
  IniFile.WriteString('Pet','MinHealth',sEdit6.Text);
  IniFile.WriteBool('Arena','Gifts',sCheckBox14.Checked);
  IniFile.WriteBool('Arena','Gift2',sCheckBox16.Checked);
  IniFile.WriteBool('Arena','Gift3',sCheckBox17.Checked);
  IniFile.WriteBool('Arena','Gift4',sCheckBox18.Checked);
  IniFile.WriteBool('Arena','Gift5',sCheckBox19.Checked);
  IniFile.WriteBool('Arena','Gift6',sCheckBox20.Checked);
  IniFile.WriteBool('Arena','Gift7',sCheckBox21.Checked);
  IniFile.WriteBool('Arena','RememberRich',sCheckBox26.Checked);
  IniFile.WriteString('Arena','RichBarier',sEdit18.Text);
  IniFile.WriteInteger('Arena','RichCount',count);
  IniFile.WriteBool('Game','FightVlad',sCheckBox22.Checked);
  IniFile.WriteBool('Other','SvitkiUse',sCheckBox23.Checked);
  IniFile.WriteInteger('Other','Svitok',sRadioGroup3.ItemIndex);
  IniFile.WriteInteger('Player','NagrabGolds',Player.NagrabGolds);
  IniFile.WriteInteger('Statistic','PanelType',PanelType);
  IniFile.WriteInteger('Other','Timeout',TIMEOUT div 1000);
  IniFile.WriteBool('Arena','FriendNotAtack',sCheckBox25.Checked);
  for i:=0 to count-1 do
  begin  
    IniFile.WriteInteger('Rich'+IntToStr(i),'Sera',RichWekings[i].Sera);
    IniFile.WriteInteger('Rich'+IntToStr(i),'Time',RichWekings[i].time);
    IniFile.WriteString('Rich'+IntToStr(i),'Id',RichWekings[i].id);
  end;
  IniFile.Free;
  Player.Free;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  SetComponentsSize;
end;

/////////////////////////////////////////////////////////////////////////////////////////////////////
////// ���������� ����� ��������(������� � ������ ������� �����������(������� �����)) ////////////////
procedure SortActionList;
var
  i,j:integer;
  buf:TAction;
begin
  for i:=0 to Length(ActionList)-2 do
    for j:=i+1 to Length(ActionList)-1 do
      if ActionList[j].Prior<ActionList[i].Prior then
      begin
        buf:=ActionList[i];
        ActionList[i]:=ActionList[j];
        ActionList[j]:=buf;
      end;
end;

///////////////////////////////////////////////////////////////////
//// ������ ����/���� //////////////////////////////////////////
procedure TForm1.sButton1Click(Sender: TObject);
var
  Time,R:integer;
begin
  ActiveControl:=nil;
  TIMEOUT:=StrToInt(sEdit12.Text)*1000;
  http.ReadTimeout:=1000;
  http.ConnectTimeout:=500;
  if sButton1.Caption='����' then
  begin
    Player.PohodIsset:=true;
    Player.ShahtaIsset:=true;
    sButton1.Caption:='����';
    sPageControl1.Enabled:=false;
    if StrToInt(Form1.sEdit3.Text)>StrToInt(Form1.sEdit4.Text) then
      Form1.sEdit3.Text:=Form1.sEdit4.Text;
    if Form1.sCheckBox12.Checked then
    begin
      Protivnik_MAX.Param.Sila:=StrToInt(Form1.sEdit7.Text);
      Protivnik_MAX.Param.Zashita:=StrToInt(Form1.sEdit8.Text);
      Protivnik_MAX.Param.Lovkost:=StrToInt(Form1.sEdit9.Text);
      Protivnik_MAX.Param.Masterstvo:=StrToInt(Form1.sEdit10.Text);
      Protivnik_MAX.Param.Zhivuchest:=StrToInt(Form1.sEdit11.Text);
      Protivnik_MIN.Param.Sila:=StrToInt(Form1.sEdit13.Text);
      Protivnik_MIN.Param.Zashita:=StrToInt(Form1.sEdit14.Text);
      Protivnik_MIN.Param.Lovkost:=StrToInt(Form1.sEdit15.Text);
      Protivnik_MIN.Param.Masterstvo:=StrToInt(Form1.sEdit16.Text);
      Protivnik_MIN.Param.Zhivuchest:=StrToInt(Form1.sEdit17.Text);
    end;
    Form1.AC1.Apikey:=Form1.sEdit5.Text;
    WaitEvent(Zagrujeno);
    Zagrujeno:=false;
    Form1.WebBrowser1.Navigate('http://'+SERVER+'/game/buildup/user');
    WaitEvent(Zagrujeno);
    if Form1.sCheckBox7.Checked  then
    begin
      if Form1.sRadioButton7.Checked then
      begin              //����������� �����
        Zagrujeno:=false;
        Form1.WebBrowser1.Navigate('http://'+SERVER+'/game/buildup/pet');
        WaitEvent(Zagrujeno);
      end;
    end;
    while Form1.sButton1.Caption='����' do   // ���� ������ ������
    begin
      Application.ProcessMessages;
      if Application.Terminated then
        exit;
      if sCheckBox24.Checked then
      begin
        if Player.MechShitSvitokIsset then
        begin
          if Player.Kris>=2 then
            SetAction('MechShitSvitok',0)
          else
            UnsetAction('MechShitSvitok');
        end
        else
          UnsetAction('MechShitSvitok');
      end
      else
        UnsetAction('MechShitSvitok');
      SortActionList;      // ����������� ������ ������� � ����������. ������� � ����� �������� �����������(0,1,2...)
      if Length(ActionList)<>0 then
        DoAction(ActionList[0]);   //��������� ��������
      if Length(ActionList)<>0 then
       if Form1.sCheckBox1.Checked then // �������� ����� �������?
       begin
         Zagrujeno:=false;
         Form1.WebBrowser1.Navigate('http://'+SERVER+'/game');
         WaitEvent(Zagrujeno);
       end;
       if Length(ActionList)=0 then    // ��� ������� � ������?
       begin
         if(sCheckBox15.Checked) and (not Player.SvitokOdet) then
           SetSvitki;
         Time:=StrToInt(Form1.sEdit2.Text);   // ��������
         Form1.sStatusBar1.Panels[0].Text:=IntToStr(Time);
         Delay(Time*1000);
         if(sCheckBox15.Checked) and Player.SvitokOdet then
           UnSetSvitki;
         Zagrujeno:=false;
         Form1.WebBrowser1.Navigate('http://'+SERVER+'/game');
         WaitEvent(Zagrujeno);
       end
       else
       begin
         Randomize;
         R:=Random(StrToInt(Form1.sEdit4.Text)-StrToInt(Form1.sEdit3.Text)+1);
         Time:=(R+StrToInt(Form1.sEdit3.Text));
         Form1.sStatusBar1.Panels[0].Text:=IntToStr(Time);
         Delay(Time*1000);
       end;
     end;
  end
  else
  begin
    sButton1.Caption:='����';
    Form1.sPageControl1.Enabled:=true;
  end;
end;

/// ���������� ����������  ///////////
procedure TForm1.sButton2Click(Sender: TObject);
begin
  ActiveControl:=nil;
  if sCheckBox8.Checked then
    sButton2.Caption:=AC1.Getbalans(sEdit5.Text)
  else
    sButton2.Caption:='N/A';
end;

procedure TForm1.sButton3Click(Sender: TObject);
begin
  ActiveControl:=nil;
  if PanelType=0 then
  begin
    Player.Nagrab:=0;
    Player.Lost:=0;
  end;
  if PanelType=1 then
  begin
    Player.NagrabKris:=0;
    Player.LostKris:=0;
  end;
  if PanelType=2 then
    Player.NagrabGolds:=0;
  sStatusBar1.Panels[1].Text:='��������: 0';
  sStatusBar1.Panels[2].Text:='��������: 0';
  if PanelType=2 then
    sStatusBar1.Panels[2].Text:='';
end;

procedure TForm1.sButton4Click(Sender: TObject);
begin
  ActiveControl:=nil;
  Form3.Top:=Form1.Top+100;
  Form3.Left:=Form1.Left+200;
  Form3.Show;
  Form3.ActiveControl:=nil;
  Timer1.Enabled:=true;
end;

procedure TForm1.sButton5Click(Sender: TObject);
begin
  SetLength(RichWekings,0);
end;

procedure TForm1.sCheckBox7Click(Sender: TObject);
begin
  if sCheckBox7.Checked then
  begin
    sRadioButton6.Enabled:=true;
    sRadioButton7.Enabled:=true;
  end
  else
  begin
    sRadioButton6.Enabled:=false;
    sRadioButton7.Enabled:=false;
  end;

end;




/// ��������� �������  //////////////////
procedure TForm1.sComboBox2Change(Sender: TObject);
begin
  SERVER:=sComboBox2.Items[sComboBox2.ItemIndex];
  WebBrowser1.Navigate('http://'+SERVER+'/');
  Zagrujeno:=false;
  WaitEvent(Zagrujeno);
end;

procedure TForm1.sEdit12Change(Sender: TObject);
begin
  TIMEOUT:=StrToInt(sEdit12.Text)*1000;
end;

procedure TForm1.SetComponentsSize;
var
  i,j,FontSize:integer;
  COOFF_MON:real;
begin
  COOFF_MON:=1/(Height/(Screen.Height*(Height/1080)));
  if Screen.Height=768 then
    COOFF_MON:=0.9;
  ClientWidth:=Round(ClientWidth*COOFF_MON);
  ClientHeight:=Round(ClientHeight*COOFF_MON);
  FontSize:=Round(8*COOFF_MON);
  for i :=0 to ComponentCount-1 do
  begin
    if Components[i] is TsPageControl then
    begin
      (Components[i] as TsPageControl).Height:=Round((Components[i] as TsPageControl).Height*COOFF_MON);
      (Components[i] as TsPageControl).Width:=Round((Components[i] as TsPageControl).Width*COOFF_MON);
      (Components[i] as TsPageControl).Top:=Round((Components[i] as TsPageControl).Top*COOFF_MON);
      (Components[i] as TsPageControl).Left:=Round((Components[i] as TsPageControl).Left*COOFF_MON);
      for j :=0 to (Components[i] as TsPageControl).ControlCount-1 do
      begin
        (Components[i] as TsPageControl).Controls[j].Height:=Round((Components[i] as TsPageControl).Controls[j].Height*COOFF_MON);
        (Components[i] as TsPageControl).Controls[j].Width:=Round((Components[i] as TsPageControl).Controls[j].Width*COOFF_MON);
      end;
      (Components[i] as TsPageControl).Font.Size:=FontSize;
    end;
   { if Components[i] is TsRadioGroup then
    begin
      (Components[i] as TsRadioGroup).Height:=Round((Components[i] as TsRadioGroup).Height*COOFF_MON*0.5);
      (Components[i] as TsRadioGroup).Width:=Round((Components[i] as TsRadioGroup).Width*COOFF_MON*0.5);
      (Components[i] as TsRadioGroup).Top:=Round((Components[i] as TsRadioGroup).Top*COOFF_MON*0.5);
      (Components[i] as TsRadioGroup).Left:=Round((Components[i] as TsRadioGroup).Left*COOFF_MON*0.5);
    end;         }
    if Components[i] is TsButton then
    begin
      (Components[i] as TsButton).Height:=Round((Components[i] as TsButton).Height*COOFF_MON);
      (Components[i] as TsButton).Width:=Round((Components[i] as TsButton).Width*COOFF_MON);
      (Components[i] as TsButton).Top:=Round((Components[i] as TsButton).Top*COOFF_MON);
      (Components[i] as TsButton).Left:=Round((Components[i] as TsButton).Left*COOFF_MON);
      (Components[i] as TsButton).Font.Size:=FontSize;
    end;
    if Components[i] is TsEdit then
    begin
      (Components[i] as TsEdit).Height:=Round((Components[i] as TsEdit).Height*COOFF_MON);
      (Components[i] as TsEdit).Width:=Round((Components[i] as TsEdit).Width*COOFF_MON);
      (Components[i] as TsEdit).Top:=Round((Components[i] as TsEdit).Top*COOFF_MON);
      (Components[i] as TsEdit).Left:=Round((Components[i] as TsEdit).Left*COOFF_MON);
      (Components[i] as TsEdit).Font.Size:=FontSize;
    end;
     if Components[i] is TsComboBox then
    begin
      (Components[i] as TsComboBox).Font.Size:=Round((Components[i] as TsComboBox).Font.Size*COOFF_MON);
      (Components[i] as TsComboBox).Height:=Round((Components[i] as TsComboBox).Height*COOFF_MON);
      (Components[i] as TsComboBox).ItemHeight:=Round((Components[i] as TsComboBox).ItemHeight*COOFF_MON);
      (Components[i] as TsComboBox).Width:=Round((Components[i] as TsComboBox).Width*COOFF_MON);
      (Components[i] as TsComboBox).Top:=Round((Components[i] as TsComboBox).Top*COOFF_MON);
      (Components[i] as TsComboBox).Left:=Round((Components[i] as TsComboBox).Left*COOFF_MON);
      (Components[i] as TsComboBox).Font.Size:=FontSize;
    end;
    if Components[i] is TsCheckBox then
    begin
      (Components[i] as TsCheckBox).Height:=Round((Components[i] as TsCheckBox).Height*COOFF_MON);
      (Components[i] as TsCheckBox).Width:=Round((Components[i] as TsCheckBox).Width*COOFF_MON);
      (Components[i] as TsCheckBox).Top:=Round((Components[i] as TsCheckBox).Top*COOFF_MON);
      (Components[i] as TsCheckBox).Left:=Round((Components[i] as TsCheckBox).Left*COOFF_MON);
      (Components[i] as TsCheckBox).Font.Size:=FontSize;
    end;
    if Components[i] is TWebBrowser then
    begin
      (Components[i] as TWebBrowser).Height:=Round((Components[i] as TWebBrowser).Height*COOFF_MON);
      (Components[i] as TWebBrowser).Width:=Round((Components[i] as TWebBrowser).Width*COOFF_MON);
      (Components[i] as TWebBrowser).Top:=Round((Components[i] as TWebBrowser).Top*COOFF_MON);
      (Components[i] as TWebBrowser).Left:=Round((Components[i] as TWebBrowser).Left*COOFF_MON);
    end;
    if Components[i] is TsRadioButton then
    begin
      (Components[i] as TsRadioButton).Height:=Round((Components[i] as TsRadioButton).Height*COOFF_MON);
      (Components[i] as TsRadioButton).Width:=Round((Components[i] as TsRadioButton).Width*COOFF_MON);
      (Components[i] as TsRadioButton).Top:=Round((Components[i] as TsRadioButton).Top*COOFF_MON);
      (Components[i] as TsRadioButton).Left:=Round((Components[i] as TsRadioButton).Left*COOFF_MON);
      (Components[i] as TsRadioButton).Font.Size:=FontSize;
    end;
    if Components[i] is TStatusBar then
    begin
      (Components[i] as TStatusBar).Height:=Round((Components[i] as TStatusBar).Height*COOFF_MON);
      (Components[i] as TStatusBar).Width:=Round((Components[i] as TStatusBar).Width*COOFF_MON);
      (Components[i] as TStatusBar).Top:=Round((Components[i] as TStatusBar).Top*COOFF_MON);
      (Components[i] as TStatusBar).Left:=Round((Components[i] as TStatusBar).Left*COOFF_MON);
      for j:=0 to (Components[i] as TStatusBar).Panels.Count-1 do
      begin
        (Components[i] as TStatusBar).Panels[j].Width:=Round((Components[i] as TStatusBar).Panels[j].Width*COOFF_MON);
      end;
     (Components[i] as TStatusBar).Font.Size:=FontSize;
    end;
    if Components[i] is TsPanel then
    begin
      (Components[i] as TsPanel).Height:=Round((Components[i] as TsPanel).Height*COOFF_MON);
      (Components[i] as TsPanel).Width:=Round((Components[i] as TsPanel).Width*COOFF_MON);
      (Components[i] as TsPanel).Top:=Round((Components[i] as TsPanel).Top*COOFF_MON);
      (Components[i] as TsPanel).Left:=Round((Components[i] as TsPanel).Left*COOFF_MON);
    end;
    if Components[i] is TsGroupBox then
    begin
      (Components[i] as TsGroupBox).Height:=Round((Components[i] as TsGroupBox).Height*COOFF_MON);
      (Components[i] as TsGroupBox).Width:=Round((Components[i] as TsGroupBox).Width*COOFF_MON);
      (Components[i] as TsGroupBox).Top:=Round((Components[i] as TsGroupBox).Top*COOFF_MON);
      (Components[i] as TsGroupBox).Left:=Round((Components[i] as TsGroupBox).Left*COOFF_MON);
      (Components[i] as TsGroupBox).Font.Size:=FontSize;
    end;
    if Components[i] is TsLabel then
    begin
      (Components[i] as TsLabel).Height:=Round((Components[i] as TsLabel).Height*COOFF_MON);
      (Components[i] as TsLabel).Width:=Round((Components[i] as TsLabel).Width*COOFF_MON);
      (Components[i] as TsLabel).Top:=Round((Components[i] as TsLabel).Top*COOFF_MON);
      (Components[i] as TsLabel).Left:=Round((Components[i] as TsLabel).Left*COOFF_MON);
      (Components[i] as TsLabel).Font.Size:=FontSize;
    end;
  end;

end;





procedure TForm1.sRadioButton4Click(Sender: TObject);
begin
  if sRadioButton4.Checked then
  begin
    sCheckBox26.Checked:=false;
    sCheckBox26.Enabled:=false;
  end
  else
  begin
    sCheckBox26.Enabled:=true;
  end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Unit3.Form3.sLabel3.Caption:=IntToStr(Player.Nagrab);
  Unit3.Form3.sLabel4.Caption:=IntToStr(Player.Lost);
  Unit3.Form3.sLabel7.Caption:=IntToStr(Player.NagrabKris);
  Unit3.Form3.sLabel8.Caption:=IntToStr(Player.LostKris);
  Unit3.Form3.sLabel10.Caption:=IntToStr(Player.NagrabGolds);
  if SetType then
  begin
    SetType:=false;
      if PanelType=0 then
      begin
        sStatusBar1.Panels[1].Text:='��������: '+IntToStr(Player.Nagrab);
        sStatusBar1.Panels[2].Text:='���������: '+IntToStr(Player.Lost);
      end;
      if PanelType=1 then
      begin
        sStatusBar1.Panels[1].Text:='��������: '+IntToStr(Player.NagrabKris);
        sStatusBar1.Panels[2].Text:='���������: '+IntToStr(Player.LostKris);
      end;
      if PanelType=2 then
      begin
        sStatusBar1.Panels[1].Text:='��������: '+IntToStr(Player.NagrabGolds);
        sStatusBar1.Panels[2].Text:='';
      end;
  end;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
  sButton1.Click;
end;

// ���������� ������ � ������� �� ������ ������ ///
procedure DeCaptcha;
  //� ������� �������� ��� ������   //
  function GetBrowserImage(url: string; var BitMaps: TBitMaps; var Len:integer): boolean;
  var
    body, imgs, controlRange: olevariant;
    i: integer;
    ImageHref: string;
  begin
     Len:=0;
     Result:=false;
     body := Form1.WebBrowser1.OleObject.document.body;
     for i := 0 to Form1.WebBrowser1.OleObject.Document.Images.Length - 1 do
     begin
       ImageHref := Form1.WebBrowser1.OleObject.Document.Images.Item(i).href;
       if Pos(url,ImageHref)<>0 then
       begin
         imgs := Form1.WebBrowser1.OleObject.document.images.item(i);
         controlRange := body.createControlRange;
         controlRange.add(imgs);
         controlRange.execCommand('Copy', False, EmptyParam);
         try
           if ClipBoard.HasFormat(CF_BITMAP) then
           begin
             inc(Len);
             SetLength(BitMaps,Len);
             BitMaps[Len-1]:=TBitmap.Create;
             BitMaps[Len-1].LoadFromClipboardFormat(cf_BitMap, ClipBoard.GetAsHandle(cf_Bitmap), 0);
             Result:=true;
           end;
         except
         end;
       end;
     end;
  end;
  // ���������� ���� �������� �� ������ � ������������ �����������, ���� �� ��� �����(���� FFFFFF) ////////
  procedure DrawXY(var BitMap:TBitmap; BitMap2:TBitmap; X,Y:integer);
  var
    i,j,MaxX,MaxY:integer;
  begin
    MaxX:=BitMap2.Width-1;
    MaxY:=BitMap2.Height-1;
    for i:=0 to MaxX do
      for j:=0 to MaxY do
      if BitMap.Canvas.Pixels[X+i,Y+j]=$00FFFFFF then
      begin
        BitMap.Canvas.Pixels[X+i,Y+j]:=BitMap2.Canvas.Pixels[i,j];
      end;
  end;
  // �������� � ����������-��������//
  procedure GetUrls(var Urls:array of IHTMLElement);
  var
    i,j: integer;
    iDoc: IHtmlDocument2;
    iDisp: IDispatch;
    Doc:IHTMLElementCollection;
    S: string;
    iElement:IHTMLElement;
  begin
    j:=0;
    iDoc := Form1.WebBrowser1.Document as IHtmlDocument2;
    Doc:=iDoc.all.tags('a') as IHTMLElementCollection;
    for i := 1 to Doc.length do
    begin
      iDisp := Doc.item(pred(i), 0);
      iDisp.QueryInterface(IHTMLElement, iElement);
      S:='';
      if assigned(iElement) then
      begin
        S:=iElement.getAttribute('href',0);
        if Pos('answer',S)<>0 then
        begin
          Urls[j]:=iElement;
          inc(j);
        end;
      end;
      iElement:=nil;
    end;
  end;
var
  BitMapsQ,BitMapsAnswer:TBitMaps;
  i,Len:integer;
  Captcha:TBitmap;
  PosX,PosY:integer;
  rc:TResourceStream;
  PNG:TPngImage;
  Urls:array[0..8] of IHTMLElement;
  Ret:string;
  jpg:TJPEGImage;
  iElement:IHTMLElement;
  S:string;
begin
  GetElement(iElement,'div','','desc');
  if iElement=nil then
    exit;
  Ret:=iElement.innerText;
  Ret:=Copy(Ret,Pos('��������',Ret)+9,Length(Ret));
  Ret:=Copy(Ret,1,Pos('�������',Ret)-2);
  i:=StrToInt(Ret);
  if i<5 then
  begin
    Showmessage('���� �������!');
    exit;
  end;
  Application.ProcessMessages;
  if Application.Terminated then
    exit;
  GetUrls(Urls);
  if not GetBrowserImage('question',BitMapsQ,Len) then
    exit;
  if not GetBrowserImage('answer',BitMapsAnswer,Len) then
    exit;
  if Len<>9 then
    exit;
  Application.ProcessMessages;
  if Application.Terminated then
    exit;
  rc:=TResourceStream.Create(HInstance,'captcha',RT_RCDATA); 
  PNG:=TPngImage.Create;
  png.LoadFromStream(rc); 
  rc.Free;
  Captcha:=TBitmap.Create;   
  Captcha.Assign(PNG);
  png.Free;
  DrawXY(Captcha,BitMapsQ[0],0,0);
  for i:=0 to 8 do
  begin
    PosX:=i*60;
    PosY:=25;  
    DrawXY(Captcha,BitMapsAnswer[i],PosX,PosY);
  end;
  Application.ProcessMessages;
  if Application.Terminated then
    exit;
  jpg:=TJPEGImage.Create;
  jpg.Assign(captcha);
  jpg.compressionquality:=50;
  jpg.Compress;
  jpg.SaveToFile('C.jpg');
  jpg.Free;
  BitMapsQ[0].Free;
  for i:=0 to 8 do
    BitMapsAnswer[i].Free;
  Captcha.Free;
  Ret:='';
  Ret:=Form1.AC1.Recognize('C.jpg');
  AssignFile(fLog,'log.txt');
  {$I-}
  Append(fLog);
  {$I+}
  if IOResult<>0 then
    Rewrite(fLog);
  WriteLn(fLog,Ret);
  Close(fLog);
  if Byte(Ret[1]) in [49..57] then
  begin
    Zagrujeno:=false;
    S:=Urls[StrToInt(Ret[1])-1].getAttribute('href',0);
    Form1.WebBrowser1.Navigate(S);
    WaitEvent(Zagrujeno);
  end
  else
  begin
    inc(CapErr);
    if CapErr=2 then
    begin
      CapErr:=0;
      Zagrujeno:=false;
      Form1.WebBrowser1.Refresh;
      WaitEvent(Zagrujeno);
    end;
  end;
end;

////////////////////////////////////////////////////////////////////
////// �������� �������� ///////////////////////////////
procedure TForm1.WebBrowser1DocumentComplete(ASender: TObject;
  const pDisp: IDispatch; const URL: OleVariant);
var
  i: integer;
  iDoc: IHtmlDocument2;
  iDisp: IDispatch;
  iElement: IHTMLElement;
  Doc,Doc1,DocEvent,DocStrong:IHTMLElementCollection;
  S: string;
  OldTime:integer;
  Confirm:boolean;
  PetIsset:boolean;
  LogList:TStringList;
begin
  OldTime:=0;
  Confirm:=false;
  PetIsset:=false;
  iDoc := (pDisp as IWebBrowser).Document as IHtmlDocument2;
  Doc:=iDoc.all.tags('span') as IHTMLElementCollection;
  DocStrong:=iDoc.all.tags('strong') as IHTMLElementCollection;
  Doc1:=iDoc.all.tags('h1') as IHTMLElementCollection;
  DocEvent:= iDoc.all.tags('tr') as IHTMLElementCollection;
  Player.Pet.Status:=2;
  for i := 1 to Doc.length do
  begin
    iDisp := Doc.item(pred(i), 0);
    iDisp.QueryInterface(IHTMLElement, iElement);
    S:='';
    if assigned(iElement) then
    begin
      if iElement.id='current_user_level' then
      begin
        S:=iElement.innerText;
        Player.Level:=StrToInt(Trim(S));
      end;
      if iElement.id='current_user_health' then
      begin
        S:=iElement.innerText;
        Player.Health:=StrToInt(Trim(S));
      end;
      if iElement.id='user_silver_amount' then
      begin
        S:=iElement.innerText;
        Player.Sera:=StrToInt(Trim(S));
      end;
      if iElement.id='user_gold_amount' then
      begin
        S:=iElement.innerText;
        Player.Golds:=StrToInt(Trim(S));
      end;
      if iElement.id='user_crystal_amount' then
      begin
        S:=S+iElement.innerText;
        Player.Kris:=StrToInt(Trim(S));
      end;
      if iElement.id='remaining_fights_count' then
      begin
        S:=iElement.innerText;
        S:=Trim(S);
        S:=Copy(S,1,Pos('/',S)-1);
        Player.Fights:=StrToInt(S);
      end;
      if iElement.id='current_pet_health' then
      begin
        S:=iElement.innerText;
        S:=Trim(S);
        Player.Pet.Health:=StrToInt(S);
        PetIsset:=true;
      end;
      if iElement.id='current_game_time' then
      begin
        S:=iElement.innerText;
        S:=Trim(S);
        OldTime:=GlobTime;
        GlobTime:=StrToInt(Copy(S,1,Pos(':',S)-1))*3600;
        S:=Copy(S,Pos(':',S)+1,Length(S));
        GlobTime:=GlobTime+StrToInt(Copy(S,1,Pos(':',S)-1))*60;
        S:=Copy(S,Pos(':',S)+1,Length(S));
        GlobTime:=GlobTime+StrToInt(S);
      end;
      S := iElement.className;
      if Pos('info_block-pet_inactive',S)<>0 then
      begin
        Player.Pet.Status:=1;
      end;

    end;
  end;
  if (GetTickCount-oldLogTime) > 60000 then
  begin
    oldLogTime:=GetTickCount;
    iDisp := DocStrong.item(0, 0);
    iDisp.QueryInterface(IHTMLElement, iElement);
    S:='';
    if assigned(iElement) then
    begin
      S:=iElement.innerText;
      LogList:=TStringList.Create;
      LogList.Add('name='+S);
      LogList.Add('level='+IntToStr(Player.Level));
      LogList.Add('sera='+IntToStr(Player.Sera));
      LogList.Add('golds='+IntToStr(Player.Golds));
      LogList.Add('kris='+IntToStr(Player.Kris));
      LogList.Add('pet='+IntToStr(Player.Pet.Health));
      try
      http.Post('http://wbot.xedus.ru/log.php',LogList);
      except
      end;
      LogList.Free;
    end;
  end;
  /// ���� �����?  ///////////////
  if not PetIsset then
  begin
    Player.Pet.Health:=-1;
    Player.Pet.Status:=0;
  end;
  /// �������� ����� //////////////
  if Form1.sCheckBox10.Checked then
  begin
    if Player.Pet.Health<StrToInt(Form1.sEdit6.Text) then
      if Player.Pet.Status=2 then
        SetAction('pet_in',0)
      else
        UnsetAction('pet_in');
  end;
  //// ����� �������(�����,�����) /////////
  Events.Pohod:=false;
  Events.Shahta:=false;
  Events.Spusk:=false;
  if WebBrowser1.LocationURL='http://'+SERVER+'/game' then
    Events.Vlad:=false;
  ///// �������� ������� //////////
  for i:=0 to DocEvent.length-1 do
   begin
    iDisp:= DocEvent.item(i, 0);
    iDisp.QueryInterface(IHTMLElement, iElement);
    S:='';
    if assigned(iElement) and (iElement.className='notification') then
    begin
      S:=iElement.innerText;
      if Pos('� ������',S)<>0 then
        Events.Pohod:=true;
      if (Pos('�����',S)<>0) then
        Events.Shahta:=true;
      if (Pos('�����',S)<>0) then
        Events.Spusk:=true;
      if (Pos('�������',S)<>0) then
        Events.Vlad:=true;

    end;
  end;
  ////// �������� ���������� ���������/�����? - ������ ��������� ////////
  for i:=1 to Doc1.length do
  begin
    iDisp := Doc1.item(pred(i), 0);
    iDisp.QueryInterface(IHTMLElement, iElement);
    S:='';
    if assigned(iElement) then
    begin
      if iElement.innerText='�������������' then
        Player.GetTrainCost;
      if iElement.innerText='�����������' then
        Player.Pet.GetTrainCost;
      if iElement.innerText='�������������' then
        Confirm:=true;
    end;
  end;
  //// ����� �����?  ////////
  if OldTime>GlobTime then
  begin
    Player.PohodIsset:=true;
    Player.ShahtaIsset:=true;
  end;
  if (OldTime<(6*3600)) and (GlobTime>(6*3600)) then
    Player.MechShitSvitokIsset:=true;
  //////  �����  //////////
  if (not Events.Pohod) and (sCheckBox3.Checked) and Player.PohodIsset then
    if not Events.Shahta then
      SetAction('pohod',5)
    else
      UnsetAction('pohod')    
  else
    UnsetAction('pohod');
  ///// ��������  ////////
  if sCheckBox7.Checked then  // ������������� �����������.
  begin
    if sRadioButton6.Checked then     // ����������� ���������
    begin
      if sRadioGroup2.ItemIndex=0 then   // ���� �����
        if Player.Sera>=Player.SilaCost then
          SetAction('train',1)
        else
          UnsetAction('train');
      if sRadioGroup2.ItemIndex=1 then   //������ �����
        if Player.Sera>=Player.ZashitaCost then
          SetAction('train',1)
        else
          UnsetAction('train');
      if sRadioGroup2.ItemIndex=2 then  //�������� �����
        if Player.Sera>=Player.LovkostCost then
          SetAction('train',1)
        else
          UnsetAction('train');
      if sRadioGroup2.ItemIndex=3 then   // ���������� �����
        if Player.Sera>=Player.MasterstvoCost then
          SetAction('train',1)
        else
          UnsetAction('train');
      if sRadioGroup2.ItemIndex=4 then   // ��������� �����
        if Player.Sera>=Player.ZhivuchestCost then
          SetAction('train',1)
        else
          UnsetAction('train');
    end;
    if sRadioButton7.Checked then  //����������� �����
    begin
      if sRadioGroup2.ItemIndex=0 then   // ���� �����
        if (Player.Sera>=Player.Pet.SilaCost) and (Player.Pet.SilaCost<>0) then
          SetAction('train',1)
        else
          UnsetAction('train');
      if sRadioGroup2.ItemIndex=1 then   //������ �����
        if (Player.Sera>=Player.Pet.ZashitaCost) and (Player.Pet.ZashitaCost<>0) then
          SetAction('train',1)
        else
          UnsetAction('train');
      if sRadioGroup2.ItemIndex=2 then  //�������� �����
        if (Player.Sera>=Player.Pet.LovkostCost) and (Player.Pet.LovkostCost<>0) then
          SetAction('train',1)
        else
          UnsetAction('train');
      if sRadioGroup2.ItemIndex=3 then   // ���������� �����
        if (Player.Sera>=Player.Pet.MasterstvoCost) and (Player.Pet.MasterstvoCost<>0) then
          SetAction('train',1)
        else
          UnsetAction('train');
      if sRadioGroup2.ItemIndex=4 then   // ��������� �����
        if (Player.Sera>=Player.Pet.ZhivuchestCost) and (Player.Pet.ZhivuchestCost<>0) then
          SetAction('train',1)
        else
          UnsetAction('train');
    end;
  end;
  //// ���  /////////////////
  if (Player.Fights>0) and (Player.Health>=30) then
  begin
    if not Events.Pohod then
    begin
      if (sCheckBox2.Checked) or (Events.Vlad and sCheckBox22.Checked) then
        SetAction('fight',3)
      else
        UnsetAction('fight');
    end
    else
      UnsetAction('fight');
  end
  else
    UnsetAction('fight');
  //////// �����  ///////////////////
  if sCheckBox6.Checked and (not Events.Pohod) then
  begin
    if Player.ShahtaIsset then
    begin
      if (Events.Shahta and (not Events.Spusk)) or (not Events.Shahta) then
        SetAction('shahta',2)
      else
        UnsetAction('shahta');
    end
    else
      UnsetAction('shahta');
  end
  else
    UnsetAction('shahta');
  ///// �������������  /////////////
  if Confirm then
  begin
    GetElement(iElement,'a','��','');
    if iElement<>nil then
    begin
      iElement.click;
      exit;
    end;
  end;
  Zagrujeno:=true;   // �������� ���������
end;



{ TPlayer }

constructor TPlayer.Create;
begin
  Pet:=TPet.Create;
  Nagrab:=0;
  Lost:=0;
  NagrabKris:=0;
  LostKris:=0;
  PohodIsset:=true;
  ShahtaIsset:=true;
  MechShitSvitokIsset:=true;
  SvitkiTime:=0;
end;

///////////////////////////////////////////////////////////////////////
///////////// �������� ���� ���������� ��������� //////////////////
procedure TPlayer.GetTrainCost;
var
  i,j,j1: integer;
  iDoc: IHtmlDocument2;
  iDisp: IDispatch;
  iElement: IHTMLElement;
  Doc:IHTMLElementCollection;
  S,S1: string;
  buf,buf1:array[0..4] of integer;
begin
  iDoc := Form1.Webbrowser1.Document as IHtmlDocument2;
  Doc:=iDoc.all.tags('div') as IHTMLElementCollection;
  j:=0;
  j1:=0;
  for i := 1 to Doc.length do
  begin
    iDisp := Doc.item(pred(i), 0);
    iDisp.QueryInterface(IHTMLElement, iElement);
    S:='';
    if assigned(iElement) and (iElement.className='props') then
    begin
      S:=iElement.innerText;
      if Pos('����',S)<>0 then
      begin
        S1:=Copy(S,Pos('����',S)+16,15);
        S1:=Copy(S1,1,Pos('�������',S1)-2);
        buf[j]:=StrToInt(S1);
        inc(j);
      end;
      if Pos('�������:',S)<>0 then
      begin
        S1:=Copy(S,Pos('�������:',S)+9,6);
        S1:=Copy(S1,1,Pos(' ',S1)-1);
        buf1[j1]:=StrToInt(S1);
        inc(j1);
      end;
    end;
  end;
  SilaCost:=buf[0];
  ZashitaCost:=buf[1];
  LovkostCost:=buf[2];
  MasterstvoCost:=buf[3];
  ZhivuchestCost:=buf[4];
  Param.Sila:=buf1[0];
  Param.Zashita:=buf1[1];
  Param.Lovkost:=buf1[2];
  Param.Masterstvo:=buf1[3];
  Param.Zhivuchest:=buf1[4];
end;

{ TPet }


/////////////////////////////////////////////////////////////////////////////
//// �������� ���� ���������� ����� //////////////////////////////
procedure TPet.GetTrainCost;
var
  i,j,j1: integer;
  iDoc: IHtmlDocument2;
  iDisp: IDispatch;
  iElement: IHTMLElement;
  Doc:IHTMLElementCollection;
  S,S1: string;
  buf,buf1:array[0..4] of integer;
begin
  iDoc := Form1.Webbrowser1.Document as IHtmlDocument2;
  Doc:=iDoc.all.tags('div') as IHTMLElementCollection;
  j:=0;
  j1:=0;
  for i := 1 to Doc.length do
  begin
    iDisp := Doc.item(pred(i), 0);
    iDisp.QueryInterface(IHTMLElement, iElement);
    S:='';
    if assigned(iElement) and (iElement.className='props') then
    begin
      S:=iElement.innerText;
      if Pos('����',S)<>0 then
      begin
        S1:=Copy(S,Pos('����',S)+16,15);
        S1:=Copy(S1,1,Pos('�������',S1)-2);
        buf[j]:=StrToInt(S1);
        inc(j);
      end;
      if Pos('�������:',S)<>0 then
      begin
        S1:=Copy(S,Pos('�������:',S)+9,6);
        S1:=Copy(S1,1,Pos(' ',S1)-1);
        buf1[j1]:=StrToInt(S1);
        inc(j1);
      end;
    end;
  end;
  SilaCost:=buf[0];
  ZashitaCost:=buf[1];
  LovkostCost:=buf[2];
  MasterstvoCost:=buf[3];
  ZhivuchestCost:=buf[4];
  Param.Sila:=buf1[0];
  Param.Zashita:=buf1[1];
  Param.Lovkost:=buf1[2];
  Param.Masterstvo:=buf1[3];
  Param.Zhivuchest:=buf1[4];
end;

procedure TPet.GoToCell(inCell: boolean);
var
iElement:IHTMLElement;
begin
  Zagrujeno:=false;
  Form1.WebBrowser1.Navigate('http://'+SERVER+'/game/pet/');
  WaitEvent(Zagrujeno);
  if inCell then
    GetElement(iElement,'span','�������� � ������','body')
  else
    GetElement(iElement,'span','��������� �� ������','body');
  Zagrujeno:=false;
  if iElement<>nil then
    iElement.click;
  WaitEvent(Zagrujeno);
  UnsetAction('pet_in');
end;

{ Tth }



end.
