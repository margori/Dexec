unit UArchivos;

interface

uses sysutils, classes, UValores;

type
	TAcceso = (Lectura, Reescritura, Escritura);

	TInfoArchivo = record
		Nombre : String;
		Ruta : String;
		Acceso : TAcceso;
	end;

	TArchivo = class
	private
		FArchivo : TextFile;
		FAbierto: Boolean;
		FRuta: String;
		FAcceso: TAcceso;
		FNombre: String;
		procedure SetAcceso(const Value: TAcceso);
		procedure SetRuta(const Value: String);
	public
		property Nombre : String read FNombre write FNombre;
		property Acceso : TAcceso read FAcceso write SetAcceso;
		property Ruta : String read FRuta write SetRuta; // Ruta en el sistema de archivos

		property Abierto : Boolean read FAbierto;

		procedure Abrir;
		procedure Cerrar;

		procedure Write(S: String);
		procedure Writeln(S: String);
		procedure Read(AValue : TValue);
		procedure Readln(AValue : TValue);
	end;

	TArchivos = class
	private
		FArchivos : TList;
    FRutaBase: string;
	public
		constructor Create;
		destructor Destroy; override;

		procedure Registrar(ANombre, ARuta: String; AAcceso: TAcceso); overload;
		procedure Registrar(AArchivo: TInfoArchivo); overload;
		procedure Deregistrar(Index: Integer);
		procedure DeregistrarTodo;

		procedure Inicializar;
		procedure Finalizar;

		function EsArchivo(ANombre: String): Boolean;
		function Archivo(ANombre: String): TArchivo; overload;
		function Archivo(Index: Integer): TArchivo; overload;

		function Count : Integer;

		procedure Modificar(Index: Integer; AInfoArchivo: TInfoArchivo);

    property RutaBase : string read FRutaBase write FRutaBase;
	end;

var
	Archivos : TArchivos;

implementation

uses UTipos;

{ TArchivo }

procedure TArchivo.Abrir;
begin
  if self.Abierto then
    raise Exception.Create('Cannot open already opened files');

	case Acceso of
		Lectura:
		begin
			if FileExists(Self.Ruta) then
			begin
				AssignFile(FArchivo,FRuta);
				Reset(Self.FArchivo);
			end
			else if FileExists(Archivos.RutaBase + Self.Ruta) then
			begin
				AssignFile(FArchivo,Archivos.RutaBase + FRuta);
				Reset(Self.FArchivo);
			end
			else
				raise Exception.Create('File does not exist!');
		end;
		Reescritura :
		begin
			if DirectoryExists(ExtractFileDir(Self.Ruta)) then
			begin
				AssignFile(FArchivo,FRuta);
				Rewrite(Self.FArchivo);
			end
			else
			begin
				AssignFile(FArchivo,Archivos.RutaBase + FRuta);
				Rewrite(Self.FArchivo);
			end;
		end;
		Escritura:
		begin
			if FileExists(Self.Ruta) then
			begin
				AssignFile(FArchivo,FRuta);
				Append(Self.FArchivo);
			end
			else if FileExists(Archivos.RutaBase + Self.Ruta) then
			begin
				AssignFile(FArchivo,Archivos.RutaBase + FRuta);
				Append(Self.FArchivo);
			end
			else
				raise Exception.Create('File does not exist!');
		end;
	end;
	FAbierto := True;
end;

procedure TArchivo.Cerrar;
begin
	CloseFile(FArchivo);
	FAbierto := False;
end;

procedure TArchivo.Read(AValue: TValue);
begin
  if not self.Abierto then
    raise Exception.Create('Cannot read on closed files!');

	case AValue.ValueType of
		nInt32: System.read(FArchivo,PInteger32(AValue.ValuePointer)^);
		nExte: System.read(FArchivo,PExte(AValue.ValuePointer)^);
		nString: System.read(FArchivo,PString(AValue.ValuePointer)^);
{$IFDEF debug}
	else
		raise Exception.Create('Reading error!');
{$endIF}
	end;
end;

procedure TArchivo.Readln(AValue: TValue);
begin
  if not self.Abierto then
    raise Exception.Create('Cannot read on closed files');

	case AValue.ValueType of
		nInt32: System.readln(FArchivo,PInteger32(AValue.ValuePointer)^);
		nExte: System.readln(FArchivo,PExte(AValue.ValuePointer)^);
		nString: System.readln(FArchivo,PString(AValue.ValuePointer)^);
{$IFDEF debug}
	else
		raise Exception.Create('Reading error!');
{$endIF}
	end;
end;

procedure TArchivo.SetAcceso(const Value: TAcceso);
begin
	if Self.Abierto then
		raise Exception.Create('Access mode cannot be changed on an open file!');

	FAcceso := Value;
end;

procedure TArchivo.SetRuta(const Value: String);
var
	LRuta : String;
begin
	if Self.Abierto then
		raise Exception.Create('Path cannot be changed on an open file!');

	LRuta := Value;
	if Copy(LRuta,1,Length(Archivos.RutaBase)) = Archivos.RutaBase then
			Delete(LRuta,1,Length(Archivos.RutaBase));
	FRuta := LRuta;
end;

procedure TArchivo.Write(S: String);
begin
	if not Self.Abierto then
		raise Exception.Create('File must be open in order to read it!');

	System.write(FArchivo,S);
end;

procedure TArchivo.Writeln(S: String);
begin
	if not Self.Abierto then
		raise Exception.Create('File must be open in order to write it!');

	System.writeln(FArchivo,S);
end;

{ TArchivos }

function TArchivos.Archivo(ANombre : String): TArchivo;
var
	j : integer;
	LArchivo : TArchivo;
begin
	Result := Nil;
	for j := 0 to FArchivos.Count-1 do
	begin
		LArchivo := FArchivos.Items[j];
		if LArchivo.Nombre = ANombre then
		begin
			Result := LArchivo;
			Break;
		end;
	end;
end;

function TArchivos.Archivo(Index: Integer): TArchivo;
begin
	if (Index<0) or (Index>FArchivos.Count-1) then
		raise Exception.Create('File index out of range!');
	Result := FArchivos.Items[Index];
end;

function TArchivos.Count: Integer;
begin
	Result := FArchivos.Count;
end;

constructor TArchivos.Create;
begin
	inherited;
	FArchivos := TList.create;
end;

procedure TArchivos.Deregistrar(Index: Integer);
var
	LArchivo : TArchivo;
begin
	LArchivo := FArchivos.Items[Index];
	FArchivos.Delete(Index);
	LArchivo.Free;
end;

procedure TArchivos.DeregistrarTodo;
begin
	while FArchivos.Count>0 do
		Deregistrar(0);
end;

destructor TArchivos.destroy;
begin
	DeregistrarTodo;
	FArchivos.Free;
	inherited;
end;

function TArchivos.EsArchivo(ANombre: String): Boolean;
var
	j : integer;
	LArchivo : TArchivo;
begin
	Result := False;
	for j := 0 to FArchivos.Count-1 do
	begin
		LArchivo := FArchivos.Items[j];
		if LArchivo.Nombre = ANombre then
		begin
			Result := True;
			Break;
		end;
	end;
end;

procedure TArchivos.Finalizar;
var
	j : integer;
	LArchivo: TArchivo;
begin
	for j := 0 to FArchivos.Count-1 do
	begin
		LArchivo := Farchivos.Items[j];
		LArchivo.Cerrar;
	end;
end;

procedure TArchivos.Inicializar;
var
	j : integer;
	LArchivo: TArchivo;
begin
	for j := 0 to FArchivos.Count-1 do
	begin
		LArchivo := Farchivos.Items[j];

		if LArchivo.Abierto then
			LArchivo.Cerrar;

		LArchivo.Abrir;
	end;
end;

procedure TArchivos.Modificar(Index: Integer; AInfoArchivo: TInfoArchivo);
var
	LArchivo : TArchivo;
begin
	LArchivo := FArchivos.Items[Index];
	LArchivo.Ruta := AInfoArchivo.Ruta;
	LArchivo.Acceso := AInfoArchivo.Acceso;
end;

procedure TArchivos.Registrar(ANombre, ARuta: String; AAcceso: TAcceso);
var
	LArchivo: TArchivo;
begin
	LArchivo := TArchivo.Create;
	LArchivo.Nombre := ANombre;
	LArchivo.Ruta := ARuta;
	Larchivo.Acceso := AAcceso;

	FArchivos.Add(LArchivo);
end;

procedure TArchivos.Registrar(AArchivo: TInfoArchivo);
begin
	Registrar(AArchivo.Nombre , AArchivo.Ruta, AArchivo.Acceso);
end;

initialization
begin
	Archivos := TArchivos.Create;
end;

finalization
begin
	Archivos.Free;
end;

end.
