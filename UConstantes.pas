unit UConstantes;

interface
uses Graphics;

const
	LETTERS = ['A'..'Z','a'..'z'];
	DIGITS = ['0'..'9'];
	INTEGER_CHARS = DIGITS + ['.','+','-'];
	REAL_CHARS = INTEGER_CHARS + ['E'];
	ALLOWED_CHARS = LETTERS + DIGITS + ['_','.'];
	IDENTIFIER_CHARS = LETTERS + DIGITS + ['_'];

  SEPARATOR = ';';

  COMMUNICATION_ARROW_WIDTH = 15;

resourcestring // Name of types
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
	BORDER = 9;
  BORDER_SCREEN = 20;

  COLOR_ERROR = clRed;
	COLOR_EXECUTING = clSilver;
	COLOR_BREAK_POINT = clYellow;
	COLOR_OBJECT = clWhite;

  GRID_X = 5;
  GRID_Y = 5;

implementation

end.
