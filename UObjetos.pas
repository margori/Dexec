unit UObjetos;

{$mode objfpc}

interface

uses
  SysUtils, Classes, Controls, Graphics, Types, Messages, LMessages, UUtiles, Math, Forms;

type
  TDevice = (deScreen,deFile);

	TDirection = (deUnknown,diNorth,diSouth,diEast,diWest,diHorizontal,diVertical);

	TArrow = class;
	TSegment = class;
	TJoin = class;
	TInstruction = class;
	TSentence = class;
	TCondition = class;

	TJoinEvent = procedure(Sender: TObject;AUnion : TJoin) of object;

	TSegment = class(TGraphicControl)
	private
		FPen: TPen;
		FDragging: boolean;
		FPosition : TPoint;
		FDirection: TDirection;
		FWidth: Integer;

		FX1: integer;
		FX2: integer;
		FY1: integer;
		FY2: integer;

		procedure SetPen(const Value: TPen);
		procedure SetDirection(const Value: TDirection);
		function GetArrow: TArrow;
		procedure SetX1(const Value: integer);
		procedure SetY1(const Value: integer);
		procedure SetX2(const Value: integer);
		procedure SetY2(const Value: integer);
		procedure UpdateLimits;
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

		procedure Update(Sender: TObject);
	published
		property Arrow : TArrow read GetArrow;
		property Direction: TDirection read FDirection write SetDirection;
		property Pen: TPen read FPen write SetPen;
		property Dragging: boolean read FDragging;
		property X1: integer read FX1 write SetX1;
		property X2: integer read FX2 write SetX2;
		property Y1: integer read FY1 write SetY1;
		property Y2: integer read FY2 write SetY2;
		property Width : Integer read FWidth write FWidth default 5;

		property OnMouseDown;
		property OnMouseUp;
		property OnMouseMove;
	end;

	TArrow = class(TComponent)
	private
    FPoints: array of TPoint;
		FSegments: TList;
		FMinimalLenght: Integer;
		FFromJoin: TJoin;
		FToJoin: TJoin;
		FParent: TWinControl;
		FOnDestroy: TNotifyEvent;
		FOnDestroy2: TNotifyEvent;
    FOnModify: TNotifyEvent;
    FX1: integer;
    FY1: integer;
    FX2: integer;
    FY2: integer;

		procedure SetFromJoin(const Value: TJoin);
		procedure SetToJoin(const Value: TJoin);
		procedure SetX1(const Value: integer);
		procedure SetX2(const Value: integer);
		procedure SetY1(const Value: integer);
		procedure SetY2(const Value: integer);
		function GetD1: TDirection;
		function GetD2: TDirection;

		procedure SetParent(const Value: TWinControl);
	protected
	public
		constructor Create(AOwner: TComponent; AParent: TWinControl);
		destructor Destroy; override;

		function GetPrevious(ASegment: TSegment): TSegment;
		function GetNext(ASegment: TSegment): TSegment;

		procedure MoveSegment(ASegment : TSegment; DX,DY: Integer;
			ACreateBegin: Boolean = true; ACreateEnding: Boolean = true);

		procedure Reset;
		procedure Reduce;
		procedure Repaint;

    procedure Show;
		procedure Hide;

		procedure MoveAll(DX,DY: Integer);
	published
		property Parent: TWinControl read FParent write SetParent;
		property MinimalLength: Integer read FMinimalLenght write FMinimalLenght default 20;
		property Segments: TList read FSegments;
		property X1 : integer read FX1 write SetX1;
		property Y1 : integer read FY1 write SetY1;
		property D1 : TDirection read GetD1;
		property X2 : integer read FX2 write SetX2;
		property Y2 : integer read FY2 write SetY2;
		property D2 : TDirection read GetD2;

		property FromJoin: TJoin read FFromJoin write SetFromJoin;
		property ToJoin: TJoin read FToJoin write SetToJoin;

		property OnDestroy : TNotifyEvent read FOnDestroy write FOnDestroy;
		property OnDestroy2 : TNotifyEvent read FOnDestroy2 write FOnDestroy2;

    property OnModify : TNotifyEvent read FOnModify write FOnModify;
	end;

	TJoin = class(TGraphicControl)
	private
		FDirection: TDirection;
		FArrow: TArrow;
		FInstruction: TInstruction;
		FAcceptEntry: Boolean;
		FAcceptExit: Boolean;
		FMouseInControl: Boolean;
		FMouseInJoin: Boolean;
    FSelected: Boolean;
    FOnSelect: TNotifyEvent;
    FX1: Integer;
    FY1: Integer;
    FX2: Integer;
    FY2: Integer;

		procedure SetArrow(const Value: TArrow);
		function GetRect: TRect;
		procedure SetX1(const Value: Integer);
		procedure SetY1(const Value: Integer);
		procedure SetDirection(Value: TDirection);

		procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
		procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
		procedure SetMouseInControl(const Value: Boolean);
		procedure SetMouseInJoin(const Value: Boolean);
    procedure SetSelected(const Value: Boolean);
	protected
		procedure NewPosition;
		procedure Paint; override;

		procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;

		function EstaMouseInJoin(X,Y: Integer): Boolean;
	public
		constructor Create(AOwner: TComponent; AParent: TWinControl; AInstruction: TInstruction);
		destructor Destroy; override;

		procedure OnDestroyArrow(Sender: TObject);

  	property Rect: TRect read GetRect;
  published
    property Selected : Boolean read FSelected write SetSelected;

		property X1: Integer read FX1 write SetX1;
		property Y1: Integer read FY1 write SetY1;
		property X2: Integer read FX2;
		property Y2: Integer read FY2;

		property MouseInControl : Boolean read FMouseInControl write SetMouseInControl;
		property MouseInJoin : Boolean read FMouseInJoin write SetMouseInJoin;

		property Direction: TDirection read FDirection write SetDirection;
		property Arrow: TArrow read FArrow write SetArrow;
		property Instruction: TInstruction read FInstruction write FInstruction;
		property AcceptEntry : Boolean read FAcceptEntry write FAcceptEntry;
		property AcceptExit : Boolean read FAcceptExit write FAcceptExit;

    property MouseCapture;
		property OnMouseDown;
		property OnMouseMove;
    property OnMouseUp;
    property OnSelect : TNotifyEvent read FOnSelect write FOnSelect;
	end;

	TInstruction = class(TGraphicControl)
	private
		FMouseInResizeZone: Boolean;
		FMouseInResize: Boolean;
		FMouseInControl: Boolean;
		FMouseInObject: Boolean;
		FSelected: Boolean;
		FCanMove: Boolean;
		FCanEastJoin: Boolean;
		FCanResize: Boolean;
		FCanWest: Boolean;
		FCanNorthJoin: Boolean;
		FBreakPoint: Boolean;
		FParameters: String;
    FComments: String;
    FShowComments: Boolean;
    FShowParameters: Boolean;
    FLocked: Boolean;
    FRunning: Boolean;
    FX: Integer;
    FY: Integer;
    FWidth: Integer;
    FHeight: integer;
    FError: Boolean;

 		FOnSelect: TNotifyEvent;
		FOnUnionMouseDown: TMouseEvent;
		FOnUnionMouseUp: TMouseEvent;
    FOnUnionMouseMove: TMouseMoveEvent;
    FOnDestroy: TNotifyEvent;
    FOnModify: TNotifyEvent;

		procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
		procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
		procedure SetMouseInControl(const Value: Boolean);
		procedure SetMouseInObject(const Value: Boolean);
		procedure SetMouseInResizeZone(const Value: Boolean);
		procedure SetMouseInResize(const Value: Boolean);

    procedure SetCanResize(const Value: Boolean);

		procedure SetCanEastJoin(const Value: Boolean);
		procedure SetEastJoin(const Value: TJoin);

		procedure SetCanNorthJoin(const Value: Boolean);
		procedure SetNorthJoin(const Value: TJoin);

		procedure SetCanWestJoin(const Value: Boolean);
		procedure SetWestJoin(const Value: TJoin);

		procedure SetCanSouthJoin(const Value: Boolean);
		procedure SetSouthJoin(const Value: TJoin);

		procedure SetSelected(const Value: Boolean);
		procedure SetBreakPoint(const Value: Boolean);
		procedure SetExecuting(const Value: Boolean);
		procedure SetError(const Value: Boolean);
		procedure SetComments(const Value: String);
		procedure SetParameters(const Value: String);
		procedure SetShowComments(const Value: Boolean);
		procedure SetShowParameters(const Value: Boolean);

		procedure SetX(const Value: Integer);
		procedure SetY(const Value: Integer);
		procedure SetHeight(const Value: integer);
		procedure SetWidth(const Value: Integer);

		procedure SetJoinEvents(AJoin : TJoin);
		procedure SetOnUnionMouseDown(const Value: TMouseEvent);
		procedure SetOnUnionMouseMove(const Value: TMouseMoveEvent);
		procedure SetOnUnionMouseUp(const Value: TMouseEvent);
	protected
		FCanSouthJoin: Boolean;
		FEastJoin: TJoin;
		FSouthJoin: TJoin;
		FNorthJoin: TJoin;
		FWestJoin: TJoin;

		procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
			X, Y: Integer); override;
		procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
		procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
			X, Y: Integer); override;

		procedure PaintResize; virtual;
		procedure PaintObject; virtual; abstract;
		procedure PaintText; virtual;
		procedure PrePaint; virtual;
		procedure PostPaint; virtual;
		procedure Paint; override;

		procedure NewPosition; virtual;

		function IsMouseInResize(X,Y: Integer): Boolean; virtual;
		function IsMouseInObject(X,Y: Integer): Boolean; virtual; abstract;

		procedure SetCapacities; virtual; abstract;
	public
		constructor Create(AOwner: TComponent; AParent: TWinControl); virtual;
		destructor Destroy; override;

		procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;

		function Execute : TInstruction; virtual; abstract;
	published
		property X: Integer read FX write SetX;
		property Y: Integer read FY write SetY;
		property Width : Integer read FWidth write SetWidth;
		property Height : integer read FHeight write SetHeight;

		property Comments: String read FComments write SetComments;
		property ShowComments: Boolean read FShowComments write SetShowComments;
		property Parameters: String read FParameters write SetParameters;
		property ShowParameters: Boolean read FShowParameters write SetShowParameters;
		property Locked: Boolean read FLocked write FLocked;

		property Selected: Boolean read FSelected write SetSelected;
		property BreakPoint: Boolean read FBreakPoint write SetBreakPoint;
		property Executing: Boolean read FRunning write SetExecuting;
		property Error: Boolean read FError write SetError;

		property MouseInControl : Boolean read FMouseInControl write SetMouseInControl;
		property MouseInObject : Boolean read FMouseInObject write SetMouseInObject;

		property MouseInResize: Boolean read FMouseInResize write SetMouseInResize;
		property MouseInResizeZone: Boolean read FMouseInResizeZone write SetMouseInResizeZone;

		property CanMove: Boolean read FCanMove write FCanMove;
		property CanResize: Boolean read FCanResize write SetCanResize;
		property CanNorthJoin: Boolean read FCanNorthJoin write SetCanNorthJoin;
		property CanEastJoin: Boolean read FCanEastJoin write SetCanEastJoin;
		property CanSouthJoin: Boolean read FCanSouthJoin write SetCanSouthJoin;
		property CanWestJoin: Boolean read FCanWest write SetCanWestJoin;

		property NorthJoin: TJoin read FNorthJoin write SetNorthJoin;
		property EastJoin: TJoin read FEastJoin write SetEastJoin;
		property SouthJoin: TJoin read FSouthJoin write SetSouthJoin;
		property WestJoin: TJoin read FWestJoin write SetWestJoin;

		property OnSelect : TNotifyEvent read FOnSelect write FOnSelect;
		property OnUnionMouseDown : TMouseEvent read FOnUnionMouseDown write SetOnUnionMouseDown;
		property OnUnionMouseMove : TMouseMoveEvent read FOnUnionMouseMove write SetOnUnionMouseMove;
		property OnUnionMouseUp : TMouseEvent read FOnUnionMouseUp write SetOnUnionMouseUp;

		property OnMouseMove;
    property OnMouseDown;
    property OnMouseUp;
		property OnDestroy: TNotifyEvent read FOnDestroy write FOnDestroy;
    property OnModify : TNotifyEvent read FOnModify write FOnModify;
	end;

	TSentence = class(TInstruction)
	private
	protected
		function IsMouseInObject(AX,AY: Integer): Boolean; override;

		procedure SetCapacities; override;

		procedure PaintObject; override;
	public
		constructor Create(AOwner: TComponent; AParent: TWinControl); override;

		function Execute: TInstruction; override;
	published
		property Entry: TJoin read FNorthJoin;
		property Exit: TJoin read FSouthJoin;
	end;

  TCommunication = class(TSentence)
	private
    FCarriageReturn: Boolean;
    FDevice: TDevice;
    FFilePath: String;
		procedure SetDevice(const Value: TDevice);
		procedure SetCarriageReturn(const Value: Boolean);
		procedure SetFilePath(const Value: String);
		procedure SetParameters(const Value: String);

		procedure Update; virtual; abstract;
	protected
	public
		constructor Create(AOwner: TComponent; AParent: TWinControl); override;
	published
		property Device : TDevice read FDevice write SetDevice;
		property CarriageReturn : Boolean read FCarriageReturn write SetCarriageReturn;
		property FilePath: String read FFilePath write SetFilePath;
	end;

	TInput = class(TCommunication)
	private
	protected
		procedure Update; override;

		function IsMouseInObject(AX,AY: Integer): Boolean; override;

		procedure PaintObject; override;
	public
		constructor Create(AOwner: TComponent; AParent: TWinControl); override;
		destructor Destroy; override;
	published
	end;

	TOutput = class(TCommunication)
	private
	protected
    procedure Update; override;

		function IsMouseInObject(AX,AY: Integer): Boolean; override;

		procedure PaintObject; override;
	public
    constructor Create(AOwner: TComponent; AParent: TWinControl);
    destructor Destroy; override;
	published
	end;

	TCondition = class(TInstruction)
	private
	protected
		procedure PaintObject; override;

		function IsMouseInObject(AX,AY: Integer): Boolean; override;

		procedure SetCapacities; override;
	public
		constructor Create(AOwner: TComponent; AParent: TWinControl); override;
		function Execute: TInstruction; override;
	published
		property Entrada: TJoin read FNorthJoin;
		property Verdadero: TJoin read FSouthJoin;
		property Falso: TJoin read FEastJoin;
	end;

	TNode = class(TInstruction)
	private
	protected
		procedure SetCapacities; override;

		procedure PaintObject; override;
		function IsMouseInObject(AX,AY: Integer): Boolean; override;
	public
		constructor Create(AOwner: TComponent; AParent: TWinControl); override;

		function Execute: TInstruction; Override;
	published
		property Salida: TJoin read FSouthJoin write FSouthJoin;
		property EntradaNorte: TJoin read FNorthJoin write FNorthJoin;
		property EntradaEste: TJoin read FEastJoin write FEastJoin;
		property EntradaOeste: TJoin read FWestJoin write FWestJoin;
	end;

	TBegin = class(TInstruction)
	private
	protected
		procedure SetCapacities; override;

		procedure PaintObject; override;
		function IsMouseInObject(AX,AY: Integer): Boolean; override;
	public
		constructor Create(AOwner: TComponent; AParent: TWinControl); override;

		function Execute: TInstruction; override;
	published
		property ExitJoin: TJoin read FSouthJoin write FSouthJoin;
	end;

	TEnd = class(TInstruction)
	private
	protected
		procedure SetCapacities; override;

		procedure PaintObject; override;
		function IsMouseInObject(AX,AY: Integer): Boolean; override;
	public
		constructor Create(AOwner: TComponent; AParent: TWinControl); override;
		function Execute: TInstruction; override;
	published
		property Entrada: TJoin read FNorthJoin write FNorthJoin;
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

		procedure UpdateLimites;
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
	GOnSegmentMouseDown: TMouseEvent;
	GOnSegmentMouseUp: TMouseEvent;
	GOnSegmentMouseMove: TMouseMoveEvent;

procedure Register;

implementation

uses UAnalizadores, UConstantes;

procedure Register;
begin
	RegisterComponents('Dexec', [TInstruction,TSentence,TCondition,
		TArrow, TJoin]);
end;

{ TInstruction }

procedure TInstruction.CMMouseLeave(var Message: TMessage);
begin
	MouseInControl := False;
	MouseInObject := False;
	MouseInResize := False;
end;

constructor TInstruction.Create(AOwner: TComponent; AParent: TWinControl);
begin
	inherited Create(AOwner);
	Parent := AParent;
	ControlStyle := ControlStyle + [csReplicatable];
	Self.Width := 141;
	Self.Height := 41;
	Locked := False;

	SetCapacities;
end;

procedure TInstruction.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
	inherited;
	MouseInResize := IsMouseInResize(X,Y);
	MouseInObject := Not MouseInResize and IsMouseInObject(X,Y);
end;

procedure TInstruction.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
	Y: Integer);
begin
	inherited;
//	if Button = mbLeft then
//	begin
//		FArrastrandoTamano := False;
//		FArrastrandoObjeto := False;
//	end;
end;

procedure TInstruction.PrePaint;
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

procedure TInstruction.PostPaint;
begin
end;

procedure TInstruction.SetSelected(const Value: Boolean);
begin
	if FSelected<>Value then
	begin
		FSelected := Value;

		if Value and Assigned(FOnSelect) then
			OnSelect(Self);

		Invalidate;
	end;
end;

procedure TInstruction.CMMouseEnter(var Message: TMessage);
begin
	MouseInControl := True;
end;

procedure TInstruction.SetMouseInControl(const Value: Boolean);
begin
	if FMouseInControl<>Value then
	begin
		FMouseInControl := Value;
		Invalidate;
	end;
end;

function TInstruction.IsMouseInResize(X, Y: Integer): Boolean;
begin
	Result := CanResize and
		TUtiles.PuntoEnRect(X,Y,
      TUtiles.RectCentradoEn(Self.Width-BORDER div 2,Self.Height-BORDER div 2,BORDER));
end;

procedure TInstruction.SetMouseInResizeZone(const Value: Boolean);
begin
	if FMouseInResizeZone<>Value then
	begin
		FMouseInResizeZone := Value;
	end;
end;

procedure TInstruction.SetMouseInResize(const Value: Boolean);
begin
	if FMouseInResize<>Value then
	begin
		FMouseInResize := Value;
	end;
end;

procedure TInstruction.PaintResize;
begin
	if MouseInControl and CanResize and not Locked then
		with Self.Canvas do
		begin
			Pen.Color := clBlack;
			Pen.Width := 1;
			Brush.Color := clBlue;
			Brush.Style := bsSolid;

			Rectangle(TUtiles.RectCentradoEn(Self.Width-BORDER div 2,Self.Height-BORDER div 2,BORDER));
		end;
end;

procedure TInstruction.SetMouseInObject(const Value: Boolean);
begin
	if FMouseInObject<>Value then
	begin
		FMouseInObject := Value;
	end;
end;

procedure TInstruction.Paint;
begin
	inherited;
	PrePaint;
	PaintObject;
	PaintText;
	PaintResize;
	PostPaint;
end;

procedure TInstruction.SetCanResize(const Value: Boolean);
begin
	FCanResize := Value;
end;

procedure TInstruction.SetCanEastJoin(const Value: Boolean);
begin
	if FCanEastJoin<>Value then
	begin
		FCanEastJoin := Value;
		if FCanEastJoin and (EastJoin=Nil) then
		begin
			EastJoin := TJoin.Create(Self,Parent,Self);
			EastJoin.Direction := diEast;
      SetJoinEvents(EastJoin);
			NewPosition;
		end;
		if not FCanEastJoin and (EastJoin<>Nil) then
		begin
			EastJoin.Free;
			EastJoin := Nil;
		end;
	end;
end;

procedure TInstruction.SetCanWestJoin(const Value: Boolean);
begin
	if FCanWest<>Value then
	begin
		FCanWest := Value;
		if FCanWest and (WestJoin=Nil) then
		begin
			WestJoin := TJoin.Create(Self,Parent,Self);
			WestJoin.Direction := diWest;
      SetJoinEvents(WestJoin);
			NewPosition;
		end;
		if not FCanWest and (WestJoin<>Nil) then
		begin
			WestJoin.Free;
			WestJoin := Nil;
		end;
	end;
end;

procedure TInstruction.SetCanSouthJoin(const Value: Boolean);
begin
	if FCanSouthJoin<>Value then
	begin
		FCanSouthJoin := Value;
		if FCanSouthJoin and (SouthJoin=Nil) then
		begin
			SouthJoin := TJoin.Create(Self,Parent,Self);
			SouthJoin.Direction := diSouth;
      SetJoinEvents(SouthJoin);
			NewPosition;
		end;
		if not FCanSouthJoin and (SouthJoin<>Nil) then
		begin
			SouthJoin.Free;
			SouthJoin := Nil;
		end;
	end;
end;

procedure TInstruction.SetCanNorthJoin(const Value: Boolean);
begin
	if FCanNorthJoin<>Value then
	begin
		FCanNorthJoin := Value;
		if FCanNorthJoin and (NorthJoin=Nil) then
		begin
			NorthJoin := TJoin.Create(Self,Parent,Self);
			NorthJoin.Direction := diNorth;
      SetJoinEvents(NorthJoin);
			NewPosition;
		end;
		if not FCanNorthJoin and (NorthJoin<>Nil) then
		begin
			NorthJoin.Free;
			NorthJoin := Nil;
		end;
	end;
end;

procedure TInstruction.SetEastJoin(const Value: TJoin);
begin
	if FEastJoin<>Value then
		FEastJoin := Value;
end;

procedure TInstruction.SetNorthJoin(const Value: TJoin);
begin
	if FNorthJoin<>Value then
		FNorthJoin := Value;
end;

procedure TInstruction.SetWestJoin(const Value: TJoin);
begin
	if FWestJoin<>Value then
		FWestJoin := Value;
end;

procedure TInstruction.SetSouthJoin(const Value: TJoin);
begin
	if FSouthJoin<>Value then
		FSouthJoin := Value;
end;

procedure TInstruction.NewPosition;
begin
	if CanNorthJoin then
	begin
		NorthJoin.X1 := X;
		NorthJoin.Y1 := Y - Self.Height div 2 - 1;
	end;
	if CanEastJoin then
	begin
		EastJoin.X1 := X + Self.Width div 2 + 1;
		EastJoin.Y1 := Y;
	end;
	if CanSouthJoin then
	begin
		SouthJoin.X1 := X;
		SouthJoin.Y1 := Y + Self.Height div 2 + 1;
	end;
	if CanWestJoin then
	begin
		WestJoin.X1 := X - Self.Width div 2 - 1;
		WestJoin.Y1 := Y;
	end;
end;

procedure TInstruction.SetBreakPoint(const Value: Boolean);
begin
	if Value <> FBreakPoint then
	begin
		FBreakPoint := Value;
		Invalidate;
	end;
end;

procedure TInstruction.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited;
	if Assigned(FOnModify) then
    OnModify(Self);
end;

procedure TInstruction.SetComments(const Value: String);
begin
	if FComments <> Value then
	begin
		FComments := Value;
    if Assigned(FOnModify) then
      OnModify(Self);
		Invalidate;
	end;
end;

procedure TInstruction.SetParameters(const Value: String);
begin
	if FParameters <> Value then
	begin
		FParameters := Value;
    if Assigned(FOnModify) then
      OnModify(Self);
		Invalidate;
	end;
end;

procedure TInstruction.SetShowComments(const Value: Boolean);
begin
	if FShowComments <> Value then
	begin
		FShowComments := Value;
    if Assigned(FOnModify) then
      OnModify(Self);
		Invalidate;
	end;
end;

procedure TInstruction.SetShowParameters(const Value: Boolean);
begin
	if FShowParameters <> Value then
	begin
		FShowParameters := Value;
    if Assigned(FOnModify) then
      OnModify(Self);
		Invalidate;
	end;
end;

procedure TInstruction.PaintText;
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
		if ShowComments and ShowParameters then
		begin
			b1 := TextWidth(Comments);
			TextOut((Self.Width - b1) div 2,Self.Height div 2 - h,Comments);
			b2 := TextWidth(Parameters);
			TextOut((Self.Width - b2) div 2,Self.Height div 2,Parameters);
		end
		else if ShowComments then
		begin
			b1 := TextWidth(Comments);
			TextOut((Self.Width - b1) div 2,(Self.Height - h) div 2,Comments);
		end
		else if ShowParameters then
		begin
			b2 := TextWidth(Parameters);
			TextOut((Self.Width - b2) div 2,(Self.Height - h) div 2,Parameters);
		end;
	end;
end;

procedure TInstruction.SetExecuting(const Value: Boolean);
begin
	if Value <> FRunning then
	begin
		FRunning := Value;
		Invalidate;
	end;
end;

destructor TInstruction.Destroy;
begin
  if Assigned(FOnDestroy) then
    FOnDestroy(Self);
  inherited;
end;

procedure TInstruction.MouseDown(Button: TMouseButton; Shift: TShiftState;
			X, Y: Integer);
begin
  inherited;
//  FArrastrandoTamano := MouseInResize and CanTamano;
//  FArrastrandoObjeto := not FArrastrandoTamano and MouseInObject
//    and CanMover;
end;

procedure TInstruction.SetX(const Value: Integer);
var
	LValue : Integer;
	LScrollBox : TScrollBox;
begin
	LValue := Value div GRID_X * GRID_X;
	if FX<>LValue then
	begin
		FX := LValue;
		if Self.Parent is TScrollBox then
		begin
			LScrollBox := Self.Parent as TScrollBox;
			Left := LValue - FWidth div 2 - LScrollBox.HorzScrollBar.Position;
		end
		else
			Left := LValue - FWidth div 2;
		NewPosition;
	end;
end;

procedure TInstruction.SetY(const Value: Integer);
var
	LValue : integer;
	LScrollBox : TScrollBox;
begin
	LValue := Value div GRID_Y * GRID_Y;
	if FY<>LValue then
	begin
		FY := LValue;
		if Self.Parent is TScrollBox then
		begin
			LScrollBox := Self.Parent as TScrollBox;
			Top := LValue - FHeight div 2 - LScrollBox.VertScrollBar.Position;
		end
		else
			Top := LValue - FHeight div 2;
		NewPosition;
	end;
end;

procedure TInstruction.SetHeight(const Value: integer);
var
  LValue : Integer;
begin
	if FHeight<>Value then
	begin
		LValue := Value div 2 * 2 + 1;
		Top := Top - (LValue - FHeight) div 2;
		inherited Height := LValue;
		FHeight := LValue;
		NewPosition;
	end;
end;

procedure TInstruction.SetWidth(const Value: Integer);
var
  LValue : Integer;
begin
	if FWidth<>Value then
	begin
		LValue := Value div 2 * 2 + 1;
		Left := Left - (LValue - FWidth) div 2;
	  inherited	Width := LValue;
		FWidth := LValue;
		NewPosition;
	end;
end;

procedure TInstruction.SetJoinEvents(AJoin: TJoin);
begin
  with AJoin do
  begin
    OnMouseMove := OnUnionMouseMove;
    OnMouseDown := OnUnionMouseDown;
    OnMouseUp := OnUnionMouseUp;
  end;
end;

procedure TInstruction.SetOnUnionMouseDown(const Value: TMouseEvent);
begin
  if CanNorthJoin then
    NorthJoin.OnMouseDown := Value;
  if CanEastJoin then
    EastJoin.OnMouseDown := Value;
  if CanSouthJoin then
    SouthJoin.OnMouseDown := Value;
  if CanWestJoin then
    WestJoin.OnMouseDown := Value;
  FOnUnionMouseDown := Value;
end;

procedure TInstruction.SetOnUnionMouseMove(const Value: TMouseMoveEvent);
begin
  if CanNorthJoin then
    NorthJoin.OnMouseMove := Value;
  if CanEastJoin then
    EastJoin.OnMouseMove := Value;
  if CanSouthJoin then
    SouthJoin.OnMouseMove := Value;
  if CanWestJoin then
    WestJoin.OnMouseMove := Value;
  FOnUnionMouseMove := Value;
end;

procedure TInstruction.SetOnUnionMouseUp(const Value: TMouseEvent);
begin
  if CanNorthJoin then
    NorthJoin.OnMouseUp := Value;
  if CanEastJoin then
    EastJoin.OnMouseUp := Value;
  if CanSouthJoin then
    SouthJoin.OnMouseUp := Value;
  if CanWestJoin then
    WestJoin.OnMouseUp := Value;
  FOnUnionMouseUp := Value;
end;

procedure TInstruction.SetError(const Value: Boolean);
begin
	if Value <> FError then
	begin
		FError := Value;
		Invalidate;
	end;
end;

{ TSentencia }

constructor TSentence.Create(AOwner: TComponent; AParent: TWinControl);
begin
	inherited;
	ShowComments := False;
	ShowParameters := True;
end;

function TSentence.IsMouseInObject(AX, AY: Integer): Boolean;
begin
	Result := (AX>=0)and(AX<=Self.Width)and(AY>=0)and(AY<=Self.Height);
end;

procedure TSentence.SetCapacities;
begin
	CanMove := True;
	CanResize := True;
	CanNorthJoin := True;
	CanEastJoin := False;
	CanSouthJoin := True;
	CanWestJoin := False;

	Entry.AcceptEntry := True;
	Entry.AcceptExit := False;
	Exit.AcceptEntry := False;
	Exit.AcceptExit := True;
end;

procedure TSentence.PaintObject;
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
		else if Executing then
			Brush.Color := COLOR_EXECUTING
		else if BreakPoint then
			Brush.Color := COLOR_BREAK_POINT
		else
			Brush.Color := COLOR_OBJECT;

		Brush.Style := bsSolid;
		Rectangle(0,0,self.Width,self.Height);
	end;
end;

function TSentence.Execute: TInstruction;
begin
	Self.Error := False;
	try
		TAnalyzers.Sentence(Self.Parameters);
		if not assigned(Exit.Arrow) then
			raise Exception.Create('Exit arrow expected!')
		else
			Result := Exit.Arrow.ToJoin.Instruction;
	except
		Self.Error := True;
		raise;
	end;
end;

{ TCondicion }

procedure TCondition.PaintObject;
const
	N1 = 15;
	N2 = 15;
var
	LPoints : array[0..3] of TPoint;
begin
	with Self.Canvas do
	begin
		Pen.Color := clBlack;
		if Self.Selected then
			Pen.Width := 3
		else
			Pen.Width := 1;

		if Error then
			Brush.Color := COLOR_ERROR
		else if Executing then
			Brush.Color := COLOR_EXECUTING
		else if BreakPoint then
			Brush.Color := COLOR_BREAK_POINT
		else
			Brush.Color := COLOR_OBJECT;

		Brush.Style := bsSolid;

    // Rombo principal
		LPoints[0] := Point(0,Self.Height div 2);
		LPoints[1] := Point(Self.Width div 2,0);
		LPoints[2] := Point(Self.Width-1,Self.Height div 2);
		LPoints[3] := Point(Self.Width div 2,Self.Height-1);
		Polygon(LPoints);

    // Draw true triangle in green
    Pen.Width := 1;
		Brush.Color := RGBToColor(0,196,0);
		LPoints[0] := Point(Self.Width div 2,Self.Height-1);
		if Self.Width > Self.Height then
			LPoints[1] := Point(Self.Width div 2 - N1, Self.Height - N1 * Self.Height div Self.Width - 1)
		else
			LPoints[1] := Point(Self.Width * (Self.Height - 2 * N1) div (Self.Height * 2), Self.Height - N1);

		if Self.Width > Self.Height then
			LPoints[2] := Point(Self.Width div 2 + N1, Self.Height - N1 * Self.Height div Self.Width - 1)
		else
			LPoints[2] := Point(Self.Width * (Self.Height + 2 * N1) div (Self.Height * 2), Self.Height - N1);
		LPoints[3] := Point(Self.Width div 2,Self.Height-1);
		Polygon(LPoints);

    // Draw false triangle in red
		Pen.Width := 1;
		Brush.Color := clRed;
		LPoints[0] := Point(Self.Width - 1,Self.Height div 2);
		if Self.Width > Self.Height then
			LPoints[1] := Point(Self.Width - N2, Self.Height * (Self.Width - 2 * N2) div (2 * Self.Width))
		else
			LPoints[1] := Point(Self.Width - Self.Width * N2 div Self.Height, Self.Height div 2 - N2);
		if Self.Width > Self.Height then
			LPoints[2] := Point(Self.Width - N2, Self.Height * (N2 * 2 + Self.Width) div (2 * Self.Width))
		else
			LPoints[2] := Point(Self.Width - Self.Width * N2 div Self.Height, Self.Height div 2 + N2);
		LPoints[3] := Point(Self.Width - 1,Self.Height div 2);
		Polygon(LPoints);
	end;
end;

function TCondition.IsMouseInObject(AX, AY: Integer): Boolean;
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
	if AX<=X2 then
	begin

		M1 := (Y2-Y1)/(X2-X1);
		M2 := (Y3-Y1)/(X3-X1);

		Result := (Y>=M1*(X-X1)+Y1)and(Y<=M2*(X-X1)+Y1);
	end;
	if Not Result and (AX>=X2) then
	begin
		X1 := Self.Width;
		Y1 := Self.Height / 2;

		M1 := (Y2-Y1)/(X2-X1);
		M2 := (Y3-Y1)/(X3-X1);
		Result := (AY>=M1*(AX-X1)+Y1)and(AY<=M2*(AX-X1)+Y1);
	end;
end;

constructor TCondition.Create(AOwner: TComponent; AParent: TWinControl);
begin
  inherited;
//  Comments := '';
//	Parameters := 'A = B';
	ShowComments := False;
	ShowParameters := True;
end;

procedure TCondition.SetCapacities;
begin
	CanMove := True;
	CanResize := True;
	CanNorthJoin := True;
	CanEastJoin := True;
	CanSouthJoin := True;
	CanWestJoin := False;

	Entrada.AcceptEntry := True;
	Entrada.AcceptExit := False;
	Verdadero.AcceptEntry := False;
	Verdadero.AcceptExit := True;
	Falso.AcceptEntry := False;
	Falso.AcceptExit := True;
end;

function TCondition.Execute: TInstruction;
begin
	Self.Error := False;
	try
		if TAnalyzers.Condition(Parameters) then
		begin
			if Not assigned(Verdadero.Arrow) then
				raise Exception.Create('Exit arrow expected!')
			else
				Result := Verdadero.Arrow.ToJoin.Instruction
		end
		else
		begin
			if assigned(Falso.Arrow) then
				Result := Falso.Arrow.ToJoin.Instruction
			else
				raise Exception.Create('Exit arrow expected!');
		end;
	except
		Self.Error := True;
		raise;
	end;
end;

{ TJoin }

constructor TJoin.Create(AOwner: TComponent; AParent: TWinControl; AInstruction: TInstruction);
begin
	inherited Create(AOwner);
	Parent := AParent;
	Instruction := AInstruction;
end;

destructor TJoin.Destroy;
begin
	if Assigned(Arrow) then
		Arrow.Free;
	inherited;
end;

function TJoin.GetRect: TRect;
begin
	if Instruction<>Nil then
	begin
		Result.Left := Instruction.Left - BORDER;
		Result.Top := Instruction.Top - BORDER;
		Result.Right := Instruction.Left + Instruction.Width + BORDER - 1;
		Result.Bottom := Instruction.Top + Instruction.Height + BORDER - 1;
	end;
end;

procedure TJoin.OnDestroyArrow(Sender: TObject);
begin
	Arrow := Nil;
end;

procedure TJoin.SetArrow(const Value: TArrow);
begin
  if FArrow<>Value then
  begin
    FArrow := Value;
    NewPosition;
    if Assigned(Instruction) then
      Instruction.Invalidate;
  end;
end;

procedure TJoin.NewPosition;
begin
	if Arrow<>Nil then
	begin
		if Arrow.FromJoin=Self then
		begin
			Arrow.X1 := Self.X2;
			Arrow.Y1 := Self.Y2;
		end
		else
		begin
			Arrow.X2 := Self.X2;
			Arrow.Y2 := Self.Y2;
		end;
	end;
end;

procedure TJoin.SetX1(const Value: Integer);
var
	LScrollBox : TScrollBox;
begin
	if X1<>Value then
	begin
		FX1 := Value;
		if Self.Parent is TScrollBox then
		begin
			LScrollBox := Self.Parent as TScrollBox;
			case Direction of
				diNorth: Left := FX1 - BORDER div 2 - LScrollBox.HorzScrollBar.Position;
				diEast: Left := FX1 - LScrollBox.HorzScrollBar.Position;
				diSouth: Left := FX1 - BORDER div 2 - LScrollBox.HorzScrollBar.Position;
				diWest: Left := FX1 - BORDER * 3 div 2 + 1 - LScrollBox.HorzScrollBar.Position;
			end;
		end
		else
			case Direction of
				diNorth: Left := FX1 - BORDER div 2;
				diEast: Left := FX1;
				diSouth: Left := FX1 - BORDER div 2;
				diWest: Left := FX1 - BORDER * 3 div 2 + 1;
			end;
		case Direction of
			diNorth: FX2 := FX1;
			diEast: FX2 := FX1 + BORDER div 2 * 2;
			diSouth: FX2 := FX1;
			diWest: FX2 := Value - BORDER div 2 * 2;
		end;
		NewPosition;
  end;
end;

procedure TJoin.SetY1(const Value: Integer);
var
  LScrollBox :  TScrollBox;
begin
	if Y1<>Value then
	begin
		FY1 := Value;
		if Self.Parent is TScrollBox then
		begin
			LScrollBox := Self.Parent as TScrollBox;
			case Direction of
				diNorth: Top := FY1 - BORDER * 3 div 2 + 1 - LScrollBox.VertScrollBar.Position;
				diEast: Top := FY1 - BORDER div 2 - LScrollBox.VertScrollBar.Position;
				diSouth: Top := FY1 - LScrollBox.VertScrollBar.Position;
				diWest: Top := FY1 - BORDER div 2 - LScrollBox.VertScrollBar.Position;
			end;
		end
		else
			case Direction of
				diNorth: Top := FY1 - BORDER * 3 div 2 + 1;
				diEast: Top := FY1 - BORDER div 2;
				diSouth: Top := FY1;
				diWest: Top := FY1 - BORDER div 2;
			end;
		case Direction of
			diNorth: FY2 := FY1 - BORDER div 2 * 2;
			diEast: FY2 := FY1;
      diSouth: FY2 := FY1 + BORDER div 2 * 2;
      diWest: FY2 := FY1;
    end;
    NewPosition;
  end;
end;

procedure TJoin.SetDirection(Value: TDirection);
var
	LX1,LY1: Integer;
begin
	if Value<>FDirection then
	begin
		LX1 := X1;
		LY1 := Y1;
		case Value of
			diNorth, diSouth:
				begin
					Self.Width := BORDER;
					Self.Height := BORDER * 3 div 2;
				end;
			diEast, diWest:
				begin
					Self.Width := BORDER * 3 div 2;
					Self.Height := BORDER;
				end;
		end;
		FDirection := Value;
		X1 := LX1;
		Y1 := LY1;
	end;
end;

procedure TJoin.Paint;
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
		case Direction of
			diNorth:
				begin
					MoveTo(Self.Width div 2, Self.Height);
					LineTo(Self.Width div 2, BORDER div 2);
					if MouseInJoin then
					begin
						Brush.Color := clGreen;
						Rectangle(0,0,Self.Width,BORDER);
					end
					else if FSelected then
					begin
						Brush.Color := clBlue;
						Rectangle(0,0,Self.Width,BORDER);
					end
					else if not Assigned(Arrow) then
					begin
						Brush.Color := clRed;
						Ellipse(BORDER div 4,BORDER div 4,BORDER * 3 div 4 + 1,BORDER * 3 div 4 + 1);
					end;
				end;
			diEast:
				begin
					MoveTo(0, Self.Height div 2);
					LineTo(BORDER, Self.Height div 2);
					if MouseInJoin then
          begin
            Brush.Color := clGreen;
						Rectangle(BORDER div 2,0,Self.Width,Self.Height);
          end
          else if FSelected then
          begin
            Brush.Color := clBlue;
						Rectangle(BORDER div 2,0,Self.Width,Self.Height);
					end
					else if not Assigned(Arrow) then
					begin
						Brush.Color := clRed;
						Ellipse(BORDER * 3 div 4,BORDER div 4,BORDER + 2,BORDER * 3 div 4 + 1);
					end;
				end;
			diSouth:
				begin
					MoveTo(Self.Width div 2, 0);
					LineTo(Self.Width div 2, BORDER);
					if MouseInJoin then
					begin
						Brush.Color := clGreen;
						Rectangle(0,BORDER div 2,Self.Width,Self.Height);
					end
					else if FSelected then
					begin
						Brush.Color := clBlue;
						Rectangle(0,BORDER div 2,Self.Width,Self.Height);
					end
					else if not Assigned(Arrow) then
					begin
						Brush.Color := clRed;
						Ellipse(BORDER div 4,BORDER * 3 div 4,BORDER * 3 div 4 +1,BORDER + 2);
					end;
				end;
			diWest:
				begin
					MoveTo(Self.Width, Self.Height div 2);
					LineTo(BORDER div 2, Self.Height div 2);
					if MouseInJoin then
					begin
						Brush.Color := clGreen;
						Rectangle(0,0,BORDER,Self.Height);
					end
					else if FSelected then
					begin
						Brush.Color := clBlue;
						Rectangle(0,0,BORDER,Self.Height);
					end
					else if not Assigned(Arrow) then
					begin
						Brush.Color := clRed;
						Ellipse(BORDER div 4,BORDER div 4,BORDER * 3 div 4 + 1,BORDER-2);
					end;
				end;
		end;
	end;
end;

procedure TJoin.CMMouseEnter(var Message: TMessage);
begin
	MouseInControl := True;
end;

procedure TJoin.CMMouseLeave(var Message: TMessage);
begin
	MouseInControl := False;
	MouseInJoin := False;
end;

procedure TJoin.SetMouseInControl(const Value: Boolean);
begin
  FMouseInControl := Value;
end;

procedure TJoin.SetMouseInJoin(const Value: Boolean);
begin
	if FMouseInJoin <> value then
	begin
		FMouseInJoin := Value;
		Invalidate;
	end;
end;

procedure TJoin.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;
	MouseInJoin := EstaMouseInJoin(X,Y);
end;

function TJoin.EstaMouseInJoin(X, Y: Integer): Boolean;
begin
	Result := False;
	case Direction of
		diNorth: Result := Y < BORDER;
		diEast: Result := X > BORDER div 2 - 1;
		diSouth : Result := Y > BORDER div 2 - 1;
		diWest : Result := X < BORDER;
	end;
end;

procedure TJoin.SetSelected(const Value: Boolean);
begin
	if FSelected<>Value then
	begin
		FSelected := Value;

		if Value and Assigned(FOnSelect) then
			OnSelect(Self);

		Invalidate;
	end;
end;

{ TArrow }

procedure TArrow.Reset;
type
	TPunto = record
		Punto: TPoint;
		Distancia : real;
		Desde : Integer;
		Asignado: boolean;
		Arcos: array of integer;
	end;
var
	Points : array of TPunto;
	R1,R2: TRect;

	procedure CrearPoints;

		procedure Insertar(AX,AY: Integer);
		begin
			SetLength(Points,Length(Points)+1);
			with Points[High(Points)] do
			begin
				Punto.X := AX; Punto.Y := AY;
				Distancia := MaxInt; Asignado := False;
				Desde := -1;
			end;
		end; //Insertar

	begin
		SetLength(Points,0);
		Insertar(FromJoin.X2,FromJoin.Y2);

		Insertar(R1.Left,R1.Top);
		Insertar(R1.Right,R1.Top);
		Insertar(R1.Left,R1.Bottom);
		Insertar(R1.Right,R1.Bottom);

		Insertar(R2.Left,R2.Top);
		Insertar(R2.Right,R2.Top);
		Insertar(R2.Left,R2.Bottom);
		Insertar(R2.Right,R2.Bottom);

		Insertar(ToJoin.X2,ToJoin.Y2);
	end; // CrearPoints

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
		for j := 0 to High(Points) do
			for k := j+1 to High(Points) do
				if j<>k then
					begin
						if not Secantes(Points[j].Punto,Points[k].Punto,R1)
							and not Secantes(Points[j].Punto,Points[k].Punto,R2) then
						begin
							with Points[j] do
							begin
								SetLength(Arcos,Length(Arcos)+1);
								Arcos[High(Arcos)] := k;
							end;
							with Points[k] do
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
		Points[0].Asignado := True;
		Points[0].Distancia := 0;
		Act := 0;
		while not Points[High(Points)].Asignado do begin
			for j := 0 to High(Points[Act].Arcos) do
			begin
				if not Points[Points[Act].Arcos[j]].Asignado then
				begin
					DistMin := Points[Act].Distancia +
						Dist(Points[Act].Punto,Points[Points[Act].Arcos[j]].Punto);
					if (Points[Points[Act].Arcos[j]].Distancia>DistMin) then
					begin
						Points[Points[Act].Arcos[j]].Distancia := DistMin;
						Points[Points[Act].Arcos[j]].Desde := Act;
					end;
				end;
			end;

			DistMin := MaxInt;
			Min := -1;
			for j := 0 to High(Points) do
			begin
				if not Points[j].Asignado and (Points[j].Distancia<DistMin) then
				begin
					DistMin := Points[j].Distancia;
					Min := j;
				end;
			end;

			Points[Min].Asignado := True;
			Act := Min;
		end;
	end; // CrearRuta

	procedure CrearSegments;

		procedure NuevoSegment(ADirection: TDirection;AX1,AY1,AX2,AY2:Integer);
		var Aux: TSegment;
		begin
				Aux := TSegment.Create(Self,Parent);
				Segments.Add(Aux);
				Aux.Parent := Self.Parent;
				Aux.Direction := ADirection;
				Aux.X1 := AX1;
				Aux.Y1 := AY1;
				Aux.X2 := AX2;
				Aux.Y2 := AY2;
				Aux.SendToBack;
		end; // NuevoSegment;

	type
		TRuta = record
			I : Integer;
			D : TDirection;
		end;
	var
		Ruta : Array of TRuta;
		j,LX1,LX2,LY1,LY2 : integer;
	begin
		SetLength(Ruta,1);
		Ruta[0].I := 9;
		case ToJoin.Direction of
			diNorth,diSouth,diVertical: Ruta[0].D := diVertical;
			diEast,diWest,diHorizontal: Ruta[0].D := diHorizontal;
		end;
		while Ruta[High(Ruta)].I<>0 do
		begin
			SetLength(Ruta,Length(Ruta)+1);
			Ruta[High(Ruta)].I := Points[Ruta[High(Ruta)-1].I].Desde;
			Ruta[High(Ruta)].D := deUnknown;
		end;
		case FromJoin.Direction of
			diNorth,diSouth,diVertical: Ruta[High(Ruta)].D := diVertical;
			diEast,diWest,diHorizontal: Ruta[High(Ruta)].D := diHorizontal;
		end;

		for j := High(Ruta)-1 downto 1 do
			if Ruta[j].D=deUnknown then
			begin
				if Points[Ruta[j].I].Punto.X=Points[Ruta[j+1].I].Punto.X then
					Ruta[j].D := diVertical
				else if Points[Ruta[j].I].Punto.Y=Points[Ruta[j+1].I].Punto.Y then
					Ruta[j].D := diHorizontal
				else if Points[Ruta[j].I].Punto.X=Points[Ruta[j-1].I].Punto.X then
					Ruta[j].D := diVertical
				else if Points[Ruta[j].I].Punto.Y=Points[Ruta[j-1].I].Punto.Y then
					Ruta[j].D := diHorizontal;
			end;

		for j := High(Ruta) downto 1 do
		begin
			LX1 := Points[Ruta[j].I].Punto.X;
			LY1 := Points[Ruta[j].I].Punto.Y;
			LX2 := Points[Ruta[j-1].I].Punto.X;
			LY2 := Points[Ruta[j-1].I].Punto.Y;

			if (Ruta[j].D=diHorizontal)and(Ruta[j-1].D=diHorizontal) then
			begin
				if LY1=LY2 then
					NuevoSegment(diHorizontal,LX1,LY1,LX2,0)
				else
				begin
					NuevoSegment(diHorizontal,LX1,LY1,(LX1+LX2) div 2,0);
					NuevoSegment(diVertical,(LX1+LX2) div 2,LY1,0,LY2);
					NuevoSegment(diHorizontal,(LX1+LX2) div 2,LY2,LX2,0);
				end;
			end
			else if (Ruta[j].D=diVertical)and(Ruta[j-1].D=diVertical) then
			begin
				if LX1=LX2 then
					NuevoSegment(diVertical,LX1,LY1,0,LY2)
				else
				begin
					NuevoSegment(diVertical,LX1,LY1,0,(LY1+LY2) div 2);
					NuevoSegment(diHorizontal,LX1,(LY1+LY2) div 2,LX2,0);
					NuevoSegment(diVertical,LX2,(LY1+LY2) div 2,0,LY2);
				end;
			end else if (Ruta[j].D=diHorizontal)and(Ruta[j-1].D=diVertical) then
			begin
				if LX1<>LX2 then
					NuevoSegment(diHorizontal,LX1,LY1,LX2,0);
				if LY1<>LY2 then
					NuevoSegment(diVertical,LX2,LY1,0,LY2);
			end else if (Ruta[j].D=diVertical)and(Ruta[j-1].D=diHorizontal) then
			begin
				if LY1<>LY2 then
					NuevoSegment(diVertical,LX1,LY1,0,LY2);
				if LX1<>LX2 then
					NuevoSegment(diHorizontal,LX1,LY2,LX2,0);
			end;
		end;
	end; // CrearSegments;

var
	j : integer;
begin
	if Not Assigned(FromJoin) or not Assigned(ToJoin) then
		Exit;

	for j := 0 to Segments.Count-1 do
		TSegment(Segments.Items[j]).Free;
	Segments.Clear;

	R1 := FromJoin.Rect;
	R2 := ToJoin.Rect;
	CrearPoints;
	CrearArcos;
	CrearRuta;
	CrearSegments;

	Reduce;
end;

constructor TArrow.Create(AOwner: TComponent; AParent: TWinControl);
begin
	inherited Create(AOwner);
	Parent := AParent;
  SetLength(FPoints,0);
	FSegments := TList.Create;
end;

destructor TArrow.Destroy;
begin
	FSegments.Free;
	if Assigned(FFromJoin) then
		FFromJoin.Arrow := Nil;
	if Assigned(FToJoin) then
		FToJoin.Arrow := Nil;
	if Assigned(FOnDestroy2) then
		FOnDestroy2(Self);
	if Assigned(FOnDestroy) then
		FOnDestroy(Self);
	inherited;
end;

function TArrow.GetPrevious(ASegment: TSegment): TSegment;
var
	i : integer;
begin
	i := FSegments.IndexOf(ASegment);
	if i <= 0 then
		result := Nil
	else
		Result := TSegment(FSegments.Items[i-1]);
end;

function TArrow.GetD1: TDirection;
begin
	Result := FromJoin.Direction;
end;

function TArrow.GetD2: TDirection;
begin
	Result := ToJoin.Direction;
end;

function TArrow.GetNext(ASegment: TSegment): TSegment;
var
	i : integer;
begin
	i := FSegments.IndexOf(ASegment);
	if i >= FSegments.Count-1 then
		result := Nil
	else
		Result := TSegment(FSegments.Items[i+1]);
end;

procedure TArrow.MoveSegment(ASegment: TSegment; DX, DY: Integer;
	ACreateBegin: Boolean = true; ACreateEnding: Boolean = true);
var
	A,S : TSegment;

	procedure PrepararInicio;
	var Aux : TSegment;
	begin
		Aux := TSegment.Create(Self,Parent);
		FSegments.Insert(0,Aux);
		Aux.Parent := Parent;
		Aux.X1 := X1;
		Aux.Y1 := Y1;
		case ASegment.Direction of
			diEast,diWest,diHorizontal:
				begin
					Aux.Direction := diVertical;
					Aux.Y2 := Y1;
				end;
			diNorth,diSouth,diVertical:
				begin
					Aux.Direction := diHorizontal;
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
	var Aux : TSegment;
	begin
		Aux := TSegment.Create(Self,Parent);
		FSegments.Add(Aux);
		Aux.Parent := Parent;
		Aux.X1 := X2;
		Aux.Y1 := Y2;
		case ASegment.Direction of
			diNorth,diSouth,diVertical:
				begin
					Aux.Direction := diHorizontal;
					Aux.X2 := X2;
				end;
			diEast,diWest,diHorizontal:
				begin
					Aux.Direction := diVertical;
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
	A := GetPrevious(ASegment);
	S := GetNext(ASegment);
	if ACreateBegin and not Assigned(A) then
		PrepararInicio;
	if ACreateEnding and not Assigned(S) then
		PrepararFin;

	case ASegment.Direction of
		diHorizontal:
			begin
				ASegment.Y1 := ASegment.Y1 + DY;
				if A<>Nil then
					A.Y2 := A.Y2 + DY;
				if S<>Nil then
					S.Y1 := S.Y1 + DY;
			end;
		diVertical:
			begin
				ASegment.X1 := ASegment.X1 + DX;
				if A<>Nil then
					A.X2 := A.X2 + DX;
				if S<>Nil then
					S.X1 := S.X1 + DX;
			end;
	end;
  if Assigned(FOnModify) then
    OnModify(Self);
end;

procedure TArrow.Repaint;
var
	j : integer;
begin
	for j := 0 to fSegments.Count-1 do
		TSegment(FSegments.Items[j]).Repaint;
end;

procedure TArrow.SetParent(const Value: TWinControl);
var
	j : integer;
begin
	if FParent<>Value then
	begin
		FParent := Value;
		if Assigned(FSegments) then
			for j := 0 to Segments.Count-1 do
				TSegment(Segments.Items[j]).Parent := FParent;
	end;
end;

procedure TArrow.SetFromJoin(const Value: TJoin);
begin
	if Value<>FFromJoin then
	begin
    if Assigned(FFromJoin) then
      FFromJoin.Arrow := Nil;
		FFromJoin := Value;
		FFromJoin.Arrow := Self;
		OnDestroy2 := @FFromJoin.OnDestroyArrow;
	end;
end;

procedure TArrow.SetToJoin(const Value: TJoin);
begin
	if Value<>FToJoin then
	begin
    if Assigned(FToJoin) then
      FToJoin.Arrow := Nil;
		FToJoin := Value;
		FToJoin.Arrow := Self;
		OnDestroy2 := @FToJoin.OnDestroyArrow;
	end;
end;

procedure TArrow.SetX1(const Value: integer);
var
	DX : integer;
	LSegment: TSegment;
begin
  if X1<>Value then
  begin
    if Segments.Count=0 then
      Reset
    else
    begin
      LSegment := TSegment(Segments.Items[0]);
      case LSegment.Direction of
        diHorizontal:
            LSegment.X1 := Value;
        diVertical:
          begin
            DX := Value - LSegment.X1;
            MoveSegment(LSegment,DX,0,False,True);
          end;
        else
          raise Exception.Create('Direction error!');
      end;
      Reduce;
    end;
    FX1 := Value;
  end;
end;

procedure TArrow.SetX2(const Value: integer);
var
	DX : integer;
	LSegment: TSegment;
begin
	if X2<>Value then
	begin
		if Segments.Count=0 then
			Reset
		else
		begin
			LSegment := TSegment(Segments.Items[Segments.Count-1]);
			case LSegment.Direction of
				diHorizontal:
						LSegment.X2 := Value;
				diVertical:
					begin
						DX := Value - LSegment.X2;
						MoveSegment(LSegment,DX,0,True,False);
					end;
				else
					raise Exception.Create('Direction error!');
			end;
			Reduce;
		end;
		FX2 := Value;
	end;
end;

procedure TArrow.SetY1(const Value: integer);
var
	DY : integer;
	LSegment: TSegment;
begin
  if Y1<>Value then
  begin
    if Segments.Count=0 then
    begin
      Reset;
    end
    else
    begin
      LSegment := TSegment(Segments.Items[0]);
      case LSegment.Direction of
        diVertical:
						LSegment.Y1 := Value;
        diHorizontal:
          begin
            DY := Value - LSegment.Y1;
            MoveSegment(LSegment,0,DY,False,True);
					end;
				else
					raise Exception.Create('Direction error!');
			end;
			Reduce;
		end;
		FY1 := Value;
	end;
end;

procedure TArrow.SetY2(const Value: integer);
var
	DY : integer;
	LSegment: TSegment;
begin
	if Y2<>Value then
	begin
		if Segments.Count=0 then
			Reset
		else
    begin
      LSegment := TSegment(Segments.Items[Segments.Count-1]);
      case LSegment.Direction of
        diVertical:
            LSegment.Y2 := Value;
        diHorizontal:
          begin
            DY := Value - LSegment.Y2;
            MoveSegment(LSegment,0,DY,True,False);
          end;
        else
          raise Exception.Create('Direction error!');
      end;
      Reduce;
    end;
    FY2 := Value;
  end;
end;

procedure TArrow.Reduce;
var
	j : integer;
begin
//  if (X1<>X2)and(Y1<>Y2)and(Segments.Count=0) then
//    Reset;
	j := 0;
	while j<=Segments.Count-1 do
	begin
		if (TSegment(Segments.Items[j]).Direction = diHorizontal)
			and(TSegment(Segments.Items[j]).X1 = TSegment(Segments.Items[j]).X2)
			and (j>0) then
		begin
			TSegment(Segments.Items[j]).Free;
			Segments.Delete(j);
			j := -1;
		end
		else if (TSegment(Segments.Items[j]).Direction = diVertical)
			and(TSegment(Segments.Items[j]).Y1 = TSegment(Segments.Items[j]).Y2)
			and (j>0) then
		begin
			TSegment(Segments.Items[j]).Free;
			Segments.Delete(j);
			j := -1;
		end
		else if j<Segments.Count-1 then
		begin
			if TSegment(Segments.Items[j]).Direction =
				TSegment(Segments.Items[j+1]).Direction then
			begin
				if TSegment(Segments.Items[j]).Direction = diHorizontal then
					TSegment(Segments.Items[j]).X2 :=
						TSegment(Segments.Items[j+1]).X2
				else
					TSegment(Segments.Items[j]).Y2 :=
						TSegment(Segments.Items[j+1]).Y2;
				TSegment(Segments.Items[j+1]).Free;
				Segments.Delete(j+1);
				j := -1;
			end;
		end;                                 
		j := j + 1;
	end;
end;

procedure TArrow.Show;
var
  j : integer;
begin
   for j := 0 to Segments.Count-1 do
    TSegment(Segments.Items[j]).Show;
end;

procedure TArrow.Hide;
var
  j : integer;
begin
   for j := 0 to Segments.Count-1 do
    TSegment(Segments.Items[j]).Hide;
end;

procedure TArrow.MoveAll(DX, DY: Integer);
var
	j : integer;
	LSegment : TSegment;
begin
	for j := 1 to Segments.Count-2 do
	begin
		LSegment := TSegment(Segments.Items[j]);
		MoveSegment(LSegment,DX,DY,False,False);
	end;
end;

{ TSegment }

procedure TSegment.Update(Sender: TObject);
begin
	Invalidate;
end;

procedure TSegment.UpdateLimits;
var
	L,T,H,W : integer;
  LScrollBox : TScrollBox;
begin
	L := 0;
	T := 0;
	H := 0;
	W := 0;
	case Direction of
		diHorizontal :
			begin
				L := FX1;
				T := FY1 - Width div 2;
				W := FX2 - FX1;
				H := Width;
			end;
		diVertical :
			begin
				L := FX1 - Width div 2;
				T := FY1;
				W := Width;
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

constructor TSegment.Create(AOwner: TComponent; AParent: TWinControl);
begin
	inherited Create(AOwner);

	Assert(Assigned(GOnSegmentMouseDown));
	Self.OnMouseDown := GOnSegmentMouseDown;
	Assert(Assigned(GOnSegmentMouseUp));
	Self.OnMouseUp := GOnSegmentMouseUp;
	Assert(Assigned(GOnSegmentMouseMove));
	Self.OnMouseMove := GOnSegmentMouseMove;

	ControlStyle := ControlStyle + [csReplicatable] - [csOpaque];
	Parent := AParent;
	Width := 5;
	FPen := TPen.Create;
	FPen.OnChange := @Update;
	UpdateLimits;
end;

destructor TSegment.Destroy;
begin
	FPen.Free;
	inherited;
end;

function TSegment.GetArrow: TArrow;
begin
	Result := Owner as TArrow;
end;

procedure TSegment.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  inherited;
	if Button = mbLeft then
	begin
		FPosition := Point(X,Y);
		FDragging := True;
	end;
end;

procedure TSegment.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;
	if Dragging then
		Arrow.MoveSegment(Self,X - FPosition.X,Y - FPosition.Y,True);
end;

procedure TSegment.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  inherited;
	if Button = mbLeft then
	begin
		FDragging := False;
		Arrow.Reduce;
	end;
end;

procedure TSegment.Paint;
begin
//	UpdateLimites;

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

	case Direction of
		diHorizontal:
			begin
				with Canvas do
				begin
					MoveTo(0, Width div 2);
					LineTo(Self.Width, Width div 2);
				end;
			end;
		diVertical:
			begin
				with Canvas do
				begin
					MoveTo(Width div 2, 0);
					LineTo(Width div 2, Self.Height);
				end;
			end;
	end;
end;

procedure TSegment.SetDirection(const Value: TDirection);
begin
	if FDirection<>Value then
	begin
		FDirection := Value;
		case Direction of
			diHorizontal :
      begin
        Cursor := crSizeNS;
        FY2 := FY1;
      end;
			diVertical :
      begin
        Cursor := crSizeWE;
        FX2 := FX1;
      end;
		end;
		Invalidate;
	end;
end;

procedure TSegment.SetPen(const Value: TPen);
begin
	FPen := Value;
end;

procedure TSegment.SetX1(const Value: integer);
begin
	if FX1<>Value then
	begin
		FX1 := Value;
		if Direction = diVertical then
			FX2 := Value;
		UpdateLimits;
	end;
end;

procedure TSegment.SetX2(const Value: integer);
begin
	if (FX2<>Value)and(Direction = diHorizontal) then
	begin
		FX2 := Value;
		UpdateLimits;
	end;
end;

procedure TSegment.SetY1(const Value: integer);
begin
	if FY1<>Value then
	begin
		FY1 := Value;
		if Direction = diHorizontal then
			FY2 := Value;
		UpdateLimits;
	end;
end;

procedure TSegment.SetY2(const Value: integer);
begin
	if (FY2<>Value)and(Direction = diVertical) then
	begin
		FY2 := Value;
		UpdateLimits;
	end;
end;

{ TNode }

constructor TNode.Create(AOwner: TComponent; AParent: TWinControl);
begin
  inherited;
	Width := BORDER div 2 * 2 + 1;
	Height := BORDER div 2 * 2 + 1;
	Comments := '';
	Parameters := '';
end;

procedure TNode.SetCapacities;
begin
	CanMove := True;
	CanResize := False;
	CanNorthJoin := True;
	CanEastJoin := True;
	CanSouthJoin := True;
	CanWestJoin := True;

	EntradaNorte.AcceptEntry := True;
	EntradaNorte.AcceptExit := False;
	EntradaEste.AcceptEntry := True;
	EntradaEste.AcceptExit := False;
	EntradaOeste.AcceptEntry := True;
	EntradaOeste.AcceptExit := False;
	Salida.AcceptEntry := False;
	Salida.AcceptExit := True;

	ShowComments := False;
	ShowParameters := False;
end;

function TNode.Execute: TInstruction;
begin
	Self.Error := False;
	try
		if assigned(Salida.Arrow) then
			Result := Salida.Arrow.ToJoin.Instruction
		else
			raise Exception.Create('Exit arrow missed!');
	except
		Self.Error := True;
		raise;
	end;
end;

function TNode.IsMouseInObject(AX, AY: Integer): Boolean;
begin
	Result := Sqr(BORDER / 2) > Sqr(AX - Self.Width / 2) + Sqr(AY - Self.Height / 2);
end;

procedure TNode.PaintObject;
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
		else if Executing then
			Brush.Color := COLOR_EXECUTING
		else if BreakPoint then
			Brush.Color := COLOR_BREAK_POINT
		else
			Brush.Color := COLOR_OBJECT;

		Brush.Style := bsSolid;
		Ellipse(0,0,self.Width,self.Height);
	end;
end;

{ TDragger }

procedure TDragger.UpdateLimites;
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
		UpdateLimites;
	end;
end;

procedure TDragger.SetX2(const Value: Integer);
begin
	if FX2<>Value then
	begin
		FX2 := Value;
		UpdateLimites;
	end;
end;

procedure TDragger.SetY1(const Value: Integer);
begin
	if FY1<>Value then
	begin
		FY1 := Value;
		UpdateLimites;
	end;
end;

procedure TDragger.SetY2(const Value: Integer);
begin
	if FY2<>Value then
	begin
		FY2 := Value;
		UpdateLimites;
	end;
end;

{ TEnd }

constructor TEnd.Create(AOwner: TComponent; AParent: TWinControl);
begin
  inherited;
	Comments := 'End';
	Parameters := '';
	ShowComments := True;
	ShowParameters := False;

	BreakPoint := true;
end;

procedure TEnd.SetCapacities;
begin
	CanMove := True;
	CanResize := True;
	CanNorthJoin := True;
	CanEastJoin := False;
	CanSouthJoin := False;
	CanWestJoin := False;

	Entrada.AcceptEntry := True;
	Entrada.AcceptExit := False;
end;

function TEnd.Execute: TInstruction;
begin
	Result := Nil;
end;

function TEnd.IsMouseInObject(AX, AY: Integer): Boolean;
begin
	Result := (AX>=0)and(AX<=Self.Width)and(AY>=0)and(AY<=Self.Height);
end;

procedure TEnd.PaintObject;
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
		else if Executing then
			Brush.Color := COLOR_EXECUTING
		else if BreakPoint then
			Brush.Color := clYellow
		else
			Brush.Color := clWhite;

		Brush.Style := bsSolid;
		RoundRect(0,0,Self.Width,Self.Height, BORDER * 2, BORDER * 2);
	end;
end;

{ TBegin }

constructor TBegin.Create(AOwner: TComponent; AParent: TWinControl);
begin
	inherited;
	Comments := 'Program';
	Parameters := '';
	ShowComments := True;
	ShowParameters := False;
end;

procedure TBegin.SetCapacities;
begin
	CanMove := True;
	CanResize := True;
	CanNorthJoin := False;
	CanEastJoin := False;
	CanSouthJoin := True;
	CanWestJoin := False;

	ExitJoin.AcceptEntry := False;
	ExitJoin.AcceptExit := True;
end;

function TBegin.Execute: TInstruction;
begin
	Self.Error := False;
	try
		if Assigned(ExitJoin.Arrow) then
			Result := ExitJoin.Arrow.ToJoin.Instruction
		else
			raise Exception.Create('Exit arrow missed!');
	except
		Self.Error := True;
		raise;
	end;
end;

function TBegin.IsMouseInObject(AX, AY: Integer): Boolean;
begin
	Result := (AX>=0)and(AX<=Self.Width)and(AY>=0)and(AY<=Self.Height);
end;

procedure TBegin.PaintObject;
var
   w,h : integer;
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
		else if Executing then
			Brush.Color := COLOR_EXECUTING
		else if BreakPoint then
			Brush.Color := clYellow
		else
			Brush.Color := clWhite;

		Brush.Style := bsSolid;

    w := self.Width;
    h := self.Height;

		RoundRect(0,0,w,h, BORDER * 2, BORDER * 2);
	end;
end;

{ TInput }

procedure TInput.Update;
var
  s : string;
begin
  S := 'Read';

  if (Device = deFile)  then
    S := S + 'File';

  if CarriageReturn then
     S := S + 'Ln';

  S := S + '(';

  if Device=deFile then
    S := S + FilePath + SEPARATOR + ' ';

  S := S + Parameters + ')';

  Parameters := S;
end;

constructor TInput.Create(AOwner: TComponent; AParent: TWinControl);
begin
  inherited;

end;

destructor TInput.Destroy;
begin

  inherited;
end;

function TInput.IsMouseInObject(AX, AY: Integer): Boolean;
begin
	Result := (AX>=0)and(AX<=Self.Width)and(AY>=0)and(AY<=Self.Height);
end;

procedure TInput.PaintObject;
var
  LPoints : array [0..4] of TPoint;
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
		else if Executing then
			Brush.Color := COLOR_EXECUTING
		else if BreakPoint then
			Brush.Color := COLOR_BREAK_POINT
		else
			Brush.Color := COLOR_OBJECT;

		Brush.Style := bsSolid;

    LPoints[0] := Point(0,0);
    LPoints[1] := Point(Self.Width - 1, 0);
    LPoints[2] := Point(Self.Width - 1, Self.Height - 1);
    LPoints[3] := Point(0,Self.Height - 1);
    LPoints[4] := Point(COMMUNICATION_ARROW_WIDTH,Self.Height div 2);
    Polygon(LPoints);
	end;
end;

{ TSalida }

procedure TOutput.Update;
var
  s : string;
begin
  S := 'Write';
  if (Device = deFile)  then
    S := S + 'File';

  if CarriageReturn then
     S := S + 'Ln';

  S := S + '(';

  if Device=deFile then
    S := S + FilePath + SEPARATOR + ' ';

	S := S + Parameters + ')';

  Parameters := S;
end;

constructor TOutput.Create(AOwner: TComponent; AParent: TWinControl);
begin
  inherited;
end;

destructor TOutput.Destroy;
begin

  inherited;
end;

function TOutput.IsMouseInObject(AX, AY: Integer): Boolean;
begin
	Result := (AX>=0)and(AY>=0)and(AY<=Self.Height)
		and (AY >= Round(Self.Height * (AX - Self.Width + COMMUNICATION_ARROW_WIDTH) / 2 / COMMUNICATION_ARROW_WIDTH))
		and (AY <= Round(Self.Height * (Self.Width + COMMUNICATION_ARROW_WIDTH - AX) / 2 / COMMUNICATION_ARROW_WIDTH ));
end;

procedure TOutput.PaintObject;
var
  LPoints : Array[0..4] of TPoint;
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
		else if Executing then
			Brush.Color := COLOR_EXECUTING
		else if BreakPoint then
			Brush.Color := COLOR_BREAK_POINT
		else
			Brush.Color := COLOR_OBJECT;

		Brush.Style := bsSolid;

    LPoints[0] := Point(0,0);
    LPoints[1] := Point(Self.Width - COMMUNICATION_ARROW_WIDTH,0);
    LPoints[2] := Point(Self.Width - 1,Self.Height div 2);
    LPoints[3] := Point(Self.Width - COMMUNICATION_ARROW_WIDTH,Self.Height - 1);
    LPoints[4] := Point(0,Self.Height - 1);
    Polygon(LPoints);
	end;
end;

{ TCommunication }

constructor TCommunication.Create(AOwner: TComponent;
  AParent: TWinControl);
begin
	inherited;

	CarriageReturn := True;
end;

procedure TCommunication.SetFilePath(const Value: String);
begin
  if Value<> FFilePath then
  begin
    FFilePath := Value;
    Update;
    if Assigned(FOnModify) then
      OnModify(Self);
  end;
end;

procedure TCommunication.SetDevice(const Value: TDevice);
begin
  if Value<> FDevice then
  begin
    FDevice := Value;
    Update;
    if Assigned(FOnModify) then
      OnModify(Self);
  end;
end;

procedure TCommunication.SetParameters(const Value: String);
begin
  if Value<> FParameters then
  begin
    FParameters := Value;
    Update;
    if Assigned(FOnModify) then
      OnModify(Self);
  end;
end;

procedure TCommunication.SetCarriageReturn(const Value: Boolean);
begin
  if Value<> FCarriageReturn then
  begin
    FCarriageReturn := Value;
    Update;
    if Assigned(FOnModify) then
      OnModify(Self);
  end;
end;

end.