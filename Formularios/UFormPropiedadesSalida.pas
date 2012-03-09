unit UFormPropiedadesSalida;

{$mode objfpc}{$H+}

interface

uses
	SysUtils, Variants, Classes, Graphics, Controls,
	Forms, Dialogs, StdCtrls, Buttons, UObjetos;

type
  TformPropiedadesSalida = class(TForm)
    checkCaption: TCheckBox;
    checkBreackPoint: TCheckBox;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    editCaption: TEdit;
    checkTexto: TCheckBox;
    editParametros: TEdit;
    checkBloquear: TCheckBox;
    checkRetorno: TCheckBox;
    radioArchivo: TRadioButton;
    radioPantalla: TRadioButton;
    editArchivo: TEdit;
    procedure FormCreate(Sender: TObject);
  private
  public
		function Execute(AInstruction : TCommunication): Boolean;

		function ShowComments: Boolean;
		function ShowParameters: Boolean;
		function Comments: String;
		function Parameters: String;
		function BreckPoint: Boolean;
		function Locked: Boolean;
    function Device: TDevice;
    function FilePath: String;
    function CarriageReturn: Boolean;
  end;

var
  formPropiedadesSalida: TformPropiedadesSalida;

implementation

{$R *.dfm}

{ TformPropiedadesSalida }

function TformPropiedadesSalida.FilePath: String;
begin
  Result := trim(editArchivo.Text);
end;

function TformPropiedadesSalida.Locked: Boolean;
begin
  Result := checkBloquear.Checked;
end;

function TformPropiedadesSalida.BreckPoint: Boolean;
begin
  Result := checkBreackPoint.Checked;
end;

function TformPropiedadesSalida.Comments: String;
begin
  Result := editCaption.Text;
end;

function TformPropiedadesSalida.Device: TDevice;
begin
  if radioPantalla.Checked then
    Result := deScreen
  else
    Result := deFile;
end;

function TformPropiedadesSalida.Execute(AInstruction: TCommunication): Boolean;
begin
	editCaption.Text := AInstruction.Comments;
	editParametros.Text := AInstruction.Parameters;
	checkBreackPoint.Checked := AInstruction.BreakPoint;
	checkCaption.Checked := AInstruction.ShowComments;
	checkTexto.Checked := AInstruction.ShowParameters;
	checkBloquear.Checked := AInstruction.Locked;

  editArchivo.Text := AInstruction.FilePath;
  checkRetorno.Checked := AInstruction.CarriageReturn;
  radioPantalla.Checked := AInstruction.Device = deScreen;
	Result := Self.ShowModal = mrOk;
end;

function TformPropiedadesSalida.ShowComments: Boolean;
begin
  Result := checkCaption.checked;
end;

function TformPropiedadesSalida.ShowParameters: Boolean;
begin
  Result := checkTexto.Checked;
end;

function TformPropiedadesSalida.Parameters: String;
begin
  Result := editParametros.Text;
end;

function TformPropiedadesSalida.CarriageReturn: Boolean;
begin
  Result := checkRetorno.Checked;
end;

procedure TformPropiedadesSalida.FormCreate(Sender: TObject);
begin
	// TODO: Translate Components
end;

end.
