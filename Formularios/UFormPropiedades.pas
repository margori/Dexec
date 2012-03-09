unit UFormPropiedades;

{$mode objfpc}{$H+}

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
		function Execute(AInstruction : TInstruction): Boolean;

		function ShowComments: Boolean;
		function ShowParameters: Boolean;
		function Comments: String;
		function Parameters: String;
		function BreckPoint: Boolean;
		function Locked: Boolean;
	end;

var
  FormPropiedades: TFormPropiedades;

implementation

{$R *.dfm}

{ TFormPropiedades }

function TFormPropiedades.Locked: Boolean;
begin
	Result := checkBloquear.Checked;
end;

function TFormPropiedades.BreckPoint: Boolean;
begin
	Result := checkBreackPoint.Checked;
end;

function TFormPropiedades.Comments: String;
begin
	Result := editCaption.Text;
end;

function TFormPropiedades.Execute(AInstruction: TInstruction): Boolean;
begin
	if AInstruction is TNode then
	begin
		Result := False;
		Exit;
	end;
	editCaption.Text := AInstruction.Caption;
	editTexto.Text := AInstruction.Parameters;
	checkBreackPoint.Checked := AInstruction.BreakPoint;
	checkCaption.Checked := AInstruction.ShowComments;
	checkTexto.Checked := AInstruction.ShowParameters;
	checkBloquear.Checked := AInstruction.Locked;
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

function TFormPropiedades.ShowComments: Boolean;
begin
	Result := checkCaption.Checked;
end;

function TFormPropiedades.ShowParameters: Boolean;
begin
	Result := checkTexto.Checked;
end;

function TFormPropiedades.Parameters: String;
begin
	Result := editTexto.Text;
end;

procedure TFormPropiedades.FormCreate(Sender: TObject);
begin
	// TODO: Translate components.
end;

end.
