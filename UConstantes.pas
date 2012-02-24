unit UConstantes;

interface
uses Graphics;

const
	LETRAS = ['A'..'Z','a'..'z'];
	DIGITOS = ['0'..'9'];
	NUMEROSENTEROS = Digitos + ['.','+','-'];
	NUMEROSREALES = NumerosEnteros + ['E'];
	VALIDOS = Letras + Digitos + ['_','.'];
	IDENTIFICADORES = Letras + Digitos + ['_'];

  SEPARADOR = ';';

  PUNTA_ENT_SAL = 15;

resourcestring // Declaracion de nombres de tipos
	NameIndef = 'Indefinido';

	NameInteg = 'Entero';
	NameInte8 = 'Entero 8 bits';
	NameInt16 = 'Entero 16 bits';
	NameInt32 = 'Entero 32 bits';
	NameInt64 = 'Entero 64 bits';
//	NameIn128 = 'Entero 128 bits';

	NameWord1 = 'Natural 1 bits (Si/No)';
	NameWord4 = 'Natural 4 bits';
	NameWord8 = 'Natural 8 bits';
	NameWor16 = 'Natural 16 bits';
	NameWor32 = 'Natural 32 bits';
//	NameWor64 = 'Natural 64 bits';

	NameSing = 'Real de precisión simple';
	NameDoub = 'Real de precisión doble';
	NameExte = 'Real de precisión extendida';
//	NameCurr = 'Real de precisión monetaria';

	NameCad = 'Cadena de carácteres';

	LogTrue = 'si';
	LogFalse = 'no';

//	NameSCpx = 'Complejo de precisión simple';

const
	BORDE = 9;
  BORDE_PANTALLA = 20;
	COLOR_ERROR = clRed;
	COLOR_EJECUCION = clSilver;
	COLOR_BREAK_POINT = clYellow;
	COLOR_OBJETO = clWhite;
  GRILLAX = 5;
  GRILLAY = 5;

implementation

end.