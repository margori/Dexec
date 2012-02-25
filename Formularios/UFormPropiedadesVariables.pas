unit UFormPropiedadesVariables;

{$mode objfpc}{$H+}

interface

uses
	SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, UVariables, UTipos, Buttons, ComCtrls;

type
  TformPropiedadesVariables = class(TForm)
    editNombre: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    editValorDefecto: TEdit;
    Label3: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    editFilas: TEdit;
    updownFilas: TUpDown;
    Label4: TLabel;
    Label5: TLabel;
    editColumnas: TEdit;
    updownColumnas: TUpDown;
    radioEntero: TRadioButton;
    radioCadena: TRadioButton;
    radioReal: TRadioButton;
		procedure FormShow(Sender: TObject);
		procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
		procedure radioEnteroClick(Sender: TObject);
		procedure radioRealClick(Sender: TObject);
		procedure radioCadenaClick(Sender: TObject);
		procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
	private
		FCanClose : Boolean;
		procedure SetNombre(const Value: String);
		procedure SetTipo(const Value: TTipo);
		procedure SetValorPorDefecto(const Value: String);
		function GetNombre: String;
		function GetTipo: TTipo;
		function GetValorPorDefecto: String;
		function GetFilas: Integer;
		function GetColumnas: Integer;
		procedure SetFilas(const Value: Integer);
		procedure SetColumnas(const Value: Integer);
	public
		function Execute(ACaption : String; AInfoVariable : TInfoVariable): boolean;

    property Nombre : String read GetNombre write SetNombre;
    property Tipo : TTipo read GetTipo write SetTipo;
    property ValorPorDefecto : String read GetValorPorDefecto write SetValorPorDefecto;
    property Filas: Integer read GetFilas write SetFilas;
    property Columnas: Integer read GetColumnas write SetColumnas;
	end;

var
  formPropiedadesVariables: TformPropiedadesVariables;

implementation

uses UValidadores;

{$R *.dfm}

{ TformPropiedadesVariables }

function TformPropiedadesVariables.Execute(ACaption : String;
  AInfoVariable: TInfoVariable): boolean;
var
  S : String;
begin
	Self.Caption := ACaption;
	Nombre := AInfoVariable.Nombre;
	Tipo := AInfoVariable.Tipo;
	ValorPorDefecto := AInfoVariable.ValorPorDefecto;
	Filas := AInfoVariable.Filas;
	Columnas := AInfoVariable.Columnas;

	FCanClose := True;
	Result := Self.ShowModal = mrOk;

  if Result then
    if editValorDefecto.Text='' then
    begin
      case Tipo of
        nInt32: editValorDefecto.Text := '0';
        nExte: editValorDefecto.Text := '0';
        nCad: editValorDefecto.Text := '""';
      else
				raise Exception.Create('Not supported type!');
      end;
    end
    else
    begin
      S := ValorPorDefecto;
      if (Tipo = nCad)and(S[1]<>'"')and (S[Length(S)]<>'"') then
        ValorPorDefecto := '"' + ValorPorDefecto + '"';
    end;
end;

function TformPropiedadesVariables.GetNombre: String;
begin
  Result := Trim(editNombre.Text);
end;

function TformPropiedadesVariables.GetTipo: TTipo;
begin
	if radioEntero.Checked then
		Result := nInt32
	else if radioCadena.Checked then
		Result := nCad
	else if radioReal.Checked then
		Result := nExte
{$ifdef debug}
	else
		raise Exception.Create(_('Debug: Error in radiogroup!'))
{$endif}
	;
end;

function TformPropiedadesVariables.GetValorPorDefecto: String;
begin
  Result := editValorDefecto.Text;
end;

procedure TformPropiedadesVariables.SetNombre(const Value: String);
begin
  editNombre.Text := Value;
end;

procedure TformPropiedadesVariables.SetTipo(const Value: TTipo);
begin
	case Value of
		nInt32: radioEntero.Checked := True;
		nCad: radioCadena.Checked := True;
		nExte: radioReal.Checked := True;
	else
		radioEntero.Checked := True;
	end;
end;

procedure TformPropiedadesVariables.SetValorPorDefecto(
  const Value: String);
begin
	editValorDefecto.Text := Value;
end;

procedure TformPropiedadesVariables.FormShow(Sender: TObject);
begin
  editNombre.SetFocus;
end;

function TformPropiedadesVariables.GetFilas: Integer;
begin
  Result := StrToInt(editFilas.Text);
end;

function TformPropiedadesVariables.GetColumnas: Integer;
begin
  Result := StrToInt(editColumnas.Text);
end;

procedure TformPropiedadesVariables.SetFilas(const Value: Integer);
begin
//  editFilas.Text := IntToStr(Value);
	updownFilas.Position := Value;
end;

procedure TformPropiedadesVariables.SetColumnas(const Value: Integer);
begin
//	editColumnas.Text := IntToStr(Value);
	upDownColumnas.Position := Value;
end;

procedure TformPropiedadesVariables.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
	CanClose := FCanClose;
	FCanClose := True;
end;

procedure TformPropiedadesVariables.radioEnteroClick(Sender: TObject);
begin
	editColumnas.Enabled := True;
	updownColumnas.Enabled := True;
//	editColumnas.Text := '1';
end;

procedure TformPropiedadesVariables.radioRealClick(Sender: TObject);
begin
	editColumnas.Enabled := True;
	updownColumnas.Enabled := True;
//	editColumnas.Text := '1';
end;

procedure TformPropiedadesVariables.radioCadenaClick(Sender: TObject);
begin
	editColumnas.Enabled := False;
	updownColumnas.Enabled := False;
//	editColumnas.Text := '255';
end;

procedure TformPropiedadesVariables.BitBtn1Click(Sender: TObject);
begin
	if not TValidadores.EsIdentificadorValido(Nombre) then
	begin
		FCanClose := False;
		MessageDlg('Invalid identifier.',mtError,[mbOk],-1);
	end
	else
		FCanClose := True;
end;

procedure TformPropiedadesVariables.FormCreate(Sender: TObject);
begin
	// TODO: Translate Components
end;

end.
