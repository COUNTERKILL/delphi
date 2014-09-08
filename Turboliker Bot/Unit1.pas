unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, sSkinManager, Vcl.StdCtrls, sLabel,
  sEdit, sButton, sGroupBox, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack,
  IdSSL, IdSSLOpenSSL, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP, sMemo, IdCookieManager, IdAntiFreezeBase,
  Vcl.IdAntiFreeze, Vcl.ExtCtrls, acImage, jpeg, sPanel, acSlider, sCheckBox,
  sRadioButton, sSpinEdit, ac;

type
  TForm1 = class(TForm)
    sGroupBox1: TsGroupBox;
    sButtonAuthorize: TsButton;
    sEditPass: TsEdit;
    sEditMail: TsEdit;
    sLabel1: TsLabel;
    sLabel2: TsLabel;
    sSkinManager1: TsSkinManager;
    http: TIdHTTP;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    IdCookieManager1: TIdCookieManager;
    sLabel3: TsLabel;
    sEditPassTurbo: TsEdit;
    IdAntiFreeze1: TIdAntiFreeze;
    sButtonStart: TsButton;
    sGroupBox2: TsGroupBox;
    MemoLog: TsMemo;
    sCheckBox1: TsCheckBox;
    sGroupBox3: TsGroupBox;
    sSliderLikes: TsSlider;
    sSliderPosts: TsSlider;
    sSliderGroups: TsSlider;
    sSliderFriends: TsSlider;
    sSliderComments: TsSlider;
    sRadioButtonLikes: TsRadioButton;
    sRadioButtonReposts: TsRadioButton;
    sRadioButtonGroups: TsRadioButton;
    sRadioButtonFriends: TsRadioButton;
    sRadioButtonComments: TsRadioButton;
    sButtonStop: TsButton;
    sGroupBox4: TsGroupBox;
    sImage1: TsImage;
    sEditCaptcha: TsEdit;
    sButtonCaptcha: TsButton;
    sGroupBox5: TsGroupBox;
    sDecimalSpinEdit1: TsDecimalSpinEdit;
    sLabel4: TsLabel;
    sGroupBox6: TsGroupBox;
    sLabelBalance: TsLabel;
    sCheckBoxAntigate: TsCheckBox;
    sEditAntigateKey: TsEdit;
    Antigate: TAC;
    sLabelCaptchaStatus: TsLabel;
    sLabelAntigateBalance: TsLabel;
    sEditRecordFromWall: TsEdit;
    sLabel5: TsLabel;
    procedure sButtonAuthorizeClick(Sender: TObject);
    procedure LoadCaptcha(id:string; var kod:string);
    function Authorize:boolean;
    procedure sButtonCaptchaClick(Sender: TObject);
    procedure sButtonStartClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sEditCaptchaKeyPress(Sender: TObject; var Key: Char);
    procedure sCheckBox1Click(Sender: TObject);
    procedure sSliderLikesChanging(Sender: TObject; var CanChange: Boolean);
    procedure sSliderPostsChanging(Sender: TObject; var CanChange: Boolean);
    procedure sSliderGroupsChanging(Sender: TObject; var CanChange: Boolean);
    procedure sSliderFriendsChanging(Sender: TObject; var CanChange: Boolean);
    procedure sSliderCommentsChanging(Sender: TObject; var CanChange: Boolean);
    procedure sButtonStopClick(Sender: TObject);
    procedure sCheckBoxAntigateClick(Sender: TObject);
    procedure sEditMailKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  TLog = class(TObject)
    procedure Add(str:string);
  end;

var
  Form1: TForm1;
  CaptchaEntered:boolean;
  Log:TLog;
  Started:boolean;
implementation

{$R *.dfm}

procedure Delay(mSec:Cardinal);
var
 TargetTime:Cardinal;
begin
  TargetTime:=GetTickCount+mSec;
  while TargetTime>GetTickCount do
  begin
    Application.ProcessMessages;
    sleep(3);
    if Application.Terminated then Exit;
  end;
end;

function TForm1.Authorize: boolean;
var
  res:string;
  ip_h:string;
  sTo:string;
  Send:TStringList;
  ProfileLink:string;
begin
  Result:=true;
  // ����������� ���������
  Log.Add('������� ����������� ���������');
  try
  res:=http.Get('http://vk.com/');
  res:=http.Get('http://oauth.vk.com/authorize?client_id=4150754&scope=friends&redirect_url=http://oauth.vk.com/blank.html&display=page&response_type=token');
  except
  end;
  ip_h:=Copy(res, Pos('name="ip_h',res)+19, 18);
  sTo:=Copy(res, Pos('name="to',res)+17, 152);
  Send:=TStringList.Create;
  Send.Add('ip_h='+ip_h);
  Send.Add('_origin=http://oauth.vk.com');
  Send.Add('to='+sTo);
  Send.Add('expire=0');
  Send.Add('email='+sEditMail.Text);
  Send.Add('pass='+sEditPass.Text);
  try
  res:=http.Post('https://login.vk.com:443/?act=login&soft=1', Send);
  except
  end;
  Send.Free;
  if Pos('logout', res)=0 then
  begin
    Log.Add('������ ����������� ���������');
    Result:=false;
    exit;
  end
  else
    Log.Add('�������� ����������� ���������');
  //Headers:=http.Response.RawHeaders.GetText();
  //account_id:=Copy(Headers, Pos('Set-Cookie: l=', Headers) + 14, Length(Headers));
  //account_id:=Copy(account_id, 1, Pos(';', account_id)-1);
  //Log.Lines.Add(account_id);
  try
  res:=http.Get('http://vk.com');
  except
  end;
  ProfileLink:=Copy(res,Pos('myprofile_wrap', res)+32, 100);
  ProfileLink:=Copy(ProfileLink, 1, Pos(#34, ProfileLink)-1);
  ProfileLink:='https://vk.com' + ProfileLink;
  // ����������� �� ������������
  Log.Add('������� ����������� TurboLiker');
  Send:=TStringList.Create;
  if sEditRecordFromWall.Text<>'' then
    Send.Add('link='+sEditRecordFromWall.Text)
  else
    Send.Add('link='+ProfileLink);
  try
  http.Post('http://turboliker.ru/login/get_profl_id.php', Send);
  except
  end;
  Send.Free;
  Send:=TStringList.Create;
  Send.Add('pass='+sEditPassTurbo.Text);
  try
  res:=http.Post('http://turboliker.ru/login/login_by_pass.php', Send);
  except
  end;
  Send.Free;
  try
  res:=http.Get('http://turboliker.ru/');
  except
  end;
  if Pos('���� ����������', res) = 0 then
  begin
    Log.Add('������ ����������� TurboLiker');
    Result:=false;
    exit;
  end
  else
    Log.Add('�������� ����������� TurboLiker');
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Log:=Tlog.Create;
  Started:=false;
end;


//------------------------------------------------------------------------------
// ������������� �����
//------------------------------------------------------------------------------
procedure TForm1.LoadCaptcha(id:string; var kod:string);
var
  f:TFileStream;
  e:boolean;
begin
  try
    if (StrToInt64(id)=0) then exit;
  except
    exit;
  end;
  sLabelCaptchaStatus.Caption:='������: �������������';
  {$I-}
  f:=TFileStream.Create('captcha.jpeg', fmCreate);
  e:=true;
  while e do
  begin
    f.Position:=0;
    try
    http.Get('http://vk.com/captcha.php?s=1&sid='+id, f);
    finally
      e:=false;
    end;
  end;
  f.Free;
  sImage1.Picture.LoadFromFile('captcha.jpeg');
  {$I+}
  CaptchaEntered:=false;
  if sCheckBoxAntigate.Checked then
  begin
    Antigate.Apikey:=sEditAntigateKey.Text;
    while not CaptchaEntered do
    begin
      kod:=Antigate.Recognize('captcha.jpeg');
      if Pos('ERROR', kod)=0 then
        CaptchaEntered:=true;
    end;
  end
  else
  begin
    sButtonCaptcha.Enabled:=true;
    sEditCaptcha.SetFocus;
    while not CaptchaEntered do
    begin
      Sleep(10);
      Application.ProcessMessages;
      if Application.Terminated then exit;
    end;
    kod:=sEditCaptcha.Text;
    sEditCaptcha.Text:='';
  end;
  sLabelCaptchaStatus.Caption:='������: ��� �����';
  sLabelAntigateBalance.Caption:='������ Antigate: '+Antigate.Getbalans(Antigate.Apikey);
end;

procedure TForm1.sButtonAuthorizeClick(Sender: TObject);
begin
  if not Authorize then exit;
  sButtonAuthorize.Enabled:=false;
  sButtonStart.Enabled:=true;
  sEditMail.Enabled:=false;
  sEditPass.Enabled:=false;
  sEditRecordFromWall.Enabled:=false;
  sEditPassTurbo.Enabled:=false;
end;

procedure TForm1.sButtonStartClick(Sender: TObject);
var
  res:string;
  Send:TStringList;
  link:string;
  user_id:string;
  checkId:string;
  table:string;
  buf:string;
  hash:string;
  captcha_id:string;
  captcha_key:string;
  CaptchaIsset:boolean;
  photo_id:string;
  object_id:string;
  from:string;
  IsWall:boolean;
  group_id:string;
  i:integer;
  r:integer;
  a:array[0..4] of integer;
  mess:string;
begin
  http.ReadTimeout:=20000;
  http.ConnectTimeout:=10000;
  sButtonStart.Enabled:=false;
  sButtonStop.Enabled:=true;
  Started:=true;
  while Started do
  begin
    // ���� ��������, �� �������� �������� ��������
    if sCheckBox1.Checked then
    begin
      r:=0;
      if sRadioButtonFriends.Enabled then
      begin
        a[r]:=3;
        inc(r);
      end;
      if sRadioButtonLikes.Enabled then
      begin
        a[r]:=0;
        inc(r);
      end;
      if sRadioButtonReposts.Enabled then
      begin
        a[r]:=1;
        inc(r);
      end;
      if sRadioButtonComments.Enabled then
      begin
        a[r]:=4;
        inc(r);
      end;
      if sRadioButtonGroups.Enabled then
      begin
        a[r]:=2;
        inc(r);
      end;
      if r=0 then
        break;
      randomize();
      r:=random(r);
      case a[r] of
        0: sRadioButtonLikes.Checked:=true;
        1:sRadioButtonReposts.Checked:=true;
        2:sRadioButtonGroups.Checked:=true;
        3:sRadioButtonFriends.Checked:=true;
        4:sRadioButtonComments.Checked:=true;
      end;
    end;
    Application.ProcessMessages;
    if Application.Terminated then exit;
    // ��������
    if sRadioButtonFriends.Checked then
    begin
      // �������� ��������� �������
      try
      res:=http.Get('http://turboliker.ru/index.php?page=frnd&tab=getFrnd');
      except
      end;
      // ������ ������
      buf:=Copy(res, Pos('gold', res)+6,10);
      sLabelBalance.Caption:='������: '+Copy(buf, 1, Pos('&', buf)-1); // ������� ������
      if Pos('����� �� �����������',res)<>0 then
      begin
        Log.Add('��������� ����� �� ��������');
        if not sCheckBox1.Checked then
          break
        else
        begin
          sRadioButtonFriends.Enabled:=false;
          sSliderFriends.SliderOn:=false;
          continue;
        end;
      end;
      // �������� ������� �� ������� �������
      table:=Copy(res, Pos('<table class',res), Length(res));
      table:=Copy(table,1,Pos('</table>',table)+8);
      // �������� ������� � ��� �������������
      buf:=Copy(table, Pos('onfrndchk(', table),50);
      buf:=Copy(buf, Pos(',',buf)+1, 50);
      checkId:=Copy(buf, 1, Pos(',',buf)-1);
      buf:=Copy(buf, Pos(',',buf)+1,50);
      user_id:=Copy(buf, 1, Pos(',', buf)-1);
      link:='http://vk.com/id'+user_id;
      Log.Add('����������� ��������');
      try
      res:=http.Get(link); // ��������� �� ��������
      except
      end;
      hash:=Copy(res, Pos('Profile.toggleFriend', res)+28, 18);
      if hash='' then
      begin
        Log.Add('������ ����������');
        continue;
      end;
      CaptchaIsset:=false;
      repeat
        Send:=TStringList.Create;
        Send.Add('act=add');
        Send.Add('al=1');
        Send.Add('from=profile');
        Send.Add('hash='+hash);
        Send.Add('mid='+user_id);
        if CaptchaIsset then
        begin
          Send.Add('captcha_key='+captcha_key);
          Send.Add('captcha_sid='+captcha_id);
          CaptchaIsset:=false;
        end;
        try
        res:=http.Post('http://vk.com/al_friends.php', Send);
        except
        end;
        Send.Free;
        if Pos('� ���������', res)<>0 then
        begin
          Log.Add('��������� ����� �� ������(vk)');
          if not sCheckBox1.Checked then
            break
          else
          begin
            sRadioButtonFriends.Enabled:=false;
            sSliderFriends.SliderOn:=false;
            continue;
          end;
        end;
        if res[Length(res)]='0' then
        begin
          CaptchaIsset:=true;
          buf:=Copy(res, Pos('>', res)+1, 50);
          buf:=Copy(buf, Pos('>', buf)+1, 50);
          buf:=Copy(buf, Pos('>', buf)+1, 50);
          buf:=Copy(buf, Pos('>', buf)+1, 50);
          buf:=Copy(buf, Pos('>', buf)+1, 50);
          captcha_id:=Copy(buf, 1, Pos('<', buf)-1);
          LoadCaptcha(captcha_id, captcha_key);
        end;
        if Application.Terminated then exit;
      until not CaptchaIsset;
      //  if res � ������� ���������
      try
      res:=http.Get('http://turboliker.ru/core/frnd_add.php?id='+checkId+'&user='+user_id);
      http.Get('http://turboliker.ru/core/frnd_list_pass.php?id='+checkId);
      except
      end;
      if (Length(res)>0) and (ansichar(res[1]) in ['0'..'9']) then
        Log.Add('���������')
      else
        Log.Add('�� ���������!');
      // ������������ ������� ���������
      Application.ProcessMessages;
      if Application.Terminated then exit;
    end;



    // �����
    if sRadioButtonLikes.Checked then
    begin
      // �������� ��������� �������
      try
      res:=http.Get('http://turboliker.ru/index.php?page=likes&limit=1');
      except
      end;
      // ������ ������
      buf:=Copy(res, Pos('gold', res)+6,10);
      sLabelBalance.Caption:='������: '+Copy(buf, 1, Pos('&', buf)-1); // ������� ������
      if Pos('����� �� �����',res)<>0 then
      begin
        Log.Add('��������� ����� �� �����');
        if not sCheckBox1.Checked then
          break
        else
        begin
          sRadioButtonLikes.Enabled:=false;
          sSliderLikes.SliderOn:=false;
          continue;
        end;
      end;
      if Pos('���� ���',res)<>0 then
      begin
        Log.Add('����� �����������');
        if not sCheckBox1.Checked then
        begin
          Delay(1000);
          continue;
        end
        else
        begin
          Delay(1000);
          continue;
        end;
      end;
      // �������� ������� �� ������� �������
      table:=Copy(res, Pos('<table class',res), Length(res));
      table:=Copy(table,1,Pos('</table>',table)+8);
      // �������� ������� � ��� �������������
      buf:=Copy(table, Pos('onclick="openWin', table)+20,50);
      buf:=Copy(buf, 1, Pos(#39,buf)-1);
      link:=buf;
      buf:=Copy(table, Pos('onclick="pass', table)+18);  // ��������� ������������
      buf:=Copy(buf, 1, Pos(' ', buf)-1);
      checkId:=buf;
      IsWall:=false;
      Log.Add('����������� ����');
      try
      res:=http.Get(link); // ��������� �� ��������
      except
      end;
      if Pos('wall',link)<>0 then    // ������
      begin
        IsWall:=true;
        buf:=Copy(res, Pos('wall.like(', res), 50);
        buf:=Copy(buf, Pos(',', buf)+3, 50);
        buf:=Copy(buf, 1, Pos(#39, buf)-1);
        hash:=buf;
        object_id:=Copy(link, Pos('wall', link), 50);
        from:='wall_one';
      end;
      if Pos('photo',link)<>0 then    // ����
      begin
        photo_id:=Copy(link, Pos('photo', link)+5,50);
        buf:=Copy(res, Pos('photo":"'+photo_id, res)+10, Length(res));
        buf:=Copy(buf, Pos(photo_id, buf), Length(res));
        hash:=Copy(buf, Pos('"hash"', buf)+8,18);
        object_id:='photo'+photo_id;
        from:='photo_viewer';
      end;
      if hash='' then
      begin
        Log.Add('������ ����������');
        try
        http.Get('http://turboliker.ru/core/likes_list_pass.php?id='+checkId);
        except
        end;
        continue;
      end;
      CaptchaIsset:=false;
      repeat
        Send:=TStringList.Create;
        Send.Add('act=a_do_like');
        Send.Add('al=1');
        Send.Add('from='+from);
        Send.Add('hash='+hash);
        Send.Add('object='+object_id);
        if IsWall then
          Send.Add('wall=1');
        if CaptchaIsset then
        begin
          Send.Add('captcha_key='+captcha_key);
          Send.Add('captcha_sid='+captcha_id);
          CaptchaIsset:=false;
        end;
        try
        res:=http.Post('http://vk.com/like.php', Send);
        except
        end;
        Send.Free;
        if Pos('����������', res)<>0 then
        begin
          Log.Add('������� ����� ������ (vk)');
          if not sCheckBox1.Checked then
            break
          else
          begin
            sRadioButtonLikes.Enabled:=false;
            sSliderLikes.SliderOn:=false;
            continue;
          end;
        end;
        if res[Length(res)]='0' then
        begin
          CaptchaIsset:=true;
          buf:=Copy(res, Pos('>', res)+1, 50);
          buf:=Copy(buf, Pos('>', buf)+1, 50);
          buf:=Copy(buf, Pos('>', buf)+1, 50);
          buf:=Copy(buf, Pos('>', buf)+1, 50);
          buf:=Copy(buf, Pos('>', buf)+1, 50);
          captcha_id:=Copy(buf, 1, Pos('<', buf)-1);
          LoadCaptcha(captcha_id, captcha_key);
        end;
        if Application.Terminated then exit;
      until not CaptchaIsset;
      //  if res � ������� ���������
      try
      res:=http.Get('http://turboliker.ru/core/likes_list_chek.php?id='+checkId);
      http.Get('http://turboliker.ru/core/likes_list_pass.php?id='+checkId);
      except
      end;
      if (Length(res)>0) and (ansichar(res[1]) in ['0'..'9']) then
        Log.Add('���������')
      else
        Log.Add('�� ���������!');
      Application.ProcessMessages;
      if Application.Terminated then exit;
    end;


    // ������
    if sRadioButtonGroups.Checked then
    begin
      // �������� ��������� �������
      try
      res:=http.Get('http://turboliker.ru/index.php?page=group&tab=getGroupWin&limit=1');
      except
      end;
      // ������ ������
      buf:=Copy(res, Pos('gold', res)+6,10);
      sLabelBalance.Caption:='������: '+Copy(buf, 1, Pos('&', buf)-1); // ������� ������
      if Pos('����� ��',res)<>0 then
      begin
        Log.Add('��������� ����� �� ������');
        if not sCheckBox1.Checked then
          break
        else
        begin
          sRadioButtonGroups.Enabled:=false;
          sSliderGroups.SliderOn:=true;
          continue;
        end;
      end;
      if Pos('���� ��� �����',res)<>0 then
      begin
        Log.Add('������ �����������');
        if not sCheckBox1.Checked then
        begin
          Delay(1000);
          continue;
        end
        else
        begin
          Delay(1000);
          continue;
        end;
      end;
      // �������� ������� �� ������� �������
      table:=Copy(res, Pos('<table class',res), Length(res));
      table:=Copy(table,1,Pos('</table>',table)+8);
      // �������� ������� � ��� �������������
      buf:=Copy(table, Pos('openGrWin(', table)+12,50);
      buf:=Copy(buf, 1, Pos(',',buf)-1);
      group_id:=buf;
      link:='http://vk.com/public'+group_id;
      buf:=Copy(table, Pos('ongrchk($(', table),50);
      buf:=Copy(buf, Pos(',', buf)+1,50);
      buf:=Copy(buf, 1, Pos(',', buf)-1);
      checkId:=buf;
      Log.Add('����������� ���� � ������');
      try
      res:=http.Get(link); // ��������� �� ��������
      except
      end;
      i:=Pos('Public.sharePage(',res);
      if i=0 then
        i:=Pos('Groups.enter(', res)+19;
      buf:=Copy(res, i, 50);
      buf:=Copy(buf, Pos(' ', buf)+2,50);
      hash:=Copy(buf, 1, Pos(#39, buf)-1);
      if hash='' then
      begin
        Log.Add('������ ����������');
        try
        http.Get('http://turboliker.ru/core/group_list_pass.php?id='+checkId);
        except
        end;
        continue;
      end;
      CaptchaIsset:=false;
      repeat
        Send:=TStringList.Create;
        Send.Add('act=enter');
        Send.Add('al=1');
        Send.Add('gid='+group_id);
        Send.Add('hash='+hash);
        if CaptchaIsset then
        begin
          Send.Add('captcha_key='+captcha_key);
          Send.Add('captcha_sid='+captcha_id);
          CaptchaIsset:=false;
        end;
        try
        res:=http.Post('http://vk.com/al_groups.php', Send);
        except
        end;
        Send.Free;
        if res[Length(res)]='0' then
        begin
          CaptchaIsset:=true;
          buf:=Copy(res, Pos('>', res)+1, 50);
          buf:=Copy(buf, Pos('>', buf)+1, 50);
          buf:=Copy(buf, Pos('>', buf)+1, 50);
          buf:=Copy(buf, Pos('>', buf)+1, 50);
          buf:=Copy(buf, Pos('>', buf)+1, 50);
          captcha_id:=Copy(buf, 1, Pos('<', buf)-1);
          LoadCaptcha(captcha_id, captcha_key);
        end;
        if Application.Terminated then exit;
      until not CaptchaIsset;
      //  if res � ������� ���������
      res:='';
      try
      res:=http.Get('http://turboliker.ru/core/group_add.php?bybt=1&id='+checkId);
      http.Get('http://turboliker.ru/core/group_list_pass.php?id='+checkId);
      except
      end;
      if (Length(res)>0) and (ansichar(res[1]) in ['0'..'9']) then
        Log.Add('���������')
      else
      begin
        Log.Add('�� ���������!');
        try
        http.Get('http://turboliker.ru/core/group_list_pass.php?id='+checkId);
        except
        end;
      end;
    end;



    // ����������� �� ����
    if sRadioButtonComments.Checked then
    begin
      // �������� ��������� �������
      try
      res:=http.Get('http://turboliker.ru/index.php?page=comm&tab=getCommSp');
      except
      end;
      // ������ ������
      buf:=Copy(res, Pos('gold', res)+6,10);
      sLabelBalance.Caption:='������: '+Copy(buf, 1, Pos('&', buf)-1); // ������� ������
      if Pos('����� ��',res)<>0 then
      begin
        Log.Add('��������� ����� �� ������������ �����������');
        if not sCheckBox1.Checked then
          break
        else
        begin
          sRadioButtonComments.Enabled:=false;
          sSliderComments.SliderOn:=false;
          continue;
        end;
      end;
      if Pos('���� ��� ���������',res)<>0 then
      begin
        Log.Add('����������� �����������');
        if not sCheckBox1.Checked then
        begin
          Delay(1000);
          continue;
        end
        else
        begin
          Delay(1000);
          continue;
        end;
      end;
      // �������� ������� �� ������� �������
      table:=Copy(res, Pos('<table class',res), Length(res));
      table:=Copy(table,1,Pos('</table>',table)+8);
      // �������� ������� � ��� �������������
      buf:=Copy(table, Pos('onclick="openWin', table)+20,50);
      buf:=Copy(buf, 1, Pos(#39,buf)-1);
      link:=buf;
      buf:=Copy(table, Pos('onclick="pass', table)+17,30);
      buf:=Copy(buf, 1, Pos(' ', buf)-1);
      checkId:=buf;
      buf:=Copy(res, Pos('����������', res)+79, 100);
      mess:=Copy(buf, 1, Pos('<', buf) -1);
      Log.Add('����������� ������������ �����������');
      try
      res:=http.Get(link); // ��������� �� ��������
      except
      end;
      if (Pos('wall',link)<>0) or (Pos('photo',link)=0) then    // ������
      begin
        Log.Add('��������');
        try
        http.Get('http://turboliker.ru/core/comm_list_pass.php?id='+checkId);
        except
        end;
        continue;
      end;
      if Pos('photo',link)<>0 then    // ����
      begin
        photo_id:=Copy(link, Pos('photo', link)+5,50);
        buf:=Copy(res, Pos('photo":"'+photo_id, res)+10, Length(res));
        buf:=Copy(buf, Pos('"comm"', buf), Length(buf));
        buf:=Copy(buf, Pos(photo_id, buf), Length(res));
        hash:=Copy(buf, Pos('"hash"', buf)+8,18);
      end;
      if hash='' then
      begin
        Log.Add('������ ����������');
        try
        http.Get('http://turboliker.ru/core/comm_list_pass.php?id='+checkId);
        except
        end;
        continue;
      end;
      CaptchaIsset:=false;
      repeat
        Send:=TStringList.Create;
        Send.Add('Message='+mess);
        Send.Add('act=post_comment');
        Send.Add('al=1');
        Send.Add('from_group');
        Send.Add('fromview=1');
        Send.Add('hash='+hash);
        Send.Add('photo='+photo_id);
        if CaptchaIsset then
        begin
          Send.Add('captcha_key='+captcha_key);
          Send.Add('captcha_sid='+captcha_id);
          CaptchaIsset:=false;
        end;
        try
        res:=http.Post('http://vk.com/al_photos.php', Send);
        except
        end;
        Send.Free;
        if (res[Length(res)]='0') and (res[Length(res)-1]='>') then
        begin
          CaptchaIsset:=true;
          buf:=Copy(res, Pos('>', res)+1, 50);
          buf:=Copy(buf, Pos('>', buf)+1, 50);
          buf:=Copy(buf, Pos('>', buf)+1, 50);
          buf:=Copy(buf, Pos('>', buf)+1, 50);
          buf:=Copy(buf, Pos('>', buf)+1, 50);
          captcha_id:=Copy(buf, 1, Pos('<', buf)-1);
          LoadCaptcha(captcha_id, captcha_key);
        end;
        if Application.Terminated then exit;
      until not CaptchaIsset;
      //  if res � ������� ���������
      try
      res:=http.Get('http://turboliker.ru/core/comm_list_check.php?id='+checkId);
      http.Get('http://turboliker.ru/core/comm_list_pass.php?id='+checkId);
      except
      end;
      if (length(res)<>0) AND (ansichar(res[1]) in ['0'..'9']) then
        Log.Add('���������')
      else
      begin
        Log.Add('�� ���������!');
        try
        http.Get('http://turboliker.ru/core/comm_list_pass.php?id='+checkId);
        except
        end;
      end;
      Application.ProcessMessages;
      if Application.Terminated then exit;
    end;
    Delay(StrToInt(sDecimalSpinEdit1.Text)*1000);
  end;
  sButtonStart.Enabled:=true;
  sButtonStop.Enabled:=false;
end;

procedure TForm1.sButtonStopClick(Sender: TObject);
begin
  sButtonStop.Enabled:=false;
  Started:=false;
end;

procedure TForm1.sCheckBox1Click(Sender: TObject);
begin
  if sCheckBox1.Checked then
  begin
    sSliderLikes.Visible:=true;
    sSliderPosts.Visible:=true;
    sSliderGroups.Visible:=true;
    sSliderFriends.Visible:=true;
    sSliderComments.Visible:=true;
  end
  else
  begin
    sSliderLikes.Visible:=false;
    sSliderPosts.Visible:=false;
    sSliderGroups.Visible:=false;
    sSliderFriends.Visible:=false;
    sSliderComments.Visible:=false;
  end;
end;

procedure TForm1.sCheckBoxAntigateClick(Sender: TObject);
begin
  if sCheckBoxAntigate.Checked then
  begin
    sEditAntigateKey.Enabled:=true;
    sEditCaptcha.Visible:=false;
    sButtonCaptcha.Visible:=false;
  end
  else
  begin
    sEditAntigateKey.Enabled:=false;
    sEditCaptcha.Visible:=true;
    sButtonCaptcha.Visible:=true;
  end;
end;



procedure TForm1.sEditCaptchaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    sButtonCaptcha.Click;
    Key:=#0;
  end;
end;

procedure TForm1.sEditMailKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    sButtonAuthorize.Click;
    Key:=#0;
  end;
end;

procedure TForm1.sSliderCommentsChanging(Sender: TObject;
  var CanChange: Boolean);
begin
  if not sSliderComments.SliderOn then
    sRadioButtonComments.Enabled:=true
  else
    sRadioButtonComments.Enabled:=false;
end;



procedure TForm1.sSliderFriendsChanging(Sender: TObject;
  var CanChange: Boolean);
begin
  if not sSliderFriends.SliderOn then
    sRadioButtonFriends.Enabled:=true
  else
    sRadioButtonFriends.Enabled:=false;
end;

procedure TForm1.sSliderGroupsChanging(Sender: TObject; var CanChange: Boolean);
begin
  if not sSliderGroups.SliderOn then
    sRadioButtonGroups.Enabled:=true
  else
    sRadioButtonGroups.Enabled:=false;
end;



procedure TForm1.sSliderLikesChanging(Sender: TObject; var CanChange: Boolean);
begin
 if not sSliderLikes.SliderOn then
    sRadioButtonLikes.Enabled:=true
 else
    sRadioButtonLikes.Enabled:=false;
end;



procedure TForm1.sSliderPostsChanging(Sender: TObject; var CanChange: Boolean);
begin
  if not sSliderPosts.SliderOn then
    sRadioButtonReposts.Enabled:=true
  else
    sRadioButtonReposts.Enabled:=false;
end;



procedure TForm1.sButtonCaptchaClick(Sender: TObject);
begin
  CaptchaEntered:=true;
  sButtonCaptcha.Enabled:=false;
end;

{ Log }

procedure TLog.Add(str: string);
var
  CurrentTime:string;
begin
  CurrentTime:=FormatDateTime('[hh:nn:ss] ',Time());
  Form1.MemoLog.Lines.Add(CurrentTime+str);
end;

end.
