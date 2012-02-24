unit UUtiles;

interface

uses types;

type
  TUtiles = class
  public
    class function Entre(A,B,C : Real): boolean;
    class procedure Cambiar(var P: Tpoint);
    class procedure Arreglar(var a,b: real); overload;
    class procedure Arreglar(var a,b: integer); overload;
    class function Secantes(AP1,AP2: TPoint;AR: TRect): boolean;

    class function RectCentradoEn(X,Y,Borde: integer): TRect;
    class function PuntoEnRect(X,Y: Integer; ARect : TRect): boolean;
  end;

implementation

class function TUtiles.PuntoEnRect(X,Y: Integer; ARect : TRect): boolean;
begin
	Result := (X>=ARect.Left)and(X<=ARect.Right)and
		(Y>=ARect.Top)and(Y<=ARect.Bottom);
end;

class function TUtiles.RectCentradoEn(X,Y,Borde: integer): TRect;
begin
	Result.Left := X-Borde div 2;
	Result.Right := X+Borde div 2;
	Result.Top := Y-Borde div 2;
	Result.Bottom := Y+Borde div 2;
end;

class procedure TUtiles.Arreglar(var a,b: real);
var aux : Real;
begin
	if A > B then
	begin
		Aux := B;
		B := A;
		A := Aux;
	end;
end;

class procedure TUtiles.Arreglar(var a,b: integer);
var aux : integer;
begin
	if A > B then
	begin
		Aux := B;
		B := A;
		A := Aux;
	end;
end;

class function TUtiles.Entre(A,B,C : Real): boolean;
begin
	Result := (A>=B)and(A<=C);
end;

class procedure TUtiles.Cambiar(var P: Tpoint);
var
	aux: Integer;
begin
	aux := P.X;
	P.X := P.Y;
	P.Y := aux;
end;

class function TUtiles.Secantes(AP1,AP2: TPoint;AR: TRect): boolean;
type
	TPunto = record
		X : Real;
		Y : Real;
	end;
var
	LP1,LP2,LP3,LP4 : Real;
	m,b : Real;
	cont : byte;
begin
	if AP1.X=AP2.X then
	begin
		Cambiar(AP1);
		Cambiar(AP2);
		Cambiar(AR.TopLeft);
		Cambiar(AR.BottomRight);
	end;
	Arreglar(AR.Left,AR.Right);
	Arreglar(AR.Top,AR.Bottom);

	m := (AP2.Y-AP1.Y)/(AP2.X-AP1.X);
	b := AP1.Y - m * AP1.X;

	LP1 := m * AR.Left + b;

	if m = 0 then
		LP2 := 0
	else
		LP2 := (AR.Top - b)/m;

	LP3 := m * AR.Right + b;

	if m = 0 then
		LP4 := 0
	else
		LP4 := (AR.Bottom - b)/m;

	Cont := 0;
	if Entre(LP1,AR.Top,AR.Bottom) then Inc(Cont);
	if Entre(LP2,AR.Left,AR.Right) then Inc(Cont);
	if Entre(LP3,AR.Top,AR.Bottom) then Inc(Cont);
	if Entre(LP4,AR.Left,AR.Right) then Inc(Cont);

	if m = 0 then
		Result := (AP1.Y>AR.Top)and(AP1.Y<Ar.Bottom)
	else
		Result := Cont>2;
end;

end.