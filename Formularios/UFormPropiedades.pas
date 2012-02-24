unit UFormPropiedades;

interface

uses
{$ifdef WINDOWS}
	Windows,
{$endif}
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
	Dialogs, StdCtrls, Buttons, ExtCtrls, UObjetos;

type

{ TFormPropiedades }

TFormPropiedades = class(TForm)
		checkBreackPoint: TCheckBox;
		btnOk: TBitBtn;
		btnCancel: TBitBtn;
		editCaption: TEdit;
		checkCaption: TCheckBox;
		checkTexto: TCheckBox;
		editTexto: TEdit;
		checkBloquear: TCheckBox;
procedure btnOkClick(Sender: TObject);
procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
	private
	public
		function Execute(AInstruccion : TInstruccion): Boolean;

		function MuestraCaption: Boolean;
		function MuestraTexto: Boolean;
		function Caption: String;
		function Texto: String;
		function BreckPoint: Boolean;
		function Bloquear: Boolean;
	end;

var
  FormPropiedades: TFormPropiedades;

implementation

{$R *.dfm}

{ TFormPropiedades }

function TFormPropiedades.Bloquear: Boolean;
begin
	Result := checkBloquear.Checked;
end;

function TFormPropiedades.BreckPoint: Boolean;
begin
	Result := checkBreackPoint.Checked;
end;

function TFormPropiedades.Caption: String;
begin
	Result := editCaption.Text;
end;

function TFormPropiedades.Execute(AInstruccion: TInstruccion): Boolean;
begin
	if AInstruccion is TNodo then
	begin
		Result := False;
		Exit;
	end;
	editCaption.Text := AInstruccion.Caption;
	editTexto.Text := AInstruccion.Texto;
	checkBreackPoint.Checked := AInstruccion.BreakPoint;
	checkCaption.Checked := AInstruccion.MuestraCaption;
	checkTexto.Checked := AInstruccion.MuestraTexto;
	checkBloquear.Checked := AInstruccion.Bloqueado;
	Result := Self.ShowModal = mrOk;
end;

procedure TFormPropiedades.FormShow(Sender: TObject);
begin
	editTexto.SetFocus;
	Left := (Screen.Width - Width) div 2;
	Top := (Screen.Height - Height) div 2;
end;

procedure TFormPropiedades.btnOkClick(Sender: TObject);
begin

end;

function TFormPropiedades.MuestraCaption: Boolean;
begin
	Result := checkCaption.Checked;
end;

function TFormPropiedades.MuestraTexto: Boolean;
begin
	Result := checkTexto.Checked;
end;

function TFormPropiedades.Texto: String;
begin
	Result := editTexto.Text;
end;

procedure TFormPropiedades.FormCreate(Sender: TObject);
begin
	// TODO: Translate components.
end;

end.