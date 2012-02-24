unit UProcedimientos;

interface

uses Sysutils;

type
  TProcedimientoValor = procedure(p: String);

	TProcedimiento = record
		Nombre : String;
		Valor : TProcedimientoValor;
	end;

	TProcedimientos = class
	private
		FProcedimientos : array of TProcedimiento;
	public
		constructor Create;
		destructor Destroy; override;

		procedure Registrar(ANombre: String; AValor: TProcedimientoValor);
		procedure Deregistrar(ANombre: String); overload;
		procedure Deregistrar(Index: Integer); overload;
		procedure DeregistrarTodo;

		function Procedimiento(ANombre : String): TProcedimiento; overload;
		function Procedimiento(Index : Integer): TProcedimiento; overload;
		function EsProcedimiento(S: String): Boolean;

    function Count : Integer;
	end;

var
	Procedimientos : TProcedimientos;

const
	PROCEDIMIENTO_VACIO : TProcedimiento = (Nombre : '';
    Valor : Nil);

implementation

uses UFormCrt, UAnalizadores, UValores, UVariables, UArchivos, UTipos,
  UExtractores;

{ TProcedimientos }

function TProcedimientos.Count: Integer;
begin
  Result := Length(FProcedimientos);
end;

constructor TProcedimientos.Create;
begin
  SetLength(FProcedimientos,0);
end;

procedure TProcedimientos.Deregistrar(ANombre: String);
var
	j : integer;
begin
	for j := High(FProcedimientos) downto Low(FProcedimientos) do
	begin
		if FProcedimientos[j].Nombre = ANombre  then
		begin
			SetLength(FProcedimientos,Length(FProcedimientos)-1);
			Break;
		end;
	end;
end;

procedure TProcedimientos.Deregistrar(Index: Integer);
begin
	SetLength(FProcedimientos,Length(FProcedimientos)-1);
end;

procedure TProcedimientos.DeregistrarTodo;
begin
	while Length(FProcedimientos)>0 do
		Deregistrar(0);
end;

destructor TProcedimientos.Destroy;
begin
	DeregistrarTodo;
	inherited;
end;

function TProcedimientos.EsProcedimiento(S: String): Boolean;
var
	j : integer;
begin
	Result := False;
	for j := Low(FProcedimientos) to High(FProcedimientos) do
	begin
		if UpperCase(FProcedimientos[j].Nombre) = UpperCase(S) then
		begin
			Result := True;
			Break;
		end;
	end;
end;

function TProcedimientos.Procedimiento(Index: Integer): TProcedimiento;
begin
	Result := FProcedimientos[Index];
end;

function TProcedimientos.Procedimiento(ANombre: String): TProcedimiento;
var
	j : integer;
begin
	for j := Low(FProcedimientos) to High(FProcedimientos) do
	begin
		if UpperCase(FProcedimientos[j].Nombre) = UpperCase(ANombre) then
		begin
			Result := FProcedimientos[j];
			Break;
		end;
	end;
end;

procedure TProcedimientos.Registrar(ANombre: String;
  AValor: TProcedimientoValor);
begin
	SetLength(FProcedimientos,Length(FProcedimientos)+1);
  FProcedimientos[High(FProcedimientos)] := PROCEDIMIENTO_VACIO;
	with FProcedimientos[High(FProcedimientos)] do
	begin
		Nombre := ANombre;
		Valor := AValor;
	end;
end;

//----------- Procedimientos ---------------//

procedure ProcRandomize(p: String);
begin
	Randomize;
end;

procedure ProcCLS(p: string);
begin
	formCrt.Cls;
end;

procedure ProcWrite(p: string);
var
	LValor : TValor;
	aux : string;
begin
	repeat
		aux := Copy(p,1,Pos(#10#13,p)-1);

		if aux = '' then
			raise Exception.Create('Sintax error!' + ' ' + 'Parameter expected.');

		try
			LValor := TAnalizadores.Expresion(aux);
			formCrt.Write(TValores.ValorAString(LValor));
		finally
			TValores.FreeValor(LValor);
		end;

		Delete(p,1,Length(Aux)+2);
	until p='';
end;

procedure ProcWriteln(p: string);
var
	LValor : TValor;
	aux : string;
begin
	repeat
		aux := Copy(p,1,Pos(#10#13,p)-1);

		if aux = '' then
			raise Exception.Create('Sintax error!' + ' ' + ' Parameter expected.');

		try
			LValor := TAnalizadores.Expresion(aux);
			formCrt.Write(TValores.ValorAString(LValor));
		finally;
			TValores.FreeValor(LValor);
		end;

		Delete(p,1,Length(Aux)+2);
	until p='';
	formCrt.Retorno;
end;

procedure ProcRead(p: string);
var
	LLectura : string;
	LValor : TValor;
	LTipo : TTipo;
	i : string;
begin
	LLectura := formCrt.Read;

	i := TExtractores.ExtraerIdentificador(p);
	LTipo := Variables.Variable(i).Tipo;
	LValor := TValores.StringAValorDef(LLectura, LTipo);
	Variables.Asignar(i+P,LValor);
end;

procedure ProcReadln(p: String);
var
	LLectura : string;
	LValor : TValor;
	LTipo : TTipo;
	i : string;
begin
	LLectura := formCrt.Read;

	i := TExtractores.ExtraerIdentificador(p);
	LTipo := Variables.Variable(i).Tipo;
	LValor := TValores.StringAValorDef(LLectura, LTipo);
	Variables.Asignar(i+P,LValor);
	formCrt.Retorno;
end;

procedure ProcWriteFile(p: string);
var
	aux : string;
	LArchivo : TArchivo;
	LValor : TValor;
begin
	aux := Copy(p,1,Pos(#10#13,p)-1);
	if not Archivos.EsArchivo(Aux) then
		raise Exception.Create('Sintax error!' + ' ' + ' Unknown identifier.');
	Delete(p,1,Length(Aux)+2);

	LArchivo := Archivos.Archivo(Aux);

	repeat
		Aux := Copy(p,1,Pos(#10#13,p)-1);

		if aux = '' then
			raise Exception.Create('Sintax error!' + ' ' + ' Parameter expected.');

		try
			LValor := TAnalizadores.Expresion(aux);
			LArchivo.Write(TValores.ValorAString(LValor));
		finally
			TValores.FreeValor(LValor);
		end;

		Delete(p,1,Length(Aux)+2);
	until p='';
end;

procedure ProcWriteFileln(p: string);
var
	LValor : TValor;
	aux : string;
	LArchivo : TArchivo;
begin
	aux := Copy(p,1,Pos(#10#13,p)-1);
	if not Archivos.EsArchivo(Aux) then
		raise Exception.Create('Sintax error!' + ' ' + 'Unknown file identifier.');
	Delete(p,1,Length(Aux)+2);

	LArchivo := Archivos.Archivo(Aux);

	repeat
		aux := Copy(p,1,Pos(#10#13,p)-1);

		if aux = '' then
			raise Exception.Create('Sintax error!' + ' ' + 'Parameter expected.');

		try
			LValor := TAnalizadores.Expresion(aux);
			LArchivo.Writeln(TValores.ValorAString(LValor));
		finally
			TValores.FreeValor(LValor);
		end;

		Delete(p,1,Length(Aux)+2);
	until p='';
end;

procedure ProcReadFile(p: string);
var
	LValor : TValor;
	LArchivo : TArchivo;
	Aux : string;
begin
	Aux := Copy(P,1,Pos(#10#13,p)-1);
	Delete(p,1,Pos(#10#13,p)+1);
	if not Archivos.EsArchivo(Aux) then
		raise Exception.Create('Sintax error!' + ' ' + 'Unknown file identifier.');

	LArchivo := Archivos.Archivo(Aux);
	Aux := Copy(P,1,Pos(#10#13,p)-1);
	Delete(p,1,Pos(#10#13,p)+2);
	LValor := Variables.Valor(Aux);
	LArchivo.Read(LValor);
	Variables.Asignar(Aux,LValor);
end;

procedure ProcReadFileln(p: String);
var
	LValor : TValor;
	LArchivo : TArchivo;
	Aux : string;
begin
	Aux := Copy(P,1,Pos(#10#13,p)-1);
	Delete(p,1,Pos(#10#13,p)+1);
	if not Archivos.EsArchivo(Aux) then
		raise Exception.Create('Sintax error!' + ' ' + 'Unknown file identifier.');

	LArchivo := Archivos.Archivo(Aux);
	Aux := Copy(P,1,Pos(#10#13,p)-1);
	LValor := Variables.Valor(Aux);
	LArchivo.Readln(LValor);
	Variables.Asignar(Aux,LValor);
end;

//----------- Procedimientos ---------------//

procedure ProcedimientosPorDefecto;
begin
	Procedimientos.Registrar('CLS',ProcCLS);
	Procedimientos.Registrar('LIMPIAR',ProcCLS);
	Procedimientos.Registrar('WRITE',ProcWrite);
	Procedimientos.Registrar('MOSTRAR',ProcWrite);
	Procedimientos.Registrar('WRITELN',ProcWriteln);
	Procedimientos.Registrar('MOSTRARRT',ProcWriteln);
	Procedimientos.Registrar('READ',ProcRead);
	Procedimientos.Registrar('LEER',ProcRead);
	Procedimientos.Registrar('READLN',ProcReadln);
	Procedimientos.Registrar('LEERRT',ProcReadln);
	Procedimientos.Registrar('WRITEFILE',ProcWriteFile);
	Procedimientos.Registrar('MOSTRARARCHIVO',ProcWriteFile);
	Procedimientos.Registrar('WRITEFILELN',ProcWriteFileln);
	Procedimientos.Registrar('MOSTRARARCHIVORT',ProcWriteFileln);
	Procedimientos.Registrar('READFILE',ProcReadFile);
	Procedimientos.Registrar('LEERARCHIVO',ProcReadFile);
	Procedimientos.Registrar('READFILELN',ProcReadFileln);
	Procedimientos.Registrar('LEERARCHIVORT',ProcReadFileln);
	Procedimientos.Registrar('RANDOMIZE',ProcRandomize);
	Procedimientos.Registrar('ALEATORIZAR',ProcRandomize);
end;

initialization
	Procedimientos := TProcedimientos.Create;

  ProcedimientosPorDefecto;

finalization
	Procedimientos.Free;

end.
