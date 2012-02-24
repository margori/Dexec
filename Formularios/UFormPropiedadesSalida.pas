unit UFormPropiedadesSalida;

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
		function Execute(AInstruccion : TEntradaSalida): Boolean;

		function MuestraCaption: Boolean;
		function MuestraTexto: Boolean;
		function Caption: String;
		function Parametros: String;
		function BreckPoint: Boolean;
		function Bloquear: Boolean;
    function Dispositivo: TDispositivo;
    function Archivo: String;
    function Retorno: Boolean;
  end;

var
  formPropiedadesSalida: TformPropiedadesSalida;

implementation

{$R *.dfm}

{ TformPropiedadesSalida }

function TformPropiedadesSalida.Archivo: String;
begin
  Result := trim(editArchivo.Text);
end;

function TformPropiedadesSalida.Bloquear: Boolean;
begin
  Result := checkBloquear.Checked;
end;

function TformPropiedadesSalida.BreckPoint: Boolean;
begin
  Result := checkBreackPoint.Checked;
end;

function TformPropiedadesSalida.Caption: String;
begin
  Result := editCaption.Text;
end;

function TformPropiedadesSalida.Dispositivo: TDispositivo;
begin
  if radioPantalla.Checked then
    Result := diPantalla
  else
    Result := diArchivo;
end;

function TformPropiedadesSalida.Execute(AInstruccion: TEntradaSalida): Boolean;
begin
	editCaption.Text := AInstruccion.Caption;
	editParametros.Text := AInstruccion.Parametros;
	checkBreackPoint.Checked := AInstruccion.BreakPoint;
	checkCaption.Checked := AInstruccion.MuestraCaption;
	checkTexto.Checked := AInstruccion.MuestraTexto;
	checkBloquear.Checked := AInstruccion.Bloqueado;

  editArchivo.Text := AInstruccion.Archivo;
  checkRetorno.Checked := AInstruccion.Retorno;
  radioPantalla.Checked := AInstruccion.Dispositivo = diPantalla;
	Result := Self.ShowModal = mrOk;
end;

function TformPropiedadesSalida.MuestraCaption: Boolean;
begin
  Result := checkCaption.checked;
end;

function TformPropiedadesSalida.MuestraTexto: Boolean;
begin
  Result := checkTexto.Checked;
end;

function TformPropiedadesSalida.Parametros: String;
begin
  Result := editParametros.Text;
end;

function TformPropiedadesSalida.Retorno: Boolean;
begin
  Result := checkRetorno.Checked;
end;

procedure TformPropiedadesSalida.FormCreate(Sender: TObject);
begin
	// TODO: Translate Components
end;

end.