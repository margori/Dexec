unit UOperadores;

interface

uses UValores;

type
  TOperation = function(AValue1,AValue2 : TValue): TValue;

	TOperator = record
		OperatorString: String;
		Level : integer;
    Operation : TOperation;
    IsUnary : boolean;
    IsBinary : boolean;
	end;

var
	Operators : array[1..16] of TOperator;
	OperatorChars : set of char;

function IsOperator(S: String): Boolean;
function IsUnaryOperator(S: String): Boolean;
function IsBinaryOperator(S: String): Boolean;
function GetOperatorLevel(S: string): Integer;
function Evaluate(AOperator: String; AValue1,AValue2 : TValue): TValue;

implementation

uses UTipos, Sysutils;

function IsUnaryOperator(S: String): Boolean;
var
  j : integer;
begin
  Result := False;
  for j := Low(Operators) to High(Operators) do
    if Operators[j].OperatorString = S then
    begin
      Result := Operators[j].IsUnary;
      Break;
    end;
end;

function IsBinaryOperator(S: String): Boolean;
var
  j : integer;
begin
  Result := False;
  for j := Low(Operators) to High(Operators) do
    if Operators[j].OperatorString = S then
    begin
      Result := Operators[j].IsBinary;
      Break;
    end;
end;

function IsOperator(S: String): Boolean;
var
  j : integer;
begin
  Result := False;
  for j := Low(Operators) to High(Operators) do
    if Operators[j].OperatorString = S then
    begin
      Result := True;
      Break;
    end;
end;

function GetOperatorLevel(S: string): Integer;
var
	j : integer;
begin
	Result := 0;
	for j := Low(Operators) to High(Operators) do
		if s = Operators[j].OperatorString then
		begin
			Result := Operators[j].Level;
			Break;
		end;
end;

function Evaluate(AOperator: String; AValue1,AValue2 : TValue): TValue;
var
  j : integer;
begin
	Result := DEFAULT_VALUE;

  for j := 1 to High(Operators) do
  begin
    if AOperator = Operators[j].OperatorString then
    begin
			Result := Operators[j].Operation(AValue1,AValue2);
      Exit;
    end;
  end;
end;

//---------  Operators --------------//
function OperatorNot(AValue1,AValue2 : TValue): TValue;
begin
  if (AValue1.ValueType = nIndef)and(AValue2.ValueType = nInt32) then
  begin
  	TValues.SetValueType(Result, nInt32);
		PInteger32(Result.ValuePointer)^ := not PInteger32(AValue2.ValuePointer)^;
  end
  else
		raise Exception.Create('Types missmatch!');
end;

function OperatorAnd(AValue1,AValue2 : TValue): TValue;
begin
  if (AValue1.ValueType = nInt32)and(AValue2.ValueType = nInt32) then
  begin
  	TValues.SetValueType(Result, nInt32);
		PInteger32(Result.ValuePointer)^ := PInteger32(AValue1.ValuePointer)^ and PInteger32(AValue2.ValuePointer)^;
	end
  else
		raise Exception.Create('Types missmatch!');
end;

function OperatorOr(AValue1,AValue2 : TValue): TValue;
begin
	if (AValue1.ValueType = nInt32)and(AValue2.ValueType = nInt32) then
	begin
		TValues.SetValueType(Result, nInt32);
		PInteger32(Result.ValuePointer)^ := PInteger32(AValue1.ValuePointer)^ or PInteger32(AValue2.ValuePointer)^;
	end
	else
		raise Exception.Create('Types missmatch!');
end;

function OperatorXor(AValue1,AValue2 : TValue): TValue;
begin
  if (AValue1.ValueType = nInt32)and(AValue2.ValueType = nInt32) then
  begin
  	TValues.SetValueType(Result, nInt32);
		PInteger32(Result.ValuePointer)^ := PInteger32(AValue1.ValuePointer)^ xor PInteger32(AValue2.ValuePointer)^;
  end
  else
		raise Exception.Create('Types missmatch!');
end;

function OperatorEqual(AValue1,AValue2 : TValue): TValue;
begin
	if (AValue1.ValueType = nInt32)and(AValue2.ValueType = nInt32) then
	begin
		TValues.SetValueType(Result, nInt32);
		if PInteger32(AValue1.ValuePointer)^ = PInteger32(AValue2.ValuePointer)^ then
			PInteger32(Result.ValuePointer)^ := -1
		else
			PInteger32(Result.ValuePointer)^ := 0;
	end
	else if (AValue1.ValueType = nString)and(AValue2.ValueType = nString) then
  begin
		TValues.SetValueType(Result, nInt32);
    if PString(AValue1.ValuePointer)^ = PString(AValue2.ValuePointer)^ then
      PInteger32(Result.ValuePointer)^ := -1
    else
      PInteger32(Result.ValuePointer)^ := 0;
  end
  else if (AValue1.ValueType = nInt32)and(AValue2.ValueType = nExte) then
  begin
		TValues.SetValueType(Result, nInt32);
		if PInteger32(AValue1.ValuePointer)^ = PExte(AValue2.ValuePointer)^ then
      PInteger32(Result.ValuePointer)^ := -1
    else
      PInteger32(Result.ValuePointer)^ := 0;
  end
  else if (AValue1.ValueType = nExte)and(AValue2.ValueType = nInt32) then
  begin
		TValues.SetValueType(Result, nInt32);
    if PExte(AValue1.ValuePointer)^ = PInteger32(AValue2.ValuePointer)^ then
      PInteger32(Result.ValuePointer)^ := -1
    else
      PInteger32(Result.ValuePointer)^ := 0;
  end
  else if (AValue1.ValueType = nExte)and(AValue2.ValueType = nExte) then
  begin
		TValues.SetValueType(Result, nInt32);
    if PExte(AValue1.ValuePointer)^ = PExte(AValue2.ValuePointer)^ then
      PInteger32(Result.ValuePointer)^ := -1
    else
      PInteger32(Result.ValuePointer)^ := 0;
  end
  else
		raise Exception.Create('Types missmatch!');
end;

function OperatorLess(AValue1,AValue2 : TValue): TValue;
begin
  if (AValue1.ValueType = nInt32)and(AValue2.ValueType = nInt32) then
  begin
		TValues.SetValueType(Result, nInt32);
    if PInteger32(AValue1.ValuePointer)^ < PInteger32(AValue2.ValuePointer)^ then
      PInteger32(Result.ValuePointer)^ := -1
    else
      PInteger32(Result.ValuePointer)^ := 0;
  end
  else if (AValue1.ValueType = nString)and(AValue2.ValueType = nString) then
  begin
		TValues.SetValueType(Result, nInt32);
    if PString(AValue1.ValuePointer)^ < PString(AValue2.ValuePointer)^ then
      PInteger32(Result.ValuePointer)^ := -1
    else
      PInteger32(Result.ValuePointer)^ := 0;
  end
  else if (AValue1.ValueType = nInt32)and(AValue2.ValueType = nExte) then
  begin
		TValues.SetValueType(Result, nInt32);
		if PInteger32(AValue1.ValuePointer)^ < PExte(AValue2.ValuePointer)^ then
			PInteger32(Result.ValuePointer)^ := -1
		else
			PInteger32(Result.ValuePointer)^ := 0;
	end
	else if (AValue1.ValueType = nExte)and(AValue2.ValueType = nInt32) then
	begin
		TValues.SetValueType(Result, nInt32);
		if PExte(AValue1.ValuePointer)^ < PInteger32(AValue2.ValuePointer)^ then
			PInteger32(Result.ValuePointer)^ := -1
		else
			PInteger32(Result.ValuePointer)^ := 0;
	end
	else if (AValue1.ValueType = nExte)and(AValue2.ValueType = nExte) then
	begin
		TValues.SetValueType(Result, nInt32);
		if PExte(AValue1.ValuePointer)^ < PExte(AValue2.ValuePointer)^ then
			PInteger32(Result.ValuePointer)^ := -1
		else
			PInteger32(Result.ValuePointer)^ := 0;
	end
	else
		raise Exception.Create('Types missmatch!');
end;

function OperatorGreater(AValue1,AValue2 : TValue): TValue;
begin
  if (AValue1.ValueType = nInt32)and(AValue2.ValueType = nInt32) then
  begin
		TValues.SetValueType(Result, nInt32);
    if PInteger32(AValue1.ValuePointer)^ > PInteger32(AValue2.ValuePointer)^ then
      PInteger32(Result.ValuePointer)^ := -1
    else
      PInteger32(Result.ValuePointer)^ := 0;
  end
  else if (AValue1.ValueType = nString)and(AValue2.ValueType = nString) then
  begin
		TValues.SetValueType(Result, nInt32);
    if PString(AValue1.ValuePointer)^ > PString(AValue2.ValuePointer)^ then
      PInteger32(Result.ValuePointer)^ := -1
    else
      PInteger32(Result.ValuePointer)^ := 0;
  end
  else if (AValue1.ValueType = nInt32)and(AValue2.ValueType = nExte) then
  begin
		TValues.SetValueType(Result, nInt32);
		if PInteger32(AValue1.ValuePointer)^ > PExte(AValue2.ValuePointer)^ then
      PInteger32(Result.ValuePointer)^ := -1
    else
      PInteger32(Result.ValuePointer)^ := 0;
	end
  else if (AValue1.ValueType = nExte)and(AValue2.ValueType = nInt32) then
  begin
		TValues.SetValueType(Result, nInt32);
    if PExte(AValue1.ValuePointer)^ > PInteger32(AValue2.ValuePointer)^ then
      PInteger32(Result.ValuePointer)^ := -1
    else
      PInteger32(Result.ValuePointer)^ := 0;
  end
  else if (AValue1.ValueType = nExte)and(AValue2.ValueType = nExte) then
  begin
		TValues.SetValueType(Result, nInt32);
    if PExte(AValue1.ValuePointer)^ > PExte(AValue2.ValuePointer)^ then
      PInteger32(Result.ValuePointer)^ := -1
    else
      PInteger32(Result.ValuePointer)^ := 0;
  end
  else
		raise Exception.Create('Types missmatch!');
end;

function OperatorLessOrEqual(AValue1,AValue2 : TValue): TValue;
begin
  if (AValue1.ValueType = nInt32)and(AValue2.ValueType = nInt32) then
	begin
		TValues.SetValueType(Result, nInt32);
    if PInteger32(AValue1.ValuePointer)^ <= PInteger32(AValue2.ValuePointer)^ then
      PInteger32(Result.ValuePointer)^ := -1
    else
      PInteger32(Result.ValuePointer)^ := 0;
  end
  else if (AValue1.ValueType = nString)and(AValue2.ValueType = nString) then
  begin
		TValues.SetValueType(Result, nInt32);
    if PString(AValue1.ValuePointer)^ <= PString(AValue2.ValuePointer)^ then
      PInteger32(Result.ValuePointer)^ := -1
    else
      PInteger32(Result.ValuePointer)^ := 0;
  end
  else if (AValue1.ValueType = nInt32)and(AValue2.ValueType = nExte) then
  begin
		TValues.SetValueType(Result, nInt32);
		if PInteger32(AValue1.ValuePointer)^ <= PExte(AValue2.ValuePointer)^ then
      PInteger32(Result.ValuePointer)^ := -1
    else
      PInteger32(Result.ValuePointer)^ := 0;
  end
  else if (AValue1.ValueType = nExte)and(AValue2.ValueType = nInt32) then
	begin
		TValues.SetValueType(Result, nInt32);
    if PExte(AValue1.ValuePointer)^ <= PInteger32(AValue2.ValuePointer)^ then
      PInteger32(Result.ValuePointer)^ := -1
    else
      PInteger32(Result.ValuePointer)^ := 0;
  end
  else if (AValue1.ValueType = nExte)and(AValue2.ValueType = nExte) then
  begin
		TValues.SetValueType(Result, nInt32);
    if PExte(AValue1.ValuePointer)^ <= PExte(AValue2.ValuePointer)^ then
      PInteger32(Result.ValuePointer)^ := -1
    else
      PInteger32(Result.ValuePointer)^ := 0;
  end
  else
		raise Exception.Create('Types missmatch!');
end;

function OperatorGreaterOrEqual(AValue1,AValue2 : TValue): TValue;
begin
  if (AValue1.ValueType = nInt32)and(AValue2.ValueType = nInt32) then
  begin
		TValues.SetValueType(Result, nInt32);
		if PInteger32(AValue1.ValuePointer)^ >= PInteger32(AValue2.ValuePointer)^ then
      PInteger32(Result.ValuePointer)^ := -1
    else
      PInteger32(Result.ValuePointer)^ := 0;
  end
  else if (AValue1.ValueType = nString)and(AValue2.ValueType = nString) then
  begin
		TValues.SetValueType(Result, nInt32);
    if PString(AValue1.ValuePointer)^ >= PString(AValue2.ValuePointer)^ then
      PInteger32(Result.ValuePointer)^ := -1
    else
      PInteger32(Result.ValuePointer)^ := 0;
  end
  else if (AValue1.ValueType = nInt32)and(AValue2.ValueType = nExte) then
  begin
		TValues.SetValueType(Result, nInt32);
		if PInteger32(AValue1.ValuePointer)^ >= PExte(AValue2.ValuePointer)^ then
      PInteger32(Result.ValuePointer)^ := -1
    else
      PInteger32(Result.ValuePointer)^ := 0;
  end
  else if (AValue1.ValueType = nExte)and(AValue2.ValueType = nInt32) then
  begin
		TValues.SetValueType(Result, nInt32);
		if PExte(AValue1.ValuePointer)^ >= PInteger32(AValue2.ValuePointer)^ then
      PInteger32(Result.ValuePointer)^ := -1
    else
      PInteger32(Result.ValuePointer)^ := 0;
  end
  else if (AValue1.ValueType = nExte)and(AValue2.ValueType = nExte) then
  begin
		TValues.SetValueType(Result, nInt32);
    if PExte(AValue1.ValuePointer)^ >= PExte(AValue2.ValuePointer)^ then
      PInteger32(Result.ValuePointer)^ := -1
    else
      PInteger32(Result.ValuePointer)^ := 0;
  end
  else
		raise Exception.Create('Types missmatch!');
end;

function OperatorDistinct(AValue1,AValue2 : TValue): TValue;
begin
  if (AValue1.ValueType = nInt32)and(AValue2.ValueType = nInt32) then
  begin
		TValues.SetValueType(Result, nInt32);
    if PInteger32(AValue1.ValuePointer)^ <> PInteger32(AValue2.ValuePointer)^ then
      PInteger32(Result.ValuePointer)^ := -1
		else
      PInteger32(Result.ValuePointer)^ := 0;
  end
  else if (AValue1.ValueType = nString)and(AValue2.ValueType = nString) then
  begin
		TValues.SetValueType(Result, nInt32);
    if PString(AValue1.ValuePointer)^ <> PString(AValue2.ValuePointer)^ then
      PInteger32(Result.ValuePointer)^ := -1
    else
      PInteger32(Result.ValuePointer)^ := 0;
  end
  else if (AValue1.ValueType = nInt32)and(AValue2.ValueType = nExte) then
  begin
		TValues.SetValueType(Result, nInt32);
		if PInteger32(AValue1.ValuePointer)^ <> PExte(AValue2.ValuePointer)^ then
      PInteger32(Result.ValuePointer)^ := -1
    else
      PInteger32(Result.ValuePointer)^ := 0;
  end
  else if (AValue1.ValueType = nExte)and(AValue2.ValueType = nInt32) then
  begin
		TValues.SetValueType(Result, nInt32);
    if PExte(AValue1.ValuePointer)^ <> PInteger32(AValue2.ValuePointer)^ then
      PInteger32(Result.ValuePointer)^ := -1
		else
      PInteger32(Result.ValuePointer)^ := 0;
  end
  else if (AValue1.ValueType = nExte)and(AValue2.ValueType = nExte) then
  begin
		TValues.SetValueType(Result, nInt32);
    if PExte(AValue1.ValuePointer)^ <> PExte(AValue2.ValuePointer)^ then
      PInteger32(Result.ValuePointer)^ := -1
    else
      PInteger32(Result.ValuePointer)^ := 0;
  end
  else
		raise Exception.Create('Types missmatch!');
end;

function OperatorAddition(AValue1,AValue2 : TValue): TValue;
begin
  if (AValue1.ValueType = nInt32)and(AValue2.ValueType = nInt32) then
  begin
		TValues.SetValueType(Result, nInt32);
		PInteger32(Result.ValuePointer)^ := PInteger32(AValue1.ValuePointer)^ + PInteger32(AValue2.ValuePointer)^;
  end
  else if (AValue1.ValueType = nString)and(AValue2.ValueType = nString) then
  begin
		TValues.SetValueType(Result, nString);
		PString(Result.ValuePointer)^ := PString(AValue1.ValuePointer)^ + PString(AValue2.ValuePointer)^;
  end
  else if (AValue1.ValueType = nInt32)and(AValue2.ValueType = nExte) then
  begin
		TValues.SetValueType(Result, nExte);
		PExte(Result.ValuePointer)^ := PInteger32(AValue1.ValuePointer)^ + PExte(AValue2.ValuePointer)^;
  end
  else if (AValue1.ValueType = nExte)and(AValue2.ValueType = nInt32) then
  begin
		TValues.SetValueType(Result, nExte);
		PExte(Result.ValuePointer)^ := PExte(AValue1.ValuePointer)^ + PInteger32(AValue2.ValuePointer)^;
	end
	else if (AValue1.ValueType = nExte)and(AValue2.ValueType = nExte) then
	begin
		TValues.SetValueType(Result, nExte);
		PExte(Result.ValuePointer)^ := PExte(AValue1.ValuePointer)^ + PExte(AValue2.ValuePointer)^;
	end
	else
		raise Exception.Create('Types missmatch!');
end;

function OperatorSubtraction(AValue1,AValue2 : TValue): TValue;
begin
	if (AValue1.ValueType = nIndef)and(AValue2.ValueType = nInt32) then
  begin
		TValues.SetValueType(Result, nInt32);
		PInteger32(Result.ValuePointer)^ := - PInteger32(AValue2.ValuePointer)^;
  end
  else if (AValue1.ValueType = nIndef)and(AValue2.ValueType = nExte) then
  begin
		TValues.SetValueType(Result, nExte);
		PExte(Result.ValuePointer)^ := - PExte(AValue2.ValuePointer)^;
  end
  else if (AValue1.ValueType = nInt32)and(AValue2.ValueType = nInt32) then
  begin
		TValues.SetValueType(Result, nInt32);
		PInteger32(Result.ValuePointer)^ := PInteger32(AValue1.ValuePointer)^ - PInteger32(AValue2.ValuePointer)^;
  end
  else if (AValue1.ValueType = nInt32)and(AValue2.ValueType = nExte) then
  begin
		TValues.SetValueType(Result, nExte);
		PExte(Result.ValuePointer)^ := PInteger32(AValue1.ValuePointer)^ - PExte(AValue2.ValuePointer)^;
	end
  else if (AValue1.ValueType = nExte)and(AValue2.ValueType = nInt32) then
  begin
		TValues.SetValueType(Result, nExte);
		PExte(Result.ValuePointer)^ := PExte(AValue1.ValuePointer)^ - PInteger32(AValue2.ValuePointer)^;
	end
  else if (AValue1.ValueType = nExte)and(AValue2.ValueType = nExte) then
  begin
		TValues.SetValueType(Result, nExte);
		PExte(Result.ValuePointer)^ := PExte(AValue1.ValuePointer)^ - PExte(AValue2.ValuePointer)^;
  end
	else
		raise Exception.Create('Types missmatch!');
end;

function OperatorMultiplication(AValue1,AValue2 : TValue): TValue;
begin
	if (AValue1.ValueType = nInt32)and(AValue2.ValueType = nInt32) then
	begin
		TValues.SetValueType(Result, nInt32);
		PInteger32(Result.ValuePointer)^ := PInteger32(AValue1.ValuePointer)^ * PInteger32(AValue2.ValuePointer)^;
	end
	else if (AValue1.ValueType = nInt32)and(AValue2.ValueType = nExte) then
	begin
		TValues.SetValueType(Result, nExte);
		PExte(Result.ValuePointer)^ := PInteger32(AValue1.ValuePointer)^ * PExte(AValue2.ValuePointer)^;
  end
  else if (AValue1.ValueType = nExte)and(AValue2.ValueType = nInt32) then
  begin
		TValues.SetValueType(Result, nExte);
		PExte(Result.ValuePointer)^ := PExte(AValue1.ValuePointer)^ * PInteger32(AValue2.ValuePointer)^;
  end
  else if (AValue1.ValueType = nExte)and(AValue2.ValueType = nExte) then
  begin
		TValues.SetValueType(Result, nExte);
		PExte(Result.ValuePointer)^ := PExte(AValue1.ValuePointer)^ * PExte(AValue2.ValuePointer)^;
	end
	else
		raise Exception.Create('Types missmatch!');
end;

function OperatorDivision(AValue1,AValue2 : TValue): TValue;
begin
  if (AValue1.ValueType = nInt32)and(AValue2.ValueType = nInt32) then
  begin
		TValues.SetValueType(Result, nExte);
		PExte(Result.ValuePointer)^ := PInteger32(AValue1.ValuePointer)^ / PInteger32(AValue2.ValuePointer)^;
  end
  else if (AValue1.ValueType = nInt32)and(AValue2.ValueType = nExte) then
  begin
		TValues.SetValueType(Result, nExte);
		PExte(Result.ValuePointer)^ := PInteger32(AValue1.ValuePointer)^ / PExte(AValue2.ValuePointer)^;
  end
	else if (AValue1.ValueType = nExte)and(AValue2.ValueType = nInt32) then
  begin
		TValues.SetValueType(Result, nExte);
		PExte(Result.ValuePointer)^ := PExte(AValue1.ValuePointer)^ / PInteger32(AValue2.ValuePointer)^;
  end
  else if (AValue1.ValueType = nExte)and(AValue2.ValueType = nExte) then
  begin
		TValues.SetValueType(Result, nExte);
		PExte(Result.ValuePointer)^ := PExte(AValue1.ValuePointer)^ / PExte(AValue2.ValuePointer)^;
	end
	else
		raise Exception.Create('Types missmatch!');
end;

function OperatorIntegerDivision(AValue1,AValue2 : TValue): TValue;
begin
  if (AValue1.ValueType = nInt32)and(AValue2.ValueType = nInt32) then
  begin
		TValues.SetValueType(Result, nInt32);
		PInteger32(Result.ValuePointer)^ := PInteger32(AValue1.ValuePointer)^ div PInteger32(AValue2.ValuePointer)^;
  end
  else
		raise Exception.Create('Types missmatch!');
end;

function OperatorModule(AValue1,AValue2 : TValue): TValue;
begin
	if (AValue1.ValueType = nInt32)and(AValue2.ValueType = nInt32) then
	begin
		TValues.SetValueType(Result, nInt32);
		PInteger32(Result.ValuePointer)^ := PInteger32(AValue1.ValuePointer)^ mod PInteger32(AValue2.ValuePointer)^;
	end
	else
		raise Exception.Create('Types missmatch!');
end;
//---------  Operators --------------//

var
	j,k :integer;
initialization
begin
  with Operators[1] do
  begin
    OperatorString := 'not';
    Level:= 1;
    Operation:= OperatorNot;
		IsUnary := True;
    IsBinary := False;
	end;

  with Operators[2] do
  begin
    OperatorString := 'and';
    Level:= 2;
    Operation:= OperatorAnd;
    IsUnary := False;
    IsBinary := True;
  end;

  with Operators[3] do
  begin
    OperatorString := 'or';
    Level:= 2;
    Operation:= OperatorOr;
    IsUnary := False;
    IsBinary := True;
  end;

  with Operators[4] do
  begin
		OperatorString := 'xor';
    Level:= 2;
		Operation:= OperatorXor;
    IsUnary := False;
    IsBinary := True;
  end;

  with Operators[5] do
  begin
    OperatorString := '=';
    Level:= 3;
    Operation:= OperatorEqual;
    IsUnary := False;
    IsBinary := True;
  end;

  with Operators[6] do
  begin
    OperatorString := '<>';
    Level:= 3;
    Operation:= OperatorDistinct;
    IsUnary := False;
    IsBinary := True;
  end;

  with Operators[7] do // Este Operator debe estar antes que el <
	begin
    OperatorString := '<=';
    Level:= 3;
    Operation:= OperatorLessOrEqual;
    IsUnary := False;
    IsBinary := True;
  end;

  with Operators[8] do // Este Operator debe estar antes que el >
  begin
    OperatorString := '>=';
    Level:= 3;
    Operation:= OperatorGreaterOrEqual;
    IsUnary := False;
    IsBinary := True;
  end;

  with Operators[9] do
  begin
    OperatorString := '<';
    Level:= 3;
    Operation:= OperatorLess;
		IsUnary := False;
    IsBinary := True;
	end;

  with Operators[10] do
  begin
    OperatorString := '>';
    Level:= 3;
    Operation:= OperatorGreater;
    IsUnary := False;
    IsBinary := True;
  end;

  with Operators[11] do
  begin
    OperatorString := '+';
    Level:= 4;
    Operation:= OperatorAddition;
    IsUnary := False;
    IsBinary := True;
  end;

  with Operators[12] do
  begin
		OperatorString := '-';
    Level:= 4;
		Operation:= OperatorSubtraction;
    IsUnary := True;
    IsBinary := True;
  end;

  with Operators[13] do
  begin
    OperatorString := '*';
    Level:= 5;
    Operation:= OperatorMultiplication;
    IsUnary := False;
    IsBinary := True;
  end;

  with Operators[14] do
  begin
    OperatorString := '/';
    Level:= 5;
    Operation:= OperatorDivision;
    IsUnary := False;
    IsBinary := True;
  end;

  with Operators[15] do
	begin
    OperatorString := '\';
    Level:= 5;
    Operation:= OperatorIntegerDivision;
    IsUnary := False;
    IsBinary := True;
  end;

  with Operators[16] do
  begin
    OperatorString := '%';
    Level:= 5;
    Operation:= OperatorModule;
    IsUnary := False;
    IsBinary := True;
  end;

	OperatorChars := [];
	for j := Low(Operators) to High(Operators) do
		for k := 1 to Length(Operators[j].OperatorString) do
			if not(Operators[j].OperatorString[k] in OperatorChars) then
				OperatorChars := OperatorChars + [Operators[j].OperatorString[k]];
end;

end.
