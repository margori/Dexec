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
		procedure SetTypeNumber(const Value: TTypeNumber);
		procedure SetDefaultValue(const Value: String);
		function GetName: String;
		function GetTypeNumber: TTypeNumber;
		function GetDefaultValue: String;
		function GetRows: Integer;
		function GetColumns: Integer;
		procedure SetRows(const Value: Integer);
		procedure SetColumns(const Value: Integer);
	public
		function Execute(ACaption : String; AInfoVariable : TVariableInformation): boolean;

    property VariableName : String read GetName write SetName;
    property TypeNumber : TTypeNumber read GetTypeNumber write SetTypeNumber;
    property DefaultValue : String read GetDefaultValue write SetDefaultValue;
    property Rows: Integer read GetRows write SetRows;
    property Columns: Integer read GetColumns write SetColumns;
	end;

var
  formPropiedadesVariables: TformPropiedadesVariables;

implementation

uses UValidadores;

{$R *.dfm}

{ TformPropiedadesVariables }

function TformPropiedadesVariables.Execute(ACaption : String;
  AInfoVariable: TVariableInformation): boolean;
var
  S : String;
begin
	Self.Caption := ACaption;
	VariableName := AInfoVariable.Name;
	TypeNumber := AInfoVariable.TypeNumber;
	DefaultValue := AInfoVariable.DefaultValue;
	Rows := AInfoVariable.Rows;
	Columns := AInfoVariable.Columns;

	FCanClose := True;
	Result := Self.ShowModal = mrOk;

  if Result then
    if editValorDefecto.Text='' then
    begin
      case TypeNumber of
        nInt32: editValorDefecto.Text := '0';
        nExte: editValorDefecto.Text := '0';
        nString: editValorDefecto.Text := '""';
      else
				raise Exception.Create('Not supported type!');
      end;
    end
    else
    begin
      S := DefaultValue;
      if (TypeNumber = nString)and(S[1]<>'"')and (S[Length(S)]<>'"') then
        DefaultValue := '"' + DefaultValue + '"';
    end;
end;

function TformPropiedadesVariables.GetName: String;
begin
  Result := Trim(editNombre.Text);
end;

function TformPropiedadesVariables.GetTypeNumber: TTypeNumber;
begin
	if radioEntero.Checked then
		Result := nInt32
	else if radioCadena.Checked then
		Result := nString
	else if radioReal.Checked then
		Result := nExte
{$ifdef debug}
	else
		raise Exception.Create(_('Debug: Error in radiogroup!'))
{$endif}
	;
end;

function TformPropiedadesVariables.GetDefaultValue: String;
begin
  Result := editValorDefecto.Text;
end;

procedure TformPropiedadesVariables.SetNombre(const Value: String);
begin
  editNombre.Text := Value;
end;

procedure TformPropiedadesVariables.SetTypeNumber(const Value: TTypeNumber);
begin
	case Value of
		nInt32: radioEntero.Checked := True;
		nString: radioCadena.Checked := True;
		nExte: radioReal.Checked := True;
	else
		radioEntero.Checked := True;
	end;
end;

procedure TformPropiedadesVariables.SetDefaultValue(
  const Value: String);
begin
	editValorDefecto.Text := Value;
end;

procedure TformPropiedadesVariables.FormShow(Sender: TObject);
begin
  editNombre.SetFocus;
end;

function TformPropiedadesVariables.GetRows: Integer;
begin
  Result := StrToInt(editFilas.Text);
end;

function TformPropiedadesVariables.GetColumns: Integer;
begin
  Result := StrToInt(editColumnas.Text);
end;

procedure TformPropiedadesVariables.SetRows(const Value: Integer);
begin
//  editFilas.Text := IntToStr(Value);
	updownFilas.Position := Value;
end;

procedure TformPropiedadesVariables.SetColumns(const Value: Integer);
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
	if not TValidadores.EsIdentificadorValido(VariableName) then
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
