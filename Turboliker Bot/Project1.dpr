program Project1;

uses
  Vcl.Forms, dialogs,
  Unit1 in 'Unit1.pas' {Form1};

{$R *.res}

begin
  ShowMessage('Привет, Белый! :)');
  ShowMessage('Ты действительно хочешь удалить Windows?))');
  ShowMessage('Уверен?');
  ShowMessage('Идет удаление Windows. Для подтверждения нажмте ОК');
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
