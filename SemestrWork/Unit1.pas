unit Unit1;
      //добавить вывод сообщения мимо/попал ипроверку на победу/проигрыш
interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, sSkinManager, Vcl.Imaging.jpeg,
  Vcl.ExtCtrls, Vcl.StdCtrls, sButton, sComboBox, Vcl.ComCtrls, sStatusBar,Inet,winsock2,
  sEdit, sLabel;

type
  /// <summary>
  /// Класс формы
  /// </summary>
  TForm1 = class(TForm)

    ///	<summary>
    ///	  Поле игрока
    ///	</summary>
    ImagePlayer: TImage;

    ///	<summary>
    ///	  Менеджер стилей формы
    ///	</summary>
    sSkinManager1: TsSkinManager;

    ///	<summary>
    ///	  Фоновое изображение
    ///	</summary>
    ImageBack: TImage;

    ///	<summary>
    ///	  Поле противника
    ///	</summary>
    ImageEnemy: TImage;

    ///	<summary>
    ///	  Переключатель типа игры
    ///	</summary>
    sComboBox1: TsComboBox;

    ///	<summary>
    ///	  Кнопка новой игры
    ///	</summary>
    sButton1: TsButton;

    ///	<summary>
    ///	  Нижняя панель статуса
    ///	</summary>
    sStatusBar1: TsStatusBar;

    ///	<summary>
    ///	  Лейбл IP
    ///	</summary>
    sLabel1: TsLabel;

    ///	<summary>
    ///	  Edit IP
    ///	</summary>
    sEdit1: TsEdit;

    ///	<summary>
    ///	  Логотип
    ///	</summary>
    ImageLogo: TImage;

    ///	<summary>
    ///	  Стартовый таймер
    ///	</summary>
    Timer1: TTimer;

    ///	<summary>
    ///	  Обрабатывает расстановку кораблей на поле игрока
    ///	</summary>
    ///	<param name="Sender">
    ///	  Объект, вызвавший метод
    ///	</param>
    procedure ImagePlayerClick(Sender: TObject);

    ///	<summary>
    ///	  Устанавливает IP и начальные значения переменных
    ///	</summary>
    ///	<param name="Sender">
    ///	  Объект, вызвавший метод
    ///	</param>
    procedure FormCreate(Sender: TObject);

    ///	<summary>
    ///	  Устанавливает флаг нажатия левой кнопки(левая или правая)
    ///	</summary>
    ///	<param name="Sender">
    ///	  Объект, вызвавший метод
    ///	</param>
    ///	<param name="Button">
    ///	  Кнопка мыши
    ///	</param>
    ///	<param name="Shift">
    ///	  Состояние клавиши Shift
    ///	</param>
    ///	<param name="X">
    ///	  Положение мыши X
    ///	</param>
    ///	<param name="Y">
    ///	  Положение мыши Y
    ///	</param>
    procedure ImagePlayerMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

    ///	<summary>
    ///	  Запуск новой игры
    ///	</summary>
    ///	<param name="Sender">
    ///	  Объект, вызвавший метод
    ///	</param>
    procedure sButton1Click(Sender: TObject);

    ///	<summary>
    ///	  Обрабатывает выстрелы в корабли противника
    ///	</summary>
    ///	<param name="Sender">
    ///	  Объект, вызвавший метод
    ///	</param>
    procedure ImageEnemyClick(Sender: TObject);

    ///	<summary>
    ///	  Устанавливает IP, если он записан в поле
    ///	</summary>
    ///	<param name="Sender">
    ///	  Объект, вызвавший метод
    ///	</param>
    procedure sEdit1Change(Sender: TObject);

    ///	<summary>
    ///	  Скрывает лого и запускает поток ожидания новой игры
    ///	</summary>
    ///	<param name="Sender">
    ///	  Объект, вызвавший метод
    ///	</param>
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  { Класс потока для принятия выстрела}
  /// <summary>
  /// Класс потока для принятия выстрела
  /// </summary>
  TRecvThr = class(TThread)
  private
    X,Y:integer;
    B:TBlocks;
    Ret:ansichar;
    Executed:boolean;
  protected
    ///	<summary>
    ///	  Тело потока принятия выстрела
    ///	</summary>
    procedure Execute;override;

    ///	<summary>
    ///	  Записывает результат выстрела
    ///	</summary>
    procedure WriteRes;

    ///	<summary>
    ///	  Читает блоки игрока в локальную переменную потока
    ///	</summary>
    procedure ReadBlocks;
  end;

  { Класс потока для принятия сообщения о том, что противник расставил корабли}
  /// <summary>
  /// Класс потока для принятия сообщения о том, что противник расставил корабли
  /// </summary>
  TSetedThr = class(TThread)
  protected
    ///	<summary>
    ///	  Тело потока ожидания расстановки кораблей противником
    ///	</summary>
    procedure Execute;override;

    ///	<summary>
    ///	  Записываем в глобальную переменную инфу, что корабли противника
    ///	  установлены
    ///	</summary>
    procedure WriteEnemySeted;
  end;

  { Класс потока для принятия сообщения о начале новой игры}
  /// <summary>
  /// Класс потока для принятия сообщения о начале новой игры
  /// </summary>
  TNewThr = class(TThread)
  protected
    ///	<summary>
    ///	  Тело потока ожидания запроса начала новой игры противником
    ///	</summary>
    procedure Execute;override;

    ///	<summary>
    ///	  Установка необходимых параметров для начала новой игры
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
  FirstClick:boolean; // true - нужно отправить сообщение о новой игре
  ShouldStart:boolean; // для таймера. Если true, нажать кнопку новой игры
  Clicked:boolean;
  ClickToEnemy: boolean;
  Field1: Integer;

implementation

{$R *.dfm}

procedure ReceiveNewGame;forward;
//==============================================================================
{ Создание квадратного блока
    X, Y от 1 до 10}
///<summary>
/// Создание квадратного блока
///</summary>
///	<param name="X">
///	  Координата X блока на поле. Принимает значения от 1 до 10
///	</param>
///	<param name="Y">
///	  Координата Y блока на поле. Принимает значения от 1 до 10
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
{ Создание блока подстреленной палубы на поле противника}
///<summary>
/// Создание блока подстреленной палубы на поле противника
///</summary>
///	<param name="X">
///	  Координата X блока на поле. Принимает значения от 1 до 10
///	</param>
///	<param name="Y">
///	  Координата Y блока на поле. Принимает значения от 1 до 10
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
{ Создание блока-промаха на поле противника}
///<summary>
/// Создание блока-промаха на поле противника
///</summary>
///	<param name="X">
///	  Координата X блока на поле. Принимает значения от 1 до 10
///	</param>
///	<param name="Y">
///	  Координата Y блока на поле. Принимает значения от 1 до 10
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
{Создание блока-промаха на поле игрока}
///<summary>
/// Создание блока-промаха на поле игрока
///</summary>
///	<param name="X">
///	  Координата X блока на поле. Принимает значения от 1 до 10
///	</param>
///	<param name="Y">
///	  Координата Y блока на поле. Принимает значения от 1 до 10
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
{ Количество подстреленных блоков на поле игрока}
///<summary>
/// Возвращает количество подстреленных блоков на поле игрока
///</summary>
///<returns>
///  Колличество подстреленных палуб
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
{ Количество подстреленных блоков на поле противника}
///<summary>
/// Количество подстреленных блоков на поле противника
///</summary>
///<returns>
///  Колличество подстреленных палуб
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
/// Игрок победил?
///</summary>
///<returns>
///  true - если игрок победил, false - иначе
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
/// Игрок проиграл?
///</summary>
///<returns>
///  true - если игрок победил, false - иначе
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
{ Новая игра. Сброс всех данных старой игры и первые ходы новой}
///<summary>
/// Новая игра. Сброс всех данных старой игры и первые ходы новой
///</summary>
procedure NewGame;
var
  i: Integer;
  j: Integer;
begin
  Clicked:=true;
  Form1.sStatusBar1.Panels[0].Text:='Статус: Расстановка кораблей';
  if RecvThr<>nil then // если не остановлен поток
    TerminateThread(RecvThr.Handle,0);
  RecvThr.Free;
  RecvThr:=nil;
  if NewThr<>nil then // если не остановлен поток
    TerminateThread(NewThr.Handle,0);
  NewThr.Free;
  NewThr:=nil;
  if NotSetedThr<>nil then // если не остановлен поток
    TerminateThread(NotSetedThr.Handle,0);
  NotSetedThr.Free;
  NotSetedThr:=nil;
  closesocket(SockServer); // закрываем сокет сервера
  if FirstClick then
    SendNew;
  Form1.sButton1.Enabled:=false; // запрещаем новую игру, т.к. это не имеет смысла
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
  //FirstClick:=false;  // зачем?
  if Form1.sComboBox1.ItemIndex=1 then
  begin
    NotSetedThr:=TSetedThr.Create(false);
    while not EnemySeted do
    begin
      Application.ProcessMessages; // даем возможность расставить корабли игроку
      if Application.Terminated then
        exit;
      Sleep(10);
    end;
    if Seted then
      Form1.sStatusBar1.Panels[0].Text:='Статус: Игра!';
    Hod:=true;
    Res:='p';
    while Res='p' do
    begin
      ClickToEnemy:=false; // нет нажатия на поле противника
      Received:=false;
      RecvThr:=TRecvThr.Create(false);
      while not Received do      // пока поток не примет данные первого выстрела
      begin
        Application.ProcessMessages;
        if Application.Terminated then
          exit;
        if ClickToEnemy then // если ударил первым
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
        Form1.sStatusBar1.Panels[0].Text:='Проигрыш!';
        Proigrysh:=true;
        ShowMessage('Вы проиграли!');
        Form1.sButton1.Enabled:=true;
        ReceiveNewGame;
        exit;
      end;
      Form1.sStatusBar1.Panels[0].Text:='Статус: Ваш ход';
    end;
    FirstClick:=true;
    Form1.sButton1.Enabled:=true;
  end;
end;

//==============================================================================
{ Ждет сообщения о начале новой игры и нажимает кнопку}
///<summary>
/// Ждет сообщения о начале новой игры и нажимает кнопку
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
  while not ShouldStart do // если начал игрок, то бесконечный
  begin                                  // цикл и после него кнопка не нажмется
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
{ Установка IP адреса противника для сетевого взаимодействия}
///<summary>
/// Установка IP адреса противника для сетевого взаимодействия
///</summary>
///	<param name="s">
///	  IP в строковом виде
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
{ Проверка, является ли строка IP адресом}
///<summary>
/// Проверка, является ли строка IP адресом
///</summary>
///	<param name="s">
///	  IP в строковом виде
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
{ Блок свободен для установки корабля(с учетом правил игры)}
///<summary>
/// Блок свободен для установки корабля(с учетом правил игры)
///</summary>
///	<param name="X">
///	  X - координата начального блока
///	</param>
///	<param name="Y">
///	  Y - координата начального блока
///	</param>
///	<param name="Orientation">
///   Ориентация корабля
///	</param>
///	<param name="Col">
///   Количество палуб
///	</param>
///<returns>
/// Можно ли поставить корабль?
///</returns>
function BlocksIsFree(X,Y:integer; Orientation:TOrientation;Col:integer):boolean;
var
  i,j:integer;
begin
  Result:=true;
  if Orientation=vertic then   // вертикальный корабль
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
if Orientation=horizont then     // горизонтальный корабль
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
{ Установить корабль указанного размера и положения}
///<summary>
/// Установить корабль указанного размера и положения
///</summary>
///	<param name="X">
///	  X - координата начального блока
///	</param>
///	<param name="Y">
///	  Y - координата начального блока
///	</param>
///	<param name="Orientation">
///   Ориентация корабля
///	</param>
///	<param name="Col">
///   Количество палуб
///	</param>
///<returns>
/// Установился ли корабль?
///</returns>
function SetShip(X,Y: integer; Orientation: TOrientation;Col: integer):boolean;
var
  i: integer;
begin
  Result:=true;
  if Orientation=vertic then  // вертикальный корабль
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
  if Orientation=horizont then    // горизонтальный корабль
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
{ Преобразовать координаты мыши на экране в координаты клетки на поле игрока}
///<summary>
/// Преобразовать координаты мыши на экране в координаты клетки на поле игрока
///</summary>
///	<param name="X">
///	  X - координата начального блока
///	</param>
///	<param name="Y">
///	  Y - координата начального блока
///	</param>
procedure GetCoords(var X,Y:integer);
begin
  // не вычитаем 30(граница с надписями), чтобы в итоге получилось число
  // от 1 до 10, а не от 0 до 9
  X:=(X-Form1.Left-8-Form1.ImagePlayer.Left) div 30;
  Y:=(Y-Form1.Top-30-Form1.ImagePlayer.Top) div 30;
end;

//------------------------------------------------------------------------------
{ Преобразовать координаты мыши на экране в координаты клетки на поле
  противника}
///<summary>
/// Преобразовать координаты мыши на экране в координаты клетки на поле
///  противника
///</summary>
///	<param name="X">
///	  X - координата клика мышью
///	</param>
///	<param name="Y">
///	  Y - координата клика мышью
///	</param>
procedure GetCoordsEnemy(var X,Y:integer);
begin
  // не вычитаем 30(граница с надписями), чтобы в итоге получилось число
  // от 1 до 10, а не от 0 до 9
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
  Hod:=false; // ход противника
  if Status='p' then
  begin
    CreateBlockFightEnemy(X,Y);
    Hod:=true;
    sButton1.Enabled:=true;
    if IsPlayerWin() then
    begin
      sStatusBar1.Panels[0].Text:='Победа!';
      Pobeda:=true;
      ShowMessage('Вы победили!');
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
      sStatusBar1.Panels[0].Text:='Статус: Ход противника';
      while not Received do      // пока поток не примет данные первого выстрела
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
        sStatusBar1.Panels[0].Text:='Проигрыш!';
        Proigrysh:=true;
        ShowMessage('Вы проиграли!');
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
  sStatusBar1.Panels[0].Text:='Статус: Ваш ход';
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
    // корабли не расставлены
    if not Seted then
      if MLeft then    // левая кнопка
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
              SendSeted; // сообщаем противнику
              if EnemySeted then
                sStatusBar1.Panels[0].Text:='Статус: Игра!'
              else
                sStatusBar1.Panels[0].Text:=
                  'Статус: Ожидание расстановки кораблей противником!'
            end;
        end;
      end
      else//правая кнопка
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
              SendSeted; // сообщаем противнику
              if EnemySeted then
                sStatusBar1.Panels[0].Text:='Статус: Игра!'
              else
                sStatusBar1.Panels[0].Text:=
                  'Статус: Ожидание расстановки кораблей противником!'
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
{ Читает блоки игрока в локальную переменную потока}

procedure TRecvThr.ReadBlocks;
var
  i,j:integer;
begin
  for i:=1 to 10 do
    for j:=1 to 10 do
      B[i,j]:=Blocks[i,j];
end;

//------------------------------------------------------------------------------
{ Записывает результат выстрела}

procedure TRecvThr.WriteRes;
begin
  Received:=true;
  Res:=Ret; // ответ противника(m,p или n) в глобальную переменную
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
{ Записываем в глобальную переменную инфу, что корабли противника установлены}

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
