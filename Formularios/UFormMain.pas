unit UFormMain;

interface

uses
	SysUtils, Variants, Classes, Graphics, Controls,
	Forms, Dialogs, StdCtrls, ExtCtrls, UObjetos, Buttons, ComCtrls, Menus,
	Grids, ActnList;

type

{ TFormMain }

TFormMain = class(TForm)
    toolbarMain: TToolBar;
    btnSentencia: TToolButton;
		btnCondicion: TToolButton;
		btnNodo: TToolButton;
		btnSeleccion: TToolButton;
    btnBorrar: TToolButton;
    ToolButton2: TToolButton;
    MainMenu1: TMainMenu;
    Archivo1: TMenuItem;
		Abrir1: TMenuItem;
    Salvar1: TMenuItem;
		Salvarcomo1: TMenuItem;
    Ejecutar1: TMenuItem;
    Ejecutar2: TMenuItem;
    Paso1: TMenuItem;
    btnFinal: TToolButton;
    Stop1: TMenuItem;
    N1: TMenuItem;
		Salir1: TMenuItem;
		btnSalir: TToolButton;
		ToolButton3: TToolButton;
    Salida1: TMenuItem;
		OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Nuevo1: TMenuItem;
    btnAbrir: TToolButton;
		btnSalvar: TToolButton;
		btnNuevo: TToolButton;
		ToolButton7: TToolButton;
		ScrollBox1: TScrollBox;
		ImageList1: TImageList;
		ToolButton4: TToolButton;
    btnEjecutar: TToolButton;
    btnPaso: TToolButton;
    btnParar: TToolButton;
		BevelAncho: TBevel;
		BevelAlto: TBevel;
		Ayuda1: TMenuItem;
		Acercade1: TMenuItem;
    btnPausa: TToolButton;
    Pausa1: TMenuItem;
    btnSalida: TToolButton;
		btnEntrada: TToolButton;
		splitterPanelDerecho: TSplitter;
    ToolButton5: TToolButton;
    btnCrt: TToolButton;
    panelDerecho: TPanel;
    panelVariables: TPanel;
    labelVariables: TLabel;
    toolBarVariables: TToolBar;
    btnNuevaVar: TToolButton;
    btnModificarVar: TToolButton;
    btnBorrarVar: TToolButton;
    gridVariables: TStringGrid;
    Splitter1: TSplitter;
    panelArchivos: TPanel;
    N2: TMenuItem;
    toolbarArchivos: TToolBar;
    btnNuevoArchivo: TToolButton;
    btnModificarArchivo: TToolButton;
    btnBorrarArchivo: TToolButton;
    gridArchivos: TStringGrid;
		labelArchivos: TLabel;
    btnAlto: TToolButton;
    ToolButton6: TToolButton;
    ActionList1: TActionList;
		actSalir: TAction;
		actNuevo: TAction;
    actAbrir: TAction;
    actSalvar: TAction;
    actSalvarComo: TAction;
    actEjecutar: TAction;
    actPausa: TAction;
    actPaso: TAction;
		actParar: TAction;
		actSalida: TAction;
		actAcercade: TAction;

		procedure IntruccionDestroy(Sender : TObject);
		procedure InstruccionMouseDown(Sender: TObject; Button: TMouseButton;
			Shift: TShiftState; X, Y: Integer);
		procedure InstruccionMouseMove(Sender: TObject; Shift: TShiftState; X,
			Y: Integer);
		procedure InstruccionMouseUp(Sender: TObject; Button: TMouseButton;
			Shift: TShiftState; X, Y: Integer);

		procedure UnionMouseDown(Sender: TObject; Button: TMouseButton;
			Shift: TShiftState; X, Y: Integer);
		procedure UnionMouseUp(Sender: TObject; Button: TMouseButton;
			Shift: TShiftState; X, Y: Integer);
		procedure UnionMouseMove(Sender: TObject; Shift: TShiftState; X,
			Y: Integer);

		procedure SegmentoMouseDown(Sender: TObject; Button: TMouseButton;
			Shift: TShiftState; X, Y: Integer);
		procedure SegmentoMouseUp(Sender: TObject; Button: TMouseButton;
			Shift: TShiftState; X, Y: Integer);
		procedure SegmentoMouseMove(Sender: TObject; Shift: TShiftState; X,
			Y: Integer);

		procedure DraggerMouseMove(Sender: TObject; Shift: TShiftState; X,
			Y: Integer);

		procedure FormCreate(Sender: TObject);
		procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
		procedure FormShow(Sender: TObject);
		procedure FormKeyDown(Sender: TObject; var Key: Word;
			Shift: TShiftState);

		procedure ScrollBox1MouseDown(Sender: TObject; Button: TMouseButton;
			Shift: TShiftState; X, Y: Integer);
		procedure ScrollBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
			Y: Integer);
		procedure ScrollBox1MouseUp(Sender: TObject; Button: TMouseButton;
			Shift: TShiftState; X, Y: Integer);

		procedure btnBorrarClick(Sender: TObject);
		procedure actPasoExecute(Sender: TObject);
		procedure actPararExecute(Sender: TObject);
		procedure actEjecutarExecute(Sender: TObject);
		procedure Variables1Click(Sender: TObject);
		procedure actSalidaExecute(Sender: TObject);
		procedure actSalvarcomoExecute(Sender: TObject);
		procedure actSalvarExecute(Sender: TObject);
		procedure actAbrirExecute(Sender: TObject);
		procedure actNuevoExecute(Sender: TObject);
		procedure actAcercadeExecute(Sender: TObject);
		procedure actPausaExecute(Sender: TObject);
		procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
			WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
		procedure btnCrtClick(Sender: TObject);
		procedure btnNuevaVarClick(Sender: TObject);
		procedure btnModificarVarClick(Sender: TObject);
		procedure btnBorrarVarClick(Sender: TObject);
		procedure gridVariablesDblClick(Sender: TObject);
		procedure btnNuevoArchivoClick(Sender: TObject);
		procedure btnModificarArchivoClick(Sender: TObject);
		procedure btnBorrarArchivoClick(Sender: TObject);
		procedure ScrollBox1MouseWheel(Sender: TObject; Shift: TShiftState;
			WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
		procedure btnAltoClick(Sender: TObject);
		procedure actSalirExecute(Sender: TObject);
	private
		FPausa : Boolean;

		Encabezado : String;

		TamanoInicial: TPoint;
		PosInicialMouse : TPoint;
		PosInicialInstruccion : array of TPoint;

		FUnion1: TUnion;
		FInstruccionActual: TInstruccion;
		FArchivoPrograma: String;
		FModificado: Boolean;

		FArrastrandoObjeto : Boolean;
		FArrastrandoTamano : Boolean;
		FEjecutando: Boolean;
//		FArrastrandoUnion : Boolean;

		procedure Propiedades(AInstruccion :TInstruccion);

		procedure InstruccionEventos(AInstruccion : TInstruccion);
		procedure FlechaDestroy(Sender: TObject);

		procedure SetInstruccionActual(const Value: TInstruccion);

		procedure SetArchivoPrograma(const Value: String);

		procedure Modificacion(Sender: TObject);

		procedure Salvar;
		procedure Cargar;

		procedure AjustarInstrucciones;
		procedure AjustarBevel;
		procedure SetModificado(const Value: Boolean);
		procedure SetEjecutando(const Value: Boolean);
		procedure SetPausa(const Value: Boolean);

		procedure ActualizarTitulo;
		procedure ActualizarArchivos;
		procedure ActualizarVariables;
	public
		Dragger : TDragger;

		Seleccion : TList;

		Instrucciones : TList;
		Flechas : TList;

		property Ejecutando : Boolean read FEjecutando write SetEjecutando;
		property Pausa : Boolean read FPausa write SetPausa;
		property Modificado: Boolean read FModificado write SetModificado;

		property ArchivoPrograma : String read FArchivoPrograma write SetArchivoPrograma;
		property InstruccionActual: TInstruccion read FInstruccionActual write SetInstruccionActual;
	end;

var
	FormMain: TFormMain;

implementation

uses FileUtil, LCLType, UFormCrt, UVariables, UTipos, UValores,
	UFormPropiedades, UConstantes, UArchivos, UFormAcercade,
	UFormPropiedadesSalida, UFormPropiedadesVariables,
	UFormPropiedadesArchivos;

{$R *.dfm}

procedure TFormMain.FormCreate(Sender: TObject);
begin
	// TODO: Translate Components
	Encabezado := 'Dexec';

	GOnSegmentoMouseDown := SegmentoMouseDown;
	GOnSegmentoMouseUp := SegmentoMouseUp;
	GOnSegmentoMouseMove := SegmentoMouseMove;

	ThousandSeparator := ',';
	DecimalSeparator := '.';

	Instrucciones := TList.Create;
	Flechas := TList.Create;
	Seleccion := TList.Create;

	Dragger := TDragger.Create(Self);
	Dragger.Parent := ScrollBox1;
	Dragger.Visible := False;
	Dragger.OnMouseMove := DraggerMouseMove;

	//ScrollBox1.VertScrollBar.Margin := BORDE_PANTALLA;
	//ScrollBox1.HorzScrollBar.Margin := BORDE_PANTALLA;

	Nuevo1.Click;

	gridVariables.Cells[0,0] := 'Variable';
	gridVariables.Cells[1,0] := 'Value';
	gridArchivos.Cells[0,0] := 'Name';
	gridArchivos.Cells[1,0] := 'Access';
	gridArchivos.Cells[2,0] := 'Path';

	ActualizarVariables;
end;

procedure TFormMain.InstruccionMouseMove(Sender: TObject;
	Shift: TShiftState; X, Y: Integer);
var
  LInstruccion: TInstruccion;
  LPos : TPoint;
  j : integer;
begin
	Assert(Sender is TInstruccion);
	LInstruccion := Sender as TInstruccion;
	LPos.X := LInstruccion.Left + X;
	LPos.Y := LInstruccion.Top + Y;

	if FArrastrandoObjeto then
	begin
		for j := 0 to Seleccion.Count-1 do
		begin
			with TInstruccion(Seleccion.Items[j]) do
			begin
				X := PosInicialInstruccion[j].X + LPos.X - PosInicialMouse.X;
				Y := PosInicialInstruccion[j].Y + LPos.Y - PosInicialMouse.Y;
			end;
		end;
	end
	else if FArrastrandoTamano then
	begin
		for j := 0 to Seleccion.Count-1 do
		begin
			with TInstruccion(Seleccion.Items[j]) do
			begin
				Ancho := TamanoInicial.X + (LPos.X - PosInicialMouse.X)*2;
				Alto := TamanoInicial.Y + (LPos.Y - PosInicialMouse.Y)*2;
			end;
		end;
	end
	else if Assigned(FUnion1) and Dragger.Visible then
	begin
		Dragger.X2 := TInstruccion(Sender).Left+X;
		Dragger.Y2 := TInstruccion(Sender).Top+Y;
	end;

end;

procedure TFormMain.DraggerMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
	if Assigned(FUnion1) and Dragger.Visible then
	begin
		Dragger.X2 := TDragger(Sender).Left+X;
		Dragger.Y2 := TDragger(Sender).Top+Y;
	end;
end;

procedure TFormMain.IntruccionDestroy(Sender: TObject);
var j: integer;
begin
	j := Instrucciones.IndexOf(Sender);
  Assert(j>-1);
  if j>-1 then
    Instrucciones.Delete(j);
end;

procedure TFormMain.actPasoExecute(Sender: TObject);
begin
	formCrt.Show;
	formCrt.BringToFront;

	if formCrt.Leyendo then
		exit;

	try
		if InstruccionActual = Nil then
			InstruccionActual := TInstruccion(Instrucciones.Items[0])
		else
			InstruccionActual := InstruccionActual.Ejecutar;
	except
		Pausa := true;
		raise;
	end;

	Ejecutando := True;
		
	ActualizarVariables;
end;

procedure TFormMain.actPararExecute(Sender: TObject);
begin
	formCrt.Finalizar;
	Ejecutando := False;
	Pausa := False;
	InstruccionActual := Nil;
	ActualizarVariables;
end;

procedure TFormMain.SetInstruccionActual(const Value: TInstruccion);
begin
	if FInstruccionActual <> Value then
	begin
		if FInstruccionActual <> Nil then
		begin
			FInstruccionActual.Ejecutando := False;
			FInstruccionActual.Error := False;
		end
		else
		begin
			Variables.Inicializar;
			Archivos.Inicializar;
		end;

		FInstruccionActual := Value;
		if FInstruccionActual <> Nil then
		begin
			FInstruccionActual.Ejecutando := True;
			FInstruccionActual.Error := False;
		end
		else
		begin
			Archivos.Finalizar;
			formCrt.Hide;
		end;
	end;
end;

procedure TFormMain.actEjecutarExecute(Sender: TObject);
var
	Fin : Boolean;
begin
	if formCrt.Leyendo then
		exit;

	Pausa := False;
	Ejecutando := True;

	repeat
		Paso1.Click;
		Application.ProcessMessages;
		if InstruccionActual <> Nil then
		begin
			if Pausa then
				Fin := True
			else
				Fin := InstruccionActual.BreakPoint;
		end
		else
			Fin := True;
	until Fin;
	Ejecutando := InstruccionActual <> Nil;
end;

procedure TFormMain.Variables1Click(Sender: TObject);
begin
	panelVariables.Visible := not panelVariables.Visible;
//	Variables1.Checked := panelVariables.Visible;
end;

procedure TFormMain.actSalidaExecute(Sender: TObject);
begin
	formCrt.Visible := not formCrt.Visible;
	btnCrt.Down := actSalida.Checked;
end;

procedure TFormMain.SetArchivoPrograma(const Value: String);
begin
	FArchivoPrograma := Value;
	Archivos.RutaBase := ExtractFilePath(Value);
end;

procedure TFormMain.actSalvarcomoExecute(Sender: TObject);
begin
	SaveDialog1.FileName := ArchivoPrograma;
	if SaveDialog1.Execute then
	begin
		ArchivoPrograma := SaveDialog1.FileName;
		if ExtractFileExt(ArchivoPrograma)='' then
      ArchivoPrograma := ArchivoPrograma +'.dxp';

    if not FileExists(ArchivoPrograma) then
      Salvar
    else
			if MessageDlg('Do you want to replace?', mtConfirmation, [mbYes,mbNo],-1) = mrYes then
        Salvar;
  end;
end;

procedure TFormMain.actSalvarExecute(Sender: TObject);
begin
  if ArchivoPrograma = '' then
    Salvarcomo1.Click
  else
    Salvar;
end;

procedure TFormMain.actAbrirExecute(Sender: TObject);
begin
  if FModificado then
		case MessageDlg('Do you want to save?',mtConfirmation,mbYesNoCancel,-1) of
      mrYes : Salvar1.Click;
      mrCancel : Exit;
    end;

  if OpenDialog1.Execute then
  begin
    Stop1.Click;
    ArchivoPrograma := OpenDialog1.FileName;
    Cargar;
  end;
end;

procedure TFormMain.actNuevoExecute(Sender: TObject);
var
	Aux : TInstruccion;
begin
	if (Instrucciones.Count>0) then
	begin
	 if FModificado then
			case MessageDlg('Do you want to save?',mtConfirmation,mbYesNoCancel,-1) of
				mrYes : Salvar1.Click;
				mrCancel : Exit;
			end;

		Stop1.Click
	end;

	while Instrucciones.Count>0 do
	begin
		Aux := TInstruccion(Instrucciones[0]);
		Aux.Free;
	end;

	Instrucciones.Clear;

	Aux := TInicio.Create(Self,ScrollBox1);
	InstruccionEventos(Aux);
	Instrucciones.Add(Aux);
	Aux.X := 100; // Da igual ya
	Aux.Y := 100; // Cambiar
	Aux.Caption := 'Program';
	Aux.Texto := '';

	InstruccionActual := Nil;

	Variables.DeregistrarTodo;
	ActualizarVariables;

	Archivos.DeregistrarTodo;
	ActualizarArchivos;

	ArchivoPrograma := '';
	AjustarInstrucciones;
	AjustarBevel;
	Modificado := False;
end;

procedure TFormMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
	if Modificado then
		case MessageDlg('Do you want to save?',mtConfirmation,mbYesNoCancel,-1) of
			mrYes : Salvar1.Click;
			mrCancel : CanClose := False;
		end;
end;

procedure TFormMain.FlechaDestroy(Sender: TObject);
var j: integer;
begin
	j := Flechas.IndexOf(Sender);
	Assert(j>-1);
	Flechas.Delete(j);
end;

procedure TFormMain.Cargar;
var
	LEntrada: TextFile;
	LInstruccion : TInstruccion;
	LFlecha : TFlecha;
	LSegmento : TSegmento;
	LUnion1,LUnion2 : TUnion;
	S : String;
	LInfoVariable: TInfoVariable;
	LInfoArchivo: TInfoArchivo;
	Cant,j,Aux : integer;
	X1,X2,Y1,Y2 : Integer;
	LVersion : String;
begin
	Stop1.Click;

	Seleccion.Clear;

	while Instrucciones.Count>0 do
	begin
		LInstruccion := TInstruccion(Instrucciones[0]);
		LInstruccion.Free;
	end;
	Instrucciones.Clear;

	while Flechas.Count>0 do
	begin
		LFlecha := TFlecha(Flechas[0]);
		LFlecha.Free;
	end;
	Flechas.Clear;

	Variables.DeregistrarTodo;
	Archivos.DeregistrarTodo;

	try
		AssignFile(LEntrada,fArchivoPrograma);
		Reset(LEntrada);

		Readln(LEntrada,LVersion);


// Cargo variables
		if LVersion <>'Variables' then
			Readln(LEntrada,S); // Descarte por ser solo un identificador
		Readln(LEntrada,S);
		Cant := StrToInt(S);

		for j := 1 to Cant do
		begin
			Readln(LEntrada,S);
			LInfoVariable.Tipo := TTipos.GetTipo(S);
			Readln(LEntrada,S);
			Readln(LEntrada,S);
			LInfoVariable.Nombre := Copy(S,10,Length(S));
			Readln(LEntrada,S);
			LInfoVariable.ValorPorDefecto := Copy(S,19,Length(S));
			Readln(LEntrada,S);
			if LVersion = '1.0' then
				LInfoVariable.Filas := StrToInt(Copy(S,7,Length(S)))
			else
				LInfoVariable.Filas := StrToInt(Copy(S,8,Length(S)));
			Readln(LEntrada,S);
			if LVersion = '1.0' then
				LInfoVariable.Columnas := StrToInt(Copy(S,7,Length(S)))
			else
				LInfoVariable.Columnas := StrToInt(Copy(S,11,Length(S)));
			Readln(LEntrada,S);
			Variables.Registrar(LInfoVariable);
		end;
		ActualizarVariables;

// Cargo archivos
		Readln(LEntrada,S); // Descarte por ser solo un identificador
		Readln(LEntrada,S);
		Cant := StrToInt(S);

		for j := 1 to Cant do
		begin
			LInfoArchivo.Nombre := '';
			Readln(LEntrada,S);
			if S<>'{' then
			begin
				LInfoArchivo.Nombre := S;
				Readln(LEntrada,S);
			end;

			Readln(LEntrada,S);
			LInfoArchivo.Ruta := Copy(S,8,Length(S));
			Readln(LEntrada,S);
			S := Copy(S,10,Length(S));
			if S='Lectura' then
				LInfoArchivo.Acceso := Lectura
			else if S='Reescritura' then
				LInfoArchivo.Acceso := Reescritura
			else if S='Escritura' then
				LInfoArchivo.Acceso := Escritura
			else
				raise Exception.Create('Error en archivo');
			Readln(LEntrada,S);
			if LInfoArchivo.Nombre = '' then
				LInfoArchivo.Nombre := IntToStr(j-1);

			Archivos.Registrar(LInfoArchivo);
		end;
		ActualizarArchivos;

// Cargo instrucciones
		Readln(LEntrada,S); // Descarte por ser solo un identificador
		Readln(LEntrada,S);
		Cant := StrToInt(S);

    LInstruccion := Nil;
		for j:= 1 to Cant do // carga de instrucciones
		begin
			Readln(LEntrada,S);

			if S = 'Entrada' then
				LInstruccion := TEntrada.Create(Self,ScrollBox1)
			else if S = 'Salida' then
				LInstruccion := TSalida.Create(Self,ScrollBox1)
			else if S = 'Sentencia' then
				LInstruccion := TSentencia.Create(Self,ScrollBox1)
			else if S = 'Condicion' then
				LInstruccion := TCondicion.Create(Self,ScrollBox1)
			else if S = 'Nodo' then
				LInstruccion := TNodo.Create(Self,ScrollBox1)
			else if S = 'Inicio' then
				LInstruccion := TInicio.Create(Self,ScrollBox1)
			else if S = 'Fin' then
				LInstruccion := TFin.Create(Self,ScrollBox1)
			else
				raise Exception.Create('File error!');

			Instrucciones.Add(LInstruccion);
			InstruccionEventos(LInstruccion);
			Readln(LEntrada,S);
			Readln(LEntrada,S);

			LInstruccion.X := StrToInt(Copy(S,5,Length(S)));
			Readln(LEntrada,S);
			LInstruccion.Y := StrToInt(Copy(S,5,Length(S)));
			Readln(LEntrada,S);
			LInstruccion.Ancho := StrToInt(Copy(S,9,Length(S)));
			Readln(LEntrada,S);
			LInstruccion.Alto := StrToInt(Copy(S,8,Length(S)));
			Readln(LEntrada,S);
			LInstruccion.Caption := Copy(S,11,Length(S));
			Readln(LEntrada,S);
			if S = 'MuestraCaption = Si' then
				LInstruccion.MuestraCaption := True
			else if S = 'MuestraCaption = No' then
				LInstruccion.MuestraCaption := False;

      if LInstruccion is TEntradaSalida then
        with LInstruccion as TEntradaSalida do
        begin
          Readln(LEntrada,S);
          Parametros := Copy(S,14,Length(S));
					Readln(LEntrada,S);
					if S = 'Dispositivo = Pantalla' then
            Dispositivo := diPantalla
          else if S = 'Dispositivo = Archivo' then
            Dispositivo := diArchivo
          else
            raise Exception.Create('File error!');
          Readln(LEntrada,S);
          Archivo := Copy(S,10,Length(S));
          Readln(LEntrada,S);
          if S = 'Retorno = Si' then
            Retorno := True
          else if S = 'Retorno = No' then
            Retorno := False
          else
            raise Exception.Create('File error!');
        end
      else
      begin
        Readln(LEntrada,S);
        LInstruccion.Texto := Copy(S,9,Length(S));
      end;

			Readln(LEntrada,S);
			if S = 'MuestraTexto = Si' then
				LInstruccion.MuestraTexto := True
			else if S = 'MuestraTexto = No' then
				LInstruccion.MuestraTexto := False;
			Readln(LEntrada,S);
			if S = 'Bloqueado = Si' then
				LInstruccion.Bloqueado := True
			else if S = 'Bloqueado = No' then
				LInstruccion.Bloqueado := False;
			Readln(LEntrada,S);
			if S = 'BreackPoint = Si' then
				LInstruccion.BreakPoint := True
			else if S = 'BreackPoint = No' then
				LInstruccion.BreakPoint := False;
			Readln(LEntrada,S);
			if S <> '}' then
				raise Exception.Create('File error!');
		end;

    // Cargo flechas
	  Readln(LEntrada,S); // Descartado por solo ser un comentario
		Readln(LEntrada,S);
		Cant := StrToInt(S);

		for j:= 1 to Cant do // carga de flechas
		begin
			Readln(LEntrada,S);
			Readln(LEntrada,S);

			Readln(LEntrada,S);
			Aux := StrToInt(Copy(S,14,Length(S)));
			LInstruccion := Instrucciones.Items[Aux];
			Readln(LEntrada,S);
      LUnion1 := Nil;
			if S = 'Union = Norte' then
				LUnion1 := LInstruccion.UnionNorte
			else if S = 'Union = Sur' then
				LUnion1 := LInstruccion.UnionSur
			else if S = 'Union = Este' then
				LUnion1 := LInstruccion.UnionEste
			else if S = 'Union = Oeste' then
				LUnion1 := LInstruccion.UnionOeste
			else
				raise Exception.Create('File error!');

			Readln(LEntrada,S);
			Aux := StrToInt(Copy(S,14,Length(S)));
			LInstruccion := Instrucciones.Items[Aux];
			Readln(LEntrada,S);
      LUnion2 := Nil;
			if S = 'Union = Norte' then
				LUnion2 := LInstruccion.UnionNorte
			else if S = 'Union = Sur' then
				LUnion2 := LInstruccion.UnionSur
			else if S = 'Union = Este' then
				LUnion2 := LInstruccion.UnionEste
			else if S = 'Union = Oeste' then
				LUnion2 := LInstruccion.UnionOeste
			else
				raise Exception.Create('File error!');

			LFlecha := TFlecha.Create(Self,ScrollBox1);
			Flechas.Add(LFlecha);
			LFlecha.OnDestroy := FlechaDestroy;
			LFlecha.OnModificar := Modificacion;

			LFlecha.UnionDesde := LUnion1;
			LFlecha.UnionHasta := LUnion2;

			Aux := 0;
			repeat
				Readln(LEntrada,S);

				LSegmento := LFlecha.Segmentos.Items[Aux];
				if S[1] ='Y' then
				begin
					if LSegmento.Direccion = dHorizontal then
					begin
						X1 := LSegmento.X1;
						X2 := LSegmento.X2;
						LSegmento := LFlecha.Segmentos.Items[Aux+1];
						LFlecha.MoverSegmento(LSegmento,X1-X2,0);
						LSegmento := LFlecha.Segmentos.Items[Aux];
					end;
					Y1 := LSegmento.Y2;
					Y2 := StrToInt(Copy(S,5,Length(S)));
					if Y1<>Y2 then
					begin
						LSegmento := LFlecha.Segmentos.Items[Aux+1];
						LFlecha.MoverSegmento(LSegmento,0,Y2-Y1);
	//          LSegmento := LFlecha.Segmentos.Items[Aux];
					end
				end
				else if S[1] ='X' then
				begin
					if LSegmento.Direccion = dVertical then
					begin
						Y1 := LSegmento.Y1;
						Y2 := LSegmento.Y2;
						LSegmento := LFlecha.Segmentos.Items[Aux+1];
						LFlecha.MoverSegmento(LSegmento,0,Y1-Y2);
						LSegmento := LFlecha.Segmentos.Items[Aux];
					end;
					X1 := LSegmento.X2;
					X2 := StrToInt(Copy(S,5,Length(S)));
					if X1<>X2 then
					begin
						LSegmento := LFlecha.Segmentos.Items[Aux+1];
						LFlecha.MoverSegmento(LSegmento,X2-X1,0);
	//          LSegmento := LFlecha.Segmentos.Items[Aux];
					end
				end
				else if S<>'}' then
					raise Exception.Create('File error!');
				Inc(Aux);
			until (S='}') or Eof(LEntrada);
		end;
	finally
		CloseFile(LEntrada);
  end;

  AjustarInstrucciones;
  Modificado := False;
end;

procedure TFormMain.Salvar;
var
	LSalida : TextFile;
	LVariable : TVariable;
	LInstruccion : TInstruccion;
	LFlecha : TFlecha;
	LSegmento : TSegmento;
	LUnion: TUnion;
	LArchivo : TArchivo;
  j,k: integer;
begin
	if FileExists(FArchivoPrograma) then
		CopyFile(PChar(FArchivoPrograma),PChar(FArchivoPrograma + '~'),False);

	AssignFile(LSalida,FArchivoPrograma);
	try
		rewrite(LSalida);

		Writeln(LSalida,'1.1');

		Writeln(LSalida,'Variables');
		Writeln(LSalida,Variables.Count);
		for j := 0 to Variables.Count-1 do
		begin
			LVariable := Variables.Variable(j);
			Writeln(LSalida, TTipos.NombreTipo(LVariable.Tipo));
			Writeln(LSalida, '{');
			Writeln(LSalida, 'Nombre = ', LVariable.Nombre);
			Writeln(LSalida, 'ValorPorDefecto = ', LVariable.ValorPorDefecto);
			Writeln(LSalida, 'Filas = ', LVariable.Filas);
			Writeln(LSalida, 'Columnas = ', LVariable.Columnas);
			Writeln(LSalida, '}');
		end;

		Writeln(LSalida,'Archivos');
		Writeln(LSalida,Archivos.Count);
		for j := 0 to Archivos.Count-1 do
		begin
			LArchivo := Archivos.Archivo(j);
			Writeln(LSalida,LArchivo.Nombre);
			Writeln(LSalida,'{');
			Writeln(LSalida,'Ruta = ',LArchivo.Ruta);
			case LArchivo.Acceso of
				Lectura : Writeln(LSalida,'Acceso = Lectura');
				Reescritura : Writeln(LSalida,'Acceso = Reescritura');
				Escritura : Writeln(LSalida,'Acceso = Escritura');
			end;
			Writeln(LSalida,'}');
    end;

    Writeln(LSalida,'Instrucciones');
    Writeln(LSalida,Instrucciones.Count);
    for j := 0 to Instrucciones.Count-1 do
    begin
      LInstruccion := Instrucciones.Items[j];
      if LInstruccion is TInicio then
        Writeln(LSalida,'Inicio')
      else if (LInstruccion is TSentencia)and not (LInstruccion is TEntradaSalida) then
        Writeln(LSalida,'Sentencia')
      else if LInstruccion is TCondicion then
        Writeln(LSalida,'Condicion')
      else if LInstruccion is TNodo then
        Writeln(LSalida,'Nodo')
      else if LInstruccion is TFin then
        Writeln(LSalida,'Fin')
      else if LInstruccion is TSalida then
        Writeln(LSalida,'Salida')
      else if LInstruccion is TEntrada then
        Writeln(LSalida,'Entrada')
      else 
        raise Exception.Create('Objeto desconocido.');

      Writeln(LSalida,'{');
      Writeln(LSalida,'X = ', LInstruccion.X);
      Writeln(LSalida,'Y = ', LInstruccion.Y);
			Writeln(LSalida,'Ancho = ', LInstruccion.Ancho);
      Writeln(LSalida,'Alto = ', LInstruccion.Alto);
      Writeln(LSalida,'Caption = ', LInstruccion.Caption);
      if LInstruccion.MuestraCaption then
        Writeln(LSalida,'MuestraCaption = Si')
      else
        Writeln(LSalida,'MuestraCaption = No');

      if LInstruccion is TEntradaSalida then
        with (LInstruccion as TEntradaSalida) do
        begin
          Writeln(LSalida,'Parametros = ',Parametros);
          if Dispositivo = diPantalla then
            Writeln(LSalida,'Dispositivo = Pantalla')
          else
            Writeln(LSalida,'Dispositivo = Archivo');
          Writeln(LSalida,'Archivo = ',Archivo);
          if Retorno then
            Writeln(LSalida,'Retorno = Si')
          else
            Writeln(LSalida,'Retorno = No');
        end
      else
        Writeln(LSalida,'Texto = ', LInstruccion.Texto);

      if LInstruccion.MuestraTexto then
        Writeln(LSalida,'MuestraTexto = Si')
      else
        Writeln(LSalida,'MuestraTexto = No');
      if LInstruccion.Bloqueado then
        Writeln(LSalida,'Bloqueado = Si')
      else
				Writeln(LSalida,'Bloqueado = No');
      if LInstruccion.BreakPoint then
        Writeln(LSalida,'BreackPoint = Si')
      else
        Writeln(LSalida,'BreackPoint = No');

      Writeln(LSalida,'}');
    end;

    Writeln(LSalida,'Flechas');
    Writeln(LSalida,Flechas.Count);
    for j:= 0 to Flechas.Count-1 do
    begin
      Writeln(LSalida,'Flecha');
      Writeln(LSalida,'{');
      LFlecha := Flechas.Items[j];
      LUnion := LFlecha.UnionDesde;

      LInstruccion := LUnion.Instruccion;
      Writeln(LSalida,'Instruccion = ',Instrucciones.IndexOf(LInstruccion));

      if LInstruccion.UnionNorte = LUnion then
        Writeln(LSalida,'Union = Norte')
      else if LInstruccion.UnionEste = LUnion then
        Writeln(LSalida,'Union = Este')
      else if LInstruccion.UnionSur = LUnion then
        Writeln(LSalida,'Union = Sur')
      else if LInstruccion.UnionOeste = LUnion then
        Writeln(LSalida,'Union = Oeste')
      else
        Raise Exception.Create('Error en union.');

			LUnion := LFlecha.UnionHasta;
      LInstruccion := LUnion.Instruccion;
      Writeln(LSalida,'Instruccion = ',Instrucciones.IndexOf(LInstruccion));

      if LInstruccion.UnionNorte = LUnion then
        Writeln(LSalida,'Union = Norte')
      else if LInstruccion.UnionEste = LUnion then
        Writeln(LSalida,'Union = Este')
      else if LInstruccion.UnionSur = LUnion then
        Writeln(LSalida,'Union = Sur')
      else if LInstruccion.UnionOeste = LUnion then
        Writeln(LSalida,'Union = Oeste')
      else
        Raise Exception.Create('Error en union.');

      for k := 0 to LFlecha.Segmentos.Count-2 do
      begin
				LSegmento := LFlecha.Segmentos.Items[k];

        if LSegmento.Direccion= dHorizontal then
          Writeln(LSalida,'X = ',LSegmento.X2)
        else
          Writeln(LSalida,'Y = ',LSegmento.Y2);
      end;

      Writeln(LSalida,'}');
    end;
  finally
    CloseFile(LSalida);
  end;
	Modificado := False;
end;

procedure TFormMain.FormShow(Sender: TObject);
begin
	if Assigned(formCrt) then
	begin
		formCrt.Left := Screen.Width - formCrt.Width - 1;
		formCrt.Top := Screen.Height - formCrt.Height - 1;
	end;
end;

procedure TFormMain.Modificacion(Sender: TObject);
begin
	Modificado := True;
end;

procedure TFormMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_DELETE then
		btnBorrar.Click
	else if Key = VK_F3 then
		btnEntrada.Down := True
	else if Key = VK_F4 then
		btnSalida.Down := True
	else if Key = VK_F5 then
		btnSentencia.Down := True
	else if Key = VK_F5 then
		btnSentencia.Down := True
	else if Key = VK_F6 then
		btnCondicion.Down := True
	else if Key = VK_F7 then
		btnFinal.Down := True
	else if Key = VK_F8 then
		btnNodo.Down := True
	else if Key = VK_Escape then
		btnSeleccion.Down := True;
end;

procedure TFormMain.InstruccionMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  LInstruccion : TInstruccion;
  LPosEnSeleccion: Integer;
  j :integer;
begin
	Assert(Sender is TInstruccion,'TInstruccion object expected.');
	LInstruccion := Sender as TInstruccion;

	if Button = mbLeft then
	begin
		if (ssDouble in Shift) and LInstruccion.MouseEnObjeto then
		begin
      Propiedades(Sender as TInstruccion);
		end
		else
		begin
			FArrastrandoObjeto := LInstruccion.MouseEnObjeto and not LInstruccion.Bloqueado;
			FArrastrandoTamano := LInstruccion.MouseEnTamano;
			PosInicialMouse.X := LInstruccion.Left + X;
			PosInicialMouse.Y := LInstruccion.Top + Y;
			TamanoInicial := Point(LInstruccion.Ancho,LInstruccion.Alto);

			LPosEnSeleccion := Seleccion.IndexOf(Sender);

			if (ssCtrl in Shift) and (LInstruccion.MouseEnObjeto or
				LInstruccion.MouseEnTamano) then
			begin
				if LPosEnSeleccion > -1 then
				begin
					LInstruccion.Selected := False;
					Seleccion.Delete(LPosEnSeleccion);
				end
				else
				begin
					LInstruccion.Selected := True;
					Seleccion.Add(LInstruccion);
				end;
			end
			else if (LInstruccion.MouseEnObjeto or
				LInstruccion.MouseEnTamano) then
			begin
				if LPosEnSeleccion = -1 then
				begin
					for j := 0 to Seleccion.Count-1 do
						TInstruccion(Seleccion.Items[j]).Selected := False;
					Seleccion.Clear;
					Seleccion.Add(LInstruccion);
					LInstruccion.Selected := True;
				end;
			end;

			SetLength(PosInicialInstruccion,Seleccion.Count);
			for j := 0 to Seleccion.Count-1 do
				PosInicialInstruccion[j] := Point(TInstruccion(Seleccion.items[j]).X,
					TInstruccion(Seleccion.items[j]).Y);
		end;
	end;
end;

procedure TFormMain.ScrollBox1MouseDown(Sender: TObject; Button: TMouseButton;
	Shift: TShiftState; X, Y: Integer);
var
	Aux : TInstruccion;
	j : integer;
begin
	if btnSeleccion.Down then
  begin
    for j := 0 to Seleccion.Count-1 do
      TInstruccion(Seleccion.Items[j]).Selected := False;
    Seleccion.Clear;
  end
  else
  begin
    if btnEntrada.Down then
			Aux := TEntrada.Create(Self,ScrollBox1)
		else if btnSalida.Down then
      Aux := TSalida.Create(Self,ScrollBox1)
    else if btnSentencia.Down then
      Aux := TSentencia.Create(Self,ScrollBox1)
    else if btnCondicion.Down then
      Aux := TCondicion.Create(Self,ScrollBox1)
    else if btnNodo.Down then
      Aux := TNodo.Create(Self,ScrollBox1)
    else if btnFinal.Down then
			Aux := TFin.Create(Self,ScrollBox1)
		else
			raise Exception.Create('Toolbar button error!');

		Instrucciones.Add(Aux);
		InstruccionEventos(Aux);
		Aux.X := X + ScrollBox1.HorzScrollBar.Position;
		Aux.Y := Y + ScrollBox1.VertScrollBar.Position;

		btnSeleccion.Down := True;
    AjustarInstrucciones;
  end;
end;

procedure TFormMain.ScrollBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
	if Assigned(FUnion1) then
    if (ssLeft in Shift) and (Dragger.Visible) then
    begin
      Dragger.X2 := X;
      Dragger.Y2 := Y;
    end
    else
      Dragger.Hide;
end;

procedure TFormMain.ScrollBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
	if Assigned(FUnion1) then
		if Assigned(FUnion1.Flecha) then
			FUnion1.Flecha.Free;

  if Assigned(FUnion1) then
  begin
    FUnion1.Selected := False;
	  FUnion1 := Nil;
  end;
	Dragger.Hide;
end;

procedure TFormMain.InstruccionEventos(AInstruccion: TInstruccion);
begin
  With AInstruccion do
  begin
    OnMouseDown := InstruccionMouseDown;
	  OnMouseMove := InstruccionMouseMove;
    OnMouseUp := InstruccionMouseUp;
    OnUnionMouseDown := UnionMouseDown;
	  OnUnionMouseUp := UnionMouseUp;
    OnUnionMouseMove := UnionMouseMove;
	  OnDestroy := IntruccionDestroy;
    OnModificar := Modificacion;
  END;
end;

procedure TFormMain.InstruccionMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
	if Dragger.Visible then
		Dragger.Hide;

	FArrastrandoObjeto := False;
	FArrastrandoTamano := False;

	AjustarInstrucciones;
	AjustarBevel;
end;

procedure TFormMain.AjustarInstrucciones;
var
	j,k: integer;
	LInstruccion : TInstruccion;
	LFlecha : TFlecha;
	LSegmento :  TSegmento;
	DX,DY : IntegeR;
begin
	if Instrucciones.Count>0 then
	begin
		DX := 0;
		DY := 0;
		LInstruccion := Instrucciones.Items[0];
		while LInstruccion.Left + ScrollBox1.HorzScrollBar.Position + DX > BORDE_PANTALLA + GRILLAX - 1 do
			DX := DX - GRILLAX;
		while LInstruccion.Left + ScrollBox1.HorzScrollBar.Position + DX < BORDE_PANTALLA - 1 do
			DX := DX + GRILLAX;
		while LInstruccion.Top + ScrollBox1.VertScrollBar.Position + DY > BORDE_PANTALLA + GRILLAY - 1 do
			DY := DY - GRILLAY;
		while LInstruccion.Top + ScrollBox1.VertScrollBar.Position + DY < BORDE_PANTALLA - 1 do
			DY := DY + GRILLAY;

		for j := 1 to Instrucciones.Count-1 do
		begin
			LInstruccion := Instrucciones.Items[j];
			while LInstruccion.Left + ScrollBox1.HorzScrollBar.Position + DX < BORDE_PANTALLA - 1 do
				DX := DX + GRILLAX;
			while LInstruccion.Top + ScrollBox1.VertScrollBar.Position + DY < BORDE_PANTALLA - 1 do
				DY := DY + GRILLAY;
		end;
		for j := 0 to Flechas.Count-1 do
		begin
			LFlecha := Flechas.Items[j];
			for k := 0 to LFlecha.Segmentos.Count-1 do
			begin
				LSegmento := LFlecha.Segmentos.Items[k];
				while LSegmento.Left + ScrollBox1.HorzScrollBar.Position + DX < BORDE_PANTALLA - 1 do
					DX := DX + GRILLAX;
				while LSegmento.Top + ScrollBox1.VertScrollBar.Position + DY < BORDE_PANTALLA - 1 do
					DY := DY + GRILLAY;
			end;
		end;

		for j := 0 to Instrucciones.Count-1 do
		begin
			LInstruccion := Instrucciones.Items[j];
			LInstruccion.X := LInstruccion.X + DX;
			LInstruccion.Y := LInstruccion.Y + DY;
		end;
		for j := 0 to Flechas.Count-1 do
		begin
			LFlecha := Flechas.Items[j];
			LFlecha.DesplazarTodo(DX,DY);
		end;
	end;
end;

procedure TFormMain.UnionMouseDown(Sender: TObject; Button: TMouseButton;
	Shift: TShiftState; X, Y: Integer);
var
	LUnion : TUnion;
begin
	Assert(Sender is TUnion);

	LUnion := TUnion(Sender);
	if (Button=mbLeft) and LUnion.MouseEnUnion and (not Assigned(FUnion1)
		or (LUnion=FUnion1))  then
  begin
    if not Assigned(LUnion.Flecha) then
    begin
      Dragger.X1 := LUnion.X2;
      Dragger.Y1 := LUnion.Y2;
      Dragger.X2 := LUnion.X2;
      Dragger.Y2 := LUnion.Y2;
    end
    else
      if LUnion.Flecha.UnionDesde = LUnion then
      begin
        Dragger.X1 := LUnion.Flecha.UnionHasta.X2;
        Dragger.Y1 := LUnion.Flecha.UnionHasta.Y2;
        Dragger.X2 := LUnion.Flecha.UnionHasta.X2;
        Dragger.Y2 := LUnion.Flecha.UnionHasta.Y2;
      end
      else
      begin
        Dragger.X1 := LUnion.Flecha.UnionDesde.X2;
        Dragger.Y1 := LUnion.Flecha.UnionDesde.Y2;
        Dragger.X2 := LUnion.Flecha.UnionDesde.X2;
        Dragger.Y2 := LUnion.Flecha.UnionDesde.Y2;
      end;

    FUnion1 := LUnion;
    LUnion.Selected := True;
    LUnion.MouseCapture := False;
		Dragger.Show;
		Dragger.BringToFront;
  end;
end;

procedure TFormMain.UnionMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  LUnion : TUnion;
  LFlecha : TFlecha;
  LUnion1,LUnion2 : TUnion;

  procedure LimpiarFUnion1;
  begin
    FUnion1.Selected := False;
    FUnion1 := Nil;
    Dragger.Hide;
  end;

begin
  Assert(Sender is TUnion);
  LUnion := TUnion(Sender);

  if not Assigned(FUnion1) or (LUnion=FUnion1) then
    exit;

  if not Assigned(FUnion1.Flecha) then
  begin
    if FUnion1.AceptaEntrada and LUnion.AceptaEntrada then
    begin
      LimpiarFUnion1;
      Exit;
    end
    else if FUnion1.AceptaSalida and LUnion.AceptaSalida then
    begin
      LimpiarFUnion1;
      Exit;
    end
    else if FUnion1.AceptaSalida  and LUnion.AceptaEntrada then
    begin
      LUnion1 := FUnion1;
      LUnion2 := LUnion;
    end
    else
    begin
      LUnion1 := LUnion;
      LUnion2 := FUnion1;
    end;

    if Assigned(LUnion1.Flecha) then
    begin
      LUnion1.Flecha.Free;
      LUnion1.Flecha := Nil;
    end;
    if Assigned(LUnion2.Flecha) then
    begin
      LUnion2.Flecha.Free;
      LUnion2.Flecha := Nil;
    end;

    LFlecha := TFlecha.Create(Self,ScrollBox1);
    Flechas.Add(LFlecha);
    with LFlecha do begin
      UnionDesde := LUnion1;
      UnionHasta := LUnion2;
      OnDestroy := FlechaDestroy;
    end;
  end
  else
  begin
    if (FUnion1.Flecha.UnionDesde = FUnion1)and(LUnion.AceptaSalida) then
      FUnion1.Flecha.UnionDesde := LUnion
    else if (FUnion1.Flecha.UnionHasta = FUnion1)and(LUnion.AceptaEntrada) then
      FUnion1.Flecha.UnionHasta := LUnion
    else
      beep;
  end;

  LimpiarFUnion1;
end;

procedure TFormMain.UnionMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  LUnion : TUnion;
begin
  Assert(Sender is TUnion);
  LUnion := TUnion(Sender);
  if Dragger.Visible then
  begin
		Dragger.X2 := LUnion.Left+X;
		Dragger.Y2 := LUnion.Top+Y;
	end;
end;

procedure TFormMain.btnBorrarClick(Sender: TObject);
var
	j : integer;
	LInstruccion : TInstruccion;
begin
	for j := 0 to Seleccion.Count-1 do
	begin
		LInstruccion := Seleccion.Items[j];
		if LInstruccion is TInicio then
			LInstruccion.Selected := False
		else
			LInstruccion.Free;
	end;
	Seleccion.Clear;
end;

procedure TFormMain.AjustarBevel;
var
	j,k : integer;
	LInstruccion : TInstruccion;
	LFlecha : TFlecha;
	LSegmento : TSegmento;
begin
	BevelAncho.Left := 0;
	BevelAlto.Top := 0;
	for j := 1 to Instrucciones.Count-1 do
	begin
		LInstruccion := TInstruccion(Instrucciones.Items[j]);
		if BevelAncho.Left < (LInstruccion.Left + LInstruccion.Width - 1 + BORDE) then
			BevelAncho.Left := LInstruccion.Left + LInstruccion.Width - 1 + BORDE;
		if BevelAlto.Top < (LInstruccion.Top + LInstruccion.Height - 1 + BORDE) then
			BevelAlto.Top := LInstruccion.Top + LInstruccion.Height - 1 + BORDE;
	end;

	for j := 0 to Flechas.Count-1 do
	begin
		LFlecha := Flechas.Items[j];
		for k := 0 to LFlecha.Segmentos.Count-1 do
		begin
			LSegmento := TSegmento(LFlecha.Segmentos.Items[k]);
			if BevelAncho.Left < (LSegmento.Left + LSegmento.Width - 1 + BORDE) then
				BevelAncho.Left := LSegmento.Left + LSegmento.Width - 1 + BORDE;
			if BevelAlto.Top < (LSegmento.Top + LSegmento.Height - 1 + BORDE) then
				BevelAlto.Top := LSegmento.Top + LSegmento.Height - 1 + BORDE;
		end;
	end;
end;

procedure TFormMain.actAcercadeExecute(Sender: TObject);
begin
	formAcercade.ShowModal;
end;

procedure TFormMain.SegmentoMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
//
end;

procedure TFormMain.SegmentoMouseMove(Sender: TObject; Shift: TShiftState;
	X, Y: Integer);
begin
	Assert(Sender is TSegmento);

	if Dragger.Visible then
	begin
		Dragger.X2 := TSegmento(Sender).Left+X;
		Dragger.Y2 := TSegmento(Sender).Top+Y;
	end;
end;

procedure TFormMain.SegmentoMouseUp(Sender: TObject; Button: TMouseButton;
	Shift: TShiftState; X, Y: Integer);
begin
	if Dragger.Visible then
		Dragger.Hide;

	AjustarInstrucciones;
	AjustarBevel;
end;

procedure TFormMain.actPausaExecute(Sender: TObject);
begin
	Pausa := True;
end;

procedure TFormMain.FormMouseWheel(Sender: TObject; Shift: TShiftState;
	WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
	if ssShift in Shift then
		ScrollBox1.HorzScrollBar.Position := ScrollBox1.HorzScrollBar.Position - WheelDelta
	else
		ScrollBox1.VertScrollBar.Position := ScrollBox1.VertScrollBar.Position - WheelDelta;
end;

procedure TFormMain.Propiedades(AInstruccion: TInstruccion);
begin
  if (AInstruccion is TEntradaSalida) then
	begin
    if formPropiedadesSalida.Execute(AInstruccion as TEntradaSalida) then
      with AInstruccion as TEntradaSalida do
      begin
        Caption := formPropiedadesSalida.Caption;
        BreakPoint := formPropiedadesSalida.BreckPoint;
        MuestraCaption := formPropiedadesSalida.MuestraCaption;
        MuestraTexto := formPropiedadesSalida.MuestraTexto;
        Bloqueado := formPropiedadesSalida.Bloquear;

        Parametros := formPropiedadesSalida.Parametros;
        Dispositivo := formPropiedadesSalida.Dispositivo;
        Archivo := formPropiedadesSalida.Archivo;
        Retorno := formPropiedadesSalida.Retorno;
      end;
  end
  else if not (AInstruccion is TNodo) then
    if FormPropiedades.Execute(AInstruccion) then
      with (AInstruccion) do
      begin
        Caption := FormPropiedades.Caption;
        Texto := FormPropiedades.Texto;
        BreakPoint := FormPropiedades.BreckPoint;
        MuestraCaption := FormPropiedades.MuestraCaption;
        MuestraTexto := FormPropiedades.MuestraTexto;
        Bloqueado := FormPropiedades.Bloquear;
      end;
end;

procedure TFormMain.ActualizarTitulo;
var
	S : string;
begin
	S := Encabezado + ' - ' + ExtractFileName(FArchivoPrograma);
	if FModificado then
		S := S + ' - *';
	if Ejecutando then
		S := S + ' - Running';
	if Pausa then
		S := S + ' - Pause';

	Self.Caption := S;

	S := Encabezado + ' - ' + ExtractFileName(FArchivoPrograma);
	Application.Title := S;
end;

procedure TFormMain.SetModificado(const Value: Boolean);
begin
	FModificado := Value;
	ActualizarTitulo;
end;

procedure TFormMain.SetEjecutando(const Value: Boolean);
begin
	FEjecutando := Value;
	ActualizarTitulo;
end;

procedure TFormMain.SetPausa(const Value: Boolean);
begin
	FPausa := Value;
	ActualizarTitulo;
end;

procedure TFormMain.btnCrtClick(Sender: TObject);
begin
	Salida1.Click;
	btnCrt.Down := Salida1.Checked;
end;

procedure TFormMain.btnNuevaVarClick(Sender: TObject);
var
  LInfoVariable : TInfoVariable;
//  LValor : TValor;
begin
	LInfoVariable := INFOVARIABLEVACIA;
	if formPropiedadesVariables.Execute('New variable', LInfoVariable) then
    with LInfoVariable do
    begin
			LInfoVariable.Nombre := formPropiedadesVariables.Nombre;
			LInfoVariable.ValorPorDefecto := formPropiedadesVariables.ValorPorDefecto;
	//    LValor := StringAValor(LVariable.ValorPorDefecto);
			LInfoVariable.Filas := formPropiedadesVariables.Filas;
			LInfoVariable.Columnas := formPropiedadesVariables.Columnas;
			LInfoVariable.Tipo := formPropiedadesVariables.Tipo;
      Variables.Registrar(LInfoVariable);

  //    Variables.Asignar(Variables.Variable(LVariable.Nombre),LValor);
  //    FreeValor(LValor);
			Modificacion(Self);
			ActualizarVariables;
    end;
end;

procedure TFormMain.btnModificarVarClick(Sender: TObject);
var
  LInfoVariable : TInfoVariable;

//  LValor : TValor;
begin
  if Variables.Count = 0 then
    Exit;

  with Variables.Variable(gridVariables.Row-1) do
  begin
    LInfoVariable.Nombre := Nombre;
    LInfoVariable.ValorPorDefecto := ValorPorDefecto;
    LInfoVariable.Filas := Filas;
    LInfoVariable.Columnas := Columnas;
    LInfoVariable.Tipo := Tipo;
  end;

	if formPropiedadesVariables.Execute('Variable ' + LInfoVariable.Nombre, LInfoVariable) then
	begin
		with formPropiedadesVariables do
      Variables.Modificar(gridVariables.Row-1,Nombre,ValorPorDefecto,Filas,Columnas,Tipo);
//    Variables.Asignar(Variables.Variable(LVariable.Nombre),LValor);
//    FreeValor(LValor);
		Modificacion(Self);
		ActualizarVariables;
	end;
end;

procedure TFormMain.btnBorrarVarClick(Sender: TObject);
begin
	if Variables.Count = 0 then
		Exit;

	Variables.Deregistrar(gridVariables.Row-1);
	Modificacion(Self);
	ActualizarVariables;
end;

procedure TFormMain.ActualizarVariables;
var
  j,k,l : integer;
	LVariable : TVariable;
	LValor : TValor;
  s : string;
begin
  if Not Self.Visible then
    Exit;

  if Variables.Count = 0 then
  begin
    gridVariables.RowCount := 2;
    gridVariables.Cells[0,1] := '';
    gridVariables.Cells[1,1] := '';
  END
  else
	begin
		if gridVariables.RowCount-1 <> Variables.Count then
			gridVariables.RowCount := Variables.Count+1;

		for j := 0 to Variables.Count - 1 do
		begin
			LVariable := Variables.Variable(j);
			gridVariables.Cells[0,j+1] := LVariable.Nombre;
			if (LVariable.Filas=1)and(LVariable.Columnas=1) then
			begin
				try
					LValor := LVariable.Valores(0,0);
					gridVariables.Cells[1,j+1] := TValores.ValorAString(LValor);
				finally
					TValores.FreeValor(LValor);
				end;
			end
			else
			begin
				s := '(';
				for k := 0 to LVariable.Filas-1 do
				begin
					if (LVariable.Columnas=1)or(LVariable.Tipo=nCad) then
					begin
						try
							LValor := LVariable.Valores(k,0);
							S := S + TValores.ValorAString(LValor);
						finally
							TValores.FreeValor(LValor);
						end;
					end
					else
					begin
						S := S + '(';
						for l := 0 to LVariable.Columnas-1 do
						begin
							try
								LValor := LVariable.Valores(k,l);
								S := S + TValores.ValorAString(LValor);
							finally
								TValores.FreeValor(LValor);
							end;
							if l<LVariable.Columnas-1 then
								S := S + SEPARADOR;
						end;
						s := S + ')';
					end;
					if k<LVariable.Filas-1 then
						S := S + SEPARADOR;
				end;
				S := S + ')';
				gridVariables.Cells[1,j+1] := S;
			end;
		end;
	end;
end;

procedure TFormMain.gridVariablesDblClick(Sender: TObject);
begin
	if Variables.Count = 0 then
		btnNuevaVar.Click
	else
		btnModificarVar.Click;
end;

procedure TFormMain.btnNuevoArchivoClick(Sender: TObject);
var
	LInfoArchivo : TInfoArchivo;
begin
	LInfoArchivo.Ruta := '';
	LInfoArchivo.Acceso := Lectura;

	if formPropiedadesArchivos.Execute('New file',LInfoArchivo) then
	begin
		LInfoArchivo.Nombre := formPropiedadesArchivos.Nombre;
		LInfoArchivo.Ruta := formPropiedadesArchivos.Ruta;
		LInfoArchivo.Acceso := formPropiedadesArchivos.Acceso;
		Archivos.Registrar(LInfoArchivo);

		Modificacion(Self);

		ActualizarArchivos;
	end;
end;

procedure TFormMain.ActualizarArchivos;
var
	j : integer;
	LArchivo : TArchivo;
begin
	if Archivos.Count = 0 then
	begin
		gridArchivos.Cells[0,1] := '';
		gridArchivos.Cells[1,1] := '';
		gridArchivos.Cells[2,1] := '';
	end
	else
	begin
		gridArchivos.RowCount := Archivos.Count + 1;
		for j := 0 to Archivos.Count - 1 do
		begin
			LArchivo := Archivos.Archivo(j);
			gridArchivos.Cells[0,j+1] := LArchivo.Nombre;

			case LArchivo.Acceso of
				Lectura : gridArchivos.Cells[1,j+1] := 'Read';
				Reescritura : gridArchivos.Cells[1,j+1] := 'Rewrite';
				Escritura : gridArchivos.Cells[1,j+1] := 'Write';
			end;
			gridArchivos.Cells[2,j+1] := LArchivo.Ruta;
		end;
	end;
end;

procedure TFormMain.btnModificarArchivoClick(Sender: TObject);
var
	LArchivo : TArchivo;
	LInfoArchivo : TInfoArchivo;
begin
	if Archivos.Count = 0 then
		exit;

	LArchivo := Archivos.Archivo(gridArchivos.Row-1);

	LInfoArchivo.Nombre := LArchivo.Nombre;
	LInfoArchivo.Ruta := LArchivo.Ruta;
	LInfoArchivo.Acceso := LArchivo.Acceso;

	if formPropiedadesArchivos.Execute('Modify file',LInfoArchivo) then
	begin
		LInfoArchivo.Nombre := formPropiedadesArchivos.Nombre;
		LInfoArchivo.Ruta := formPropiedadesArchivos.Ruta;
		LInfoArchivo.Acceso := formPropiedadesArchivos.Acceso;
		Archivos.Modificar(gridArchivos.Row-1,LInfoArchivo);

		Modificacion(Self);
		ActualizarArchivos;
	end;
end;

procedure TFormMain.btnBorrarArchivoClick(Sender: TObject);
begin
	if Archivos.Count = 0 then
		exit;

	Archivos.Deregistrar(gridArchivos.Row-1);

	Modificacion(Self);

	ActualizarArchivos;
end;

procedure TFormMain.ScrollBox1MouseWheel(Sender: TObject;
  Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint;
  var Handled: Boolean);
begin
	ScrollBox1.VertScrollBar.Position := ScrollBox1.VertScrollBar.Position + WheelDelta;
end;

procedure TFormMain.btnAltoClick(Sender: TObject);
var
	j : integer;
	LInstruccion : TInstruccion;
begin
	for j := 0 to Seleccion.Count-1 do
	begin
		LInstruccion := Seleccion.Items[j];
		if not(LInstruccion is TInicio) then
			LInstruccion.BreakPoint := not LInstruccion.BreakPoint;
	end;
end;

procedure TFormMain.actSalirExecute(Sender: TObject);
begin
	formCrt.Finalizar;
	Self.Close;
end;

end.
