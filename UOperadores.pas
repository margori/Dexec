unit UOperadores;

interface

uses UValores;

type
  TOperacion = function(AValor1,AValor2 : TValor): TValor;

	TOperador = record
		Cadena: String;
		Nivel : integer;
    Operacion : TOperacion;
    Unario : boolean;
    Binario : boolean;
	end;

var
	Operadores : array[1..16] of TOperador;
	CaractOperadores : set of char;

function EsOperador(S: String): Boolean;
function EsOperadorUnario(S: String): Boolean;
function EsOperadorBinario(S: String): Boolean;
function OperadorNivel(S: string): Integer;
function Evaluar(Operador: String; AValor1,AValor2 : TValor): TValor;

implementation

uses UTipos, Sysutils;

function EsOperadorUnario(S: String): Boolean;
var
  j : integer;
begin
  Result := False;
  for j := Low(Operadores) to High(Operadores) do
    if Operadores[j].Cadena = S then
    begin
      Result := Operadores[j].Unario;
      Break;
    end;
end;

function EsOperadorBinario(S: String): Boolean;
var
  j : integer;
begin
  Result := False;
  for j := Low(Operadores) to High(Operadores) do
    if Operadores[j].Cadena = S then
    begin
      Result := Operadores[j].Binario;
      Break;
    end;
end;

function EsOperador(S: String): Boolean;
var
  j : integer;
begin
  Result := False;
  for j := Low(Operadores) to High(Operadores) do
    if Operadores[j].Cadena = S then
    begin
      Result := True;
      Break;
    end;
end;

function OperadorNivel(S: string): Integer;
var
	j : integer;
begin
	Result := 0;
	for j := Low(Operadores) to High(Operadores) do
		if s = Operadores[j].Cadena then
		begin
			Result := Operadores[j].Nivel;
			Break;
		end;
end;

function Evaluar(Operador: String; AValor1,AValor2 : TValor): TValor;
var
  j : integer;
begin
	Result := VALOR_VACIO;

  for j := 1 to High(Operadores) do
  begin
    if Operador = Operadores[j].Cadena then
    begin
			Result := Operadores[j].Operacion(AValor1,AValor2);
      Exit;
    end;
  end;
end;

//---------  Operadores --------------//
function OperadorNot(AValor1,AValor2 : TValor): TValor;
begin
  if (AValor1.Tipo = nIndef)and(AValor2.Tipo = nInt32) then
  begin
  	TValores.SetValor(Result, nInt32);
		PInt32(Result.Puntero)^ := not PInt32(AValor2.Puntero)^;
  end
  else
		raise Exception.Create('Types missmatch!');
end;

function OperadorAnd(AValor1,AValor2 : TValor): TValor;
begin
  if (AValor1.Tipo = nInt32)and(AValor2.Tipo = nInt32) then
  begin
  	TValores.SetValor(Result, nInt32);
		PInt32(Result.Puntero)^ := PInt32(AValor1.Puntero)^ and PInt32(AValor2.Puntero)^;
	end
  else
		raise Exception.Create('Types missmatch!');
end;

function OperadorOr(AValor1,AValor2 : TValor): TValor;
begin
	if (AValor1.Tipo = nInt32)and(AValor2.Tipo = nInt32) then
	begin
		TValores.SetValor(Result, nInt32);
		PInt32(Result.Puntero)^ := PInt32(AValor1.Puntero)^ or PInt32(AValor2.Puntero)^;
	end
	else
		raise Exception.Create('Types missmatch!');
end;

function OperadorXor(AValor1,AValor2 : TValor): TValor;
begin
  if (AValor1.Tipo = nInt32)and(AValor2.Tipo = nInt32) then
  begin
  	TValores.SetValor(Result, nInt32);
		PInt32(Result.Puntero)^ := PInt32(AValor1.Puntero)^ xor PInt32(AValor2.Puntero)^;
  end
  else
		raise Exception.Create('Types missmatch!');
end;

function OperadorIgual(AValor1,AValor2 : TValor): TValor;
begin
	if (AValor1.Tipo = nInt32)and(AValor2.Tipo = nInt32) then
	begin
		TValores.SetValor(Result, nInt32);
		if PInt32(AValor1.Puntero)^ = PInt32(AValor2.Puntero)^ then
			PInt32(Result.Puntero)^ := -1
		else
			PInt32(Result.Puntero)^ := 0;
	end
	else if (AValor1.Tipo = nCad)and(AValor2.Tipo = nCad) then
  begin
		TValores.SetValor(Result, nInt32);
    if PCadena(AValor1.Puntero)^ = PCadena(AValor2.Puntero)^ then
      PInt32(Result.Puntero)^ := -1
    else
      PInt32(Result.Puntero)^ := 0;
  end
  else if (AValor1.Tipo = nInt32)and(AValor2.Tipo = nExte) then
  begin
		TValores.SetValor(Result, nInt32);
		if PInt32(AValor1.Puntero)^ = PExte(AValor2.Puntero)^ then
      PInt32(Result.Puntero)^ := -1
    else
      PInt32(Result.Puntero)^ := 0;
  end
  else if (AValor1.Tipo = nExte)and(AValor2.Tipo = nInt32) then
  begin
		TValores.SetValor(Result, nInt32);
    if PExte(AValor1.Puntero)^ = PInt32(AValor2.Puntero)^ then
      PInt32(Result.Puntero)^ := -1
    else
      PInt32(Result.Puntero)^ := 0;
  end
  else if (AValor1.Tipo = nExte)and(AValor2.Tipo = nExte) then
  begin
		TValores.SetValor(Result, nInt32);
    if PExte(AValor1.Puntero)^ = PExte(AValor2.Puntero)^ then
      PInt32(Result.Puntero)^ := -1
    else
      PInt32(Result.Puntero)^ := 0;
  end
  else
		raise Exception.Create('Types missmatch!');
end;

function OperadorMenor(AValor1,AValor2 : TValor): TValor;
begin
  if (AValor1.Tipo = nInt32)and(AValor2.Tipo = nInt32) then
  begin
		TValores.SetValor(Result, nInt32);
    if PInt32(AValor1.Puntero)^ < PInt32(AValor2.Puntero)^ then
      PInt32(Result.Puntero)^ := -1
    else
      PInt32(Result.Puntero)^ := 0;
  end
  else if (AValor1.Tipo = nCad)and(AValor2.Tipo = nCad) then
  begin
		TValores.SetValor(Result, nInt32);
    if PCadena(AValor1.Puntero)^ < PCadena(AValor2.Puntero)^ then
      PInt32(Result.Puntero)^ := -1
    else
      PInt32(Result.Puntero)^ := 0;
  end
  else if (AValor1.Tipo = nInt32)and(AValor2.Tipo = nExte) then
  begin
		TValores.SetValor(Result, nInt32);
		if PInt32(AValor1.Puntero)^ < PExte(AValor2.Puntero)^ then
			PInt32(Result.Puntero)^ := -1
		else
			PInt32(Result.Puntero)^ := 0;
	end
	else if (AValor1.Tipo = nExte)and(AValor2.Tipo = nInt32) then
	begin
		TValores.SetValor(Result, nInt32);
		if PExte(AValor1.Puntero)^ < PInt32(AValor2.Puntero)^ then
			PInt32(Result.Puntero)^ := -1
		else
			PInt32(Result.Puntero)^ := 0;
	end
	else if (AValor1.Tipo = nExte)and(AValor2.Tipo = nExte) then
	begin
		TValores.SetValor(Result, nInt32);
		if PExte(AValor1.Puntero)^ < PExte(AValor2.Puntero)^ then
			PInt32(Result.Puntero)^ := -1
		else
			PInt32(Result.Puntero)^ := 0;
	end
	else
		raise Exception.Create('Types missmatch!');
end;

function OperadorMayor(AValor1,AValor2 : TValor): TValor;
begin
  if (AValor1.Tipo = nInt32)and(AValor2.Tipo = nInt32) then
  begin
		TValores.SetValor(Result, nInt32);
    if PInt32(AValor1.Puntero)^ > PInt32(AValor2.Puntero)^ then
      PInt32(Result.Puntero)^ := -1
    else
      PInt32(Result.Puntero)^ := 0;
  end
  else if (AValor1.Tipo = nCad)and(AValor2.Tipo = nCad) then
  begin
		TValores.SetValor(Result, nInt32);
    if PCadena(AValor1.Puntero)^ > PCadena(AValor2.Puntero)^ then
      PInt32(Result.Puntero)^ := -1
    else
      PInt32(Result.Puntero)^ := 0;
  end
  else if (AValor1.Tipo = nInt32)and(AValor2.Tipo = nExte) then
  begin
		TValores.SetValor(Result, nInt32);
		if PInt32(AValor1.Puntero)^ > PExte(AValor2.Puntero)^ then
      PInt32(Result.Puntero)^ := -1
    else
      PInt32(Result.Puntero)^ := 0;
	end
  else if (AValor1.Tipo = nExte)and(AValor2.Tipo = nInt32) then
  begin
		TValores.SetValor(Result, nInt32);
    if PExte(AValor1.Puntero)^ > PInt32(AValor2.Puntero)^ then
      PInt32(Result.Puntero)^ := -1
    else
      PInt32(Result.Puntero)^ := 0;
  end
  else if (AValor1.Tipo = nExte)and(AValor2.Tipo = nExte) then
  begin
		TValores.SetValor(Result, nInt32);
    if PExte(AValor1.Puntero)^ > PExte(AValor2.Puntero)^ then
      PInt32(Result.Puntero)^ := -1
    else
      PInt32(Result.Puntero)^ := 0;
  end
  else
		raise Exception.Create('Types missmatch!');
end;

function OperadorMenorIgual(AValor1,AValor2 : TValor): TValor;
begin
  if (AValor1.Tipo = nInt32)and(AValor2.Tipo = nInt32) then
	begin
		TValores.SetValor(Result, nInt32);
    if PInt32(AValor1.Puntero)^ <= PInt32(AValor2.Puntero)^ then
      PInt32(Result.Puntero)^ := -1
    else
      PInt32(Result.Puntero)^ := 0;
  end
  else if (AValor1.Tipo = nCad)and(AValor2.Tipo = nCad) then
  begin
		TValores.SetValor(Result, nInt32);
    if PCadena(AValor1.Puntero)^ <= PCadena(AValor2.Puntero)^ then
      PInt32(Result.Puntero)^ := -1
    else
      PInt32(Result.Puntero)^ := 0;
  end
  else if (AValor1.Tipo = nInt32)and(AValor2.Tipo = nExte) then
  begin
		TValores.SetValor(Result, nInt32);
		if PInt32(AValor1.Puntero)^ <= PExte(AValor2.Puntero)^ then
      PInt32(Result.Puntero)^ := -1
    else
      PInt32(Result.Puntero)^ := 0;
  end
  else if (AValor1.Tipo = nExte)and(AValor2.Tipo = nInt32) then
	begin
		TValores.SetValor(Result, nInt32);
    if PExte(AValor1.Puntero)^ <= PInt32(AValor2.Puntero)^ then
      PInt32(Result.Puntero)^ := -1
    else
      PInt32(Result.Puntero)^ := 0;
  end
  else if (AValor1.Tipo = nExte)and(AValor2.Tipo = nExte) then
  begin
		TValores.SetValor(Result, nInt32);
    if PExte(AValor1.Puntero)^ <= PExte(AValor2.Puntero)^ then
      PInt32(Result.Puntero)^ := -1
    else
      PInt32(Result.Puntero)^ := 0;
  end
  else
		raise Exception.Create('Types missmatch!');
end;

function OperadorMayorIgual(AValor1,AValor2 : TValor): TValor;
begin
  if (AValor1.Tipo = nInt32)and(AValor2.Tipo = nInt32) then
  begin
		TValores.SetValor(Result, nInt32);
		if PInt32(AValor1.Puntero)^ >= PInt32(AValor2.Puntero)^ then
      PInt32(Result.Puntero)^ := -1
    else
      PInt32(Result.Puntero)^ := 0;
  end
  else if (AValor1.Tipo = nCad)and(AValor2.Tipo = nCad) then
  begin
		TValores.SetValor(Result, nInt32);
    if PCadena(AValor1.Puntero)^ >= PCadena(AValor2.Puntero)^ then
      PInt32(Result.Puntero)^ := -1
    else
      PInt32(Result.Puntero)^ := 0;
  end
  else if (AValor1.Tipo = nInt32)and(AValor2.Tipo = nExte) then
  begin
		TValores.SetValor(Result, nInt32);
		if PInt32(AValor1.Puntero)^ >= PExte(AValor2.Puntero)^ then
      PInt32(Result.Puntero)^ := -1
    else
      PInt32(Result.Puntero)^ := 0;
  end
  else if (AValor1.Tipo = nExte)and(AValor2.Tipo = nInt32) then
  begin
		TValores.SetValor(Result, nInt32);
		if PExte(AValor1.Puntero)^ >= PInt32(AValor2.Puntero)^ then
      PInt32(Result.Puntero)^ := -1
    else
      PInt32(Result.Puntero)^ := 0;
  end
  else if (AValor1.Tipo = nExte)and(AValor2.Tipo = nExte) then
  begin
		TValores.SetValor(Result, nInt32);
    if PExte(AValor1.Puntero)^ >= PExte(AValor2.Puntero)^ then
      PInt32(Result.Puntero)^ := -1
    else
      PInt32(Result.Puntero)^ := 0;
  end
  else
		raise Exception.Create('Types missmatch!');
end;

function OperadorDistinto(AValor1,AValor2 : TValor): TValor;
begin
  if (AValor1.Tipo = nInt32)and(AValor2.Tipo = nInt32) then
  begin
		TValores.SetValor(Result, nInt32);
    if PInt32(AValor1.Puntero)^ <> PInt32(AValor2.Puntero)^ then
      PInt32(Result.Puntero)^ := -1
		else
      PInt32(Result.Puntero)^ := 0;
  end
  else if (AValor1.Tipo = nCad)and(AValor2.Tipo = nCad) then
  begin
		TValores.SetValor(Result, nInt32);
    if PCadena(AValor1.Puntero)^ <> PCadena(AValor2.Puntero)^ then
      PInt32(Result.Puntero)^ := -1
    else
      PInt32(Result.Puntero)^ := 0;
  end
  else if (AValor1.Tipo = nInt32)and(AValor2.Tipo = nExte) then
  begin
		TValores.SetValor(Result, nInt32);
		if PInt32(AValor1.Puntero)^ <> PExte(AValor2.Puntero)^ then
      PInt32(Result.Puntero)^ := -1
    else
      PInt32(Result.Puntero)^ := 0;
  end
  else if (AValor1.Tipo = nExte)and(AValor2.Tipo = nInt32) then
  begin
		TValores.SetValor(Result, nInt32);
    if PExte(AValor1.Puntero)^ <> PInt32(AValor2.Puntero)^ then
      PInt32(Result.Puntero)^ := -1
		else
      PInt32(Result.Puntero)^ := 0;
  end
  else if (AValor1.Tipo = nExte)and(AValor2.Tipo = nExte) then
  begin
		TValores.SetValor(Result, nInt32);
    if PExte(AValor1.Puntero)^ <> PExte(AValor2.Puntero)^ then
      PInt32(Result.Puntero)^ := -1
    else
      PInt32(Result.Puntero)^ := 0;
  end
  else
		raise Exception.Create('Types missmatch!');
end;

function OperadorSuma(AValor1,AValor2 : TValor): TValor;
begin
  if (AValor1.Tipo = nInt32)and(AValor2.Tipo = nInt32) then
  begin
		TValores.SetValor(Result, nInt32);
		PInt32(Result.Puntero)^ := PInt32(AValor1.Puntero)^ + PInt32(AValor2.Puntero)^;
  end
  else if (AValor1.Tipo = nCad)and(AValor2.Tipo = nCad) then
  begin
		TValores.SetValor(Result, nCad);
		PCadena(Result.Puntero)^ := PCadena(AValor1.Puntero)^ + PCadena(AValor2.Puntero)^;
  end
  else if (AValor1.Tipo = nInt32)and(AValor2.Tipo = nExte) then
  begin
		TValores.SetValor(Result, nExte);
		PExte(Result.Puntero)^ := PInt32(AValor1.Puntero)^ + PExte(AValor2.Puntero)^;
  end
  else if (AValor1.Tipo = nExte)and(AValor2.Tipo = nInt32) then
  begin
		TValores.SetValor(Result, nExte);
		PExte(Result.Puntero)^ := PExte(AValor1.Puntero)^ + PInt32(AValor2.Puntero)^;
	end
	else if (AValor1.Tipo = nExte)and(AValor2.Tipo = nExte) then
	begin
		TValores.SetValor(Result, nExte);
		PExte(Result.Puntero)^ := PExte(AValor1.Puntero)^ + PExte(AValor2.Puntero)^;
	end
	else
		raise Exception.Create('Types missmatch!');
end;

function OperadorResta(AValor1,AValor2 : TValor): TValor;
begin
	if (AValor1.Tipo = nIndef)and(AValor2.Tipo = nInt32) then
  begin
		TValores.SetValor(Result, nInt32);
		PInt32(Result.Puntero)^ := - PInt32(AValor2.Puntero)^;
  end
  else if (AValor1.Tipo = nIndef)and(AValor2.Tipo = nExte) then
  begin
		TValores.SetValor(Result, nExte);
		PExte(Result.Puntero)^ := - PExte(AValor2.Puntero)^;
  end
  else if (AValor1.Tipo = nInt32)and(AValor2.Tipo = nInt32) then
  begin
		TValores.SetValor(Result, nInt32);
		PInt32(Result.Puntero)^ := PInt32(AValor1.Puntero)^ - PInt32(AValor2.Puntero)^;
  end
  else if (AValor1.Tipo = nInt32)and(AValor2.Tipo = nExte) then
  begin
		TValores.SetValor(Result, nExte);
		PExte(Result.Puntero)^ := PInt32(AValor1.Puntero)^ - PExte(AValor2.Puntero)^;
	end
  else if (AValor1.Tipo = nExte)and(AValor2.Tipo = nInt32) then
  begin
		TValores.SetValor(Result, nExte);
		PExte(Result.Puntero)^ := PExte(AValor1.Puntero)^ - PInt32(AValor2.Puntero)^;
	end
  else if (AValor1.Tipo = nExte)and(AValor2.Tipo = nExte) then
  begin
		TValores.SetValor(Result, nExte);
		PExte(Result.Puntero)^ := PExte(AValor1.Puntero)^ - PExte(AValor2.Puntero)^;
  end
	else
		raise Exception.Create('Types missmatch!');
end;

function OperadorMultiplicacion(AValor1,AValor2 : TValor): TValor;
begin
	if (AValor1.Tipo = nInt32)and(AValor2.Tipo = nInt32) then
	begin
		TValores.SetValor(Result, nInt32);
		PInt32(Result.Puntero)^ := PInt32(AValor1.Puntero)^ * PInt32(AValor2.Puntero)^;
	end
	else if (AValor1.Tipo = nInt32)and(AValor2.Tipo = nExte) then
	begin
		TValores.SetValor(Result, nExte);
		PExte(Result.Puntero)^ := PInt32(AValor1.Puntero)^ * PExte(AValor2.Puntero)^;
  end
  else if (AValor1.Tipo = nExte)and(AValor2.Tipo = nInt32) then
  begin
		TValores.SetValor(Result, nExte);
		PExte(Result.Puntero)^ := PExte(AValor1.Puntero)^ * PInt32(AValor2.Puntero)^;
  end
  else if (AValor1.Tipo = nExte)and(AValor2.Tipo = nExte) then
  begin
		TValores.SetValor(Result, nExte);
		PExte(Result.Puntero)^ := PExte(AValor1.Puntero)^ * PExte(AValor2.Puntero)^;
	end
	else
		raise Exception.Create('Types missmatch!');
end;

function OperadorDivision(AValor1,AValor2 : TValor): TValor;
begin
  if (AValor1.Tipo = nInt32)and(AValor2.Tipo = nInt32) then
  begin
		TValores.SetValor(Result, nExte);
		PExte(Result.Puntero)^ := PInt32(AValor1.Puntero)^ / PInt32(AValor2.Puntero)^;
  end
  else if (AValor1.Tipo = nInt32)and(AValor2.Tipo = nExte) then
  begin
		TValores.SetValor(Result, nExte);
		PExte(Result.Puntero)^ := PInt32(AValor1.Puntero)^ / PExte(AValor2.Puntero)^;
  end
	else if (AValor1.Tipo = nExte)and(AValor2.Tipo = nInt32) then
  begin
		TValores.SetValor(Result, nExte);
		PExte(Result.Puntero)^ := PExte(AValor1.Puntero)^ / PInt32(AValor2.Puntero)^;
  end
  else if (AValor1.Tipo = nExte)and(AValor2.Tipo = nExte) then
  begin
		TValores.SetValor(Result, nExte);
		PExte(Result.Puntero)^ := PExte(AValor1.Puntero)^ / PExte(AValor2.Puntero)^;
	end
	else
		raise Exception.Create('Types missmatch!');
end;

function OperadorDivisionEntera(AValor1,AValor2 : TValor): TValor;
begin
  if (AValor1.Tipo = nInt32)and(AValor2.Tipo = nInt32) then
  begin
		TValores.SetValor(Result, nInt32);
		PInt32(Result.Puntero)^ := PInt32(AValor1.Puntero)^ div PInt32(AValor2.Puntero)^;
  end
  else
		raise Exception.Create('Types missmatch!');
end;

function OperadorModulo(AValor1,AValor2 : TValor): TValor;
begin
	if (AValor1.Tipo = nInt32)and(AValor2.Tipo = nInt32) then
	begin
		TValores.SetValor(Result, nInt32);
		PInt32(Result.Puntero)^ := PInt32(AValor1.Puntero)^ mod PInt32(AValor2.Puntero)^;
	end
	else
		raise Exception.Create('Types missmatch!');
end;
//---------  Operadores --------------//

var
	j,k :integer;
initialization
begin
  with Operadores[1] do
  begin
    Cadena := 'not';
    Nivel:= 1;
    Operacion:= OperadorNot;
		Unario := True;
    Binario := False;
	end;

  with Operadores[2] do
  begin
    Cadena := 'and';
    Nivel:= 2;
    Operacion:= OperadorAnd;
    Unario := False;
    Binario := True;
  end;

  with Operadores[3] do
  begin
    Cadena := 'or';
    Nivel:= 2;
    Operacion:= OperadorOr;
    Unario := False;
    Binario := True;
  end;

  with Operadores[4] do
  begin
		Cadena := 'xor';
    Nivel:= 2;
		Operacion:= OperadorXor;
    Unario := False;
    Binario := True;
  end;

  with Operadores[5] do
  begin
    Cadena := '=';
    Nivel:= 3;
    Operacion:= OperadorIgual;
    Unario := False;
    Binario := True;
  end;

  with Operadores[6] do
  begin
    Cadena := '<>';
    Nivel:= 3;
    Operacion:= OperadorDistinto;
    Unario := False;
    Binario := True;
  end;

  with Operadores[7] do // Este operador debe estar antes que el <
	begin
    Cadena := '<=';
    Nivel:= 3;
    Operacion:= OperadorMenorIgual;
    Unario := False;
    Binario := True;
  end;

  with Operadores[8] do // Este operador debe estar antes que el >
  begin
    Cadena := '>=';
    Nivel:= 3;
    Operacion:= OperadorMayorIgual;
    Unario := False;
    Binario := True;
  end;

  with Operadores[9] do
  begin
    Cadena := '<';
    Nivel:= 3;
    Operacion:= OperadorMenor;
		Unario := False;
    Binario := True;
	end;

  with Operadores[10] do
  begin
    Cadena := '>';
    Nivel:= 3;
    Operacion:= OperadorMayor;
    Unario := False;
    Binario := True;
  end;

  with Operadores[11] do
  begin
    Cadena := '+';
    Nivel:= 4;
    Operacion:= OperadorSuma;
    Unario := False;
    Binario := True;
  end;

  with Operadores[12] do
  begin
		Cadena := '-';
    Nivel:= 4;
		Operacion:= OperadorResta;
    Unario := True;
    Binario := True;
  end;

  with Operadores[13] do
  begin
    Cadena := '*';
    Nivel:= 5;
    Operacion:= OperadorMultiplicacion;
    Unario := False;
    Binario := True;
  end;

  with Operadores[14] do
  begin
    Cadena := '/';
    Nivel:= 5;
    Operacion:= OperadorDivision;
    Unario := False;
    Binario := True;
  end;

  with Operadores[15] do
	begin
    Cadena := '\';
    Nivel:= 5;
    Operacion:= OperadorDivisionEntera;
    Unario := False;
    Binario := True;
  end;

  with Operadores[16] do
  begin
    Cadena := '%';
    Nivel:= 5;
    Operacion:= OperadorModulo;
    Unario := False;
    Binario := True;
  end;

	CaractOperadores := [];
	for j := Low(Operadores) to High(Operadores) do
		for k := 1 to Length(Operadores[j].Cadena) do
			if not(Operadores[j].Cadena[k] in CaractOperadores) then
				CaractOperadores := CaractOperadores + [Operadores[j].Cadena[k]];
end;

end.