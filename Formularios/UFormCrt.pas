unit UFormCrt;

interface

uses
	SysUtils, Variants, Classes, Graphics, Controls, Forms,
	Dialogs, StdCtrls, UVariables, ExtCtrls;

type
	TformCrt = class(TForm)
		Memo1: TMemo;
		procedure FormCreate(Sender: TObject);
		procedure Memo1KeyPress(Sender: TObject; var Key: Char);
		procedure FormShow(Sender: TObject);
		procedure FormHide(Sender: TObject);
	private
		FCursorY: Integer;
		FCursorX: Integer;

		Buffer : String;
		Enter : Boolean;
		FLeyendo: Boolean;

		procedure SetCursorX(const Value: Integer);
		procedure SetCursorY(const Value: Integer);

		procedure WriteChar(C: Char);
		procedure SetLeyendo(const Value: Boolean);
	public
		procedure Cls;
		procedure Write(S: String);
		procedure Retorno;
		function Read: String;

		procedure Finalizar;

		property CursorX : Integer read FCursorX write SetCursorX;
		property CursorY : Integer read FCursorY write SetCursorY;

		property Leyendo : Boolean read FLeyendo write SetLeyendo;
	end;

var
	formCrt: TformCrt;

implementation

uses UTipos, UFormMain;

{$R *.dfm}

const
	Columnas = 80;
	Filas = 25;
	Letras : set of char = ['A'..'Z','a'..'z'];
	Numeros : set of char = ['0'..'9'];


procedure TformCrt.Cls;
var
	j : integer;
begin
	Memo1.Clear;
	for j := 1 to Filas do
		Memo1.Lines.Add(StringofChar(' ',Columnas));
	CursorX := 0;
	Cursory := 0;
end;

function TformCrt.Read: String;
begin

	Leyendo := True;
	Buffer := '';
	Enter := False;
	repeat
		Application.ProcessMessages;
	until Enter;
	Leyendo := False;
	Result := Buffer;
end;

procedure TformCrt.SetCursorX(const Value: Integer);
begin
	if FCursorX <> Value then
	begin
		FCursorX := Value;
		if FCursorX > Columnas - 1 then
		begin
			CursorX := 0;
			CursorY := CursorY + 1;
		end;
		Memo1.SelStart := (Columnas+2) * CursorY + FCursorX;
	end;
end;

procedure TformCrt.SetCursorY(const Value: Integer);
begin
	if FCursorY <> Value then
	begin
		FCursorY := Value;
		if FCursorY > Filas-1 then
		begin
			Memo1.Lines.Delete(0);
			Memo1.Lines.Add(StringOfChar(' ',Columnas));
			FCursorY := Filas - 1;
		end;
		Memo1.SelStart := (Columnas+2) * FCursorY + CursorX;
	end;
end;

procedure TformCrt.Write(S: String);
var
	Aux : String;
begin
	while S<>'' do
	begin
		Aux := Memo1.Lines[CursorY];
		if Length(S) + CursorX > Columnas then
		begin
			Aux := Copy(Aux,1,CursorX) + Copy(S,1,Columnas - CursorX);
			Assert(Length(Aux)=80);
			Delete(S,1,Columnas - CursorX);
			Memo1.Lines[CursorY] := Aux;
			CursorX := 0;
			CursorY := CursorY + 1;
		end
		else
		begin
			Aux := Copy(Aux,1,CursorX) + S + Copy(Aux,CursorX + Length(S),
				Columnas - CursorX - Length(S));
			Assert(Length(Aux)=80);
			Memo1.Lines[CursorY] := Aux;
			CursorX := CursorX + LEngth(S);
			S := '';
		end;
	end;
end;

procedure TformCrt.Retorno;
begin
	CursorX := 0;
	CursorY := CursorY + 1;
	if CursorY > Filas then
	begin
		Memo1.Lines.Delete(0);
		Memo1.Lines.Add(StringOfChar(' ',Columnas));
	end;
end;

procedure TformCrt.FormCreate(Sender: TObject);
begin
	Cls;
	Leyendo := False;
end;

procedure TformCrt.WriteChar(C: Char);
var
	s: string;
begin
	s := Memo1.Lines[CursorY];
	Assert(Length(S)=Columnas,'Columns mismatch!');

	s := Copy(s,1,CursorX) + C + Copy(s,CursorX+2,Length(S));

	Assert(Length(S)=Columnas,'Columns mismatch!');
	Memo1.Lines[CursorY] := s;
	CursorX := CursorX + 1;
	Memo1.SetFocus;
end;

procedure TformCrt.Memo1KeyPress(Sender: TObject; var Key: Char);
begin
	if Leyendo then
	begin
		if Key = #13 then // Enter
			Enter := True
		else
		if Key = #8 then // BackSpace
		begin
			if Length(Buffer)>0 then
			begin
				CursorX := CursorX - 1;
				WriteChar(' ');
				CursorX := CursorX - 1;
				Buffer := Copy(Buffer,1,Length(Buffer)-1);
			end;
		end
		else if Ord(Key)>=32 then
		begin
			Buffer := Buffer + Key;
			WriteChar(Key);
		end;
	end;
	Key := #0;
end;

procedure TformCrt.FormShow(Sender: TObject);
begin
  FormMain.Salida1.Checked := true;
  Memo1.SetFocus;
end;

procedure TformCrt.FormHide(Sender: TObject);
begin
  FormMain.Salida1.Checked := False;
end;

procedure TformCrt.Finalizar;
begin
	Leyendo := False;
end;

procedure TformCrt.SetLeyendo(const Value: Boolean);
begin
	Enter := True;
	FLeyendo := Value;

	if FLeyendo then
		Self.Caption := 'Output - reading'
	else
		Self.Caption := 'Output';
end;

end.
