unit UVariables;

interface

uses sysutils, UUtiles, classes, UValores, UTipos;

type
  TInfoVariable = record
    Nombre : String;
		ValorPorDefecto : String;
		Filas, Columnas : Integer;
		Tipo : TTipo;
	end;

	TVariable = class
	private
		FNombre : String;
		FValorPorDefecto : String;
		FTipo : TTipo;
		FPunteros : array of array of Pointer;
		function GetFilas: Integer;
		function GetColumnas: Integer;
		procedure SetFilas(const Value: Integer);
		procedure SetColumnas(const Value: Integer);
		procedure SetTipo(const Value: integer);

		function ValoresP(i1,i2: integer): TValor;
	public
		constructor Create;
		destructor Destroy; override;

		property Nombre: String read FNombre write FNombre;
		property ValorPorDefecto : String read FValorPorDefecto write FValorPorDefecto;
		property Filas : Integer read GetFilas write SetFilas;
		property Columnas : Integer read GetColumnas  write SetColumnas;
		property Tipo : integer read FTipo write SetTipo;

		procedure Inicializar;
		function Valores(i1,i2: integer): TValor;
		function Info : TInfoVariable;
	end;

	TVariables = class
	private
		FVariables : TList;
	public
		constructor Create;
		destructor Destroy; override;

		procedure Registrar(ANombre, AValorPorDefecto: String; AFilas, AColumnas : Integer; ATipo : TTipo); overload;
		procedure Registrar(AInfoVariable : TInfoVariable); overload;
		procedure Deregistrar(ANombre: String); overload;
		procedure Deregistrar(Index: Integer); overload;
		procedure DeregistrarTodo;

		procedure Inicializar;

		function Variable(S : String): TVariable; overload;
		function Variable(Index : Integer): TVariable; overload;
		function EsVariable(S: String): Boolean;

		function Valor(AExpresion: String): TValor;

		function Count : Integer;

		procedure Modificar(Index: Integer; ANombre, AValorPorDefecto: String;
			AFilas,AColumnas: Integer; ATipo: Integer);

		procedure Asignar(AExpresion : String; AValor: TValor); overload;
	end;

var
	Variables : TVariables;

const
  INFOVARIABLEVACIA : TInfoVariable = (
    Nombre : ''; ValorPorDefecto : '';Filas : 1; Columnas : 1;Tipo : 0;  
  );

implementation

uses UEsTipo, UExtractores, UAnalizadores, UConstantes;

{ TVariables }

function TVariables.Count: Integer;
begin
  Result := FVariables.Count;
end;

constructor TVariables.Create;
begin
	FVariables := TList.Create;
end;

procedure TVariables.Deregistrar(ANombre: String);
var
	j : integer;
  LVariable : TVariable;
begin
	for j := FVariables.Count-1 downto 0 do
  begin
    LVariable := TVariable(FVariables.Items[j]);
		if LVariable.Nombre = ANombre  then
		begin
			Deregistrar(j);
			Break;
		end;
  end;
end;

procedure TVariables.Deregistrar(Index: Integer);
var
  LVariable : TVariable;
begin
  LVariable := FVariables.Items[Index];
  LVariable.Free;
  FVariables.Delete(Index);
end;

procedure TVariables.DeregistrarTodo;
begin
	while FVariables.Count>0 do
		Deregistrar(0);
end;

destructor TVariables.destroy;
begin
	DeregistrarTodo;
	inherited;
end;

function TVariables.EsVariable(S: String): Boolean;
var
	j : integer;
  LVariable : TVariable;
begin
	Result := False;
	for j := 0 to FVariables.Count-1 do
	begin
    LVariable := FVariables.Items[j];
		if UpperCase(LVariable.Nombre) = UpperCase(S) then
		begin
			Result := True;
			Break;
		end;
	end;
end;

procedure TVariables.Registrar(ANombre, AValorPorDefecto: String; AFilas,
	AColumnas : Integer; ATipo : TTipo);
var
  LVariable : TVariable;
begin
  LVariable := TVariable.Create;
	FVariables.Add(LVariable);
	with LVariable do
	begin
		Nombre := ANombre;
    ValorPorDefecto := AValorPorDefecto;
    Tipo := ATipo;
    Filas := AFilas;
    Columnas := AColumnas;
	end;
end;

function TVariables.Variable(S: String): TVariable;
var
	j : integer;
  LVariable : TVariable;
begin
  Result := Nil;
	for j := 0 to FVariables.Count-1 do
	begin
    LVariable := FVariables.Items[j];
		if UpperCase(LVariable.Nombre) = UpperCase(S) then
		begin
			Result := FVariables[j];
			Break;
		end;
	end;
end;

function TVariables.Variable(Index: Integer): TVariable;
begin
	Result := FVariables[Index];
end;

procedure TVariables.Inicializar;
var
  j : Integer;
  LVariable : TVariable;
begin
  for j := 0 to FVariables.Count-1 do
  begin
    LVariable := FVariables.Items[j];
    LVariable.Inicializar;
  end;
end;

procedure TVariables.Modificar(Index: Integer; ANombre,
  AValorPorDefecto: String; AFilas,AColumnas : Integer; ATipo: Integer);
var
  LVariable : TVariable;
begin
  LVariable := FVariables.Items[Index];
  with LVariable do
  begin
    Nombre := ANombre;
    ValorPorDefecto := AValorPorDefecto;
		Tipo := ATipo;
		Filas := AFilas;
		Columnas := AColumnas;
	end;
end;

procedure TVariables.Registrar(AInfoVariable: TInfoVariable);
begin
	with AInfoVariable do
		Self.Registrar(Nombre,ValorPorDefecto,Filas,Columnas,Tipo);
end;

function TVariables.Valor(AExpresion: String): TValor;
var
	LIndex1,LIndex2 : Integer;
	i : String;
	LExpresion1,LExpresion2: String;
	LValorIndex1, LValorIndex2 : TValor;
	LVariable : TVariable;
begin
	LIndex1 := 0; LIndex2 := 0;
	i := TExtractores.ExtraerIdentificador(AExpresion);
	if not EsVariable(i) then
		raise Exception.Create('Sintax error!' + ' ' +' Unknown identifier.');

	LVariable := Variables.Variable(i);
	if AExpresion<>'' then
	begin
		if AExpresion[1]='(' then
		begin
			delete(AExpresion,1,1);
			LExpresion1 := TExtractores.ExtraerExpresion(AExpresion);
			try
				LValorIndex1 := TAnalizadores.Expresion(LExpresion1);
				if LValorIndex1.Tipo <> nInt32 then
					raise Exception.Create('Sintax error!' + ' ' +' Integer number expected.');
				LIndex1 := PInt32(LValorIndex1.Puntero)^;
			finally
				TValores.FreeValor(LValorIndex1);
			end;

			if (AExpresion[1]=')')and(AExpresion[1]<>SEPARADOR) then
				LIndex2 := 0
			else if AExpresion[1]=SEPARADOR then
			begin
				Delete(AExpresion,1,1);
				LExpresion2 := TExtractores.ExtraerExpresion(AExpresion);
				if AExpresion[1]<>')' then
					Raise Exception.Create('Sintax error!' + ' ' +' ")" expected.');

				try
					LValorIndex2 := TAnalizadores.Expresion(LExpresion2);
					if LValorIndex2.Tipo <> nInt32 then
						raise Exception.Create('Sintax error!' + ' ' +' Integer number expected.');
					LIndex2 := PInt32(LValorIndex2.Puntero)^;
				finally
					TValores.FreeValor(LValorIndex2);
				end;
			end
			else if AExpresion[1]<>SEPARADOR then
				raise Exception.Create(Format('Sintax error!' + ' ' +' "%s" expected.',[SEPARADOR]));
		end;
	end;

	Result := LVariable.Valores(LIndex1,LIndex2);
end;

procedure TVariables.Asignar(AExpresion: String; AValor: TValor);
var
	LIndex1,LIndex2 : Integer;
	i : String;
	LExpresion1,LExpresion2: String;
	LValorIndex1, LValorIndex2 : TValor;
	LVariable : TVariable;
	LValor : TValor; // Este no se debe liberar.
begin
	LIndex1 := 0; LIndex2 := 0;
	i := TExtractores.ExtraerIdentificador(AExpresion);
	if not EsVariable(i) then
		raise Exception.Create('Sintax error!' + ' ' +' Unknown identifier.');

	LVariable := Variables.Variable(i);
	if AExpresion<>'' then
	begin
		if AExpresion[1]='(' then
		begin
			delete(AExpresion,1,1);
			LExpresion1 := TExtractores.ExtraerExpresion(AExpresion);
			try
				LValorIndex1 := TAnalizadores.Expresion(LExpresion1);
				if LValorIndex1.Tipo <> nInt32 then
					raise Exception.Create('Sintax error!' + ' ' +' Integer number expected.');
				LIndex1 := PInt32(LValorIndex1.Puntero)^;
			finally
				TValores.FreeValor(LValorIndex1);
			end;

			if (AExpresion[1]=')')and(AExpresion[1]<>SEPARADOR) then
				LIndex2 := 0
			else if AExpresion[1]=SEPARADOR then
			begin
				Delete(AExpresion,1,1);
				LExpresion2 := TExtractores.ExtraerExpresion(AExpresion);
				if AExpresion[1]<>')' then
					Raise Exception.Create('Sintax error!' + ' ' +' ")" expected.');

				try
					LValorIndex2 := TAnalizadores.Expresion(LExpresion2);
					if LValorIndex2.Tipo <> nInt32 then
						raise Exception.Create('Sintax error!' + ' ' +' Integer number expected.');
					LIndex2 := PInt32(LValorIndex2.Puntero)^;
				finally
					TValores.FreeValor(LValorIndex2);
				end;
			end;
		end;
	end;

	if LVariable.Tipo = nCad then
		LValor := LVariable.ValoresP(LIndex1,0) // Esto evita la devolucion de un char
	else
		LValor := LVariable.ValoresP(LIndex1,LIndex2);


	if (LValor.Tipo = nInt32)and(AValor.Tipo=nInt32) then
		PInt32(LValor.Puntero)^ := PInt32(AValor.Puntero)^
	else if (LValor.Tipo = nExte)and(AValor.Tipo = nInt32) then
		PExte(LValor.Puntero)^ := PInt32(AValor.Puntero)^
	else if (LValor.Tipo= nExte)and(AValor.Tipo=nExte) then
		PExte(LValor.Puntero)^ := PExte(AValor.Puntero)^
	else if (AValor.Tipo=nCad)and(AValor.Tipo=nCad) then
	begin
		if Lindex2 = 0 then
			PCadena(LValor.Puntero)^ := PCadena(AValor.Puntero)^
		else
			PCadena(LValor.Puntero)^[Lindex2] := PCadena(AValor.Puntero)^[1];
	end
	else
		raise Exception.Create('Sintax error!' + ' ' +' Types missmatch.');
end;

{ TVariable }

constructor TVariable.Create;
begin
	Filas := 0;
	Columnas := 0;
	inherited;
end;

destructor TVariable.Destroy;
var
  j,k: integer;
begin
  for j := 0 to Filas-1 do
    for k := 0 to Columnas-1 do
      if FPunteros[j,k]<> Nil then
        FreeMem(FPunteros[j,k]);
  inherited;
end;

function TVariable.GetFilas: Integer;
begin
  Result := Length(FPunteros);
end;

function TVariable.GetColumnas: Integer;
begin
	if Length(FPunteros)>0 then
		Result := Length(FPunteros[0])
	else
		Result := 0;
end;

function TVariable.Info: TInfoVariable;
begin
  Result.Nombre := Nombre;
  Result.ValorPorDefecto := ValorPorDefecto;
  Result.Filas := Filas;
  Result.Columnas := Columnas;
  Result.Tipo := Tipo;
end;

procedure TVariable.Inicializar;
var
  j,k: integer;
	LValor1,LValor2 : TValor;
begin
	try
		LValor1 := TValores.StringAValor(ValorPorDefecto);
		for j := 0 to Filas-1 do
			for k := 0 to Columnas-1 do
			begin
				LValor2.Tipo := Self.FTipo;
				LValor2.Puntero := FPunteros[j,k];
				TValores.Asignar(LValor2,LValor1);
			end;
	finally
		TValores.FreeValor(LValor1);
	end;
end;

procedure TVariable.SetFilas(const Value: Integer);
var
  j,k: integer;
  LDim : integer;
begin
  if Value < Filas then
  begin
    for j := Value downto Filas-1 do
			for k := 0 to Columnas-1 do
      begin
        FreeMem(FPunteros[j,k]);
        FPunteros[j,k] := nil;
      end;
    SetLength(FPunteros,Value);
  end
  else if Value > Filas then
  begin
    LDim := Filas;
    SetLength(FPunteros,Value);
    for j := LDim to Value-1 do
    begin
      SetLength(FPunteros[j],Columnas);
      for k := 0 to Columnas-1 do
      begin
        GetMem(FPunteros[j,k], TTipos.SizeTipo(FTipo));

        case Tipo of
          nInt32 : PInt32(FPunteros[j,k])^ := 0;
          nExte : PExte(FPunteros[j,k])^ := 0.0;
          nCad : PCadena(FPunteros[j,k])^ := '';
        end;
      end;
    end;
  end;
end;

procedure TVariable.SetColumnas(const Value: Integer);
var
  j,k: integer;
  LDim : integer;
begin
  if Value < Columnas then
  begin
    for j := 0 to Filas-1 do
    begin
      for k := Columnas-1 to Value do
      begin
        FreeMem(FPunteros[j,k]);
        FPunteros[j,k] := nil;
      end;
      SetLength(FPunteros[j],Value);
    end;
  end
  else if Value > Columnas then
  begin
    LDim := Columnas;
    for j := 0 to Filas-1 do
    begin
      SetLength(FPunteros[j],Value);
      for k := LDim to Value-1 do
      begin
        GetMem(FPunteros[j,k], TTipos.SizeTipo(FTipo));

        case Tipo of
          nInt32 : PInt32(FPunteros[j,k])^ := 0;
          nExte : PExte(FPunteros[j,k])^ := 0.0;
          nCad : PCadena(FPunteros[j,k])^ := '';
        end;
      end;
    end;
  end;
end;

procedure TVariable.SetTipo(const Value: integer);
var
  j,k: integer;
begin
  if FTipo <> Value then
  begin
    for j := 0 to Filas-1 do
      for k := 0 to Columnas-1 do
      begin
        FreeMem(FPunteros[j,k]);
        GetMem(FPunteros[j,k], TTipos.SizeTipo(FTipo));
        case Value of
          nInt32 : PInt32(FPunteros[j,k])^ := 0;
          nExte : PExte(FPunteros[j,k])^ := 0.0;
          nCad : PCadena(FPunteros[j,k])^ := '';
        end;
      end;
    FTipo := Value;
  end;

end;

function TVariable.Valores(i1, i2: integer): TValor;
begin
	if (i1<0)or(i1>Filas-1) then
		Raise Exception.Create('Row index out of range!');
	if Self.Tipo = nCad then
	begin
		if Length(PCadena(FPunteros[i1,0])^)< i2 then
			Raise Exception.Create('Character index out of range!');
	end
	else if (i2<0)or(i2>Columnas-1) then
		Raise Exception.Create('Column index out of range!');

	Result := VALOR_VACIO;
	TValores.SetValor(Result,Tipo);
	case Tipo of
		nInt32 : PInt32(Result.Puntero)^ := PInt32(FPunteros[i1,i2])^;
		nCad :
			begin
				if i2 = 0 then
					PCadena(Result.Puntero)^ := PCadena(FPunteros[i1,i2])^
				else
					PCadena(Result.Puntero)^ := PCadena(FPunteros[i1,0])^[i2];
			end;
		nExte : PExte(Result.Puntero)^ := PExte(FPunteros[i1,i2])^;
	else
		raise Exception.Create('Type not supported!');
	end;
end;

function TVariable.ValoresP(i1, i2: integer): TValor;
begin
	if (i1<0)or(i1>Filas-1) then
		Raise Exception.Create('Row index out of range!');
	if Self.Tipo = nCad then
	begin
		if Length(PCadena(FPunteros[i1,0])^)< i2 then
			Raise Exception.Create('Character index out of range!');
	end
	else if (i2<0)or(i2>Columnas-1) then
		Raise Exception.Create('Column index out of range!');
	Result.Tipo := Tipo;
	Result.Puntero := FPunteros[i1,i2];
end;

initialization
	Variables := TVariables.Create;

finalization
	Variables.Free;

end.
