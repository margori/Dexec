unit UFunciones;

interface

uses Sysutils, UValores;

type
  TFuncionValor = function(p: String): TValor;

	TFuncion = record
		Nombre : String;
		Valor : TFuncionValor;
	end;

	TFunciones = class
	private
		FFunciones : array of TFuncion;
	public
		constructor Create;
		destructor Destroy; override;

		procedure Registrar(ANombre: String; AValor: TFuncionValor);
		procedure Deregistrar(ANombre: String); overload;
		procedure Deregistrar(Index: Integer); overload;
		procedure DeregistrarTodo;

		function Funcion(ANombre : String): TFuncion; overload;
		function Funcion(Index : Integer): TFuncion; overload;
		function EsFuncion(S: String): Boolean;

    function Count : Integer;
	end;

var
	Funciones : TFunciones;

const
  FUNCION_VACIA : TFuncion = (Nombre : '';
    Valor : Nil);

implementation

uses UAnalizadores, UTipos;

{ TFunciones }

function TFunciones.Count: Integer;
begin
  Result := Length(FFunciones);
end;

constructor TFunciones.Create;
begin
  SetLength(FFunciones,0);
end;

procedure TFunciones.Deregistrar(ANombre: String);
var
	j : integer;
begin
	for j := High(FFunciones) downto Low(FFunciones) do
	begin
		if FFunciones[j].Nombre = ANombre  then
		begin
			SetLength(FFunciones,Length(FFunciones)-1);
			Break;
		end;
	end;
end;

procedure TFunciones.Deregistrar(Index: Integer);
begin
	SetLength(FFunciones,Length(FFunciones)-1);
end;

procedure TFunciones.DeregistrarTodo;
begin
	while Length(FFunciones)>0 do
		Deregistrar(0);
end;

destructor TFunciones.Destroy;
begin
	DeregistrarTodo;
  inherited;
end;

function TFunciones.EsFuncion(S: String): Boolean;
var
	j : integer;
begin
	Result := False;
	for j := Low(FFunciones) to High(FFunciones) do
	begin
		if UpperCase(FFunciones[j].Nombre) = UpperCase(S) then
		begin
			Result := True;
			Break;
		end;
	end;
end;

function TFunciones.Funcion(ANombre: String): TFuncion;
var
	j : integer;
begin
	for j := Low(FFunciones) to High(FFunciones) do
	begin
		if UpperCase(FFunciones[j].Nombre) = UpperCase(ANombre) then
		begin
			Result := FFunciones[j];
			Break;
		end;
	end;
end;

function TFunciones.Funcion(Index: Integer): TFuncion;
begin
	Result := FFunciones[Index];
end;

procedure TFunciones.Registrar(ANombre: String; AValor: TFuncionValor);
begin
	SetLength(FFunciones,Length(FFunciones)+1);
  FFunciones[High(FFunciones)] := FUNCION_VACIA;
	with FFunciones[High(FFunciones)] do
	begin
		Nombre := ANombre;
		Valor := AValor;
	end;
end;

//-------- Funciones ------------//

function FuncSQR(P: string): TValor;
var
  LValor : TValor;
begin
	P := Trim(P);
	try
		LValor := TAnalizadores.Expresion(P);
		Result := VALOR_VACIO;
		case LValor.Tipo of
			nInt32 :
			begin
				TValores.SetValor(Result,nInt32);
				PInt32(Result.Puntero)^ := PInt32(LValor.Puntero)^ * PInt32(LValor.Puntero)^;
			end;
			nExte :
			begin
				TValores.SetValor(Result,nExte);
				PExte(Result.Puntero)^ := PExte(LValor.Puntero)^ * PExte(LValor.Puntero)^;
			end;
		else
			raise Exception.Create('Not supported parameter type!');
		end;
	finally
		TValores.FreeValor(LValor);
	end;
end;

function FuncSQRT(P: string): TValor;
var
	LValor : TValor;
begin
	P := Trim(P);
	try
		LValor := TAnalizadores.Expresion(P);
		Result := VALOR_VACIO;
		case LValor.Tipo of
			nInt32 :
			begin
				if PInt32(LValor.Puntero)^ < 0 then
					raise Exception.Create('Square root of negative number not supported!');
				TValores.SetValor(Result,nExte);
				PExte(Result.Puntero)^ := Sqrt(PInt32(LValor.Puntero)^);
			end;
			nExte :
			begin
				if PExte(LValor.Puntero)^ < 0 then
					raise Exception.Create('Square root of negative number not supported!');
				TValores.SetValor(Result,nExte);
				PExte(Result.Puntero)^ := Sqrt(PExte(LValor.Puntero)^);
			end;
		else
			raise Exception.Create('Not supported parameter type!');
		end;
	finally
		TValores.FreeValor(LValor);
	end;
end;

function FuncAbs(P: string): TValor;
var
	LValor : TValor;
begin
	P := Trim(P);
	try
		LValor := TAnalizadores.Expresion(P);
		Result := VALOR_VACIO;
		case LValor.Tipo of
			nInt32 :
			begin
				TValores.SetValor(Result,nInt32);
				PInt32(Result.Puntero)^ := Abs(PInt32(LValor.Puntero)^);
			end;
			nExte :
			begin
				TValores.SetValor(Result,nExte);
				PExte(Result.Puntero)^ := Abs(PExte(LValor.Puntero)^);
			end;
		else
			raise Exception.Create('Not supported parameter type!');
		end;
	finally
		TValores.FreeValor(LValor);
	end;
end;

function FuncSin(P: string): TValor;
var
	LValor : TValor;
begin
	P := Trim(P);
	try
		LValor := TAnalizadores.Expresion(P);
		Result := VALOR_VACIO;
		case LValor.Tipo of
			nInt32 :
			begin
				TValores.SetValor(Result,nExte);
				PExte(Result.Puntero)^ := Sin(PInt32(LValor.Puntero)^);
			end;
			nExte :
			begin
				TValores.SetValor(Result,nExte);
				PExte(Result.Puntero)^ := Sin(PExte(LValor.Puntero)^);
			end;
		else
			raise Exception.Create('Not supported parameter type!');
		end;
	finally
		TValores.FreeValor(LValor);
	end;
end;

function FuncCos(P: string): TValor;
var
	LValor : TValor;
begin
	P := Trim(P);
	try
		LValor := TAnalizadores.Expresion(P);
		Result := VALOR_VACIO;
		case LValor.Tipo of
			nInt32 :
			begin
				TValores.SetValor(Result,nExte);
				PExte(Result.Puntero)^ := Cos(PInt32(LValor.Puntero)^);
			end;
			nExte :
			begin
				TValores.SetValor(Result,nExte);
				PExte(Result.Puntero)^ := Cos(PExte(LValor.Puntero)^);
			end;
		else
			raise Exception.Create('Not supported parameter type!');
		end;
	finally
		TValores.FreeValor(LValor);
	end;
end;

function FuncTan(P: string): TValor;
var
	LValor : TValor;
begin
	P := Trim(P);
	try
		LValor := TAnalizadores.Expresion(P);
		Result := VALOR_VACIO;
		case LValor.Tipo of
			nInt32 :
			begin
				if Cos(PInt32(LValor.Puntero)^) = 0 then
					raise Exception.Create('Tangent not defined for angles = n * Pi + Pi / 2.');
				TValores.SetValor(Result,nExte);
				PExte(Result.Puntero)^ := Sin(PInt32(LValor.Puntero)^)/Cos(PInt32(LValor.Puntero)^);
			end;
			nExte :
			begin
				if Cos(PExte(LValor.Puntero)^) = 0 then
					raise Exception.Create('Tangent not defined for angles = n * Pi + Pi / 2.');
				TValores.SetValor(Result,nExte);
				PExte(Result.Puntero)^ := Sin(PExte(LValor.Puntero)^)/Cos(PExte(LValor.Puntero)^);
			end;
		else
			raise Exception.Create('Not supported parameter type!');
		end;
	finally
		TValores.FreeValor(LValor);
	end;
end;

function FuncArcTan(P: string): TValor;
var
	LValor : TValor;
begin
	P := Trim(P);
	try
		LValor := TAnalizadores.Expresion(P);
		Result := VALOR_VACIO;
		case LValor.Tipo of
			nInt32 :
			begin
				TValores.SetValor(Result,nExte);
				PExte(Result.Puntero)^ := ArcTan(PInt32(LValor.Puntero)^);
			end;
			nExte :
			begin
				TValores.SetValor(Result,nExte);
				PExte(Result.Puntero)^ := ArcTan(PExte(LValor.Puntero)^);
			end;
		else
			raise Exception.Create('Not supported parameter type!');
		end;
	finally
		TValores.FreeValor(LValor);
	end;
end;

function FuncLog(P: string): TValor;
var
	LValor : TValor;
begin
	P := Trim(P);
	try
		LValor := TAnalizadores.Expresion(P);
		Result := VALOR_VACIO;
		case LValor.Tipo of
			nInt32 :
			begin
				if PInt32(LValor.Puntero)^ <= 0 then
					raise Exception.Create('Logarithm of negative numbers not supported!');
				TValores.SetValor(Result,nExte);
				PExte(Result.Puntero)^ := Ln(PInt32(LValor.Puntero)^);
			end;
			nExte :
			begin
				if Cos(PExte(LValor.Puntero)^) = 0 then
					raise Exception.Create('Logarithm of negative numbers not supported!');
				TValores.SetValor(Result,nExte);
				PExte(Result.Puntero)^ := Ln(PExte(LValor.Puntero)^);
			end;
		else
			raise Exception.Create('Not supported parameter type!');
		end;
	finally
		TValores.FreeValor(LValor);
	end;
end;

function FuncExp(P: string): TValor;
var
	LValor : TValor;
begin
	P := Trim(P);
	try
		LValor := TAnalizadores.Expresion(P);
		Result := VALOR_VACIO;
		case LValor.Tipo of
			nInt32 :
			begin
				TValores.SetValor(Result,nExte);
				PExte(Result.Puntero)^ := Exp(PInt32(LValor.Puntero)^);
			end;
			nExte :
			begin
				TValores.SetValor(Result,nExte);
				PExte(Result.Puntero)^ := Exp(PExte(LValor.Puntero)^);
			end;
		else
			raise Exception.Create('Not supported parameter type!');
		end;
	finally
		TValores.FreeValor(LValor);
	end;
end;

function FuncPi(P: string): TValor;
begin
	TValores.SetValor(Result,nExte);
	PExte(Result.Puntero)^ := Pi;
end;

function FuncLength(P: string): TValor;
var
	LValor : TValor;
begin
	P := Trim(P);
	try
		LValor := TAnalizadores.Expresion(P);
		Result := VALOR_VACIO;
		case LValor.Tipo of
			nCad :
			begin
				TValores.SetValor(Result,nInt32);
				PInt32(Result.Puntero)^ := Length(PCadena(LValor.Puntero)^);
			end;
		else
			raise Exception.Create('Not supported parameter type!');
		end;
	finally
		TValores.FreeValor(LValor);
	end;
end;

function FuncUpCase(P: string): TValor;
var
	LValor : TValor;
begin
	P := Trim(P);
	try
		LValor := TAnalizadores.Expresion(P);
		Result := VALOR_VACIO;
		case LValor.Tipo of
			nCad :
			begin
				TValores.SetValor(Result,nCad);
				PCadena(Result.Puntero)^ := UpperCase(PCadena(LValor.Puntero)^);
			end;
		else
			raise Exception.Create('Not supported parameter type!');
		end;
	finally
		TValores.FreeValor(LValor);
	end;
end;

function FuncLoCase(P: string): TValor;
var
	LValor : TValor;
begin
	P := Trim(P);
	try
		LValor := TAnalizadores.Expresion(P);
		Result := VALOR_VACIO;
		case LValor.Tipo of
			nCad :
			begin
				TValores.SetValor(Result,nCad);
				PCadena(Result.Puntero)^ := LowerCase(PCadena(LValor.Puntero)^);
			end;
		else
			raise Exception.Create('Not supported parameter type!');
		end;
	finally
		TValores.FreeValor(LValor);
	end;
end;

function FuncTrim(P: string): TValor;
var
	LValor : TValor;
begin
	P := Trim(P);
	try
		LValor := TAnalizadores.Expresion(P);
		Result := VALOR_VACIO;
		case LValor.Tipo of
			nCad :
			begin
				TValores.SetValor(Result,nCad);
				PCadena(Result.Puntero)^ := Trim(PCadena(LValor.Puntero)^);
			end;
		else
			raise Exception.Create('Not supported parameter type!');
		end;
	finally
		TValores.FreeValor(LValor);
	end;
end;

function FuncCopy(P: string): TValor;
var
	LValor : TValor;
  LCadena : String;
  LInicio : Integer;
  LLargo : Integer;
  Aux : String;
begin
  Aux := Copy(P,1,Pos(#10#13,P)-1);
  Delete(P,1,Pos(#10#13,P)+1);
	try
		LValor := TAnalizadores.Expresion(Aux);
    if LValor.Tipo<>nCad then
			raise Exception.Create('String expected!');
    LCadena := PCadena(LValor.Puntero)^;
	finally
		TValores.FreeValor(LValor);
	end;

  Aux := Copy(P,1,Pos(#10#13,P)-1);
  Delete(P,1,Pos(#10#13,P)+1);
	try
		LValor := TAnalizadores.Expresion(Aux);
    if LValor.Tipo<>nInt32 then
			raise Exception.Create('Integer number expected!');
    LInicio := PInt32(LValor.Puntero)^;
	finally
		TValores.FreeValor(LValor);
	end;

  Aux := Copy(P,1,Pos(#10#13,P)-1);
  Delete(P,1,Pos(#10#13,P)+1);
	try
		LValor := TAnalizadores.Expresion(Aux);
    if LValor.Tipo<>nInt32 then
			raise Exception.Create('Integer number expected!');
    LLargo := PInt32(LValor.Puntero)^;
	finally
		TValores.FreeValor(LValor);
	end;

  if P<>'' then
    raise Exception.Create('Parameter expected!');

	TValores.SetValor(Result,nCad);
  PCadena(Result.Puntero)^ := Copy(LCadena,LInicio, LLargo);
end;

//-------- Funciones ------------//

procedure FuncionesPorDefecto;
begin
	Funciones.Registrar('SQR',FuncSQR);
	Funciones.Registrar('CUAD',FuncSQR);
	Funciones.Registrar('SQRT',FuncSQRT);
	Funciones.Registrar('RAIZ',FuncSQRT);

	Funciones.Registrar('ABS',FuncAbs);

	Funciones.Registrar('SIN',FuncSin);
	Funciones.Registrar('SEN',FuncSin);
	Funciones.Registrar('COS',FuncCos);
	Funciones.Registrar('TAN',FuncTan);
	Funciones.Registrar('ARCTAN',FuncArcTan);

	Funciones.Registrar('LOG',FuncLog);
  Funciones.Registrar('EXP',FuncExp);

  Funciones.Registrar('PI',FuncPi);

  Funciones.Registrar('LENGTH', FuncLength);
  Funciones.Registrar('LARGO', FuncLength);

  Funciones.Registrar('UPCASE', FuncUpCase);
  Funciones.Registrar('MAYUS', FuncUpCase);

  Funciones.Registrar('LOCASE', FuncUpCase);
  Funciones.Registrar('MINUS', FuncUpCase);

  Funciones.Registrar('TRIM', FuncTrim);
  Funciones.Registrar('ARREGLAR', FuncTrim);

  Funciones.Registrar('COPY', FuncCopy);
  Funciones.Registrar('COPIAR', FuncCopy);
end;

initialization
	Funciones := TFunciones.Create;

  FuncionesPorDefecto;

finalization
	Funciones.Free;

end.

