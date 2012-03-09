unit UValores;

interface

uses UTipos;

type
	TValue = record
		ValueType: TTypeNumber;
		ValuePointer: Pointer;
	end;

  TValues = class
  public
    class function ToString(AValue: TValue): String;
    class function Parse(AString: String): TValue;
    class function ParseDef(AString: String; AValueType: TTypeNumber): TValue;

    class procedure SetValueType(var AValue : TValue; AValueType : integer);
    class procedure FreeValue(var AValue : TValue);
    class function Clone(AValue: TValue): TValue;

    class procedure Assign(AOrigin: TValue; ADestination: TValue);
  end;

const
	DEFAULT_VALUE : TValue = (ValueType : 0; ValuePointer: Nil);

implementation

uses Sysutils, UVariables, UEsTipo;

class procedure TValues.Assign( AOrigin: TValue; ADestination: TValue);
begin
  if (ADestination.ValueType = nString)and(AOrigin.ValueType = nString) then
    PString(ADestination.ValuePointer)^ := PString(AOrigin.ValuePointer)^
  else if (ADestination.ValueType = nInt32)and(AOrigin.ValueType = nInt32) then
    PInteger32(ADestination.ValuePointer)^ := PInteger32(AOrigin.ValuePointer)^
  else if (ADestination.ValueType = nExte)and(AOrigin.ValueType = nInt32) then
    PExte(ADestination.ValuePointer)^ := PInteger32(AOrigin.ValuePointer)^
  else if (ADestination.ValueType = nExte)and(AOrigin.ValueType = nExte) then
    PExte(ADestination.ValuePointer)^ := PExte(AOrigin.ValuePointer)^
  else
		raise Exception.Create('Not supported asignation!');
end;

class function TValues.Clone(AValue: TValue): TValue;
begin
	Result := DEFAULT_VALUE;
	SetValueType(Result, AValue.ValueType);
  case AValue.ValueType of
		nInt32 : PInteger32(Result.ValuePointer)^ := PInteger32(AValue.ValuePointer)^;
		nString : PString(Result.ValuePointer)^ := PString(AValue.ValuePointer)^;
		nExte : PExte(Result.ValuePointer)^ := PExte(AValue.ValuePointer)^;
{$ifdef debug}
	else
		raise Exception.Create('Debug: Data type not supported!');
{$endif}
	end;
end;

class function TValues.ToString(AValue: TValue): String;
begin
  if AValue.ValuePointer = Nil then
    Result := '-'
  else
    case AValue.ValueType of
      nInt32: Result := IntToStr(PInteger32(AValue.ValuePointer)^);
      nExte: Result := FloatToStr(PExte(AValue.ValuePointer)^);
      nString : Result := PString(AValue.ValuePointer)^;
{$ifdef debug}
		else
			raise Exception.Create('Debug: Data type error!');
{$endif}
		end;
end;

class function TValues.Parse(AString: String): TValue;
begin
	Result := DEFAULT_VALUE;
	AString := Trim(AString);
  if TEsTipo.Entero(AString) then
  begin
    SetValueType(Result, nInt32);
    PInteger32(Result.ValuePointer)^ := StrToInt(AString);
  end
  else if TEsTipo.Real(AString) then
  begin
    SetValueType(Result, nExte);
    PExte(Result.ValuePointer)^ := StrToFloat(AString);
  end
	else if TEsTipo.Cadena(AString) then
	begin
		SetValueType(Result, nString);
		PString(Result.ValuePointer)^ := Copy(AString,2,Length(AString)-2);
	end
	else
		raise Exception.Create('String unconvertible to value!');
end;

class function TValues.ParseDef(AString: String; AValueType : TTypeNumber): TValue;
begin
	Result := DEFAULT_VALUE;
	case AValueType of
		nInt32:
			begin
				SetValueType(Result, nInt32);
				try
					PInteger32(Result.ValuePointer)^ := StrToInt(AString);
				except
					FreeValue(Result);
					raise Exception.Create('Convertion error to integer type!');
				end;
			end;
		nExte:
			begin
				SetValueType(Result, nExte);
				try
					PExte(Result.ValuePointer)^ := StrToFloat(AString);
				except
					FreeValue(Result);
					raise Exception.Create('Convertion error to real type!');
				end;
			end;
		nString:
			begin
				SetValueType(Result, nString);
				try
					PString(Result.ValuePointer)^ := AString;
				except
					FreeValue(Result);
					raise;
				end;
			end;
	else
		raise Exception.Create('String unconvertible to value!');
	end;
end;

class procedure TValues.SetValueType(var AValue : TValue; AValueType : integer);
begin
	if AValue.ValueType <> AValueType then
	begin
		FreeValue(AValue);
		GetMem(AValue.ValuePointer, TTypes.SizeOfType(AValueType));

		case AValueType of
			nInt32 : PInteger32(AValue.ValuePointer)^ := 0;
			nExte : PExte(AValue.ValuePointer)^ := 0.0;
			nString : PString(AValue.ValuePointer)^ := '';
{$ifdef debug}
		else
			raise Exception.Create('Debug: Not supported type!');
{$endif}
		end;
		AValue.ValueType := AValueType;
	end;
end;

class procedure TValues.FreeValue(var AValue : TValue);
begin
	if (AValue.ValuePointer <> nil) then
	begin
{$ifdef DEBUG}
//		FillChar(V, SizeTipo(V.Tipo), 0);
{$endif}
		FreeMem(AValue.ValuePointer);
		AValue.ValuePointer := Nil;
	end;
end;

end.
