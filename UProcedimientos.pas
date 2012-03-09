unit UProcedimientos;

interface

uses Sysutils;

type
  TProcedurePointer = procedure(p: String);

	TProcedure = record
		ProcedureName : String;
		ProcedurePointer : TProcedurePointer;
	end;

	TProcedures = class
	private
		FProcedures : array of TProcedure;
	public
		constructor Create;
		destructor Destroy; override;

		procedure Add(ANombre: String; AValor: TProcedurePointer);
		procedure Remove(ANombre: String); overload;
		procedure Remove(Index: Integer); overload;
		procedure Clean;

		function GetProcedure(ANombre : String): TProcedure; overload;
		function GetProcedure(Index : Integer): TProcedure; overload;
		function IsProcedure(S: String): Boolean;

    function Count : Integer;
	end;

var
	Procedures : TProcedures;

const
	DEFAULT_PROCEDURE : TProcedure = (ProcedureName : '';
    ProcedurePointer : Nil);

implementation

uses UFormCrt, UAnalizadores, UValores, UVariables, UArchivos, UTipos,
  UExtractores;

{ TProcedures }

function TProcedures.Count: Integer;
begin
  Result := Length(FProcedures);
end;

constructor TProcedures.Create;
begin
  SetLength(FProcedures,0);
end;

procedure TProcedures.Remove(ANombre: String);
var
	j : integer;
begin
	for j := High(FProcedures) downto Low(FProcedures) do
	begin
		if FProcedures[j].ProcedureName = ANombre  then
		begin
			SetLength(FProcedures,Length(FProcedures)-1);
			Break;
		end;
	end;
end;

procedure TProcedures.Remove(Index: Integer);
begin
	SetLength(FProcedures,Length(FProcedures)-1);
end;

procedure TProcedures.Clean;
begin
	while Length(FProcedures)>0 do
		Remove(0);
end;

destructor TProcedures.Destroy;
begin
	Clean;
	inherited;
end;

function TProcedures.IsProcedure(S: String): Boolean;
var
	j : integer;
begin
	Result := False;
	for j := Low(FProcedures) to High(FProcedures) do
	begin
		if UpperCase(FProcedures[j].ProcedureName) = UpperCase(S) then
		begin
			Result := True;
			Break;
		end;
	end;
end;

function TProcedures.GetProcedure(Index: Integer): TProcedure;
begin
	Result := FProcedures[Index];
end;

function TProcedures.GetProcedure(ANombre: String): TProcedure;
var
	j : integer;
begin
	for j := Low(FProcedures) to High(FProcedures) do
	begin
		if UpperCase(FProcedures[j].ProcedureName) = UpperCase(ANombre) then
		begin
			Result := FProcedures[j];
			Break;
		end;
	end;
end;

procedure TProcedures.Add(ANombre: String;
  AValor: TProcedurePointer);
begin
	SetLength(FProcedures,Length(FProcedures)+1);
  FProcedures[High(FProcedures)] := DEFAULT_PROCEDURE;
	with FProcedures[High(FProcedures)] do
	begin
		ProcedureName := ANombre;
		ProcedurePointer := AValor;
	end;
end;

//----------- Procedures ---------------//

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
	LValue : TValue;
	aux : string;
begin
	repeat
		aux := Copy(p,1,Pos(#10#13,p)-1);

		if aux = '' then
			raise Exception.Create('Sintax error!' + ' ' + 'Parameter expected.');

		try
			LValue := TAnalyzers.Expression(aux);
			formCrt.Write(TValues.ToString(LValue));
		finally
			TValues.FreeValue(LValue);
		end;

		Delete(p,1,Length(Aux)+2);
	until p='';
end;

procedure ProcWriteln(p: string);
var
	LValor : TValue;
	aux : string;
begin
	repeat
		aux := Copy(p,1,Pos(#10#13,p)-1);

		if aux = '' then
			raise Exception.Create('Sintax error!' + ' ' + ' Parameter expected.');

		try
			LValor := TAnalyzers.Expression(aux);
			formCrt.Write(TValues.ToString(LValor));
		finally;
			TValues.FreeValue(LValor);
		end;

		Delete(p,1,Length(Aux)+2);
	until p='';
	formCrt.Retorno;
end;

procedure ProcRead(p: string);
var
	LLectura : string;
	LValor : TValue;
	LTipo : TTypeNumber;
	i : string;
begin
	LLectura := formCrt.Read;

	i := TExtractors.ExtractIdentifier(p);
	LTipo := Variables.Variable(i).TypeNumber;
	LValor := TValues.ParseDef(LLectura, LTipo);
	Variables.Assign(i+P,LValor);
end;

procedure ProcReadln(p: String);
var
	LLectura : string;
	LValor : TValue;
	LTipo : TTypeNumber;
	i : string;
begin
	LLectura := formCrt.Read;

	i := TExtractors.ExtractIdentifier(p);
	LTipo := Variables.Variable(i).TypeNumber;
	LValor := TValues.ParseDef(LLectura, LTipo);
	Variables.Assign(i+P,LValor);
	formCrt.Retorno;
end;

procedure ProcWriteFile(p: string);
var
	aux : string;
	LArchivo : TArchivo;
	LValor : TValue;
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
			LValor := TAnalyzers.Expression(aux);
			LArchivo.Write(TValues.ToString(LValor));
		finally
			TValues.FreeValue(LValor);
		end;

		Delete(p,1,Length(Aux)+2);
	until p='';
end;

procedure ProcWriteFileln(p: string);
var
	LValor : TValue;
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
			LValor := TAnalyzers.Expression(aux);
			LArchivo.Writeln(TValues.ToString(LValor));
		finally
			TValues.FreeValue(LValor);
		end;

		Delete(p,1,Length(Aux)+2);
	until p='';
end;

procedure ProcReadFile(p: string);
var
	LValor : TValue;
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
	LValor := Variables.Parse(Aux);
	LArchivo.Read(LValor);
	Variables.Assign(Aux,LValor);
end;

procedure ProcReadFileln(p: String);
var
	LValor : TValue;
	LArchivo : TArchivo;
	Aux : string;
begin
	Aux := Copy(P,1,Pos(#10#13,p)-1);
	Delete(p,1,Pos(#10#13,p)+1);
	if not Archivos.EsArchivo(Aux) then
		raise Exception.Create('Sintax error!' + ' ' + 'Unknown file identifier.');

	LArchivo := Archivos.Archivo(Aux);
	Aux := Copy(P,1,Pos(#10#13,p)-1);
	LValor := Variables.Parse(Aux);
	LArchivo.Readln(LValor);
	Variables.Assign(Aux,LValor);
end;

//----------- Procedures ---------------//

procedure ProcedimientosPorDefecto;
begin
	Procedures.Add('CLS',ProcCLS);
	Procedures.Add('LIMPIAR',ProcCLS);
	Procedures.Add('WRITE',ProcWrite);
	Procedures.Add('MOSTRAR',ProcWrite);
	Procedures.Add('WRITELN',ProcWriteln);
	Procedures.Add('MOSTRARRT',ProcWriteln);
	Procedures.Add('READ',ProcRead);
	Procedures.Add('LEER',ProcRead);
	Procedures.Add('READLN',ProcReadln);
	Procedures.Add('LEERRT',ProcReadln);
	Procedures.Add('WRITEFILE',ProcWriteFile);
	Procedures.Add('MOSTRARARCHIVO',ProcWriteFile);
	Procedures.Add('WRITEFILELN',ProcWriteFileln);
	Procedures.Add('MOSTRARARCHIVORT',ProcWriteFileln);
	Procedures.Add('READFILE',ProcReadFile);
	Procedures.Add('LEERARCHIVO',ProcReadFile);
	Procedures.Add('READFILELN',ProcReadFileln);
	Procedures.Add('LEERARCHIVORT',ProcReadFileln);
	Procedures.Add('RANDOMIZE',ProcRandomize);
	Procedures.Add('ALEATORIZAR',ProcRandomize);
end;

initialization
	Procedures := TProcedures.Create;

  ProcedimientosPorDefecto;

finalization
	Procedures.Free;

end.

