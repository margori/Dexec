unit UValores;

interface

uses UTipos;

type
	TValor = record
		Tipo: TTipo;
		Puntero: Pointer;
	end;

  TValores = class
  public
    class function ValorAString(V: TValor): String;
    class function StringAValor(S: String): TValor;
    class function StringAValorDef(S: String; ATipo: TTipo): TValor;

    class procedure SetValor(var AValor : TValor; ATipo : integer);
    class procedure FreeValor(var V : TValor);
    class function CopiarValor(V: TValor): TValor;

    class procedure Asignar(ADestino: TValor; AOrigen: TValor);
  end;

const
	VALOR_VACIO : Tvalor = (Tipo : 0;Puntero : Nil);

implementation

uses Sysutils, UVariables, UEsTipo;

class procedure TValores.Asignar(ADestino: TValor; AOrigen: TValor);
begin
  if (ADestino.Tipo = nCad)and(AOrigen.Tipo = nCad) then
    PCadena(ADestino.Puntero)^ := PCadena(AOrigen.Puntero)^
  else if (ADestino.Tipo = nInt32)and(AOrigen.Tipo = nInt32) then
    PInt32(ADestino.Puntero)^ := PInt32(AOrigen.Puntero)^
  else if (ADestino.Tipo = nExte)and(AOrigen.Tipo = nInt32) then
    PExte(ADestino.Puntero)^ := PInt32(AOrigen.Puntero)^
  else if (ADestino.Tipo = nExte)and(AOrigen.Tipo = nExte) then
    PExte(ADestino.Puntero)^ := PExte(AOrigen.Puntero)^
  else
		raise Exception.Create('Not supported asignation!');
end;

class function TValores.CopiarValor(V: TValor): TValor;
begin
	Result := VALOR_VACIO;
	SetValor(Result, V.Tipo);
  case V.Tipo of
		nInt32 : PInt32(Result.Puntero)^ := PInt32(V.Puntero)^;
		nCad : PCadena(Result.Puntero)^ := PCadena(V.Puntero)^;
		nExte : PExte(Result.Puntero)^ := PExte(V.Puntero)^;
{$ifdef debug}
	else
		raise Exception.Create('Debug: Data type not supported!');
{$endif}
	end;
end;

class function TValores.ValorAString(V: TValor): String;
begin
  if V.Puntero = Nil then
    Result := '-'
  else
    case V.Tipo of
      nInt32: Result := IntToStr(PInt32(V.Puntero)^);
      nExte: Result := FloatToStr(PExte(V.Puntero)^);
      nCad : Result := PCadena(V.Puntero)^;
{$ifdef debug}
		else
			raise Exception.Create('Debug: Data type error!');
{$endif}
		end;
end;

class function TValores.StringAValor(S: String): TValor;
begin
	Result := VALOR_VACIO;
	S := Trim(s);
  if TEsTipo.Entero(S) then
  begin
    SetValor(Result, nInt32);
    PInt32(Result.Puntero)^ := StrToInt(S);
  end
  else if TEsTipo.Real(S) then
  begin
    SetValor(Result, nExte);
    PExte(Result.Puntero)^ := StrToFloat(S);
  end
	else if TEsTipo.Cadena(S) then
	begin
		SetValor(Result, nCad);
		PCadena(Result.Puntero)^ := Copy(S,2,Length(S)-2);
	end
	else
		raise Exception.Create('String unconvertible to value!');
end;

class function TValores.StringAValorDef(S: String; ATipo : TTipo): TValor;
begin
	Result := VALOR_VACIO;
	case ATipo of
		nInt32:
			begin
				SetValor(Result, nInt32);
				try
					PInt32(Result.Puntero)^ := StrToInt(S);
				except
					FreeValor(Result);
					raise Exception.Create('Convertion error to integer type!');
				end;
			end;
		nExte:
			begin
				SetValor(Result, nExte);
				try
					PExte(Result.Puntero)^ := StrToFloat(S);
				except
					FreeValor(Result);
					raise Exception.Create('Convertion error to real type!');
				end;
			end;
		nCad:
			begin
				SetValor(Result, nCad);
				try
					PCadena(Result.Puntero)^ := S;
				except
					FreeValor(Result);
					raise;
				end;
			end;
	else
		raise Exception.Create('String unconvertible to value!');
	end;
end;

class procedure TValores.SetValor(var AValor : TValor; ATipo : integer);
begin
	if AValor.Tipo <> Atipo then
	begin
		FreeValor(AValor);
		GetMem(AValor.Puntero, TTipos.SizeTipo(ATipo));

		case ATipo of
			nInt32 : PInt32(AValor.Puntero)^ := 0;
			nExte : PExte(AValor.Puntero)^ := 0.0;
			nCad : PCadena(AValor.Puntero)^ := '';
{$ifdef debug}
		else
			raise Exception.Create('Debug: Not supported type!');
{$endif}
		end;
		AValor.tipo := ATipo;
	end;
end;

class procedure TValores.FreeValor(var V : TValor);
begin
	if (V.Puntero <> nil) then
	begin
{$ifdef DEBUG}
//		FillChar(V, SizeTipo(V.Tipo), 0);
{$endif}
		FreeMem(V.Puntero);
		V.Puntero := Nil;
	end;
end;

end.