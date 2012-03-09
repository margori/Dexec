unit UFormMain;

{$mode objfpc}

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
		procedure InstructionMouseDown(Sender: TObject; Button: TMouseButton;
			Shift: TShiftState; X, Y: Integer);
		procedure InstructionMouseMove(Sender: TObject; Shift: TShiftState; X,
			Y: Integer);
		procedure InstructionMouseUp(Sender: TObject; Button: TMouseButton;
			Shift: TShiftState; X, Y: Integer);

		procedure UnionMouseDown(Sender: TObject; Button: TMouseButton;
			Shift: TShiftState; X, Y: Integer);
		procedure UnionMouseUp(Sender: TObject; Button: TMouseButton;
			Shift: TShiftState; X, Y: Integer);
		procedure UnionMouseMove(Sender: TObject; Shift: TShiftState; X,
			Y: Integer);

		procedure SegmentMouseDown(Sender: TObject; Button: TMouseButton;
			Shift: TShiftState; X, Y: Integer);
		procedure SegmentMouseUp(Sender: TObject; Button: TMouseButton;
			Shift: TShiftState; X, Y: Integer);
		procedure SegmentMouseMove(Sender: TObject; Shift: TShiftState; X,
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
		PosInicialInstruction : array of TPoint;

		FUnion1: TJoin;
		FInstructionActual: TInstruction;
		FArchivoPrograma: String;
		FModificado: Boolean;

		FArrastrandoObjeto : Boolean;
		FArrastrandoTamano : Boolean;
		FEjecutando: Boolean;
//		FArrastrandoUnion : Boolean;

		procedure Propiedades(AInstruction :TInstruction);

		procedure InstructionEventos(AInstruction : TInstruction);
		procedure ArrowDestroy(Sender: TObject);

		procedure SetInstructionActual(const Value: TInstruction);

		procedure SetArchivoPrograma(const Value: String);

		procedure Modificacion(Sender: TObject);

		procedure Salvar;
		procedure Cargar;

		procedure AjustarInstructiones;
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

		Instructiones : TList;
		Arrows : TList;

		property Ejecutando : Boolean read FEjecutando write SetEjecutando;
		property Pausa : Boolean read FPausa write SetPausa;
		property Modificado: Boolean read FModificado write SetModificado;

		property ArchivoPrograma : String read FArchivoPrograma write SetArchivoPrograma;
		property InstructionActual: TInstruction read FInstructionActual write SetInstructionActual;
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

	GOnSegmentMouseDown := @SegmentMouseDown;
	GOnSegmentMouseUp := @SegmentMouseUp;
	GOnSegmentMouseMove := @SegmentMouseMove;

	ThousandSeparator := ',';
	DecimalSeparator := '.';

	Instructiones := TList.Create;
	Arrows := TList.Create;
	Seleccion := TList.Create;

	Dragger := TDragger.Create(Self);
	Dragger.Parent := ScrollBox1;
	Dragger.Visible := False;
	Dragger.OnMouseMove := @DraggerMouseMove;

	//ScrollBox1.VertScrollBar.Margin := BORDER_SCREEN;
	//ScrollBox1.HorzScrollBar.Margin := BORDER_SCREEN;

	Nuevo1.Click;

	gridVariables.Cells[0,0] := 'Variable';
	gridVariables.Cells[1,0] := 'Value';
	gridArchivos.Cells[0,0] := 'Name';
	gridArchivos.Cells[1,0] := 'Access';
	gridArchivos.Cells[2,0] := 'Path';

	ActualizarVariables;
end;

procedure TFormMain.InstructionMouseMove(Sender: TObject;
	Shift: TShiftState; X, Y: Integer);
var
  LInstruction: TInstruction;
  LPos : TPoint;
  j : integer;
begin
	Assert(Sender is TInstruction);
	LInstruction := Sender as TInstruction;
	LPos.X := LInstruction.Left + X;
	LPos.Y := LInstruction.Top + Y;

	if FArrastrandoObjeto then
	begin
		for j := 0 to Seleccion.Count-1 do
		begin
			with TInstruction(Seleccion.Items[j]) do
			begin
				X := PosInicialInstruction[j].X + LPos.X - PosInicialMouse.X;
				Y := PosInicialInstruction[j].Y + LPos.Y - PosInicialMouse.Y;
			end;
		end;
	end
	else if FArrastrandoTamano then
	begin
		for j := 0 to Seleccion.Count-1 do
		begin
			with TInstruction(Seleccion.Items[j]) do
			begin
				Width := TamanoInicial.X + (LPos.X - PosInicialMouse.X)*2;
				Height := TamanoInicial.Y + (LPos.Y - PosInicialMouse.Y)*2;
			end;
		end;
	end
	else if Assigned(FUnion1) and Dragger.Visible then
	begin
		Dragger.X2 := TInstruction(Sender).Left+X;
		Dragger.Y2 := TInstruction(Sender).Top+Y;
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
	j := Instructiones.IndexOf(Sender);
  Assert(j>-1);
  if j>-1 then
    Instructiones.Delete(j);
end;

procedure TFormMain.actPasoExecute(Sender: TObject);
begin
	formCrt.Show;
	formCrt.BringToFront;

	if formCrt.Leyendo then
		exit;

	try
		if InstructionActual = Nil then
			InstructionActual := TInstruction(Instructiones.Items[0])
		else
			InstructionActual := InstructionActual.Execute;
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
	InstructionActual := Nil;
	ActualizarVariables;
end;

procedure TFormMain.SetInstructionActual(const Value: TInstruction);
begin
	if FInstructionActual <> Value then
	begin
		if FInstructionActual <> Nil then
		begin
			FInstructionActual.Executing := False;
			FInstructionActual.Error := False;
		end
		else
		begin
			Variables.Initialize;
			Archivos.Inicializar;
		end;

		FInstructionActual := Value;
		if FInstructionActual <> Nil then
		begin
			FInstructionActual.Executing := True;
			FInstructionActual.Error := False;
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
		if InstructionActual <> Nil then
		begin
			if Pausa then
				Fin := True
			else
				Fin := InstructionActual.BreakPoint;
		end
		else
			Fin := True;
	until Fin;
	Ejecutando := InstructionActual <> Nil;
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
	Aux : TInstruction;
begin
	if (Instructiones.Count>0) then
	begin
	 if FModificado then
			case MessageDlg('Do you want to save?',mtConfirmation,mbYesNoCancel,-1) of
				mrYes : Salvar1.Click;
				mrCancel : Exit;
			end;

		Stop1.Click
	end;

	while Instructiones.Count>0 do
	begin
		Aux := TInstruction(Instructiones[0]);
		Aux.Free;
	end;

	Instructiones.Clear;

	Aux := TBegin.Create(Self,ScrollBox1);
	InstructionEventos(Aux);
	Instructiones.Add(Aux);
	Aux.X := 100; // Da igual ya
	Aux.Y := 100; // Cambiar
	Aux.Comments := 'Program';
	Aux.Parameters := '';

	InstructionActual := Nil;

	Variables.Clean;
	ActualizarVariables;

	Archivos.DeregistrarTodo;
	ActualizarArchivos;

	ArchivoPrograma := '';
	AjustarInstructiones;
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

procedure TFormMain.ArrowDestroy(Sender: TObject);
var j: integer;
begin
	j := Arrows.IndexOf(Sender);
	Assert(j>-1);
	Arrows.Delete(j);
end;

procedure TFormMain.Cargar;
var
	LEntrada: TextFile;
	LInstruction : TInstruction;
	LArrow : TArrow;
	LSegment : TSegment;
	LUnion1,LUnion2 : TJoin;
	S : String;
	LInfoVariable: TVariableInformation;
	LInfoArchivo: TInfoArchivo;
	Cant,j,Aux : integer;
	X1,X2,Y1,Y2 : Integer;
	LVersion : String;
begin
	Stop1.Click;

	Seleccion.Clear;

	while Instructiones.Count>0 do
	begin
		LInstruction := TInstruction(Instructiones[0]);
		LInstruction.Free;
	end;
	Instructiones.Clear;

	while Arrows.Count>0 do
	begin
		LArrow := TArrow(Arrows[0]);
		LArrow.Free;
	end;
	Arrows.Clear;

	Variables.Clean;
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
			LInfoVariable.TypeNumber := TTypes.GetType(S);
			Readln(LEntrada,S);
			Readln(LEntrada,S);
			LInfoVariable.Name := Copy(S,10,Length(S));
			Readln(LEntrada,S);
			LInfoVariable.DefaultValue := Copy(S,19,Length(S));
			Readln(LEntrada,S);
			if LVersion = '1.0' then
				LInfoVariable.Rows := StrToInt(Copy(S,7,Length(S)))
			else
				LInfoVariable.Rows := StrToInt(Copy(S,8,Length(S)));
			Readln(LEntrada,S);
			if LVersion = '1.0' then
				LInfoVariable.Columns := StrToInt(Copy(S,7,Length(S)))
			else
				LInfoVariable.Columns := StrToInt(Copy(S,11,Length(S)));
			Readln(LEntrada,S);
			Variables.Add(LInfoVariable);
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

// Cargo Instructiones
		Readln(LEntrada,S); // Descarte por ser solo un identificador
		Readln(LEntrada,S);
		Cant := StrToInt(S);

    LInstruction := Nil;
		for j:= 1 to Cant do // carga de Instructiones
		begin
			Readln(LEntrada,S);

			if S = 'Entrada' then
				LInstruction := TInput.Create(Self,ScrollBox1)
			else if S = 'Salida' then
				LInstruction := TOutput.Create(Self,ScrollBox1)
			else if S = 'Sentencia' then
				LInstruction := TSentence.Create(Self,ScrollBox1)
			else if S = 'Condicion' then
				LInstruction := TCondition.Create(Self,ScrollBox1)
			else if S = 'Nodo' then
				LInstruction := TNode.Create(Self,ScrollBox1)
			else if S = 'Inicio' then
				LInstruction := TBegin.Create(Self,ScrollBox1)
			else if S = 'Fin' then
				LInstruction := TEnd.Create(Self,ScrollBox1)
			else
				raise Exception.Create('File error!');

			Instructiones.Add(LInstruction);
			InstructionEventos(LInstruction);
			Readln(LEntrada,S);
			Readln(LEntrada,S);

			LInstruction.X := StrToInt(Copy(S,5,Length(S)));
			Readln(LEntrada,S);
			LInstruction.Y := StrToInt(Copy(S,5,Length(S)));
			Readln(LEntrada,S);
			LInstruction.Width := StrToInt(Copy(S,9,Length(S)));
			Readln(LEntrada,S);
			LInstruction.Height := StrToInt(Copy(S,8,Length(S)));
			Readln(LEntrada,S);
			LInstruction.Comments := Copy(S,11,Length(S));
			Readln(LEntrada,S);
			if S = 'MuestraCaption = Si' then
				LInstruction.ShowComments := True
			else if S = 'MuestraCaption = No' then
				LInstruction.ShowComments := False;

      if LInstruction is TCommunication then
        with LInstruction as TCommunication do
        begin
          Readln(LEntrada,S);
          Parameters := Copy(S,14,Length(S));
					Readln(LEntrada,S);
					if S = 'Dispositivo = Pantalla' then
            Device := deScreen
          else if S = 'Dispositivo = Archivo' then
            Device := deFile
          else
            raise Exception.Create('File error!');
          Readln(LEntrada,S);
          FilePath := Copy(S,10,Length(S));
          Readln(LEntrada,S);
          if S = 'Retorno = Si' then
            CarriageReturn := True
          else if S = 'Retorno = No' then
            CarriageReturn := False
          else
            raise Exception.Create('File error!');
        end
      else
      begin
        Readln(LEntrada,S);
        LInstruction.Parameters := Copy(S,9,Length(S));
      end;

			Readln(LEntrada,S);
			if S = 'MuestraTexto = Si' then
				LInstruction.ShowParameters := True
			else if S = 'MuestraTexto = No' then
				LInstruction.ShowParameters := False;
			Readln(LEntrada,S);
			if S = 'Bloqueado = Si' then
				LInstruction.Locked := True
			else if S = 'Bloqueado = No' then
				LInstruction.Locked := False;
			Readln(LEntrada,S);
			if S = 'BreackPoint = Si' then
				LInstruction.BreakPoint := True
			else if S = 'BreackPoint = No' then
				LInstruction.BreakPoint := False;
			Readln(LEntrada,S);
			if S <> '}' then
				raise Exception.Create('File error!');
		end;

    // Cargo Arrows
	  Readln(LEntrada,S); // Descartado por solo ser un comentario
		Readln(LEntrada,S);
		Cant := StrToInt(S);

		for j:= 1 to Cant do // carga de Arrows
		begin
			Readln(LEntrada,S);
			Readln(LEntrada,S);

			Readln(LEntrada,S);
			Aux := StrToInt(Copy(S,14,Length(S)));
			LInstruction := TInstruction(Instructiones.Items[Aux]);
			Readln(LEntrada,S);
      LUnion1 := Nil;
			if S = 'Union = Norte' then
				LUnion1 := LInstruction.NorthJoin
			else if S = 'Union = Sur' then
				LUnion1 := LInstruction.SouthJoin
			else if S = 'Union = Este' then
				LUnion1 := LInstruction.EastJoin
			else if S = 'Union = Oeste' then
				LUnion1 := LInstruction.WestJoin
			else
				raise Exception.Create('File error!');

			Readln(LEntrada,S);
			Aux := StrToInt(Copy(S,14,Length(S)));
			LInstruction := TInstruction(Instructiones.Items[Aux]);
			Readln(LEntrada,S);
      LUnion2 := Nil;
			if S = 'Union = Norte' then
				LUnion2 := LInstruction.NorthJoin
			else if S = 'Union = Sur' then
				LUnion2 := LInstruction.SouthJoin
			else if S = 'Union = Este' then
				LUnion2 := LInstruction.EastJoin
			else if S = 'Union = Oeste' then
				LUnion2 := LInstruction.WestJoin
			else
				raise Exception.Create('File error!');

			LArrow := TArrow.Create(Self,ScrollBox1);
			Arrows.Add(LArrow);
			LArrow.OnDestroy := @ArrowDestroy;
			LArrow.OnModify := @Modificacion;

			LArrow.FromJoin := LUnion1;
			LArrow.ToJoin := LUnion2;

			Aux := 0;
			repeat
				Readln(LEntrada,S);

				LSegment := TSegment(LArrow.Segments.Items[Aux]);
				if S[1] ='Y' then
				begin
					if LSegment.Direction = diHorizontal then
					begin
						X1 := LSegment.X1;
						X2 := LSegment.X2;
						LSegment := TSegment(LArrow.Segments.Items[Aux+1]);
						LArrow.MoveSegment(LSegment,X1-X2,0);
						LSegment := TSegment(LArrow.Segments.Items[Aux]);
					end;
					Y1 := LSegment.Y2;
					Y2 := StrToInt(Copy(S,5,Length(S)));
					if Y1<>Y2 then
					begin
						LSegment := TSegment(LArrow.Segments.Items[Aux+1]);
						LArrow.MoveSegment(LSegment,0,Y2-Y1);
	//          LSegment := LArrow.Segments.Items[Aux];
					end
				end
				else if S[1] ='X' then
				begin
					if LSegment.Direction = diVertical then
					begin
						Y1 := LSegment.Y1;
						Y2 := LSegment.Y2;
						LSegment := TSegment(LArrow.Segments.Items[Aux+1]);
						LArrow.MoveSegment(LSegment,0,Y1-Y2);
						LSegment := TSegment(LArrow.Segments.Items[Aux]);
					end;
					X1 := LSegment.X2;
					X2 := StrToInt(Copy(S,5,Length(S)));
					if X1<>X2 then
					begin
						LSegment := TSegment(LArrow.Segments.Items[Aux+1]);
						LArrow.MoveSegment(LSegment,X2-X1,0);
	//          LSegment := LArrow.Segments.Items[Aux];
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

  AjustarInstructiones;
  Modificado := False;
end;

procedure TFormMain.Salvar;
var
	LSalida : TextFile;
	LVariable : TVariable;
	LInstruction : TInstruction;
	LArrow : TArrow;
	LSegment : TSegment;
	LUnion: TJoin;
	LArchivo : TArchivo;
  j,k: integer;
begin
	if FileExists(FArchivoPrograma) then
		CopyFile(FArchivoPrograma,FArchivoPrograma + '~',False);

	AssignFile(LSalida,FArchivoPrograma);
	try
		rewrite(LSalida);

		Writeln(LSalida,'1.1');

		Writeln(LSalida,'Variables');
		Writeln(LSalida,Variables.Count);
		for j := 0 to Variables.Count-1 do
		begin
			LVariable := Variables.Variable(j);
			Writeln(LSalida, TTypes.NameOfType(LVariable.TypeNumber));
			Writeln(LSalida, '{');
			Writeln(LSalida, 'Nombre = ', LVariable.Name);
			Writeln(LSalida, 'ValorPorDefecto = ', LVariable.ValorPorDefecto);
			Writeln(LSalida, 'Filas = ', LVariable.Rows);
			Writeln(LSalida, 'Columnas = ', LVariable.Columns);
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

    Writeln(LSalida,'Instructiones');
    Writeln(LSalida,Instructiones.Count);
    for j := 0 to Instructiones.Count-1 do
    begin
      LInstruction := TInstruction(Instructiones.Items[j]);
      if LInstruction is TBegin then
        Writeln(LSalida,'Inicio')
      else if (LInstruction is TSentence)and not (LInstruction is TCommunication) then
        Writeln(LSalida,'Sentencia')
      else if LInstruction is TCondition then
        Writeln(LSalida,'Condicion')
      else if LInstruction is TNode then
        Writeln(LSalida,'Nodo')
      else if LInstruction is TEnd then
        Writeln(LSalida,'Fin')
      else if LInstruction is TOutput then
        Writeln(LSalida,'Salida')
      else if LInstruction is TInput then
        Writeln(LSalida,'Entrada')
      else 
        raise Exception.Create('Objeto desconocido.');

      Writeln(LSalida,'{');
      Writeln(LSalida,'X = ', LInstruction.X);
      Writeln(LSalida,'Y = ', LInstruction.Y);
			Writeln(LSalida,'Ancho = ', LInstruction.Width);
      Writeln(LSalida,'Alto = ', LInstruction.Height);
      Writeln(LSalida,'Caption = ', LInstruction.Comments);
      if LInstruction.ShowComments then
        Writeln(LSalida,'MuestraCaption = Si')
      else
        Writeln(LSalida,'MuestraCaption = No');

      if LInstruction is TCommunication then
        with (LInstruction as TCommunication) do
        begin
          Writeln(LSalida,'Parametros = ',Parameters);
          if Device = deScreen then
            Writeln(LSalida,'Dispositivo = Pantalla')
          else
            Writeln(LSalida,'Dispositivo = Archivo');
          Writeln(LSalida,'Archivo = ',FilePath);
          if CarriageReturn then
            Writeln(LSalida,'Retorno = Si')
          else
            Writeln(LSalida,'Retorno = No');
        end
      else
        Writeln(LSalida,'Texto = ', LInstruction.Parameters);

      if LInstruction.ShowParameters then
        Writeln(LSalida,'MuestraTexto = Si')
      else
        Writeln(LSalida,'MuestraTexto = No');
      if LInstruction.Locked then
        Writeln(LSalida,'Bloqueado = Si')
      else
				Writeln(LSalida,'Bloqueado = No');
      if LInstruction.BreakPoint then
        Writeln(LSalida,'BreackPoint = Si')
      else
        Writeln(LSalida,'BreackPoint = No');

      Writeln(LSalida,'}');
    end;

    Writeln(LSalida,'Arrows');
    Writeln(LSalida,Arrows.Count);
    for j:= 0 to Arrows.Count-1 do
    begin
      Writeln(LSalida,'Arrow');
      Writeln(LSalida,'{');
      LArrow := TArrow(Arrows.Items[j]);
      LUnion := LArrow.FromJoin;

      LInstruction := LUnion.Instruction;
      Writeln(LSalida,'Instruction = ',Instructiones.IndexOf(LInstruction));

      if LInstruction.NorthJoin = LUnion then
        Writeln(LSalida,'Union = Norte')
      else if LInstruction.EastJoin = LUnion then
        Writeln(LSalida,'Union = Este')
      else if LInstruction.SouthJoin = LUnion then
        Writeln(LSalida,'Union = Sur')
      else if LInstruction.WestJoin = LUnion then
        Writeln(LSalida,'Union = Oeste')
      else
        Raise Exception.Create('Error en union.');

			LUnion := LArrow.ToJoin;
      LInstruction := LUnion.Instruction;
      Writeln(LSalida,'Instruction = ',Instructiones.IndexOf(LInstruction));

      if LInstruction.NorthJoin = LUnion then
        Writeln(LSalida,'Union = Norte')
      else if LInstruction.EastJoin = LUnion then
        Writeln(LSalida,'Union = Este')
      else if LInstruction.SouthJoin = LUnion then
        Writeln(LSalida,'Union = Sur')
      else if LInstruction.WestJoin = LUnion then
        Writeln(LSalida,'Union = Oeste')
      else
        Raise Exception.Create('Error en union.');

      for k := 0 to LArrow.Segments.Count-2 do
      begin
				LSegment := TSegment(LArrow.Segments.Items[k]);

        if LSegment.Direction= diHorizontal then
          Writeln(LSalida,'X = ',LSegment.X2)
        else
          Writeln(LSalida,'Y = ',LSegment.Y2);
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

procedure TFormMain.InstructionMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  LInstruction : TInstruction;
  LPosEnSeleccion: Integer;
  j :integer;
begin
	Assert(Sender is TInstruction,'TInstruction object expected.');
	LInstruction := Sender as TInstruction;

	if Button = mbLeft then
	begin
		if (ssDouble in Shift) and LInstruction.MouseInObject then
		begin
      Propiedades(Sender as TInstruction);
		end
		else
		begin
			FArrastrandoObjeto := LInstruction.MouseInObject and not LInstruction.Locked;
			FArrastrandoTamano := LInstruction.MouseInResize;
			PosInicialMouse.X := LInstruction.Left + X;
			PosInicialMouse.Y := LInstruction.Top + Y;
			TamanoInicial := Point(LInstruction.Width,LInstruction.Height);

			LPosEnSeleccion := Seleccion.IndexOf(Sender);

			if (ssCtrl in Shift) and (LInstruction.MouseInObject or
				LInstruction.MouseInResize) then
			begin
				if LPosEnSeleccion > -1 then
				begin
					LInstruction.Selected := False;
					Seleccion.Delete(LPosEnSeleccion);
				end
				else
				begin
					LInstruction.Selected := True;
					Seleccion.Add(LInstruction);
				end;
			end
			else if (LInstruction.MouseInObject or
				LInstruction.MouseInResize) then
			begin
				if LPosEnSeleccion = -1 then
				begin
					for j := 0 to Seleccion.Count-1 do
						TInstruction(Seleccion.Items[j]).Selected := False;
					Seleccion.Clear;
					Seleccion.Add(LInstruction);
					LInstruction.Selected := True;
				end;
			end;

			SetLength(PosInicialInstruction,Seleccion.Count);
			for j := 0 to Seleccion.Count-1 do
				PosInicialInstruction[j] := Point(TInstruction(Seleccion.items[j]).X,
					TInstruction(Seleccion.items[j]).Y);
		end;
	end;
end;

procedure TFormMain.ScrollBox1MouseDown(Sender: TObject; Button: TMouseButton;
	Shift: TShiftState; X, Y: Integer);
var
	Aux : TInstruction;
	j : integer;
begin
	if btnSeleccion.Down then
  begin
    for j := 0 to Seleccion.Count-1 do
      TInstruction(Seleccion.Items[j]).Selected := False;
    Seleccion.Clear;
  end
  else
  begin
    if btnEntrada.Down then
			Aux := TInput.Create(Self,ScrollBox1)
		else if btnSalida.Down then
      Aux := TOutput.Create(Self,ScrollBox1)
    else if btnSentencia.Down then
      Aux := TSentence.Create(Self,ScrollBox1)
    else if btnCondicion.Down then
      Aux := TCondition.Create(Self,ScrollBox1)
    else if btnNodo.Down then
      Aux := TNode.Create(Self,ScrollBox1)
    else if btnFinal.Down then
			Aux := TEnd.Create(Self,ScrollBox1)
		else
			raise Exception.Create('Toolbar button error!');

		Instructiones.Add(Aux);
		InstructionEventos(Aux);
		Aux.X := X + ScrollBox1.HorzScrollBar.Position;
		Aux.Y := Y + ScrollBox1.VertScrollBar.Position;

		btnSeleccion.Down := True;
    AjustarInstructiones;
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
		if Assigned(FUnion1.Arrow) then
			FUnion1.Arrow.Free;

  if Assigned(FUnion1) then
  begin
    FUnion1.Selected := False;
	  FUnion1 := Nil;
  end;
	Dragger.Hide;
end;

procedure TFormMain.InstructionEventos(AInstruction: TInstruction);
begin
  With AInstruction do
  begin
    OnMouseDown := @InstructionMouseDown;
	  OnMouseMove := @InstructionMouseMove;
    OnMouseUp := @InstructionMouseUp;
    OnUnionMouseDown := @UnionMouseDown;
	  OnUnionMouseUp := @UnionMouseUp;
    OnUnionMouseMove := @UnionMouseMove;
	  OnDestroy := @IntruccionDestroy;
    OnModify := @Modificacion;
  END;
end;

procedure TFormMain.InstructionMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
	if Dragger.Visible then
		Dragger.Hide;

	FArrastrandoObjeto := False;
	FArrastrandoTamano := False;

	AjustarInstructiones;
	AjustarBevel;
end;

procedure TFormMain.AjustarInstructiones;
var
	j,k: integer;
	LInstruction : TInstruction;
	LArrow : TArrow;
	LSegment :  TSegment;
	DX,DY : IntegeR;
begin
	if Instructiones.Count>0 then
	begin
		DX := 0;
		DY := 0;
		LInstruction := TInstruction(Instructiones.Items[0]);
		while LInstruction.Left + ScrollBox1.HorzScrollBar.Position + DX > BORDER_SCREEN + GRID_X - 1 do
			DX := DX - GRID_X;
		while LInstruction.Left + ScrollBox1.HorzScrollBar.Position + DX < BORDER_SCREEN - 1 do
			DX := DX + GRID_X;
		while LInstruction.Top + ScrollBox1.VertScrollBar.Position + DY > BORDER_SCREEN + GRID_Y - 1 do
			DY := DY - GRID_Y;
		while LInstruction.Top + ScrollBox1.VertScrollBar.Position + DY < BORDER_SCREEN - 1 do
			DY := DY + GRID_Y;

		for j := 1 to Instructiones.Count-1 do
		begin
			LInstruction := TInstruction(Instructiones.Items[j]);
			while LInstruction.Left + ScrollBox1.HorzScrollBar.Position + DX < BORDER_SCREEN - 1 do
				DX := DX + GRID_X;
			while LInstruction.Top + ScrollBox1.VertScrollBar.Position + DY < BORDER_SCREEN - 1 do
				DY := DY + GRID_Y;
		end;
		for j := 0 to Arrows.Count-1 do
		begin
			LArrow := TArrow(Arrows.Items[j]);
			for k := 0 to LArrow.Segments.Count-1 do
			begin
				LSegment := TSegment(LArrow.Segments.Items[k]);
				while LSegment.Left + ScrollBox1.HorzScrollBar.Position + DX < BORDER_SCREEN - 1 do
					DX := DX + GRID_X;
				while LSegment.Top + ScrollBox1.VertScrollBar.Position + DY < BORDER_SCREEN - 1 do
					DY := DY + GRID_Y;
			end;
		end;

		for j := 0 to Instructiones.Count-1 do
		begin
			LInstruction := TInstruction(Instructiones.Items[j]);
			LInstruction.X := LInstruction.X + DX;
			LInstruction.Y := LInstruction.Y + DY;
		end;
		for j := 0 to Arrows.Count-1 do
		begin
			LArrow := TArrow(Arrows.Items[j]);
			LArrow.MoveAll(DX,DY);
		end;
	end;
end;

procedure TFormMain.UnionMouseDown(Sender: TObject; Button: TMouseButton;
	Shift: TShiftState; X, Y: Integer);
var
	LUnion : TJoin;
begin
	Assert(Sender is TJoin);

	LUnion := TJoin(Sender);
	if (Button=mbLeft) and LUnion.MouseInJoin and (not Assigned(FUnion1)
		or (LUnion=FUnion1))  then
  begin
    if not Assigned(LUnion.Arrow) then
    begin
      Dragger.X1 := LUnion.X2;
      Dragger.Y1 := LUnion.Y2;
      Dragger.X2 := LUnion.X2;
      Dragger.Y2 := LUnion.Y2;
    end
    else
      if LUnion.Arrow.FromJoin = LUnion then
      begin
        Dragger.X1 := LUnion.Arrow.ToJoin.X2;
        Dragger.Y1 := LUnion.Arrow.ToJoin.Y2;
        Dragger.X2 := LUnion.Arrow.ToJoin.X2;
        Dragger.Y2 := LUnion.Arrow.ToJoin.Y2;
      end
      else
      begin
        Dragger.X1 := LUnion.Arrow.FromJoin.X2;
        Dragger.Y1 := LUnion.Arrow.FromJoin.Y2;
        Dragger.X2 := LUnion.Arrow.FromJoin.X2;
        Dragger.Y2 := LUnion.Arrow.FromJoin.Y2;
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
  LUnion : TJoin;
  LArrow : TArrow;
  LUnion1,LUnion2 : TJoin;

  procedure LimpiarFUnion1;
  begin
    FUnion1.Selected := False;
    FUnion1 := Nil;
    Dragger.Hide;
  end;

begin
  Assert(Sender is TJoin);
  LUnion := TJoin(Sender);

  if not Assigned(FUnion1) or (LUnion=FUnion1) then
    exit;

  if not Assigned(FUnion1.Arrow) then
  begin
    if FUnion1.AcceptEntry and LUnion.AcceptEntry then
    begin
      LimpiarFUnion1;
      Exit;
    end
    else if FUnion1.AcceptExit and LUnion.AcceptExit then
    begin
      LimpiarFUnion1;
      Exit;
    end
    else if FUnion1.AcceptExit  and LUnion.AcceptEntry then
    begin
      LUnion1 := FUnion1;
      LUnion2 := LUnion;
    end
    else
    begin
      LUnion1 := LUnion;
      LUnion2 := FUnion1;
    end;

    if Assigned(LUnion1.Arrow) then
    begin
      LUnion1.Arrow.Free;
      LUnion1.Arrow := Nil;
    end;
    if Assigned(LUnion2.Arrow) then
    begin
      LUnion2.Arrow.Free;
      LUnion2.Arrow := Nil;
    end;

    LArrow := TArrow.Create(Self,ScrollBox1);
    Arrows.Add(LArrow);
    with LArrow do begin
      FromJoin := LUnion1;
      ToJoin := LUnion2;
      OnDestroy := @ArrowDestroy;
    end;
  end
  else
  begin
    if (FUnion1.Arrow.FromJoin = FUnion1)and(LUnion.AcceptExit) then
      FUnion1.Arrow.FromJoin := LUnion
    else if (FUnion1.Arrow.ToJoin = FUnion1)and(LUnion.AcceptEntry) then
      FUnion1.Arrow.ToJoin := LUnion
    else
      beep;
  end;

  LimpiarFUnion1;
end;

procedure TFormMain.UnionMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  LUnion : TJoin;
begin
  Assert(Sender is TJoin);
  LUnion := TJoin(Sender);
  if Dragger.Visible then
  begin
		Dragger.X2 := LUnion.Left+X;
		Dragger.Y2 := LUnion.Top+Y;
	end;
end;

procedure TFormMain.btnBorrarClick(Sender: TObject);
var
	j : integer;
	LInstruction : TInstruction;
begin
	for j := 0 to Seleccion.Count-1 do
	begin
		LInstruction := TInstruction(Seleccion.Items[j]);
		if LInstruction is TBegin then
			LInstruction.Selected := False
		else
			LInstruction.Free;
	end;
	Seleccion.Clear;
end;

procedure TFormMain.AjustarBevel;
var
	j,k : integer;
	LInstruction : TInstruction;
	LArrow : TArrow;
	LSegment : TSegment;
begin
	BevelAncho.Left := 0;
	BevelAlto.Top := 0;
	for j := 1 to Instructiones.Count-1 do
	begin
		LInstruction := TInstruction(Instructiones.Items[j]);
		if BevelAncho.Left < (LInstruction.Left + LInstruction.Width - 1 + BORDER) then
			BevelAncho.Left := LInstruction.Left + LInstruction.Width - 1 + BORDER;
		if BevelAlto.Top < (LInstruction.Top + LInstruction.Height - 1 + BORDER) then
			BevelAlto.Top := LInstruction.Top + LInstruction.Height - 1 + BORDER;
	end;

	for j := 0 to Arrows.Count-1 do
	begin
		LArrow := TArrow(Arrows.Items[j]);
		for k := 0 to LArrow.Segments.Count-1 do
		begin
			LSegment := TSegment(LArrow.Segments.Items[k]);
			if BevelAncho.Left < (LSegment.Left + LSegment.Thickness - 1 + BORDER) then
				BevelAncho.Left := LSegment.Left + LSegment.Thickness - 1 + BORDER;
			if BevelAlto.Top < (LSegment.Top + LSegment.Height - 1 + BORDER) then
				BevelAlto.Top := LSegment.Top + LSegment.Height - 1 + BORDER;
		end;
	end;
end;

procedure TFormMain.actAcercadeExecute(Sender: TObject);
begin
	formAcercade.ShowModal;
end;

procedure TFormMain.SegmentMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
//
end;

procedure TFormMain.SegmentMouseMove(Sender: TObject; Shift: TShiftState;
	X, Y: Integer);
begin
	Assert(Sender is TSegment);

	if Dragger.Visible then
	begin
		Dragger.X2 := TSegment(Sender).Left+X;
		Dragger.Y2 := TSegment(Sender).Top+Y;
	end;
end;

procedure TFormMain.SegmentMouseUp(Sender: TObject; Button: TMouseButton;
	Shift: TShiftState; X, Y: Integer);
begin
	if Dragger.Visible then
		Dragger.Hide;

	AjustarInstructiones;
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

procedure TFormMain.Propiedades(AInstruction: TInstruction);
begin
  if (AInstruction is TCommunication) then
	begin
    if formPropiedadesSalida.Execute(AInstruction as TCommunication) then
      with AInstruction as TCommunication do
      begin
        Comments := formPropiedadesSalida.Caption;
        BreakPoint := formPropiedadesSalida.BreckPoint;
        ShowComments := formPropiedadesSalida.ShowComments;
        ShowParameters := formPropiedadesSalida.ShowParameters;
        Locked := formPropiedadesSalida.Locked;

        Parameters := formPropiedadesSalida.Parameters;
        Device := formPropiedadesSalida.Device;
        FilePath := formPropiedadesSalida.FilePath;
        CarriageReturn := formPropiedadesSalida.CarriageReturn;
      end;
  end
  else if not (AInstruction is TNode) then
    if FormPropiedades.Execute(AInstruction) then
      with (AInstruction) do
      begin
        Comments := FormPropiedades.Caption;
        Parameters := FormPropiedades.Parameters;
        BreakPoint := FormPropiedades.BreckPoint;
        ShowComments := FormPropiedades.ShowComments;
        ShowParameters := FormPropiedades.ShowParameters;
        Locked := FormPropiedades.Locked;
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
  LInfoVariable : TVariableInformation;
//  LValor : TValue;
begin
	LInfoVariable := DEFAULT_VARIABLE_INFORMATION;
	if formPropiedadesVariables.Execute('New variable', LInfoVariable) then
    with LInfoVariable do
    begin
			LInfoVariable.Name := formPropiedadesVariables.VariableName;
			LInfoVariable.DefaultValue := formPropiedadesVariables.DefaultValue;
	//    LValor := StringAValor(LVariable.ValorPorDefecto);
			LInfoVariable.Rows := formPropiedadesVariables.Rows;
			LInfoVariable.Columns := formPropiedadesVariables.Columns;
			LInfoVariable.TypeNumber := formPropiedadesVariables.TypeNumber;
      Variables.Add(LInfoVariable);

  //    Variables.Assign(Variables.Variable(LVariable.Nombre),LValor);
  //    FreeValor(LValor);
			Modificacion(Self);
			ActualizarVariables;
    end;
end;

procedure TFormMain.btnModificarVarClick(Sender: TObject);
var
  LInfoVariable : TVariableInformation;

//  LValor : TValue;
begin
  if Variables.Count = 0 then
    Exit;

  with Variables.Variable(gridVariables.Row-1) do
  begin
    LInfoVariable.Name := Name;
    LInfoVariable.DefaultValue := ValorPorDefecto;
    LInfoVariable.Rows := Rows;
    LInfoVariable.Columns := Columns;
    LInfoVariable.TypeNumber := TypeNumber;
  end;

	if formPropiedadesVariables.Execute('Variable ' + LInfoVariable.Name, LInfoVariable) then
	begin
		with formPropiedadesVariables do
      Variables.Modify(gridVariables.Row-1,VariableName,DefaultValue,Rows,Columns,TypeNumber);
//    Variables.Assign(Variables.Variable(LVariable.Nombre),LValor);
//    FreeValor(LValor);
		Modificacion(Self);
		ActualizarVariables;
	end;
end;

procedure TFormMain.btnBorrarVarClick(Sender: TObject);
begin
	if Variables.Count = 0 then
		Exit;

	Variables.Remove(gridVariables.Row-1);
	Modificacion(Self);
	ActualizarVariables;
end;

procedure TFormMain.ActualizarVariables;
var
  j,k,l : integer;
	LVariable : TVariable;
	LValor : TValue;
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
			gridVariables.Cells[0,j+1] := LVariable.Name;
			if (LVariable.Rows=1)and(LVariable.Columns=1) then
			begin
				try
					LValor := LVariable.GetValues(0,0);
					gridVariables.Cells[1,j+1] := TValues.ToString(LValor);
				finally
					TValues.FreeValue(LValor);
				end;
			end
			else
			begin
				s := '(';
				for k := 0 to LVariable.Rows-1 do
				begin
					if (LVariable.Columns=1)or(LVariable.TypeNumber=nString) then
					begin
						try
							LValor := LVariable.GetValues(k,0);
							S := S + TValues.ToString(LValor);
						finally
							TValues.FreeValue(LValor);
						end;
					end
					else
					begin
						S := S + '(';
						for l := 0 to LVariable.Columns-1 do
						begin
							try
								LValor := LVariable.GetValues(k,l);
								S := S + TValues.ToString(LValor);
							finally
								TValues.FreeValue(LValor);
							end;
							if l<LVariable.Columns-1 then
								S := S + SEPARATOR;
						end;
						s := S + ')';
					end;
					if k<LVariable.Rows-1 then
						S := S + SEPARATOR;
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
	LInstruction : TInstruction;
begin
	for j := 0 to Seleccion.Count-1 do
	begin
		LInstruction := TInstruction(Seleccion.Items[j]);
		if not(LInstruction is TBegin) then
			LInstruction.BreakPoint := not LInstruction.BreakPoint;
	end;
end;

procedure TFormMain.actSalirExecute(Sender: TObject);
begin
	formCrt.Finalizar;
	Self.Close;
end;

end.
