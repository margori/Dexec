unit UFunciones;

interface

uses Sysutils, UValores;

type
  TFunctionPointer = function(p: String): TValue;

	TFunction = record
		FunctionName : String;
		FunctionPointer : TFunctionPointer;
	end;

	TFunctions = class
	private
		FFunctions : array of TFunction;
	public
		constructor Create;
		destructor Destroy; override;

		procedure Add(ANombre: String; AValor: TFunctionPointer);
		procedure Remove(AName: String); overload;
		procedure Remove(Index: Integer); overload;
		procedure Clean;

		function GetFunction(AName : String): TFunction; overload;
		function GetFunction(Index : Integer): TFunction; overload;
		function IsFunction(S: String): Boolean;

    function Count : Integer;
	end;

var
	Functions : TFunctions;

const
  DEFAULT_FUNCTION : TFunction = (FunctionName : '';
    FunctionPointer : Nil);

implementation

uses UAnalizadores, UTipos;

{ TFunctions }

function TFunctions.Count: Integer;
begin
  Result := Length(FFunctions);
end;

constructor TFunctions.Create;
begin
  SetLength(FFunctions,0);
end;

procedure TFunctions.Remove(AName: String);
var
	j : integer;
begin
	for j := High(FFunctions) downto Low(FFunctions) do
	begin
		if FFunctions[j].FunctionName = AName  then
		begin
			SetLength(FFunctions,Length(FFunctions)-1);
			Break;
		end;
	end;
end;

procedure TFunctions.Remove(Index: Integer);
begin
	SetLength(FFunctions,Length(FFunctions)-1);
end;

procedure TFunctions.Clean;
begin
	while Length(FFunctions)>0 do
		Remove(0);
end;

destructor TFunctions.Destroy;
begin
	Clean;
  inherited;
end;

function TFunctions.IsFunction(S: String): Boolean;
var
	j : integer;
begin
	Result := False;
	for j := Low(FFunctions) to High(FFunctions) do
	begin
		if UpperCase(FFunctions[j].FunctionName) = UpperCase(S) then
		begin
			Result := True;
			Break;
		end;
	end;
end;

function TFunctions.GetFunction(AName: String): TFunction;
var
	j : integer;
begin
	for j := Low(FFunctions) to High(FFunctions) do
	begin
		if UpperCase(FFunctions[j].FunctionName) = UpperCase(AName) then
		begin
			Result := FFunctions[j];
			Break;
		end;
	end;
end;

function TFunctions.GetFunction(Index: Integer): TFunction;
begin
	Result := FFunctions[Index];
end;

procedure TFunctions.Add(ANombre: String; AValor: TFunctionPointer);
begin
	SetLength(FFunctions,Length(FFunctions)+1);
  FFunctions[High(FFunctions)] := DEFAULT_FUNCTION;
	with FFunctions[High(FFunctions)] do
	begin
		FunctionName := ANombre;
		FunctionPointer := AValor;
	end;
end;

//-------- Functions ------------//

function FuncSQR(P: string): TValue;
var
  LValor : TValue;
begin
	P := Trim(P);
	try
		LValor := TAnalyzers.Expression(P);
		Result := DEFAULT_VALUE;
		case LValor.ValueType of
			nInt32 :
			begin
				TValues.SetValueType(Result,nInt32);
				PInteger32(Result.ValuePointer)^ := PInteger32(LValor.ValuePointer)^ * PInteger32(LValor.ValuePointer)^;
			end;
			nExte :
			begin
				TValues.SetValueType(Result,nExte);
				PExte(Result.ValuePointer)^ := PExte(LValor.ValuePointer)^ * PExte(LValor.ValuePointer)^;
			end;
		else
			raise Exception.Create('Not supported parameter type!');
		end;
	finally
		TValues.FreeValue(LValor);
	end;
end;

function FuncSQRT(P: string): TValue;
var
	LValor : TValue;
begin
	P := Trim(P);
	try
		LValor := TAnalyzers.Expression(P);
		Result := DEFAULT_VALUE;
		case LValor.ValueType of
			nInt32 :
			begin
				if PInteger32(LValor.ValuePointer)^ < 0 then
					raise Exception.Create('Square root of negative number not supported!');
				TValues.SetValueType(Result,nExte);
				PExte(Result.ValuePointer)^ := Sqrt(PInteger32(LValor.ValuePointer)^);
			end;
			nExte :
			begin
				if PExte(LValor.ValuePointer)^ < 0 then
					raise Exception.Create('Square root of negative number not supported!');
				TValues.SetValueType(Result,nExte);
				PExte(Result.ValuePointer)^ := Sqrt(PExte(LValor.ValuePointer)^);
			end;
		else
			raise Exception.Create('Not supported parameter type!');
		end;
	finally
		TValues.FreeValue(LValor);
	end;
end;

function FuncAbs(P: string): TValue;
var
	LValor : TValue;
begin
	P := Trim(P);
	try
		LValor := TAnalyzers.Expression(P);
		Result := DEFAULT_VALUE;
		case LValor.ValueType of
			nInt32 :
			begin
				TValues.SetValueType(Result,nInt32);
				PInteger32(Result.ValuePointer)^ := Abs(PInteger32(LValor.ValuePointer)^);
			end;
			nExte :
			begin
				TValues.SetValueType(Result,nExte);
				PExte(Result.ValuePointer)^ := Abs(PExte(LValor.ValuePointer)^);
			end;
		else
			raise Exception.Create('Not supported parameter type!');
		end;
	finally
		TValues.FreeValue(LValor);
	end;
end;

function FuncSin(P: string): TValue;
var
	LValor : TValue;
begin
	P := Trim(P);
	try
		LValor := TAnalyzers.Expression(P);
		Result := DEFAULT_VALUE;
		case LValor.ValueType of
			nInt32 :
			begin
				TValues.SetValueType(Result,nExte);
				PExte(Result.ValuePointer)^ := Sin(PInteger32(LValor.ValuePointer)^);
			end;
			nExte :
			begin
				TValues.SetValueType(Result,nExte);
				PExte(Result.ValuePointer)^ := Sin(PExte(LValor.ValuePointer)^);
			end;
		else
			raise Exception.Create('Not supported parameter type!');
		end;
	finally
		TValues.FreeValue(LValor);
	end;
end;

function FuncCos(P: string): TValue;
var
	LValor : TValue;
begin
	P := Trim(P);
	try
		LValor := TAnalyzers.Expression(P);
		Result := DEFAULT_VALUE;
		case LValor.ValueType of
			nInt32 :
			begin
				TValues.SetValueType(Result,nExte);
				PExte(Result.ValuePointer)^ := Cos(PInteger32(LValor.ValuePointer)^);
			end;
			nExte :
			begin
				TValues.SetValueType(Result,nExte);
				PExte(Result.ValuePointer)^ := Cos(PExte(LValor.ValuePointer)^);
			end;
		else
			raise Exception.Create('Not supported parameter type!');
		end;
	finally
		TValues.FreeValue(LValor);
	end;
end;

function FuncTan(P: string): TValue;
var
	LValor : TValue;
begin
	P := Trim(P);
	try
		LValor := TAnalyzers.Expression(P);
		Result := DEFAULT_VALUE;
		case LValor.ValueType of
			nInt32 :
			begin
				if Cos(PInteger32(LValor.ValuePointer)^) = 0 then
					raise Exception.Create('Tangent not defined for angles = n * Pi + Pi / 2.');
				TValues.SetValueType(Result,nExte);
				PExte(Result.ValuePointer)^ := Sin(PInteger32(LValor.ValuePointer)^)/Cos(PInteger32(LValor.ValuePointer)^);
			end;
			nExte :
			begin
				if Cos(PExte(LValor.ValuePointer)^) = 0 then
					raise Exception.Create('Tangent not defined for angles = n * Pi + Pi / 2.');
				TValues.SetValueType(Result,nExte);
				PExte(Result.ValuePointer)^ := Sin(PExte(LValor.ValuePointer)^)/Cos(PExte(LValor.ValuePointer)^);
			end;
		else
			raise Exception.Create('Not supported parameter type!');
		end;
	finally
		TValues.FreeValue(LValor);
	end;
end;

function FuncArcTan(P: string): TValue;
var
	LValor : TValue;
begin
	P := Trim(P);
	try
		LValor := TAnalyzers.Expression(P);
		Result := DEFAULT_VALUE;
		case LValor.ValueType of
			nInt32 :
			begin
				TValues.SetValueType(Result,nExte);
				PExte(Result.ValuePointer)^ := ArcTan(PInteger32(LValor.ValuePointer)^);
			end;
			nExte :
			begin
				TValues.SetValueType(Result,nExte);
				PExte(Result.ValuePointer)^ := ArcTan(PExte(LValor.ValuePointer)^);
			end;
		else
			raise Exception.Create('Not supported parameter type!');
		end;
	finally
		TValues.FreeValue(LValor);
	end;
end;

function FuncLog(P: string): TValue;
var
	LValor : TValue;
begin
	P := Trim(P);
	try
		LValor := TAnalyzers.Expression(P);
		Result := DEFAULT_VALUE;
		case LValor.ValueType of
			nInt32 :
			begin
				if PInteger32(LValor.ValuePointer)^ <= 0 then
					raise Exception.Create('Logarithm of negative numbers not supported!');
				TValues.SetValueType(Result,nExte);
				PExte(Result.ValuePointer)^ := Ln(PInteger32(LValor.ValuePointer)^);
			end;
			nExte :
			begin
				if Cos(PExte(LValor.ValuePointer)^) = 0 then
					raise Exception.Create('Logarithm of negative numbers not supported!');
				TValues.SetValueType(Result,nExte);
				PExte(Result.ValuePointer)^ := Ln(PExte(LValor.ValuePointer)^);
			end;
		else
			raise Exception.Create('Not supported parameter type!');
		end;
	finally
		TValues.FreeValue(LValor);
	end;
end;

function FuncExp(P: string): TValue;
var
	LValor : TValue;
begin
	P := Trim(P);
	try
		LValor := TAnalyzers.Expression(P);
		Result := DEFAULT_VALUE;
		case LValor.ValueType of
			nInt32 :
			begin
				TValues.SetValueType(Result,nExte);
				PExte(Result.ValuePointer)^ := Exp(PInteger32(LValor.ValuePointer)^);
			end;
			nExte :
			begin
				TValues.SetValueType(Result,nExte);
				PExte(Result.ValuePointer)^ := Exp(PExte(LValor.ValuePointer)^);
			end;
		else
			raise Exception.Create('Not supported parameter type!');
		end;
	finally
		TValues.FreeValue(LValor);
	end;
end;

function FuncPi(P: string): TValue;
begin
	TValues.SetValueType(Result,nExte);
	PExte(Result.ValuePointer)^ := Pi;
end;

function FuncLength(P: string): TValue;
var
	LValor : TValue;
begin
	P := Trim(P);
	try
		LValor := TAnalyzers.Expression(P);
		Result := DEFAULT_VALUE;
		case LValor.ValueType of
			nString :
			begin
				TValues.SetValueType(Result,nInt32);
				PInteger32(Result.ValuePointer)^ := Length(PString(LValor.ValuePointer)^);
			end;
		else
			raise Exception.Create('Not supported parameter type!');
		end;
	finally
		TValues.FreeValue(LValor);
	end;
end;

function FuncUpCase(P: string): TValue;
var
	LValor : TValue;
begin
	P := Trim(P);
	try
		LValor := TAnalyzers.Expression(P);
		Result := DEFAULT_VALUE;
		case LValor.ValueType of
			nString :
			begin
				TValues.SetValueType(Result,nString);
				PString(Result.ValuePointer)^ := UpperCase(PString(LValor.ValuePointer)^);
			end;
		else
			raise Exception.Create('Not supported parameter type!');
		end;
	finally
		TValues.FreeValue(LValor);
	end;
end;

function FuncLoCase(P: string): TValue;
var
	LValor : TValue;
begin
	P := Trim(P);
	try
		LValor := TAnalyzers.Expression(P);
		Result := DEFAULT_VALUE;
		case LValor.ValueType of
			nString :
			begin
				TValues.SetValueType(Result,nString);
				PString(Result.ValuePointer)^ := LowerCase(PString(LValor.ValuePointer)^);
			end;
		else
			raise Exception.Create('Not supported parameter type!');
		end;
	finally
		TValues.FreeValue(LValor);
	end;
end;

function FuncTrim(P: string): TValue;
var
	LValor : TValue;
begin
	P := Trim(P);
	try
		LValor := TAnalyzers.Expression(P);
		Result := DEFAULT_VALUE;
		case LValor.ValueType of
			nString :
			begin
				TValues.SetValueType(Result,nString);
				PString(Result.ValuePointer)^ := Trim(PString(LValor.ValuePointer)^);
			end;
		else
			raise Exception.Create('Not supported parameter type!');
		end;
	finally
		TValues.FreeValue(LValor);
	end;
end;

function FuncCopy(P: string): TValue;
var
	LValor : TValue;
  LCadena : String;
  LInicio : Integer;
  LLargo : Integer;
  Aux : String;
begin
  Aux := Copy(P,1,Pos(#10#13,P)-1);
  Delete(P,1,Pos(#10#13,P)+1);
	try
		LValor := TAnalyzers.Expression(Aux);
    if LValor.ValueType<>nString then
			raise Exception.Create('String expected!');
    LCadena := PString(LValor.ValuePointer)^;
	finally
		TValues.FreeValue(LValor);
	end;

  Aux := Copy(P,1,Pos(#10#13,P)-1);
  Delete(P,1,Pos(#10#13,P)+1);
	try
		LValor := TAnalyzers.Expression(Aux);
    if LValor.ValueType<>nInt32 then
			raise Exception.Create('Integer number expected!');
    LInicio := PInteger32(LValor.ValuePointer)^;
	finally
		TValues.FreeValue(LValor);
	end;

  Aux := Copy(P,1,Pos(#10#13,P)-1);
  Delete(P,1,Pos(#10#13,P)+1);
	try
		LValor := TAnalyzers.Expression(Aux);
    if LValor.ValueType<>nInt32 then
			raise Exception.Create('Integer number expected!');
    LLargo := PInteger32(LValor.ValuePointer)^;
	finally
		TValues.FreeValue(LValor);
	end;

  if P<>'' then
    raise Exception.Create('Parameter expected!');

	TValues.SetValueType(Result,nString);
  PString(Result.ValuePointer)^ := Copy(LCadena,LInicio, LLargo);
end;

//-------- Functions ------------//

procedure FunctionInitialize;
begin
	Functions.Add('SQR',FuncSQR);
	Functions.Add('CUAD',FuncSQR);
	Functions.Add('SQRT',FuncSQRT);
	Functions.Add('RAIZ',FuncSQRT);

	Functions.Add('ABS',FuncAbs);

	Functions.Add('SIN',FuncSin);
	Functions.Add('SEN',FuncSin);
	Functions.Add('COS',FuncCos);
	Functions.Add('TAN',FuncTan);
	Functions.Add('ARCTAN',FuncArcTan);

	Functions.Add('LOG',FuncLog);
  Functions.Add('EXP',FuncExp);

  Functions.Add('PI',FuncPi);

  Functions.Add('LENGTH', FuncLength);
  Functions.Add('LARGO', FuncLength);

  Functions.Add('UPCASE', FuncUpCase);
  Functions.Add('MAYUS', FuncUpCase);

  Functions.Add('LOCASE', FuncUpCase);
  Functions.Add('MINUS', FuncUpCase);

  Functions.Add('TRIM', FuncTrim);
  Functions.Add('ARREGLAR', FuncTrim);

  Functions.Add('COPY', FuncCopy);
  Functions.Add('COPIAR', FuncCopy);
end;

initialization
	Functions := TFunctions.Create;

  FunctionInitialize;

finalization
	Functions.Free;

end.

