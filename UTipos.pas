unit UTipos;

// Tipos Enteros |---------------
// Nº 1 Inte8: Integer 8 bits
// Nº 2 Int16: Integer 16 bits
// Nº 3 Int32: Integer 32 bits
// Nº 4 Int64: Integer 64 bits
// Nº 5 In128: Integer 128 bits !!

// Nº 10 Word1: unsigned Integer 1 bits
// Nº 11 Word4: unsigned Integer 4 bits
// Nº 12 Word8: unsigned Integer 8 bits
// Nº 13 Wor16: unsigned Integer 16 bits
// Nº 14 Wor32: unsigned Integer 32 bits
// Nº 15 Wor64: unsigned Integer 64 bits !!

// Nº 20 Sing: Float Single presicion
// Nº 21 Doub: Float Double presicion
// Nº 22 Exte: Float Extended presicion
// Nº 24 Curr: Float Currency presicion to mange money values!

// Nº 30 Cad: Char String

interface

uses UConstantes, classes;

type

//----- Declaracion interna de tipos y punteros a tipos -----
	TTipo = integer;
	TIdentificador = String; // Identificadores de variables y funciones
	TExpresion = String; // Expresion a parsear

	TInte8 = LongInt;
	PInte8 = ^TInte8;

	TInt16 = LongInt;
	PInt16 = ^TInt16;

	TInt32 = LongInt;
	PInt32 = ^TInt32;

	TInt64 = Int64;
	PInt64 = ^TInt64;

	TWord1 = LongWord;
	PWord1 = ^TWord1;

	TWord4 = LongWord;
	PWord4 = ^TWord4;

	TWord8 = LongWord;
	PWord8 = ^TWord8;

	TWor16 = LongWord;
	PWor16 = ^TWor16;

	TWor32 = LongWord;
	pWor32 = ^TWor32;

	TSing = Single;
	PSing = ^TSing;

	TDoub = Double;
	PDoub = ^TDoub;

	TExte = Extended;
	PExte = ^TExte;

//	tCurr = Currency;
//	pCurr = ^tCurr;

	TCadena = ShortString;
	PCadena = ^TCadena;

const
  //----- Indices internos de los tipos -----
	nIndef = 0;

	nInte8 = 1;
	nInt16 = 2;
	nInt32 = 3;
	nInt64 = 4;

	nWord1 = 10;
	nWord4 = 11;
	nWord8 = 12;
	nWor16 = 13;
	nWor32 = 14;

	nSing = 20;
	nDoub = 21;
	nExte = 22;

	nCad = 30;

	nTipos : array[1..13] of byte = (
		nInte8,nInt16,nInt32,nInt64,nWord1,
    nWord4,nWord8,nWor16,nWor32,
		nSing,nDoub,nExte,
 		nCad
	);

var
  TiposList: TStringList;
{$ifdef fulldebug}
  fSizeTipoCalls: longWord = 0;
  fGrupoTipoCalls: longWord = 0;
{$endif}

// ---| Funciones de tipos |---
type
  TTipos = class
    class function NombreTipo(nTipo: byte): String;
    class function GetTipo (Name : String): Byte;
    class function SizeTipo(nTipo: byte): Word;
    class function GrupoTipo(nTipo: byte): byte;
  end;

implementation

uses SysUtils;
{$ifdef debug}
//uses MemControl;
{$endif}

class function TTipos.GetTipo (Name : String): Byte;
var a : integer;
Begin
  result := 0;
	for a := 1 to High(nTipos) do
	 if UpperCase(Name) = UpperCase(NombreTipo(nTipos[a])) then
	 begin
		 Result := nTipos[a];
		 Break;
	 end;
end;

class function TTipos.NombreTipo(nTipo: byte): String;
begin
	case nTipo of
    nIndef: result:= NameIndef;

		nInte8: result:= NameInte8;
		nInt16: result:= NameInt16;
		nInt32: result:= NameInt32;
		nInt64: result:= NameInt64;

		nWord1: result:= NameWord1;
		nWord4: result:= NameWord4;
		nWord8: result:= NameWord8;
		nWor16: result:= NameWor16;
		nWor32: result:= NameWor32;

		nSing: result:= NameSing;
		nDoub: result:= NameDoub;
		nExte: result:= NameExte;

		nCad: result:= NameCad;
{$ifdef debug}
		else
			assert(false,'nTipo error!'); // Expresion falsa -> Error
{$endif}
	end;
end;

class function TTipos.SizeTipo(nTipo: byte): Word;
begin
{$ifdef fulldebug}
	inc(fSizeTipoCalls);
{$endif}
	result:= 0; // Los valores indefinidos no ocupan lugar.
	case nTipo of
		nInte8: result:= sizeof(TInte8);
		nInt16: result:= sizeof(TInt16);
		nInt32: result:= sizeof(TInt32);
		nInt64: result:= sizeof(TInt64);
		nWord1: result:= sizeof(TWord1);
		nWord4: result:= sizeof(TWord4);
		nWord8: result:= sizeof(TWord8);
		nWor16: result:= sizeof(TWor16);
		nWor32: result:= sizeof(TWor32);

		nSing: result:= sizeof(TSing);
		nDoub: result:= sizeof(TDoub);
		nExte: result:= sizeof(TExte);

		nCad: result:= SizeOf(TCadena); // Las cadenas tienen largo variante!
{$ifdef debug}
		else
			assert(false,'Error en nTipo'); // Expresion falsa -> Error
{$endif}
	end;
end;

class function TTipos.GrupoTipo(nTipo: byte): byte;
		{ Devueve el grupo del tipo
		Ej: 1 -> Entero con signo;
				2 -> Entero sin signo;
				3 -> Flotantes;
				4 -> Cadenas;
				5 -> Complejos !
		}
begin
{$ifdef fulldebug}
	inc(fGrupoTipoCalls);
{$endif}
	result:= nTipo div 10 + 1 ;
end;

initialization
begin
	TiposList:= TStringList.Create;
	TiposList.Add(TTipos.NombreTipo(nInt32));
	TiposList.Add(TTipos.NombreTipo(nExte));
	TiposList.Add(TTipos.NombreTipo(nCad));
end;

finalization
begin
	TiposList.Free;
end;

end.
