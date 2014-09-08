program BossFileToPvcScript;

{$APPTYPE CONSOLE}


uses
  System.SysUtils;

function GenPass:string;
const
  s = 'abcdefghijklmnopqrstuvwxyz1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ';
var
  i, num: integer;
begin
  Result:='';
  Randomize;
  num := 8;
  for i := 1 to num do
  Result := Result + s[random(length(s) + 1) + 1];
end;


function TranslitRus2Lat(const Str: string): string;
const
  RArrayL = '��������������������������������';
  RArrayU = '�����Ũ��������������������������';
  colChar = 33;
  arr: array[1..2, 1..ColChar] of string =
  (('a', 'b', 'v', 'g', 'd', 'e', 'yo', 'zh', 'z', 'i', 'y',
    'k', 'l', 'm', 'n', 'o', 'p', 'r', 's', 't', 'u', 'f',
    'kh', 'ts', 'ch', 'sh', 'shch', '', 'y', '', 'e', 'yu', 'ya'),
    ('A', 'B', 'V', 'G', 'D', 'E', 'Yo', 'Zh', 'Z', 'I', 'Y',
    'K', 'L', 'M', 'N', 'O', 'P', 'R', 'S', 'T', 'U', 'F',
    'Kh', 'Ts', 'Ch', 'Sh', 'Shch', '', 'Y', '', 'E', 'Yu', 'Ya'));
var
  i: Integer;
  LenS: Integer;
  p: integer;
  d: byte;
begin
  result := '';
  LenS := length(str);
  for i := 1 to lenS do
  begin
    d := 1;
    p := pos(str[i], RArrayL);
    if p=0 then
      p := pos(str[i], RArrayU);
    if p = 0 then
    begin
      p := pos(str[i], RArrayU);
      d := 2
    end;
    if p <> 0 then
      result := result + arr[d, p]
    else
      result := result + str[i]; //���� �� ������� �����, �� ����� ��������
  end;
end;

var
  fIn: text;
  fOut: text;
  str: string;
  Name, Family, Parent, Group: string;
  sOut:string;
begin
  // ��������� ����
  Assign(fIn, 'stud.csv');
  Reset(fIn);
  Assign(fOut, 'stud_out.csv');
  Rewrite(fOut);
  // ������ � ���������� � ������ ������
  while not Eof(fIn) do
  begin
    Readln(fIn, str);
    str:=Copy(str, Pos(';', str)+1, Length(str));
    Family:=Copy(str, 1, Pos(' ', str)-1);
    str:=Copy(str, Pos(' ', str)+1, Length(str));
    Name:=Copy(str, 1, Pos(' ', str)-1);
    str:=Copy(str, Pos(' ', str)+1, Length(str));
    Parent:=Copy(str, 1, Pos(';', str)-1);
    str:=Copy(str, Pos(';', str)+1, Length(str));
    Group:=Copy(str, 1, Pos(';', str)-1);
    sOut:=Family+';' + Name+';' + Parent+';'
      + TranslitRus2Lat(Family) + TranslitRus2Lat(Name[1])
      + TranslitRus2Lat(Parent[1]) + ';' + Group + ';' + GenPass;
    Writeln(fOut, sOut);
  end;
  Close(fIn);
  Close(fOut);
end.
