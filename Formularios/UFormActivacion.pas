unit UFormActivacion;

interface

uses
	Messages, SysUtils, Variants, Classes, Graphics, Controls,
	Forms, Dialogs, StdCtrls, Buttons;

type
	TformActivacion = class(TForm)
		Label1: TLabel;
		editID: TEdit;
		Label2: TLabel;
		editActivacion: TEdit;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
		procedure btnCancelClick(Sender: TObject);
		procedure FormCreate(Sender: TObject);
		procedure btnOkClick(Sender: TObject);
	private
		{ Private declarations }
	public
		function Activado: Boolean;
	end;

var
	formActivacion: TformActivacion;

implementation

uses UFormMain;

{$R *.dfm}

const
{$I '..\codes.inc'}
	GNombre = 'act.txt';


procedure TformActivacion.btnCancelClick(Sender: TObject);
begin
	Application.Terminate;
end;

procedure TformActivacion.FormCreate(Sender: TObject);
begin
	// TODO: Translate Components
	editID.Text := ID;
end;

procedure TformActivacion.btnOkClick(Sender: TObject);
var
	LArchivo: TextFile;
begin
	editActivacion.Text := UpperCase(editActivacion.Text);
	if editActivacion.Text = ACT then
	begin
		AssignFile(LArchivo,GNombre);
		rewrite(LArchivo);
		Writeln(LArchivo,editActivacion.Text);
		closeFile(LArchivo);
		ModalResult := mrOk;
	end
	else
		MessageDlg('Activation code error!'),mtError,[mbOk],-1);
end;

function TformActivacion.Activado: Boolean;
var
	LArchivo : TextFile;
	S : String;
begin
	if FileExists(GNombre) then
	begin
		AssignFile(LArchivo,GNombre);
		Reset(LArchivo);
		readln(LArchivo,S);
		result := S = ACT;
	end
	else
		Result := False;
end;

end.