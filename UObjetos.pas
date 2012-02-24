unit UObjetos;

interface

uses
{$ifdef WINDOWS}
	Windows,
{$endif}
  SysUtils, Classes, Controls, Graphics, Types, Messages, LMessages, UUtiles, Math, Forms;

type
  TDispositivo = (diPantalla,diArchivo);

	TDireccion = (dIndefinida,dNorte,dSur,dEste,dOeste,dHorizontal,dVertical);

	TFlecha = class;
	TSegmento = class;
	TUnion = class;
	TInstruccion = class;
	TSentencia = class;
	TCondicion = class;

	TUnionEvent = procedure(Sender: TObject;AUnion : TUnion) of object;

	TSegmento = class(TGraphicControl)
	private
		FPen: TPen;
		FArrastrando: boolean;
		FPos : TPoint;
		FDireccion: TDireccion;
		FAncho: Integer;

		FX1: integer;
		FX2: integer;
		FY1: integer;
		FY2: integer;

		procedure SetPen(const Value: TPen);
		procedure SetDireccion(const Value: TDireccion);
		function GetFlecha: TFlecha;
		procedure SetX1(const Value: integer);
		procedure SetY1(const Value: integer);
		procedure SetX2(const Value: integer);
		procedure SetY2(const Value: integer);
		procedure ActualizarLimites;
	protected
		procedure Paint; override;

		procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
			X, Y: Integer); override;
		procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
		procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
			X, Y: Integer); override;
	public
		constructor Create(AOwner: TComponent; AParent: TWinControl);
		destructor Destroy; override;

		procedure Actualizar(Sender: TObject);
	published
		property Flecha : TFlecha read GetFlecha;
		property Direccion: TDireccion read FDireccion write SetDireccion;
		property Pen: TPen read FPen write SetPen;
		property Arrastrando: boolean read FArrastrando;
		property X1: integer read FX1 write SetX1;
		property X2: integer read FX2 write SetX2;
		property Y1: integer read FY1 write SetY1;
		property Y2: integer read FY2 write SetY2;
		property Ancho : Integer read FAncho write FAncho default 5;

		property OnMouseDown;
		property OnMouseUp;
		property OnMouseMove;
	end;

	TFlecha = class(TComponent)
	private
    FPuntos: array of TPoint;
		FSegmentos: TList;
		FLargoMinimo: Integer;
		FUnionDesde: TUnion;
		FUnionHasta: Tunion;
		FParent: TWinControl;
		FOnDestroy: TNotifyEvent;
		FOnDestroy2: TNotifyEvent;
    FOnModificar: TNotifyEvent;
    FX1: integer;
    FY1: integer;
    FX2: integer;
    FY2: integer;

		procedure SetUnionDesde(const Value: TUnion);
		procedure SetUnionHasta(const Value: Tunion);
		procedure SetX1(const Value: integer);
		procedure SetX2(const Value: integer);
		procedure SetY1(const Value: integer);
		procedure SetY2(const Value: integer);
		function GetD1: TDireccion;
		function GetD2: TDireccion;

		procedure SetParent(const Value: TWinControl);
	protected
	public
		constructor Create(AOwner: TComponent; AParent: TWinControl);
		destructor Destroy; override;

		function GetAnterior(ASegmento: TSegmento): TSegmento;
		function GetSiguiente(ASegmento: TSegmento): TSegmento;

		procedure MoverSegmento(ASegmento : TSegmento; DX,DY: Integer;
			ACrearInicial: Boolean = true; ACrearFinal: Boolean = true);

		procedure Reset;
		procedure Reducir;
		procedure Repaint;

    procedure Mostrar;
		procedure Ocultar;

		procedure DesplazarTodo(DX,DY: Integer);
	published
		property Parent: TWinControl read FParent write SetParent;
		property LargoMinimo: Integer read FLargoMinimo write FLargoMinimo default 20;
		property Segmentos: TList read FSegmentos;
		property X1 : integer read FX1 write SetX1;
		property Y1 : integer read FY1 write SetY1;
		property D1 : TDireccion read GetD1;
		property X2 : integer read FX2 write SetX2;
		property Y2 : integer read FY2 write SetY2;
		property D2 : TDireccion read GetD2;

		property UnionDesde: TUnion read FUnionDesde write SetUnionDesde;
		property UnionHasta: Tunion read FUnionHasta write SetUnionHasta;

		property OnDestroy : TNotifyEvent read FOnDestroy write FOnDestroy;
		property OnDestroy2 : TNotifyEvent read FOnDestroy2 write FOnDestroy2;

    property OnModificar : TNotifyEvent read FOnModificar write FOnModificar;
	end;

	TUnion = class(TGraphicControl)
	private
		FDirecccion: TDireccion;
		FFlecha: TFlecha;
		FInstruccion: TInstruccion;
		FAceptaEntrada: Boolean;
		FAceptaSalida: Boolean;
		FMouseEnControl: Boolean;
		FMouseEnUnion: Boolean;
//		FArrastrando: Boolean;
    FSelected: Boolean;
    FOnSelect: TNotifyEvent;
    FX1: Integer;
    FY1: Integer;
    FX2: Integer;
    FY2: Integer;

		procedure SetFlecha(const Value: TFlecha);
		function GetRect: TRect;
		procedure SetX1(const Value: Integer);
		procedure SetY1(const Value: Integer);
		procedure SetDirecccion(Value: TDireccion);

		procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
		procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
		procedure SetMouseEnControl(const Value: Boolean);
		procedure SetMouseEnUnion(const Value: Boolean);
    procedure SetSelected(const Value: Boolean);
	protected
		procedure NuevaPosicion;
		procedure Paint; override;

		procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;

		function EstaMouseEnUnion(X,Y: Integer): Boolean;
	public
		constructor Create(AOwner: TComponent; AParent: TWinControl; AInstruccion: TInstruccion);
		destructor Destroy; override;

		procedure OnDestroyFlecha(Sender: TObject);

  	property Rect: TRect read GetRect;
  published
    property Selected : Boolean read FSelected write SetSelected;

		property X1: Integer read FX1 write SetX1;
		property Y1: Integer read FY1 write SetY1;
		property X2: Integer read FX2;
		property Y2: Integer read FY2;

		property MouseEnControl : Boolean read FMouseEnControl write SetMouseEnControl;
		property MouseEnUnion : Boolean read FMouseEnUnion write SetMouseEnUnion;

		property Direcccion: TDireccion read FDirecccion write SetDirecccion;
		property Flecha: TFlecha read FFlecha write SetFlecha;
		property Instruccion: TInstruccion read FInstruccion write FInstruccion;
		property AceptaEntrada : Boolean read FAceptaEntrada write FAceptaEntrada;
		property AceptaSalida : Boolean read FAceptaSalida write FAceptaSalida;

    property MouseCapture;
		property OnMouseDown;
		property OnMouseMove;
    property OnMouseUp;
    property OnSelect : TNotifyEvent read FOnSelect write FOnSelect;
	end;

	TInstruccion = class(TGraphicControl)
	private
		FMouseEnZonaTamano: Boolean;
		FMouseEnTamano: Boolean;
		FMouseEnControl: Boolean;
		FSelected: Boolean;
		FPuedeMover: Boolean;
		FMouseEnObjeto: Boolean;
		FPuedeUnionEste: Boolean;
		FPuedeTamano: Boolean;
		FPuedeUnionOeste: Boolean;
		FPuedeUnionNorte: Boolean;
		FOnSelect: TNotifyEvent;
		FOnUnionMouseDown: TMouseEvent;
		FOnUnionMouseUp: TMouseEvent;
		FBreakPoint: Boolean;
		FTexto: String;
    FCaption: String;
    FMuestraCaption: Boolean;
    FMuestraTexto: Boolean;
    FBloqueado: Boolean;
    FEjecutando: Boolean;
    FOnDestroy: TNotifyEvent;
    FOnModificar: TNotifyEvent;
    FX: Integer;
    FY: Integer;
    FAncho: Integer;
    FAlto: integer;
    FOnUnionMouseMove: TMouseMoveEvent;
    FError: Boolean;

		procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
		procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
		procedure SetMouseEnControl(const Value: Boolean);
		procedure SetMouseEnObjeto(const Value: Boolean);
		procedure SetMouseEnZonaTamano(const Value: Boolean);
		procedure SetMouseEnTamano(const Value: Boolean);
		procedure SetPuedeTamano(const Value: Boolean);

		procedure SetPuedeUnionEste(const Value: Boolean);
		procedure SetUnionEste(const Value: TUnion);

		procedure SetPuedeUnionNorte(const Value: Boolean);
		procedure SetUnionNorte(const Value: TUnion);

		procedure SetPuedeUnionOeste(const Value: Boolean);
		procedure SetUnionOeste(const Value: TUnion);

		procedure SetPuedeUnionSur(const Value: Boolean);
		procedure SetUnionSur(const Value: TUnion);

		procedure SetSelected(const Value: Boolean);
		procedure SetBreakPoint(const Value: Boolean);
		procedure SetEjecutando(const Value: Boolean);
		procedure SetError(const Value: Boolean);
		procedure SetCaption(const Value: String);
		procedure SetTexto(const Value: String);
		procedure SetMuestraCaption(const Value: Boolean);
		procedure SetMuestraTexto(const Value: Boolean);

		procedure SetX(const Value: Integer);
		procedure SetY(const Value: Integer);
		procedure SetAlto(const Value: integer);
		procedure SetAncho(const Value: Integer);

		procedure UnionEventos(AUnion : TUnion);
		procedure SetOnUnionMouseDown(const Value: TMouseEvent);
		procedure SetOnUnionMouseMove(const Value: TMouseMoveEvent);
		procedure SetOnUnionMouseUp(const Value: TMouseEvent);
	protected
		FPuedeUnionSur: Boolean;
		FUnionEste: TUnion;
		FUnionSur: TUnion;
		FUnionNorte: TUnion;
		FUnionOeste: TUnion;

		procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
			X, Y: Integer); override;
		procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
		procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
			X, Y: Integer); override;

		procedure PaintTamano; virtual;
		procedure PaintObjeto; virtual; abstract;
		procedure PaintTexto; virtual;
		procedure PrePaint; virtual;
		procedure PostPaint; virtual;
		procedure Paint; override;

		procedure NuevaPosicion; virtual;

		function EstaMouseEnTamano(X,Y: Integer): Boolean; virtual;
		function EstaMouseEnObjeto(X,Y: Integer): Boolean; virtual; abstract;

		procedure DarCapacidades; virtual; abstract;
	public
		constructor Create(AOwner: TComponent; AParent: TWinControl); virtual;
		destructor Destroy; override;

		procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;

		function Ejecutar : TInstruccion; virtual; abstract;
	published
		property X: Integer read FX write SetX;
		property Y: Integer read FY write SetY;
		property Ancho : Integer read FAncho write SetAncho;
		property Alto : integer read FAlto write SetAlto;

		property Caption: String read FCaption write SetCaption;
		property MuestraCaption: Boolean read FMuestraCaption write SetMuestraCaption;
		property Texto: String read FTexto write SetTexto;
		property MuestraTexto: Boolean read FMuestraTexto write SetMuestraTexto;
		property Bloqueado: Boolean read FBloqueado write FBloqueado;

		property Selected: Boolean read FSelected write SetSelected;
		property BreakPoint: Boolean read FBreakPoint write SetBreakPoint;
		property Ejecutando: Boolean read FEjecutando write SetEjecutando;
		property Error: Boolean read FError write SetError;

		property MouseEnControl : Boolean read FMouseEnControl write SetMouseEnControl;
		property MouseEnObjeto : Boolean read FMouseEnObjeto write SetMouseEnObjeto;

		property MouseEnTamano: Boolean read FMouseEnTamano write SetMouseEnTamano;
		property MouseEnZonaTamano: Boolean read FMouseEnZonaTamano write SetMouseEnZonaTamano;

		property PuedeMover: Boolean read FPuedeMover write FPuedeMover;
		property PuedeTamano: Boolean read FPuedeTamano write SetPuedeTamano;
		property PuedeUnionNorte: Boolean read FPuedeUnionNorte write SetPuedeUnionNorte;
		property PuedeUnionEste: Boolean read FPuedeUnionEste write SetPuedeUnionEste;
		property PuedeUnionSur: Boolean read FPuedeUnionSur write SetPuedeUnionSur;
		property PuedeUnionOeste: Boolean read FPuedeUnionOeste write SetPuedeUnionOeste;

		property UnionNorte: TUnion read FUnionNorte write SetUnionNorte;
		property UnionEste: TUnion read FUnionEste write SetUnionEste;
		property UnionSur: TUnion read FUnionSur write SetUnionSur;
		property UnionOeste: TUnion read FUnionOeste write SetUnionOeste;

		property OnSelect : TNotifyEvent read FOnSelect write FOnSelect;
		property OnUnionMouseDown : TMouseEvent read FOnUnionMouseDown write SetOnUnionMouseDown;
		property OnUnionMouseMove : TMouseMoveEvent read FOnUnionMouseMove write SetOnUnionMouseMove;
		property OnUnionMouseUp : TMouseEvent read FOnUnionMouseUp write SetOnUnionMouseUp;

		property OnMouseMove;
    property OnMouseDown;
    property OnMouseUp;
		property OnDestroy: TNotifyEvent read FOnDestroy write FOnDestroy;
    property OnModificar : TNotifyEvent read FOnModificar write FOnModificar;
	end;

	TSentencia = class(TInstruccion)
	private
	protected
		function EstaMouseEnObjeto(X,Y: Integer): Boolean; override;

		procedure DarCapacidades; override;

		procedure PaintObjeto; override;
	public
		constructor Create(AOwner: TComponent; AParent: TWinControl); override;

		function Ejecutar: TInstruccion; override;
	published
		property Entrada: TUnion read FUnionNorte;
		property Salida: TUnion read FUnionSur;
	end;

  TEntradaSalida = class(TSentencia)
	private
    FRetorno: Boolean;
    FDispositivo: TDispositivo;
    FArchivo: String;
		FParametros: String;
		procedure SetDispositivo(const Value: TDispositivo);
		procedure SetRetorno(const Value: Boolean);
		procedure SetArchivo(const Value: String);
		procedure SetParametros(const Value: String);

		procedure Actualizar; virtual; abstract;
	protected
	public
		constructor Create(AOwner: TComponent; AParent: TWinControl); override;
	published
		property Parametros : String read FParametros write SetParametros;
		property Dispositivo : TDispositivo read FDispositivo write SetDispositivo;
		property Retorno : Boolean read FRetorno write SetRetorno;
		property Archivo: String read FArchivo write SetArchivo;
	end;

	TEntrada = class(TEntradaSalida)
	private
	protected
		procedure Actualizar; override;

		function EstaMouseEnObjeto(X,Y: Integer): Boolean; override;

		procedure PaintObjeto; override;
	public
		constructor Create(AOwner: TComponent; AParent: TWinControl); override;
		destructor Destroy; override;
	published
	end;

	TSalida = class(TEntradaSalida)
	private
	protected
    procedure Actualizar; override;

		function EstaMouseEnObjeto(X,Y: Integer): Boolean; override;

		procedure PaintObjeto; override;
	public
    constructor Create(AOwner: TComponent; AParent: TWinControl);
    destructor Destroy; override;
	published
	end;

	TCondicion = class(TInstruccion)
	private
	protected
		procedure PaintObjeto; override;

		function EstaMouseEnObjeto(X,Y: Integer): Boolean; override;

		procedure DarCapacidades; override;
	public
		constructor Create(AOwner: TComponent; AParent: TWinControl); override;
		function Ejecutar: TInstruccion; override;
	published
		property Entrada: TUnion read FUnionNorte;
		property Verdadero: TUnion read FUnionSur;
		property Falso: TUnion read FUnionEste;
	end;

	TNodo = class(TInstruccion)
	private
	protected
		procedure DarCapacidades; override;

		procedure PaintObjeto; override;
		function EstaMouseEnObjeto(X,Y: Integer): Boolean; override;
	public
		constructor Create(AOwner: TComponent; AParent: TWinControl); override;

		function Ejecutar: TInstruccion; Override;
	published
		property Salida: TUnion read FUnionSur write FUnionSur;
		property EntradaNorte: TUnion read FUnionNorte write FUnionNorte;
		property EntradaEste: TUnion read FUnionEste write FUnionEste;
		property EntradaOeste: TUnion read FUnionOeste write FUnionOeste;
	end;

	TInicio = class(TInstruccion)
	private
	protected
		procedure DarCapacidades; override;

		procedure PaintObjeto; override;
		function EstaMouseEnObjeto(X,Y: Integer): Boolean; override;
	public
		constructor Create(AOwner: TComponent; AParent: TWinControl); override;

		function Ejecutar: TInstruccion; override;
	published
		property Salida: TUnion read FUnionSur write FUnionSur;
	end;

	TFin = class(TInstruccion)
	private
	protected
		procedure DarCapacidades; override;

		procedure PaintObjeto; override;
		function EstaMouseEnObjeto(X,Y: Integer): Boolean; override;
	public
		constructor Create(AOwner: TComponent; AParent: TWinControl); override;
		function Ejecutar: TInstruccion; override;
	published
		property Entrada: TUnion read FUnionNorte write FUnionNorte;
	end;

	TDragger = class(TGraphicControl)
	private
		FY1: Integer;
		FX1: integer;
		FX2: Integer;
		FY2: Integer;
		procedure SetX1(const Value: integer);
		procedure SetX2(const Value: Integer);
		procedure SetY1(const Value: Integer);
		procedure SetY2(const Value: Integer);

		procedure ActualizarLimites;
	protected
		procedure Paint; override;
	public
		constructor Create(AOwner: TComponent); override;
	published
		property X1: integer read FX1 write SetX1;
		property Y1: Integer read FY1 write SetY1;
		property X2: Integer read FX2 write SetX2;
		property Y2: Integer read FY2 write SetY2;

		property OnMouseMove;
	end;

var
	GOnSegmentoMouseDown: TMouseEvent;
	GOnSegmentoMouseUp: TMouseEvent;
	GOnSegmentoMouseMove: TMouseMoveEvent;

procedure Register;

implementation

uses UFormPropiedades, UAnalizadores, UConstantes;

procedure Register;
begin
	RegisterComponents('Dexec', [TInstruccion,TSentencia,TCondicion,
		TFlecha, TUnion]);
end;

{ TInstruccion }

procedure TInstruccion.CMMouseLeave(var Message: TMessage);
begin
	MouseEnControl := False;
	MouseEnObjeto := False;
	MouseEnTamano := False;
end;

constructor TInstruccion.Create(AOwner: TComponent; AParent: TWinControl);
begin
	inherited Create(AOwner);
	Parent := AParent;
	ControlStyle := ControlStyle + [csReplicatable];
	Self.Width := 141;
  FAncho := 141;
	Self.Height := 41;
  FAlto := 41;
	Bloqueado := False;

	DarCapacidades;
end;

procedure TInstruccion.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
	inherited;
	MouseEnTamano := EstaMouseEnTamano(X,Y);
	MouseEnObjeto := Not MouseEnTamano and EstaMouseEnObjeto(X,Y);
end;

procedure TInstruccion.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
	Y: Integer);
begin
	inherited;
//	if Button = mbLeft then
//	begin
//		FArrastrandoTamano := False;
//		FArrastrandoObjeto := False;
//	end;
end;

procedure TInstruccion.PrePaint;
begin
{$IFDEF FULLDEBUG}
  with canvas do
  begin
		Pen.Color := clWhite;
		Brush.Color := clWhite;
		Rectangle(0,0,Self.Width,Self.Height);
  end;
{$ENDIF}
	// Por ahora no es necesario hacer nada
end;

procedure TInstruccion.PostPaint;
begin
end;

procedure TInstruccion.SetSelected(const Value: Boolean);
begin
	if FSelected<>Value then
	begin
		FSelected := Value;

		if Value and Assigned(FOnSelect) then
			OnSelect(Self);

		Invalidate;
	end;
end;

procedure TInstruccion.CMMouseEnter(var Message: TMessage);
begin
	MouseEnControl := True;
end;

procedure TInstruccion.SetMouseEnControl(const Value: Boolean);
begin
	if FMouseEnControl<>Value then
	begin
		FMouseEnControl := Value;
		Invalidate;
	end;
end;

function TInstruccion.EstaMouseEnTamano(X, Y: Integer): Boolean;
begin
	Result := PuedeTamano and
		TUtiles.PuntoEnRect(X,Y,
      TUtiles.RectCentradoEn(Self.Width-BORDE div 2,Self.Height-BORDE div 2,BORDE));
end;

procedure TInstruccion.SetMouseEnZonaTamano(const Value: Boolean);
begin
	if FMouseEnZonaTamano<>Value then
	begin
		FMouseEnZonaTamano := Value;
	end;
end;

procedure TInstruccion.SetMouseEnTamano(const Value: Boolean);
begin
	if FMouseEnTamano<>Value then
	begin
		FMouseEnTamano := Value;
	end;
end;

procedure TInstruccion.PaintTamano;
begin
	if MouseEnControl and PuedeTamano and not Bloqueado then
		with Canvas do
		begin
			Pen.Color := clBlack;
			Pen.Width := 1;
			Brush.Color := clBlue;
			Brush.Style := bsSolid;

			Rectangle(TUtiles.RectCentradoEn(Self.Width-BORDE div 2,Self.Height-BORDE div 2,BORDE));
		end;
end;

procedure TInstruccion.SetMouseEnObjeto(const Value: Boolean);
begin
	if FMouseEnObjeto<>Value then
	begin
		FMouseEnObjeto := Value;
	end;
end;

procedure TInstruccion.Paint;
begin
	inherited;
	PrePaint;
	PaintObjeto;
	PaintTexto;
	PaintTamano;
	PostPaint;
end;

procedure TInstruccion.SetPuedeTamano(const Value: Boolean);
begin
	FPuedeTamano := Value;
end;

procedure TInstruccion.SetPuedeUnionEste(const Value: Boolean);
begin
	if FPuedeUnionEste<>Value then
	begin
		FPuedeUnionEste := Value;
		if FPuedeUnionEste and (UnionEste=Nil) then
		begin
			UnionEste := TUnion.Create(Self,Parent,Self);
			UnionEste.Direcccion := dEste;
      UnionEventos(UnionEste);
			NuevaPosicion;
		end;
		if not FPuedeUnionEste and (UnionEste<>Nil) then
		begin
			UnionEste.Free;
			UnionEste := Nil;
		end;
	end;
end;

procedure TInstruccion.SetPuedeUnionOeste(const Value: Boolean);
begin
	if FPuedeUnionOeste<>Value then
	begin
		FPuedeUnionOeste := Value;
		if FPuedeUnionOeste and (UnionOeste=Nil) then
		begin
			UnionOeste := TUnion.Create(Self,Parent,Self);
			UnionOeste.Direcccion := dOeste;
      UnionEventos(UnionOeste);
			NuevaPosicion;
		end;
		if not FPuedeUnionOeste and (UnionOeste<>Nil) then
		begin
			UnionOeste.Free;
			UnionOeste := Nil;
		end;
	end;
end;

procedure TInstruccion.SetPuedeUnionSur(const Value: Boolean);
begin
	if FPuedeUnionSur<>Value then
	begin
		FPuedeUnionSur := Value;
		if FPuedeUnionSur and (UnionSur=Nil) then
		begin
			UnionSur := TUnion.Create(Self,Parent,Self);
			UnionSur.Direcccion := dSur;
      UnionEventos(UnionSur);
			NuevaPosicion;
		end;
		if not FPuedeUnionSur and (UnionSur<>Nil) then
		begin
			UnionSur.Free;
			UnionSur := Nil;
		end;
	end;
end;

procedure TInstruccion.SetPuedeUnionNorte(const Value: Boolean);
begin
	if FPuedeUnionNorte<>Value then
	begin
		FPuedeUnionNorte := Value;
		if FPuedeUnionNorte and (UnionNorte=Nil) then
		begin
			UnionNorte := TUnion.Create(Self,Parent,Self);
			UnionNorte.Direcccion := dNorte;
      UnionEventos(UnionNorte);
			NuevaPosicion;
		end;
		if not FPuedeUnionNorte and (UnionNorte<>Nil) then
		begin
			UnionNorte.Free;
			UnionNorte := Nil;
		end;
	end;
end;

procedure TInstruccion.SetUnionEste(const Value: TUnion);
begin
	if FUnionEste<>Value then
		FUnionEste := Value;
end;

procedure TInstruccion.SetUnionNorte(const Value: TUnion);
begin
	if FUnionNorte<>Value then
		FUnionNorte := Value;
end;

procedure TInstruccion.SetUnionOeste(const Value: TUnion);
begin
	if FUnionOeste<>Value then
		FUnionOeste := Value;
end;

procedure TInstruccion.SetUnionSur(const Value: TUnion);
begin
	if FUnionSur<>Value then
		FUnionSur := Value;
end;

procedure TInstruccion.NuevaPosicion;
begin
	if PuedeUnionNorte then
	begin
		UnionNorte.X1 := X;
		UnionNorte.Y1 := Y - Self.Alto div 2 - 1;
	end;
	if PuedeUnionEste then
	begin
		UnionEste.X1 := X + Self.Ancho div 2 + 1;
		UnionEste.Y1 := Y;
	end;
	if PuedeUnionSur then
	begin
		UnionSur.X1 := X;
		UnionSur.Y1 := Y + Self.Alto div 2 + 1;
	end;
	if PuedeUnionOeste then
	begin
		UnionOeste.X1 := X - Self.Ancho div 2 - 1;
		UnionOeste.Y1 := Y;
	end;
end;

procedure TInstruccion.SetBreakPoint(const Value: Boolean);
begin
	if Value <> FBreakPoint then
	begin
		FBreakPoint := Value;
		Invalidate;
	end;
end;

procedure TInstruccion.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited;
	if Assigned(FOnModificar) then
    OnModificar(Self);
end;

procedure TInstruccion.SetCaption(const Value: String);
begin
	if FCaption <> Value then
	begin
		FCaption := Value;
    if Assigned(FOnModificar) then
      OnModificar(Self);
		Invalidate;
	end;
end;

procedure TInstruccion.SetTexto(const Value: String);
begin
	if FTexto <> Value then
	begin
		FTexto := Value;
    if Assigned(FOnModificar) then
      OnModificar(Self);
		Invalidate;
	end;
end;

procedure TInstruccion.SetMuestraCaption(const Value: Boolean);
begin
	if FMuestraCaption <> Value then
	begin
		FMuestraCaption := Value;
    if Assigned(FOnModificar) then
      OnModificar(Self);
		Invalidate;
	end;
end;

procedure TInstruccion.SetMuestraTexto(const Value: Boolean);
begin
	if FMuestraTexto <> Value then
	begin
		FMuestraTexto := Value;
    if Assigned(FOnModificar) then
      OnModificar(Self);
		Invalidate;
	end;
end;

procedure TInstruccion.PaintTexto;
var h,b1,b2: integer;
begin
	with Canvas do
	begin
		Pen.Color := clBlack;
		Pen.Width := 1;
		Brush.Color := clWhite;
		Brush.Style := bsClear;
		Font.Color := clBlack;

		h := TextHeight('m');
		if MuestraCaption and MuestraTexto then
		begin
			b1 := TextWidth(Caption);
			TextOut((Self.Width - b1) div 2,Self.Height div 2 - h,Caption);
			b2 := TextWidth(Texto);
			TextOut((Self.Width - b2) div 2,Self.Height div 2,Texto);
		end
		else if MuestraCaption then
		begin
			b1 := TextWidth(Caption);
			TextOut((Self.Width - b1) div 2,(Self.Height - h) div 2,Caption);
		end
		else if MuestraTexto then
		begin
			b2 := TextWidth(Texto);
			TextOut((Self.Width - b2) div 2,(Self.Height - h) div 2,Texto);
		end;
	end;
end;

procedure TInstruccion.SetEjecutando(const Value: Boolean);
begin
	if Value <> FEjecutando then
	begin
		FEjecutando := Value;
		Invalidate;
	end;
end;

destructor TInstruccion.Destroy;
begin
  if Assigned(FOnDestroy) then
    FOnDestroy(Self);
  inherited;
end;

procedure TInstruccion.MouseDown(Button: TMouseButton; Shift: TShiftState;
			X, Y: Integer);
begin
  inherited;
//  FArrastrandoTamano := MouseEnTamano and PuedeTamano;
//  FArrastrandoObjeto := not FArrastrandoTamano and MouseEnObjeto
//    and PuedeMover;
end;

procedure TInstruccion.SetX(const Value: Integer);
var
	LValue : Integer;
	LScrollBox : TScrollBox;
begin
	LValue := Value div GRILLAX * GRILLAX;
	if FX<>LValue then
	begin
		FX := LValue;
		if Self.Parent is TScrollBox then
		begin
			LScrollBox := Self.Parent as TScrollBox;
			Left := LValue - FAncho div 2 - LScrollBox.HorzScrollBar.Position;
		end
		else
			Left := LValue - FAncho div 2;
		NuevaPosicion;
	end;
end;

procedure TInstruccion.SetY(const Value: Integer);
var
	LValue : integer;
	LScrollBox : TScrollBox;
begin
	LValue := Value div GRILLAY * GRILLAY;
	if FY<>LValue then
	begin
		FY := LValue;
		if Self.Parent is TScrollBox then
		begin
			LScrollBox := Self.Parent as TScrollBox;
			Top := LValue - FAlto div 2 - LScrollBox.VertScrollBar.Position;
		end
		else
			Top := LValue - FAlto div 2;
		NuevaPosicion;
	end;
end;

procedure TInstruccion.SetAlto(const Value: integer);
var
  LValue : Integer;
begin
	if FAlto<>Value then
	begin
		LValue := Value div 2 * 2 + 1;
		Top := Top - (LValue - FAlto) div 2;
		Self.Height := LValue;
		FAlto := LValue;
		NuevaPosicion;
	end;
end;

procedure TInstruccion.SetAncho(const Value: Integer);
var
  LValue : Integer;
begin
	if FAncho<>Value then
	begin
		LValue := Value div 2 * 2 + 1;
		Left := Left - (LValue - FAncho) div 2;
		Self.Width := LValue;
		FAncho := LValue;
		NuevaPosicion;
	end;
end;

procedure TInstruccion.UnionEventos(AUnion: TUnion);
begin
  with AUnion do
  begin
    OnMouseMove := OnUnionMouseMove;
    OnMouseDown := OnUnionMouseDown;
    OnMouseUp := OnUnionMouseUp;
  end;
end;

procedure TInstruccion.SetOnUnionMouseDown(const Value: TMouseEvent);
begin
  if PuedeUnionNorte then
    UnionNorte.OnMouseDown := Value;
  if PuedeUnionEste then
    UnionEste.OnMouseDown := Value;
  if PuedeUnionSur then
    UnionSur.OnMouseDown := Value;
  if PuedeUnionOeste then
    UnionOeste.OnMouseDown := Value;
  FOnUnionMouseDown := Value;
end;

procedure TInstruccion.SetOnUnionMouseMove(const Value: TMouseMoveEvent);
begin
  if PuedeUnionNorte then
    UnionNorte.OnMouseMove := Value;
  if PuedeUnionEste then
    UnionEste.OnMouseMove := Value;
  if PuedeUnionSur then
    UnionSur.OnMouseMove := Value;
  if PuedeUnionOeste then
    UnionOeste.OnMouseMove := Value;
  FOnUnionMouseMove := Value;
end;

procedure TInstruccion.SetOnUnionMouseUp(const Value: TMouseEvent);
begin
  if PuedeUnionNorte then
    UnionNorte.OnMouseUp := Value;
  if PuedeUnionEste then
    UnionEste.OnMouseUp := Value;
  if PuedeUnionSur then
    UnionSur.OnMouseUp := Value;
  if PuedeUnionOeste then
    UnionOeste.OnMouseUp := Value;
  FOnUnionMouseUp := Value;
end;

procedure TInstruccion.SetError(const Value: Boolean);
begin
	if Value <> FError then
	begin
		FError := Value;
		Invalidate;
	end;
end;

{ TSentencia }

constructor TSentencia.Create(AOwner: TComponent; AParent: TWinControl);
begin
	inherited;
	MuestraCaption := False;
	MuestraTexto := True;
end;

function TSentencia.EstaMouseEnObjeto(X, Y: Integer): Boolean;
begin
	Result := (X>=0)and(X<=Self.Width)and(Y>=0)and(Y<=Self.Height);
end;

procedure TSentencia.DarCapacidades;
begin
  inherited;
	PuedeMover := True;
	PuedeTamano := True;
	PuedeUnionNorte := True;
	PuedeUnionEste := False;
	PuedeUnionSur := True;
	PuedeUnionOeste := False;

	Entrada.AceptaEntrada := True;
	Entrada.AceptaSalida := False;
	Salida.AceptaEntrada := False;
	Salida.AceptaSalida := True;
end;

procedure TSentencia.PaintObjeto;
begin
	inherited;
	with Canvas do
	begin
		Pen.Color := clBlack;
		if Selected then
			Pen.Width := 3
		else
			Pen.Width := 1;

		if Error then
			Brush.Color := COLOR_ERROR
		else if Ejecutando then
			Brush.Color := COLOR_EJECUCION
		else if BreakPoint then
			Brush.Color := COLOR_BREAK_POINT
		else
			Brush.Color := COLOR_OBJETO;

		Brush.Style := bsSolid;
		Rectangle(0,0,self.Width,self.Height);
	end;
end;

function TSentencia.Ejecutar: TInstruccion;
begin
	Self.Error := False;
	try
		TAnalizadores.Sentencia(Self.Texto);
		if not assigned(Salida.Flecha) then
			raise Exception.Create('Exit arrow expected!')
		else
			Result := Salida.Flecha.UnionHasta.Instruccion;
	except
		Self.Error := True;
		raise;
	end;
end;

{ TCondicion }

procedure TCondicion.PaintObjeto;
const
	N1 = 15;
	N2 = 15;
var
	P : array[0..3] of TPoint;
begin
	with Canvas do
	begin
		Pen.Color := clBlack;
		if Selected then
			Pen.Width := 3
		else
			Pen.Width := 1;

		if Error then
			Brush.Color := COLOR_ERROR
		else if Ejecutando then
			Brush.Color := COLOR_EJECUCION
		else if BreakPoint then
			Brush.Color := COLOR_BREAK_POINT
		else
			Brush.Color := COLOR_OBJETO;

		// Rombo principal
		P[0] := Point(0,Self.Height div 2);
		P[1] := Point(Self.Width div 2,0);
		P[2] := Point(Self.Width-1,Self.Height div 2);
		P[3] := Point(Self.Width div 2,Self.Height-1);
		Polygon(P);

		Pen.Width := 1;
		Brush.Color := RGBToColor(0,196,0);
		P[0] := Point(Self.Width div 2,Self.Height-1);
		if Self.Width > Self.Height then
			P[1] := Point(Self.Width div 2 - N1, Self.Height - N1 * Self.Height div Self.Width - 1)
		else
			P[1] := Point(Self.Width * (Self.Height - 2 * N1) div (Self.Height * 2), Self.Height - N1);

		if Self.Width > Self.Height then
			P[2] := Point(Self.Width div 2 + N1, Self.Height - N1 * Self.Height div Self.Width - 1)
		else
			P[2] := Point(Self.Width * (Self.Height + 2 * N1) div (Self.Height * 2), Self.Height - N1);
		P[3] := Point(Self.Width div 2,Self.Height-1);
		Polygon(P);
		Pen.Width := 1;
		Brush.Color := clRed;
		P[0] := Point(Self.Width - 1,Self.Height div 2);
		if Self.Width > Self.Height then
			P[1] := Point(Self.Width - N2, Self.Height * (Self.Width - 2 * N2) div (2 * Self.Width))
		else
			P[1] := Point(Self.Width - Self.Width * N2 div Self.Height, Self.Height div 2 - N2);
		if Self.Width > Self.Height then
			P[2] := Point(Self.Width - N2, Self.Height * (N2 * 2 + Self.Width) div (2 * Self.Width))
		else
			P[2] := Point(Self.Width - Self.Width * N2 div Self.Height, Self.Height div 2 + N2);
		P[3] := Point(Self.Width - 1,Self.Height div 2);
		Polygon(P);
	end;
end;

function TCondicion.EstaMouseEnObjeto(X, Y: Integer): Boolean;
var
	M1,M2 : Real;
	X1,Y1,X2,Y2,X3,Y3 : Real;
begin
	Result := False;

	X1 := 0;
	Y1 := Self.Height / 2;
	X2 := Self.Width / 2;
	Y2 := 0;
	X3 := Self.Width / 2;
	Y3 := Self.Height;
	if X<=X2 then
	begin

		M1 := (Y2-Y1)/(X2-X1);
		M2 := (Y3-Y1)/(X3-X1);

		Result := (Y>=M1*(X-X1)+Y1)and(Y<=M2*(X-X1)+Y1);
	end;
	if Not Result and (X>=X2) then
	begin
		X1 := Self.Width;
		Y1 := Self.Height / 2;

		M1 := (Y2-Y1)/(X2-X1);
		M2 := (Y3-Y1)/(X3-X1);
		Result := (Y>=M1*(X-X1)+Y1)and(Y<=M2*(X-X1)+Y1);
	end;
end;

constructor TCondicion.Create(AOwner: TComponent; AParent: TWinControl);
begin
  inherited;
//  Caption := '';
//	Texto := 'A = B';
	MuestraCaption := False;
	MuestraTexto := True;
end;

procedure TCondicion.DarCapacidades;
begin
  inherited;
	PuedeMover := True;
	PuedeTamano := True;
	PuedeUnionNorte := True;
	PuedeUnionEste := True;
	PuedeUnionSur := True;
	PuedeUnionOeste := False;

	Entrada.AceptaEntrada := True;
	Entrada.AceptaSalida := False;
	Verdadero.AceptaEntrada := False;
	Verdadero.AceptaSalida := True;
	Falso.AceptaEntrada := False;
	Falso.AceptaSalida := True;
end;

function TCondicion.Ejecutar: TInstruccion;
begin
	Self.Error := False;
	try
		if TAnalizadores.Condicion(Texto) then
		begin
			if Not assigned(Verdadero.Flecha) then
				raise Exception.Create('Exit arrow expected!')
			else
				Result := Verdadero.Flecha.UnionHasta.Instruccion
		end
		else
		begin
			if assigned(Falso.Flecha) then
				Result := Falso.Flecha.UnionHasta.Instruccion
			else
				raise Exception.Create('Exit arrow expected!');
		end;
	except
		Self.Error := True;
		raise;
	end;
end;

{ TUnion }

constructor TUnion.Create(AOwner: TComponent; AParent: TWinControl; AInstruccion: TInstruccion);
begin
	inherited Create(AOwner);
	Parent := AParent;
	Instruccion := AInstruccion;
end;

destructor TUnion.Destroy;
begin
	if Assigned(Flecha) then
		Flecha.Free;	
	inherited;
end;

function TUnion.GetRect: TRect;
begin
	if Instruccion<>Nil then
	begin
		Result.Left := Instruccion.Left - BORDE;
		Result.Top := Instruccion.Top - BORDE;
		Result.Right := Instruccion.Left + Instruccion.Width + BORDE - 1;
		Result.Bottom := Instruccion.Top + Instruccion.Height + BORDE - 1;
	end;
end;

procedure TUnion.OnDestroyFlecha(Sender: TObject);
begin
	Flecha := Nil;
end;

procedure TUnion.SetFlecha(const Value: TFlecha);
begin
  if FFlecha<>Value then
  begin
    FFlecha := Value;
    NuevaPosicion;
    if Assigned(Instruccion) then
      Instruccion.Invalidate;
  end;
end;

procedure TUnion.NuevaPosicion;
begin
	if Flecha<>Nil then
	begin
		if Flecha.UnionDesde=Self then
		begin
			Flecha.X1 := Self.X2;
			Flecha.Y1 := Self.Y2;
		end
		else
		begin
			Flecha.X2 := Self.X2;
			Flecha.Y2 := Self.Y2;
		end;
	end;
end;

procedure TUnion.SetX1(const Value: Integer);
var
	LScrollBox : TScrollBox;
begin
	if X1<>Value then
	begin
		FX1 := Value;
		if Self.Parent is TScrollBox then
		begin
			LScrollBox := Self.Parent as TScrollBox;
			case Direcccion of
				dNorte: Left := FX1 - BORDE div 2 - LScrollBox.HorzScrollBar.Position;
				dEste: Left := FX1 - LScrollBox.HorzScrollBar.Position;
				dSur: Left := FX1 - BORDE div 2 - LScrollBox.HorzScrollBar.Position;
				dOeste: Left := FX1 - BORDE * 3 div 2 + 1 - LScrollBox.HorzScrollBar.Position;
			end;
		end
		else
			case Direcccion of
				dNorte: Left := FX1 - BORDE div 2;
				dEste: Left := FX1;
				dSur: Left := FX1 - BORDE div 2;
				dOeste: Left := FX1 - BORDE * 3 div 2 + 1;
			end;
		case Direcccion of
			dNorte: FX2 := FX1;
			dEste: FX2 := FX1 + BORDE div 2 * 2;
			dSur: FX2 := FX1;
			dOeste: FX2 := Value - BORDE div 2 * 2;
		end;
		NuevaPosicion;
  end;
end;

procedure TUnion.SetY1(const Value: Integer);
var
  LScrollBox :  TScrollBox;
begin
	if Y1<>Value then
	begin
		FY1 := Value;
		if Self.Parent is TScrollBox then
		begin
			LScrollBox := Self.Parent as TScrollBox;
			case Direcccion of
				dNorte: Top := FY1 - BORDE * 3 div 2 + 1 - LScrollBox.VertScrollBar.Position;
				dEste: Top := FY1 - BORDE div 2 - LScrollBox.VertScrollBar.Position;
				dSur: Top := FY1 - LScrollBox.VertScrollBar.Position;
				dOeste: Top := FY1 - BORDE div 2 - LScrollBox.VertScrollBar.Position;
			end;
		end
		else
			case Direcccion of
				dNorte: Top := FY1 - BORDE * 3 div 2 + 1;
				dEste: Top := FY1 - BORDE div 2;
				dSur: Top := FY1;
				dOeste: Top := FY1 - BORDE div 2;
			end;
		case Direcccion of
			dNorte: FY2 := FY1 - BORDE div 2 * 2;
			dEste: FY2 := FY1;
      dSur: FY2 := FY1 + BORDE div 2 * 2;
      dOeste: FY2 := FY1;
    end;
    NuevaPosicion;
  end;
end;

procedure TUnion.SetDirecccion(Value: TDireccion);
var
	LX1,LY1: Integer;
begin
	if Value<>FDirecccion then
	begin
		LX1 := X1;
		LY1 := Y1;
		case Value of
			dNorte, dSur:
				begin
					Self.Width := BORDE;
					Self.Height := BORDE * 3 div 2;
				end;
			dEste, dOeste:
				begin
					Self.Width := BORDE * 3 div 2;
					Self.Height := BORDE;
				end;
		end;
		FDirecccion := Value;
		X1 := LX1;
		Y1 := LY1;
	end;
end;

procedure TUnion.Paint;
begin
	inherited;
	with Canvas do
	begin
{$IFDEF FULLDEBUG}
		Pen.Color := clWhite;
		Brush.Color := clWhite;
		Rectangle(0,0,Self.Width,Self.Height);
{$ENDIF}
		Pen.Color := clBlack;
//		Pen.Width := 1;
		case Direcccion of
			dNorte:
				begin
					MoveTo(Self.Width div 2, Self.Height);
					LineTo(Self.Width div 2, BORDE div 2);
					if MouseEnUnion then
					begin
						Brush.Color := clGreen;
						Rectangle(0,0,Self.Width,BORDE);
					end
					else if FSelected then
					begin
						Brush.Color := clBlue;
						Rectangle(0,0,Self.Width,BORDE);
					end
					else if not Assigned(Flecha) then
					begin
						Brush.Color := clRed;
						Ellipse(BORDE div 4,BORDE div 4,BORDE * 3 div 4 + 1,BORDE * 3 div 4 + 1);
					end;
				end;
			dEste:
				begin
					MoveTo(0, Self.Height div 2);
					LineTo(BORDE, Self.Height div 2);
					if MouseEnUnion then
          begin
            Brush.Color := clGreen;
						Rectangle(BORDE div 2,0,Self.Width,Self.Height);
          end
          else if FSelected then
          begin
            Brush.Color := clBlue;
						Rectangle(BORDE div 2,0,Self.Width,Self.Height);
					end
					else if not Assigned(Flecha) then
					begin
						Brush.Color := clRed;
						Ellipse(BORDE * 3 div 4,BORDE div 4,BORDE + 2,BORDE * 3 div 4 + 1);
					end;
				end;
			dSur:
				begin
					MoveTo(Self.Width div 2, 0);
					LineTo(Self.Width div 2, BORDE);
					if MouseEnUnion then
					begin
						Brush.Color := clGreen;
						Rectangle(0,BORDE div 2,Self.Width,Self.Height);
					end
					else if FSelected then
					begin
						Brush.Color := clBlue;
						Rectangle(0,BORDE div 2,Self.Width,Self.Height);
					end
					else if not Assigned(Flecha) then
					begin
						Brush.Color := clRed;
						Ellipse(BORDE div 4,BORDE * 3 div 4,BORDE * 3 div 4 +1,BORDE + 2);
					end;
				end;
			dOeste:
				begin
					MoveTo(Self.Width, Self.Height div 2);
					LineTo(BORDE div 2, Self.Height div 2);
					if MouseEnUnion then
					begin
						Brush.Color := clGreen;
						Rectangle(0,0,BORDE,Self.Height);
					end
					else if FSelected then
					begin
						Brush.Color := clBlue;
						Rectangle(0,0,BORDE,Self.Height);
					end
					else if not Assigned(Flecha) then
					begin
						Brush.Color := clRed;
						Ellipse(BORDE div 4,BORDE div 4,BORDE * 3 div 4 + 1,BORDE-2);
					end;
				end;
		end;
	end;
end;

procedure TUnion.CMMouseEnter(var Message: TMessage);
begin
	MouseEnControl := True;
end;

procedure TUnion.CMMouseLeave(var Message: TMessage);
begin
	MouseEnControl := False;
	MouseEnUnion := False;
end;

procedure TUnion.SetMouseEnControl(const Value: Boolean);
begin
  FMouseEnControl := Value;
end;

procedure TUnion.SetMouseEnUnion(const Value: Boolean);
begin
	if FMouseEnUnion <> value then
	begin
		FMouseEnUnion := Value;
		Invalidate;
	end;
end;

procedure TUnion.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;
	MouseEnUnion := EstaMouseEnUnion(X,Y);
end;

function TUnion.EstaMouseEnUnion(X, Y: Integer): Boolean;
begin
	Result := False;
	case Direcccion of
		dNorte: Result := Y < BORDE;
		dEste: Result := X > BORDE div 2 - 1;
		dSur : Result := Y > BORDE div 2 - 1;
		dOeste : Result := X < BORDE;
	end;
end;

procedure TUnion.SetSelected(const Value: Boolean);
begin
	if FSelected<>Value then
	begin
		FSelected := Value;

		if Value and Assigned(FOnSelect) then
			OnSelect(Self);

		Invalidate;
	end;
end;

{ TFlecha }

procedure TFlecha.Reset;
type
	TPunto = record
		Punto: TPoint;
		Distancia : real;
		Desde : Integer;
		Asignado: boolean;
		Arcos: array of integer;
	end;
var
	Puntos : array of TPunto;
	R1,R2: TRect;

	procedure CrearPuntos;

		procedure Insertar(AX,AY: Integer);
		begin
			SetLength(Puntos,Length(Puntos)+1);
			with Puntos[High(Puntos)] do
			begin
				Punto.X := AX; Punto.Y := AY;
				Distancia := MaxInt; Asignado := False;
				Desde := -1;
			end;
		end; //Insertar

	begin
		SetLength(Puntos,0);
		Insertar(UnionDesde.X2,UnionDesde.Y2);

		Insertar(R1.Left,R1.Top);
		Insertar(R1.Right,R1.Top);
		Insertar(R1.Left,R1.Bottom);
		Insertar(R1.Right,R1.Bottom);

		Insertar(R2.Left,R2.Top);
		Insertar(R2.Right,R2.Top);
		Insertar(R2.Left,R2.Bottom);
		Insertar(R2.Right,R2.Bottom);

		Insertar(UnionHasta.X2,UnionHasta.Y2);
	end; // CrearPuntos

	procedure CrearArcos;
	var
		j,k : integer;

		function Secantes(AP1,AP2: TPoint; AR: TRect): Boolean;
		var
			Aux : TPoint;
		begin
			Result := (AP1.X=AR.Right)and(AP1.Y>AR.Top)and(AP1.Y<AR.Bottom)and
				(AP2.X<AR.Right);
			Result := Result or (AP1.X=AR.Right)and(AP1.Y=AR.Bottom)and
				(AP2.X<AR.Right)and(AP2.Y<AR.Bottom);
			Result := Result or (AP1.X>AR.Left)and(AP1.X<AR.Right)and(AP1.Y=AR.Bottom)and
				(AP2.Y<AR.Bottom);
			Result := Result or (AP1.X=AR.Left)and(AP1.Y=AR.Bottom)and
				(AP2.X>AR.Left)and(AP2.Y<AR.Bottom);
			Result := Result or (AP1.X=AR.Left)and(AP1.Y>AR.Top)and(AP1.Y<AR.Bottom)and
				(AP2.X>AR.Left);
			Result := Result or (AP1.X=AR.Left)and(AP1.Y=AR.Top)and
				(AP2.X>AR.Left)and(AP2.Y>AR.Top);
			Result := Result or (AP1.Y=AR.Top)and(AP1.X>AR.Left)and(AP1.X<AR.Right)and
				(AP2.Y>AR.Top);
			Result := Result or (AP1.X=AR.Right)and(AP1.Y=AR.Top)and
				(AP2.X<AR.Right)and(AP2.Y>AR.Top);

			Aux := AP1;
			AP1 := AP2;
			AP2 := Aux;

			Result := Result or (AP1.X=AR.Right)and(AP1.Y>AR.Top)and(AP1.Y<AR.Bottom)and
				(AP2.X<AR.Right);
			Result := Result or (AP1.X=AR.Right)and(AP1.Y=AR.Bottom)and
				(AP2.X<AR.Right)and(AP2.Y<AR.Bottom);
			Result := Result or (AP1.X>AR.Left)and(AP1.X<AR.Right)and(AP1.Y=AR.Bottom)and
				(AP2.Y<AR.Bottom);
			Result := Result or (AP1.X=AR.Left)and(AP1.Y=AR.Bottom)and
				(AP2.X>AR.Left)and(AP2.Y<AR.Bottom);
			Result := Result or (AP1.X=AR.Left)and(AP1.Y>AR.Top)and(AP1.Y<AR.Bottom)and
				(AP2.X>AR.Left);
			Result := Result or (AP1.X=AR.Left)and(AP1.Y=AR.Top)and
				(AP2.X>AR.Left)and(AP2.Y>AR.Top);
			Result := Result or (AP1.Y=AR.Top)and(AP1.X>AR.Left)and(AP1.X<AR.Right)and
				(AP2.Y>AR.Top);
			Result := Result or (AP1.X=AR.Right)and(AP1.Y=AR.Top)and
				(AP2.X<AR.Right)and(AP2.Y>AR.Top);
		end; // Secantes

	begin
		for j := 0 to High(Puntos) do
			for k := j+1 to High(Puntos) do
				if j<>k then
					begin
						if not Secantes(Puntos[j].Punto,Puntos[k].Punto,R1)
							and not Secantes(Puntos[j].Punto,Puntos[k].Punto,R2) then
						begin
							with Puntos[j] do
							begin
								SetLength(Arcos,Length(Arcos)+1);
								Arcos[High(Arcos)] := k;
							end;
							with Puntos[k] do
							begin
								SetLength(Arcos,Length(Arcos)+1);
								Arcos[High(Arcos)] := j;
							end;
						end;
					end;
	end; // CrearArcos

	procedure CrearRuta;

		function Dist(AP1,AP2: TPoint): Real;
		begin
			Result := Sqrt(Sqr(AP1.X-AP2.X)+Sqr(AP1.Y-AP2.Y));
		end;

	var
		j : integer;
		Act,Min : integer;
		DistMin : Real;
	begin
		Puntos[0].Asignado := True;
		Puntos[0].Distancia := 0;
		Act := 0;
		while not Puntos[High(Puntos)].Asignado do begin
			for j := 0 to High(Puntos[Act].Arcos) do
			begin
				if not Puntos[Puntos[Act].Arcos[j]].Asignado then
				begin
					DistMin := Puntos[Act].Distancia +
						Dist(Puntos[Act].Punto,Puntos[Puntos[Act].Arcos[j]].Punto);
					if (Puntos[Puntos[Act].Arcos[j]].Distancia>DistMin) then
					begin
						Puntos[Puntos[Act].Arcos[j]].Distancia := DistMin;
						Puntos[Puntos[Act].Arcos[j]].Desde := Act;
					end;
				end;
			end;

			DistMin := MaxInt;
			Min := -1;
			for j := 0 to High(Puntos) do
			begin
				if not Puntos[j].Asignado and (Puntos[j].Distancia<DistMin) then
				begin
					DistMin := Puntos[j].Distancia;
					Min := j;
				end;
			end;

			Puntos[Min].Asignado := True;
			Act := Min;
		end;
	end; // CrearRuta

	procedure CrearSegmentos;

		procedure NuevoSegmento(ADireccion: TDireccion;AX1,AY1,AX2,AY2:Integer);
		var Aux: TSegmento;
		begin
				Aux := TSegmento.Create(Self,Parent);
				Segmentos.Add(Aux);
				Aux.Parent := Self.Parent;
				Aux.Direccion := ADireccion;
				Aux.X1 := AX1;
				Aux.Y1 := AY1;
				Aux.X2 := AX2;
				Aux.Y2 := AY2;
				Aux.SendToBack;
		end; // NuevoSegmento;

	type
		TRuta = record
			I : Integer;
			D : TDireccion;
		end;
	var
		Ruta : Array of TRuta;
		j,LX1,LX2,LY1,LY2 : integer;
	begin
		SetLength(Ruta,1);
		Ruta[0].I := 9;
		case UnionHasta.Direcccion of
			dNorte,dSur,dVertical: Ruta[0].D := dVertical;
			dEste,dOeste,dHorizontal: Ruta[0].D := dHorizontal;
		end;
		while Ruta[High(Ruta)].I<>0 do
		begin
			SetLength(Ruta,Length(Ruta)+1);
			Ruta[High(Ruta)].I := Puntos[Ruta[High(Ruta)-1].I].Desde;
			Ruta[High(Ruta)].D := dIndefinida;
		end;
		case UnionDesde.Direcccion of
			dNorte,dSur,dVertical: Ruta[High(Ruta)].D := dVertical;
			dEste,dOeste,dHorizontal: Ruta[High(Ruta)].D := dHorizontal;
		end;

		for j := High(Ruta)-1 downto 1 do
			if Ruta[j].D=dIndefinida then
			begin
				if Puntos[Ruta[j].I].Punto.X=Puntos[Ruta[j+1].I].Punto.X then
					Ruta[j].D := dVertical
				else if Puntos[Ruta[j].I].Punto.Y=Puntos[Ruta[j+1].I].Punto.Y then
					Ruta[j].D := dHorizontal
				else if Puntos[Ruta[j].I].Punto.X=Puntos[Ruta[j-1].I].Punto.X then
					Ruta[j].D := dVertical
				else if Puntos[Ruta[j].I].Punto.Y=Puntos[Ruta[j-1].I].Punto.Y then
					Ruta[j].D := dHorizontal;
			end;

		for j := High(Ruta) downto 1 do
		begin
			LX1 := Puntos[Ruta[j].I].Punto.X;
			LY1 := Puntos[Ruta[j].I].Punto.Y;
			LX2 := Puntos[Ruta[j-1].I].Punto.X;
			LY2 := Puntos[Ruta[j-1].I].Punto.Y;

			if (Ruta[j].D=dHorizontal)and(Ruta[j-1].D=dHorizontal) then
			begin
				if LY1=LY2 then
					NuevoSegmento(dHorizontal,LX1,LY1,LX2,0)
				else
				begin
					NuevoSegmento(dHorizontal,LX1,LY1,(LX1+LX2) div 2,0);
					NuevoSegmento(dVertical,(LX1+LX2) div 2,LY1,0,LY2);
					NuevoSegmento(dHorizontal,(LX1+LX2) div 2,LY2,LX2,0);
				end;
			end
			else if (Ruta[j].D=dVertical)and(Ruta[j-1].D=dVertical) then
			begin
				if LX1=LX2 then
					NuevoSegmento(dVertical,LX1,LY1,0,LY2)
				else
				begin
					NuevoSegmento(dVertical,LX1,LY1,0,(LY1+LY2) div 2);
					NuevoSegmento(dHorizontal,LX1,(LY1+LY2) div 2,LX2,0);
					NuevoSegmento(dVertical,LX2,(LY1+LY2) div 2,0,LY2);
				end;
			end else if (Ruta[j].D=dHorizontal)and(Ruta[j-1].D=dVertical) then
			begin
				if LX1<>LX2 then
					NuevoSegmento(dHorizontal,LX1,LY1,LX2,0);
				if LY1<>LY2 then
					NuevoSegmento(dVertical,LX2,LY1,0,LY2);
			end else if (Ruta[j].D=dVertical)and(Ruta[j-1].D=dHorizontal) then
			begin
				if LY1<>LY2 then
					NuevoSegmento(dVertical,LX1,LY1,0,LY2);
				if LX1<>LX2 then
					NuevoSegmento(dHorizontal,LX1,LY2,LX2,0);
			end;
		end;
	end; // CrearSegmentos;

var
	j : integer;
begin
	if Not Assigned(UnionDesde) or not Assigned(UnionHasta) then
		Exit;

	for j := 0 to Segmentos.Count-1 do
		TSegmento(Segmentos.Items[j]).Free;
	Segmentos.Clear;

	R1 := UnionDesde.Rect;
	R2 := UnionHasta.Rect;
	CrearPuntos;
	CrearArcos;
	CrearRuta;
	CrearSegmentos;

	Reducir;
end;

constructor TFlecha.Create(AOwner: TComponent; AParent: TWinControl);
begin
	inherited Create(AOwner);
	Parent := AParent;
  SetLength(FPuntos,0);
	FSegmentos := TList.Create;
end;

destructor TFlecha.Destroy;
begin
	FSegmentos.Free;
	if Assigned(FUnionDesde) then
		FUnionDesde.Flecha := Nil;
	if Assigned(FUnionHasta) then
		FUnionHasta.Flecha := Nil;
	if Assigned(FOnDestroy2) then
		FOnDestroy2(Self);
	if Assigned(FOnDestroy) then
		FOnDestroy(Self);
	inherited;
end;

function TFlecha.GetAnterior(ASegmento: TSegmento): TSegmento;
var
	i : integer;
begin
	i := FSegmentos.IndexOf(ASegmento);
	if i <= 0 then
		result := Nil
	else
		Result := FSegmentos.Items[i-1];
end;

function TFlecha.GetD1: TDireccion;
begin
	Result := UnionDesde.Direcccion;
end;

function TFlecha.GetD2: TDireccion;
begin
	Result := UnionHasta.Direcccion;
end;

function TFlecha.GetSiguiente(ASegmento: TSegmento): TSegmento;
var
	i : integer;
begin
	i := FSegmentos.IndexOf(ASegmento);
	if i >= FSegmentos.Count-1 then
		result := Nil
	else
		Result := FSegmentos.Items[i+1];
end;

procedure TFlecha.MoverSegmento(ASegmento: TSegmento; DX, DY: Integer;
	ACrearInicial: Boolean = true; ACrearFinal: Boolean = true);
var
	A,S : TSegmento;

	procedure PrepararInicio;
	var Aux : TSegmento;
	begin
		Aux := TSegmento.Create(Self,Parent);
		FSegmentos.Insert(0,Aux);
		Aux.Parent := Parent;
		Aux.X1 := X1;
		Aux.Y1 := Y1;
		case ASegmento.Direccion of
			dEste,dOeste,dHorizontal:
				begin
					Aux.Direccion := dVertical;
					Aux.Y2 := Y1;
				end;
			dNorte,dSur,dVertical:
				begin
					Aux.Direccion := dHorizontal;
					Aux.X2 := X1;
				end;
{$IFDEF DEBUG}
			else
				raise Exception.Create('Wrong direction!');
{$ENDIF}
		end;
		A := Aux;
	end; // PrepararInicio

	procedure PrepararFin;
	var Aux : TSegmento;
	begin
		Aux := TSegmento.Create(Self,Parent);
		FSegmentos.Add(Aux);
		Aux.Parent := Parent;
		Aux.X1 := X2;
		Aux.Y1 := Y2;
		case ASegmento.Direccion of
			dNorte,dSur,dVertical:
				begin
					Aux.Direccion := dHorizontal;
					Aux.X2 := X2;
				end;
			dEste,dOeste,dHorizontal:
				begin
					Aux.Direccion := dVertical;
					Aux.Y2 := Y2;
				end;
{$IFDEF DEBUG}
			else
				raise Exception.Create('Wrong direction!');
{$ENDIF}
		end;
		S := Aux;
	end; // PrepararFin

begin
	A := GetAnterior(ASegmento);
	S := GetSiguiente(ASegmento);
	if ACrearInicial and not Assigned(A) then
		PrepararInicio;
	if ACrearFinal and not Assigned(S) then
		PrepararFin;

	case ASegmento.Direccion of
		dHorizontal:
			begin
				ASegmento.Y1 := ASegmento.Y1 + DY;
				if A<>Nil then
					A.Y2 := A.Y2 + DY;
				if S<>Nil then
					S.Y1 := S.Y1 + DY;
			end;
		dVertical:
			begin
				ASegmento.X1 := ASegmento.X1 + DX;
				if A<>Nil then
					A.X2 := A.X2 + DX;
				if S<>Nil then
					S.X1 := S.X1 + DX;
			end;
	end;
  if Assigned(FOnModificar) then
    OnModificar(Self);
end;

procedure TFlecha.Repaint;
var
	j : integer;
begin
	for j := 0 to fSegmentos.Count-1 do
		TSegmento(FSegmentos.Items[j]).Repaint;
end;

procedure TFlecha.SetParent(const Value: TWinControl);
var
	j : integer;
begin
	if FParent<>Value then
	begin
		FParent := Value;
		if Assigned(FSegmentos) then
			for j := 0 to Segmentos.Count-1 do
				TSegmento(Segmentos.Items[j]).Parent := FParent;
	end;
end;

procedure TFlecha.SetUnionDesde(const Value: TUnion);
begin
	if Value<>FUnionDesde then
	begin
    if Assigned(FUnionDesde) then
      FUnionDesde.Flecha := Nil;
		FUnionDesde := Value;
		FUnionDesde.Flecha := Self;
		OnDestroy2 := FUnionDesde.OnDestroyFlecha;
//		Reset;
	end;
end;

procedure TFlecha.SetUnionHasta(const Value: Tunion);
begin
	if Value<>FUnionHasta then
	begin
    if Assigned(FUnionHasta) then
      FUnionHasta.Flecha := Nil;
		FUnionHasta := Value;
		FUnionHasta.Flecha := Self;
		OnDestroy2 := FUnionHasta.OnDestroyFlecha;
//		Reset;
	end;
end;

procedure TFlecha.SetX1(const Value: integer);
var
	DX : integer;
	LSegmento: TSegmento;
begin
  if X1<>Value then
  begin
    if Segmentos.Count=0 then
      Reset
    else
    begin
      LSegmento := Segmentos.Items[0];
      case LSegmento.Direccion of
        dHorizontal:
            LSegmento.X1 := Value;
        dVertical:
          begin
            DX := Value - LSegmento.X1;
            MoverSegmento(LSegmento,DX,0,False,True);
          end;
        else
          raise Exception.Create('Direction error!');
      end;
      Reducir;
    end;
    FX1 := Value;
  end;
end;

procedure TFlecha.SetX2(const Value: integer);
var
	DX : integer;
	LSegmento: TSegmento;
begin
	if X2<>Value then
	begin
		if Segmentos.Count=0 then
			Reset
		else
		begin
			LSegmento := TSegmento(Segmentos.Items[Segmentos.Count-1]);
			case LSegmento.Direccion of
				dHorizontal:
						LSegmento.X2 := Value;
				dVertical:
					begin
						DX := Value - LSegmento.X2;
						MoverSegmento(LSegmento,DX,0,True,False);
					end;
				else
					raise Exception.Create('Direction error!');
			end;
			Reducir;
		end;
		FX2 := Value;
	end;
end;

procedure TFlecha.SetY1(const Value: integer);
var
	DY : integer;
	LSegmento: TSegmento;
begin
  if Y1<>Value then
  begin
    if Segmentos.Count=0 then
    begin
      Reset;
    end
    else
    begin
      LSegmento := TSegmento(Segmentos.Items[0]);
      case LSegmento.Direccion of
        dVertical:
						LSegmento.Y1 := Value;
        dHorizontal:
          begin
            DY := Value - LSegmento.Y1;
            MoverSegmento(LSegmento,0,DY,False,True);
					end;
				else
					raise Exception.Create('Direction error!');
			end;
			Reducir;
		end;
		FY1 := Value;
	end;
end;

procedure TFlecha.SetY2(const Value: integer);
var
	DY : integer;
	LSegmento: TSegmento;
begin
	if Y2<>Value then
	begin
		if Segmentos.Count=0 then
			Reset
		else
    begin
      LSegmento := TSegmento(Segmentos.Items[Segmentos.Count-1]);
      case LSegmento.Direccion of
        dVertical:
            LSegmento.Y2 := Value;
        dHorizontal:
          begin
            DY := Value - LSegmento.Y2;
            MoverSegmento(LSegmento,0,DY,True,False);
          end;
        else
          raise Exception.Create('Direction error!');
      end;
      Reducir;
    end;
    FY2 := Value;
  end;
end;

procedure TFlecha.Reducir;
var
	j : integer;
begin
//  if (X1<>X2)and(Y1<>Y2)and(Segmentos.Count=0) then
//    Reset;
	j := 0;
	while j<=Segmentos.Count-1 do
	begin
		if (TSegmento(Segmentos.Items[j]).Direccion = dHorizontal)
			and(TSegmento(Segmentos.Items[j]).X1 = TSegmento(Segmentos.Items[j]).X2)
			and (j>0) then
		begin
			TSegmento(Segmentos.Items[j]).Free;
			Segmentos.Delete(j);
			j := -1;
		end
		else if (TSegmento(Segmentos.Items[j]).Direccion = dVertical)
			and(TSegmento(Segmentos.Items[j]).Y1 = TSegmento(Segmentos.Items[j]).Y2)
			and (j>0) then
		begin
			TSegmento(Segmentos.Items[j]).Free;
			Segmentos.Delete(j);
			j := -1;
		end
		else if j<Segmentos.Count-1 then
		begin
			if TSegmento(Segmentos.Items[j]).Direccion =
				TSegmento(Segmentos.Items[j+1]).Direccion then
			begin
				if TSegmento(Segmentos.Items[j]).Direccion = dHorizontal then
					TSegmento(Segmentos.Items[j]).X2 :=
						TSegmento(Segmentos.Items[j+1]).X2
				else
					TSegmento(Segmentos.Items[j]).Y2 :=
						TSegmento(Segmentos.Items[j+1]).Y2;
				TSegmento(Segmentos.Items[j+1]).Free;
				Segmentos.Delete(j+1);
				j := -1;
			end;
		end;                                 
		j := j + 1;
	end;
end;

procedure TFlecha.Mostrar;
var
  j : integer;
begin
   for j := 0 to Segmentos.Count-1 do
    TSegmento(Segmentos.Items[j]).Show;
end;

procedure TFlecha.Ocultar;
var
  j : integer;
begin
   for j := 0 to Segmentos.Count-1 do
    TSegmento(Segmentos.Items[j]).Hide;
end;

procedure TFlecha.DesplazarTodo(DX, DY: Integer);
var
	j : integer;
	Lsegmento : TSegmento;
begin
	for j := 1 to Segmentos.Count-2 do
	begin
		LSegmento := Segmentos.Items[j];
		MoverSegmento(Lsegmento,DX,DY,False,False);
	end;
end;

{ TSegmento }

procedure TSegmento.Actualizar(Sender: TObject);
begin
	Invalidate;
end;

procedure TSegmento.ActualizarLimites;
var
	L,T,H,W : integer;
  LScrollBox : TScrollBox;
begin
	L := 0;
	T := 0;
	H := 0;
	W := 0;
	case Direccion of
		dHorizontal :
			begin
				L := FX1;
				T := FY1 - Ancho div 2;
				W := FX2 - FX1;
				H := Ancho;
			end;
		dVertical :
			begin
				L := FX1 - Ancho div 2;
				T := FY1;
				W := Ancho;
				H := FY2 - FY1;
			end;
	end;

	if W < 0 then
	begin
		W := -W;
		L := L - W;
	end;

	if H < 0 then
	begin
		H := -H;
		T := T - H;
	end;

  if Self.Parent is TScrollBox then
  begin
    LScrollBox := Self.Parent as TScrollBox;
    Left := L - LScrollBox.HorzScrollBar.Position;
    Top := T - LScrollBox.VertScrollBar.Position;
    Self.Width := W + 1;
    Self.Height := H + 1;
  end
  else
  begin
    Left := L;
    Top := T;
    Self.Width := W + 1;
    Self.Height := H + 1;
  end;
end;

constructor TSegmento.Create(AOwner: TComponent; AParent: TWinControl);
begin
	inherited Create(AOwner);

	Assert(Assigned(GOnSegmentoMouseDown));
	Self.OnMouseDown := GOnSegmentoMouseDown;
	Assert(Assigned(GOnSegmentoMouseUp));
	Self.OnMouseUp := GOnSegmentoMouseUp;
	Assert(Assigned(GOnSegmentoMouseMove));
	Self.OnMouseMove := GOnSegmentoMouseMove;

	ControlStyle := ControlStyle + [csReplicatable] - [csOpaque];
	Parent := AParent;
	Ancho := 5;
	FPen := TPen.Create;
	FPen.OnChange := Actualizar;
	ActualizarLimites;
end;

destructor TSegmento.Destroy;
begin
	FPen.Free;
	inherited;
end;

function TSegmento.GetFlecha: TFlecha;
begin
	Result := Owner as TFlecha;
end;

procedure TSegmento.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  inherited;
	if Button = mbLeft then
	begin
		FPos := Point(X,Y);
		FArrastrando := True;
	end;
end;

procedure TSegmento.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;
	if Arrastrando then
		Flecha.MoverSegmento(Self,X - FPos.X,Y - FPos.Y,True);
end;

procedure TSegmento.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  inherited;
	if Button = mbLeft then
	begin
		FArrastrando := False;
		Flecha.Reducir;
	end;
end;

procedure TSegmento.Paint;
begin
//	ActualizarLimites;

	with Canvas do
	begin
		Pen := FPen;
		Brush.Style := bsClear;
{$IFDEF FULLDEBUG}
		Pen.Color := clRed;
		Brush.Color := clWhite;
		Rectangle(0,0,Self.Width,Self.Height);
{$ENDIF}
	end;

	case Direccion of
		dHorizontal:
			begin
				with Canvas do
				begin
					MoveTo(0, Ancho div 2);
					LineTo(Self.Width, Ancho div 2);
				end;
			end;
		dVertical:
			begin
				with Canvas do
				begin
					MoveTo(Ancho div 2, 0);
					LineTo(Ancho div 2, Self.Height);
				end;
			end;
	end;
end;

procedure TSegmento.SetDireccion(const Value: TDireccion);
begin
	if FDireccion<>Value then
	begin
		FDireccion := Value;
		case Direccion of
			dHorizontal :
      begin
        Cursor := crSizeNS;
        FY2 := FY1;
      end;
			dVertical :
      begin
        Cursor := crSizeWE;
        FX2 := FX1;
      end;
		end;
		Invalidate;
	end;
end;

procedure TSegmento.SetPen(const Value: TPen);
begin
	FPen := Value;
end;

procedure TSegmento.SetX1(const Value: integer);
begin
	if FX1<>Value then
	begin
		FX1 := Value;
		if Direccion = dVertical then
			FX2 := Value;
		ActualizarLimites;
	end;
end;

procedure TSegmento.SetX2(const Value: integer);
begin
	if (FX2<>Value)and(Direccion = dHorizontal) then
	begin
		FX2 := Value;
		ActualizarLimites;
	end;
end;

procedure TSegmento.SetY1(const Value: integer);
begin
	if FY1<>Value then
	begin
		FY1 := Value;
		if Direccion = dHorizontal then
			FY2 := Value;
		ActualizarLimites;
	end;
end;

procedure TSegmento.SetY2(const Value: integer);
begin
	if (FY2<>Value)and(Direccion = dVertical) then
	begin
		FY2 := Value;
		ActualizarLimites;
	end;
end;

{ TNodo }

constructor TNodo.Create(AOwner: TComponent; AParent: TWinControl);
begin
  inherited;
	Ancho := BORDE div 2 * 2 + 1;
	Alto := BORDE div 2 * 2 + 1;
	Caption := '';
	Texto := '';
end;

procedure TNodo.DarCapacidades;
begin
	inherited;
	PuedeMover := True;
	PuedeTamano := False;
	PuedeUnionNorte := True;
	PuedeUnionEste := True;
	PuedeUnionSur := True;
	PuedeUnionOeste := True;

	EntradaNorte.AceptaEntrada := True;
	EntradaNorte.AceptaSalida := False;
	EntradaEste.AceptaEntrada := True;
	EntradaEste.AceptaSalida := False;
	EntradaOeste.AceptaEntrada := True;
	EntradaOeste.AceptaSalida := False;
	Salida.AceptaEntrada := False;
	Salida.AceptaSalida := True;

	MuestraCaption := False;
	MuestraTexto := False;
end;

function TNodo.Ejecutar: TInstruccion;
begin
	Self.Error := False;
	try
		if assigned(Salida.Flecha) then
			Result := Salida.Flecha.UnionHasta.Instruccion
		else
			raise Exception.Create('Exit arrow missed!');
	except
		Self.Error := True;
		raise;
	end;
end;

function TNodo.EstaMouseEnObjeto(X, Y: Integer): Boolean;
begin
	Result := Sqr(BORDE / 2) > Sqr(X - Self.Width / 2) + Sqr(Y - Self.Height / 2);
end;

procedure TNodo.PaintObjeto;
begin
  inherited;
	with Canvas do
	begin
		Pen.Color := clBlack;
		if Selected then
			Pen.Width := 3
		else
			Pen.Width := 1;

		if Error then
			Brush.Color := COLOR_ERROR
		else if Ejecutando then
			Brush.Color := COLOR_EJECUCION
		else if BreakPoint then
			Brush.Color := COLOR_BREAK_POINT
		else
			Brush.Color := COLOR_OBJETO;

		Brush.Style := bsSolid;
		Ellipse(0,0,self.Width,self.Height);
	end;
end;

{ TDragger }

procedure TDragger.ActualizarLimites;
var
	LX2,LY2: Integer;
	h : Real;
begin
	h := Sqrt(Sqr(X2-X1)+Sqr(Y2-Y1));

	if h = 0 then
		LX2 := X2
	else
		LX2 := Round(X2-(X2-X1)/h);

	if h = 0 then
		LY2 := Y2
	else
		LY2 := Round(Y2-(Y2-Y1)/h);

	Left := Min(X1,LX2);
	Top := Min(Y1,LY2);
	Self.Width := Max(Abs(LX2-X1),1);
	Self.Height := Max(Abs(LY2-Y1),1);
	Invalidate;
end;

constructor TDragger.Create(AOwner: TComponent);
begin
  inherited;
	ControlStyle := ControlStyle - [csCaptureMouse];
	canvas.Pen.Color := clBlue;
end;

procedure TDragger.Paint;
begin
	inherited;

	with Canvas do
	begin
{$ifdef fulldebug}
    Pen.Color := clGray;
    MoveTo(0,0);
    LineTo(Self.Width-1,Self.Height-1);
    MoveTo(Self.Width-1,0);
    LineTo(0,Self.Height-1);
{$endif}
    Pen.Color := clBlue;
		if ((X1<X2)and(Y1<Y2)) or ((X1>X2)and(Y1>Y2))then
		begin
			MoveTo(0,0);
			LineTo(Self.Width-1,Self.Height-1);
		end
		else
		begin
			MoveTo(Self.Width-1,0);
			LineTo(0,Self.Height-1);
		end
	end;
end;

procedure TDragger.SetX1(const Value: integer);
begin
	if FX1<>Value then
	begin
		FX1 := Value;
		ActualizarLimites;
	end;
end;

procedure TDragger.SetX2(const Value: Integer);
begin
	if FX2<>Value then
	begin
		FX2 := Value;
		ActualizarLimites;
	end;
end;

procedure TDragger.SetY1(const Value: Integer);
begin
	if FY1<>Value then
	begin
		FY1 := Value;
		ActualizarLimites;
	end;
end;

procedure TDragger.SetY2(const Value: Integer);
begin
	if FY2<>Value then
	begin
		FY2 := Value;
		ActualizarLimites;
	end;
end;

{ TFin }

constructor TFin.Create(AOwner: TComponent; AParent: TWinControl);
begin
  inherited;
	Caption := 'End';
	Texto := '';
	MuestraCaption := True;
	MuestraTexto := False;

	BreakPoint := true;
end;

procedure TFin.DarCapacidades;
begin
  inherited;
	PuedeMover := True;
	PuedeTamano := True;
	PuedeUnionNorte := True;
	PuedeUnionEste := False;
	PuedeUnionSur := False;
	PuedeUnionOeste := False;

	Entrada.AceptaEntrada := True;
	Entrada.AceptaSalida := False;
end;

function TFin.Ejecutar: TInstruccion;
begin
	Result := Nil;
end;

function TFin.EstaMouseEnObjeto(X, Y: Integer): Boolean;
begin
	Result := (X>=0)and(X<=Self.Width)and(Y>=0)and(Y<=Self.Height);
end;

procedure TFin.PaintObjeto;
begin
  inherited;
	with Canvas do
	begin
		Pen.Color := clBlack;
		if Selected then
			Pen.Width := 3
		else
			Pen.Width := 1;

		if Error then
			Brush.Color := COLOR_ERROR
		else if Ejecutando then
			Brush.Color := COLOR_EJECUCION
		else if BreakPoint then
			Brush.Color := clYellow
		else
			Brush.Color := clWhite;

		Brush.Style := bsSolid;
		RoundRect(0,0,Self.Width,Self.Height, BORDE * 2, BORDE * 2);
	end;
end;

{ TInicio }

constructor TInicio.Create(AOwner: TComponent; AParent: TWinControl);
begin
	inherited;
	Caption := 'Program';
	Texto := '';
	MuestraCaption := True;
	MuestraTexto := False;
end;

procedure TInicio.DarCapacidades;
begin
	inherited;
	PuedeMover := True;
	PuedeTamano := True;
	PuedeUnionNorte := False;
	PuedeUnionEste := False;
	PuedeUnionSur := True;
	PuedeUnionOeste := False;

	Salida.AceptaEntrada := False;
	Salida.AceptaSalida := True;
end;

function TInicio.Ejecutar: TInstruccion;
begin
	Self.Error := False;
	try
		if Assigned(Salida.Flecha) then
			Result := Salida.Flecha.UnionHasta.Instruccion
		else
			raise Exception.Create('Exit arrow missed!');
	except
		Self.Error := True;
		raise;
	end;
end;

function TInicio.EstaMouseEnObjeto(X, Y: Integer): Boolean;
begin
	Result := (X>=0)and(X<=self.Width)and(Y>=0)and(Y<=self.Height);
end;

procedure TInicio.PaintObjeto;
var
   w,h : integer;
begin
	inherited;
	with Canvas do
	begin
		Pen.Color := clBlack;
		if Selected then
			Pen.Width := 3
		else
			Pen.Width := 1;

		if Error then
			Brush.Color := COLOR_ERROR
		else if Ejecutando then
			Brush.Color := COLOR_EJECUCION
		else if BreakPoint then
			Brush.Color := clYellow
		else
			Brush.Color := clWhite;

		Brush.Style := bsSolid;

    w := self.Width;
    h := self.Height;

		RoundRect(0,0,w,h, BORDE * 2, BORDE * 2);
	end;
end;

{ TEntrada }

procedure TEntrada.Actualizar;
var
  s : string;
begin
  inherited;
  S := '';
  if (Dispositivo = diPantalla)  then
  begin
    if Retorno then
      S := 'LeerRt('
    else
      S := 'Leer(';
  end
  else
  begin
    if Retorno then
      S := 'LeerArchivoRt('
    else
      S := 'LeerArchivo(';
  end;

  if Dispositivo=diArchivo then
    S := S + Archivo + SEPARADOR + ' ';

  S := S + Parametros + ')';

  Texto := S;
end;

constructor TEntrada.Create(AOwner: TComponent; AParent: TWinControl);
begin
  inherited;

end;

destructor TEntrada.Destroy;
begin

  inherited;
end;

function TEntrada.EstaMouseEnObjeto(X, Y: Integer): Boolean;
begin
	Result := (X>=0)and(X<=Self.Width)and(Y>=0)and(Y<=Self.Height);
end;

procedure TEntrada.PaintObjeto;
var
  LPuntos : array [0..4] of TPoint;
begin
	with Canvas do
	begin
		Pen.Color := clBlack;
		if Selected then
			Pen.Width := 3
		else
			Pen.Width := 1;

		if Error then
			Brush.Color := COLOR_ERROR
		else if Ejecutando then
			Brush.Color := COLOR_EJECUCION
		else if BreakPoint then
			Brush.Color := COLOR_BREAK_POINT
		else
			Brush.Color := COLOR_OBJETO;

		Brush.Style := bsSolid;

    LPuntos[0] := Point(0,0);
    LPuntos[1] := Point(Self.Width - 1, 0);
    LPuntos[2] := Point(Self.Width - 1, Self.Height - 1);
    LPuntos[3] := Point(0,Self.Height - 1);
    LPuntos[4] := Point(PUNTA_ENT_SAL,Self.Height div 2);
    Polygon(LPuntos);
	end;
end;

{ TSalida }

procedure TSalida.Actualizar;
var
  s : string;
begin
  inherited;
  S := '';
  if (Dispositivo = diPantalla)  then
  begin
    if Retorno then
      S := 'MostrarRt('
    else
      S := 'Mostrar(';
  end
  else
  begin
    if Retorno then
      S := 'MostrarArchivoRt('
    else
      S := 'MostrarArchivo(';
  end;

  if Dispositivo=diArchivo then
    S := S + Archivo + SEPARADOR + ' ';

	S := S + Parametros + ')';

  Texto := S;
end;

constructor TSalida.Create(AOwner: TComponent; AParent: TWinControl);
begin
  inherited;
end;

destructor TSalida.Destroy;
begin

  inherited;
end;

function TSalida.EstaMouseEnObjeto(X, Y: Integer): Boolean;
begin
	Result := (X>=0)and(Y>=0)and(Y<=Self.Height)
		and (Y >= Round(Self.Height * (X - Self.Width + PUNTA_ENT_SAL) / 2 / PUNTA_ENT_SAL))
		and (Y <= Round(Self.Height * (Self.Width + PUNTA_ENT_SAL - X) / 2 / PUNTA_ENT_SAL ));
end;

procedure TSalida.PaintObjeto;
var
  LPuntos : Array[0..4] of TPoint;
begin
	with Canvas do
	begin
		Pen.Color := clBlack;
		if Selected then
			Pen.Width := 3
		else
			Pen.Width := 1;

		if Error then
			Brush.Color := COLOR_ERROR
		else if Ejecutando then
			Brush.Color := COLOR_EJECUCION
		else if BreakPoint then
			Brush.Color := COLOR_BREAK_POINT
		else
			Brush.Color := COLOR_OBJETO;

		Brush.Style := bsSolid;

    LPuntos[0] := Point(0,0);
    LPuntos[1] := Point(Self.Width - PUNTA_ENT_SAL,0);
    LPuntos[2] := Point(Self.Width - 1,Self.Height div 2);
    LPuntos[3] := Point(Self.Width - PUNTA_ENT_SAL,Self.Height - 1);
    LPuntos[4] := Point(0,Self.Height - 1);
    Polygon(LPuntos);
	end;
end;

{ TEntradaSalida }

constructor TEntradaSalida.Create(AOwner: TComponent;
  AParent: TWinControl);
begin
	inherited;

	Retorno := True;
end;

procedure TEntradaSalida.SetArchivo(const Value: String);
begin
  if Value<> FArchivo then
  begin
    FArchivo := Value;
    Actualizar;
    if Assigned(FOnModificar) then
      OnModificar(Self);
  end;
end;

procedure TEntradaSalida.SetDispositivo(const Value: TDispositivo);
begin
  if Value<> FDispositivo then
  begin
    FDispositivo := Value;
    Actualizar;
    if Assigned(FOnModificar) then
      OnModificar(Self);
  end;
end;

procedure TEntradaSalida.SetParametros(const Value: String);
begin
  if Value<> FParametros then
  begin
    FParametros := Value;
    Actualizar;
    if Assigned(FOnModificar) then
      OnModificar(Self);
  end;
end;

procedure TEntradaSalida.SetRetorno(const Value: Boolean);
begin
  if Value<> FRetorno then
  begin
    FRetorno := Value;
    Actualizar;
    if Assigned(FOnModificar) then
      OnModificar(Self);
  end;
end;

end.