unit UFormPropiedadesArchivos;

{$mode objfpc}{$H+}

interface

uses
	SysUtils, Variants, Classes, Graphics, Controls, Forms,
	Dialogs, Buttons, StdCtrls, UArchivos;

type
	TformPropiedadesArchivos = class(TForm)
		Label1: TLabel;
		editRuta: TEdit;
		btnExaminar: TButton;
		Label2: TLabel;
		comboAcceso: TComboBox;
		btnOk: TBitBtn;
		btnCancel: TBitBtn;
		SaveDialog1: TSaveDialog;
    editNombre: TEdit;
    Label3: TLabel;
		procedure btnExaminarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
	private
		function GetAcceso: TAcceso;
		function GetRuta: String;
		procedure SetAcceso(const Value: TAcceso);
		procedure SetRuta(const Value: String);
		procedure SetNombre(const Value: String);
    function GetNombre: String;
	public
		function Execute(ACaption : String; AInfoArchivo : TInfoArchivo): boolean;

		property Nombre : String read GetNombre write SetNombre;
		property Ruta : String read GetRuta write SetRuta;
		property Acceso : TAcceso read GetAcceso write SetAcceso;
	end;

var
	formPropiedadesArchivos: TformPropiedadesArchivos;

implementation

{$R *.dfm}

{ TformPropiedadesArchivos }

function TformPropiedadesArchivos.Execute(ACaption: String;
  AInfoArchivo: TInfoArchivo): boolean;
begin
	Self.Caption := ACaption;
	Self.Nombre := AInfoArchivo.Nombre;
	Self.Ruta := AInfoArchivo.Ruta;
	Self.Acceso := AInfoArchivo.Acceso;
	Result := Self.ShowModal = mrOk;
end;

function TformPropiedadesArchivos.GetAcceso: TAcceso;
begin
	case comboAcceso.ItemIndex of
		0 : Result :=  Lectura;
		1 : Result :=  Reescritura;
		2 : Result :=  Escritura;
{$ifdef debug}
	else
		raise Exception.Create(_('Error in combobox.'));
{$endif}
	end;
end;

function TformPropiedadesArchivos.GetRuta: String;
begin
	Result := editRuta.Text;
end;

procedure TformPropiedadesArchivos.SetAcceso(const Value: TAcceso);
begin
	comboAcceso.ItemIndex := Ord(Value);
end;

procedure TformPropiedadesArchivos.SetRuta(const Value: String);
begin
	editRuta.Text := Value;
end;

procedure TformPropiedadesArchivos.btnExaminarClick(Sender: TObject);
begin
	SaveDialog1.FileName := Self.Ruta;
	if SaveDialog1.Execute then
		Self.Ruta := SaveDialog1.FileName;
end;

procedure TformPropiedadesArchivos.SetNombre(const Value: String);
begin
	editNombre.Text := Value;
end;

function TformPropiedadesArchivos.GetNombre: String;
begin
	Result := Trim(editNombre.Text);
end;


procedure TformPropiedadesArchivos.FormCreate(Sender: TObject);
begin
	// TODO: Translate Components
end;

end.
