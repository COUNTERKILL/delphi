program Project1;

uses
  Vcl.Forms, dialogs,
  Unit1 in 'Unit1.pas' {Form1};

{$R *.res}

begin
  ShowMessage('������, �����! :)');
  ShowMessage('�� ������������� ������ ������� Windows?))');
  ShowMessage('������?');
  ShowMessage('���� �������� Windows. ��� ������������� ������ ��');
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
