unit UVariables;

interface

uses sysutils, UUtiles, classes, UValores, UTipos;

type
  TVariableInformation = record
    Name : String;
		DefaultValue : String;
		Rows, Columns : Integer;
		TypeNumber : TTypeNumber;
	end;

	TVariable = class
	private
		FName : String;
		FDefaultValue : String;
		FTypeNumber : TTypeNumber;
		FPointers : array of array of Pointer;
		function GetRows: Integer;
		function GetColumns: Integer;
		procedure SetRows(const Value: Integer);
		procedure SetColumns(const Value: Integer);
		procedure SetTypeNumber(const Value: integer);

		function PrivateGetValues(i1,i2: integer): TValue;
	public
		constructor Create;
		destructor Destroy; override;

		property Name: String read FName write FName;
		property ValorPorDefecto : String read FDefaultValue write FDefaultValue;
		property Rows : Integer read GetRows write SetRows;
		property Columns : Integer read GetColumns  write SetColumns;
		property TypeNumber : integer read FTypeNumber write SetTypeNumber;

		procedure Initialize;
		function GetValues(i1,i2: integer): TValue;
		function Information : TVariableInformation;
	end;

	TVariables = class
	private
		FVariables : TList;
	public
		constructor Create;
		destructor Destroy; override;

		procedure Add(ANombre, AValorPorDefecto: String; AFilas, AColumnas : Integer; ATipo : TTypeNumber); overload;
		procedure Add(AInfoVariable : TVariableInformation); overload;
		procedure Remove(ANombre: String); overload;
		procedure Remove(Index: Integer); overload;
		procedure Clean;

		procedure Initialize;

		function Variable(S : String): TVariable; overload;
		function Variable(Index : Integer): TVariable; overload;
		function IsVariable(S: String): Boolean;

		function Parse(AExpresion: String): TValue;

		function Count : Integer;

		procedure Modify(Index: Integer; AName, ADefualtValue: String;
			ARows,AColumns: Integer; ATypeNumber: Integer);

		procedure Assign(AExpresion : String; AValor: TValue); overload;
	end;

var
	Variables : TVariables;

const
  DEFAULT_VARIABLE_INFORMATION : TVariableInformation = (
    Name : ''; DefaultValue : '';Rows : 1; Columns : 1; TypeNumber : 0;
  );

implementation

uses UEsTipo, UExtractores, UAnalizadores, UConstantes;

{ TVariables }

function TVariables.Count: Integer;
begin
  Result := FVariables.Count;
end;

constructor TVariables.Create;
begin
	FVariables := TList.Create;
end;

procedure TVariables.Remove(ANombre: String);
var
	j : integer;
  LVariable : TVariable;
begin
	for j := FVariables.Count-1 downto 0 do
  begin
    LVariable := TVariable(FVariables.Items[j]);
		if LVariable.Name = ANombre  then
		begin
			Remove(j);
			Break;
		end;
  end;
end;

procedure TVariables.Remove(Index: Integer);
var
  LVariable : TVariable;
begin
  LVariable := FVariables.Items[Index];
  LVariable.Free;
  FVariables.Delete(Index);
end;

procedure TVariables.Clean;
begin
	while FVariables.Count>0 do
		Remove(0);
end;

destructor TVariables.destroy;
begin
	Clean;
	inherited;
end;

function TVariables.IsVariable(S: String): Boolean;
var
	j : integer;
  LVariable : TVariable;
begin
	Result := False;
	for j := 0 to FVariables.Count-1 do
	begin
    LVariable := FVariables.Items[j];
		if UpperCase(LVariable.Name) = UpperCase(S) then
		begin
			Result := True;
			Break;
		end;
	end;
end;

procedure TVariables.Add(ANombre, AValorPorDefecto: String; AFilas,
	AColumnas : Integer; ATipo : TTypeNumber);
var
  LVariable : TVariable;
begin
  LVariable := TVariable.Create;
	FVariables.Add(LVariable);
	with LVariable do
	begin
		Name := ANombre;
    ValorPorDefecto := AValorPorDefecto;
    TypeNumber := ATipo;
    Rows := AFilas;
    Columns := AColumnas;
	end;
end;

function TVariables.Variable(S: String): TVariable;
var
	j : integer;
  LVariable : TVariable;
begin
  Result := Nil;
	for j := 0 to FVariables.Count-1 do
	begin
    LVariable := FVariables.Items[j];
		if UpperCase(LVariable.Name) = UpperCase(S) then
		begin
			Result := FVariables[j];
			Break;
		end;
	end;
end;

function TVariables.Variable(Index: Integer): TVariable;
begin
	Result := FVariables[Index];
end;

procedure TVariables.Initialize;
var
  j : Integer;
  LVariable : TVariable;
begin
  for j := 0 to FVariables.Count-1 do
  begin
    LVariable := FVariables.Items[j];
    LVariable.Initialize;
  end;
end;

procedure TVariables.Modify(Index: Integer; AName,
  ADefualtValue: String; ARows,AColumns : Integer; ATypeNumber: Integer);
var
  LVariable : TVariable;
begin
  LVariable := FVariables.Items[Index];
  with LVariable do
  begin
    Name := AName;
    ValorPorDefecto := ADefualtValue;
		TypeNumber := ATypeNumber;
		Rows := ARows;
		Columns := AColumns;
	end;
end;

procedure TVariables.Add(AInfoVariable: TVariableInformation);
begin
	with AInfoVariable do
		Self.Add(Name,DefaultValue,Rows,Columns,TypeNumber);
end;

function TVariables.Parse(AExpresion: String): TValue;
var
	LIndex1,LIndex2 : Integer;
	i : String;
	LExpresion1,LExpresion2: String;
	LValorIndex1, LValorIndex2 : TValue;
	LVariable : TVariable;
begin
	LIndex1 := 0; LIndex2 := 0;
	i := TExtractors.ExtractIdentifier(AExpresion);
	if not IsVariable(i) then
		raise Exception.Create('Sintax error!' + ' ' +' Unknown identifier.');

	LVariable := Variables.Variable(i);
	if AExpresion<>'' then
	begin
		if AExpresion[1]='(' then
		begin
			delete(AExpresion,1,1);
			LExpresion1 := TExtractors.ExtractExpression(AExpresion);
			try
				LValorIndex1 := TAnalyzers.Expression(LExpresion1);
				if LValorIndex1.ValueType <> nInt32 then
					raise Exception.Create('Sintax error!' + ' ' +' Integer number expected.');
				LIndex1 := PInteger32(LValorIndex1.ValuePointer)^;
			finally
				TValues.FreeValue(LValorIndex1);
			end;

			if (AExpresion[1]=')')and(AExpresion[1]<>SEPARATOR) then
				LIndex2 := 0
			else if AExpresion[1]=SEPARATOR then
			begin
				Delete(AExpresion,1,1);
				LExpresion2 := TExtractors.ExtractExpression(AExpresion);
				if AExpresion[1]<>')' then
					Raise Exception.Create('Sintax error!' + ' ' +' ")" expected.');

				try
					LValorIndex2 := TAnalyzers.Expression(LExpresion2);
					if LValorIndex2.ValueType <> nInt32 then
						raise Exception.Create('Sintax error!' + ' ' +' Integer number expected.');
					LIndex2 := PInteger32(LValorIndex2.ValuePointer)^;
				finally
					TValues.FreeValue(LValorIndex2);
				end;
			end
			else if AExpresion[1]<>SEPARATOR then
				raise Exception.Create(Format('Sintax error!' + ' ' +' "%s" expected.',[SEPARATOR]));
		end;
	end;

	Result := LVariable.GetValues(LIndex1,LIndex2);
end;

procedure TVariables.Assign(AExpresion: String; AValor: TValue);
var
	LIndex1,LIndex2 : Integer;
	i : String;
	LExpresion1,LExpresion2: String;
	LValorIndex1, LValorIndex2 : TValue;
	LVariable : TVariable;
	LValor : TValue; // Este no se debe liberar.
begin
	LIndex1 := 0; LIndex2 := 0;
	i := TExtractors.ExtractIdentifier(AExpresion);
	if not IsVariable(i) then
		raise Exception.Create('Sintax error!' + ' ' +' Unknown identifier.');

	LVariable := Variables.Variable(i);
	if AExpresion<>'' then
	begin
		if AExpresion[1]='(' then
		begin
			delete(AExpresion,1,1);
			LExpresion1 := TExtractors.ExtractExpression(AExpresion);
			try
				LValorIndex1 := TAnalyzers.Expression(LExpresion1);
				if LValorIndex1.ValueType <> nInt32 then
					raise Exception.Create('Sintax error!' + ' ' +' Integer number expected.');
				LIndex1 := PInteger32(LValorIndex1.ValuePointer)^;
			finally
				TValues.FreeValue(LValorIndex1);
			end;

			if (AExpresion[1]=')')and(AExpresion[1]<>SEPARATOR) then
				LIndex2 := 0
			else if AExpresion[1]=SEPARATOR then
			begin
				Delete(AExpresion,1,1);
				LExpresion2 := TExtractors.ExtractExpression(AExpresion);
				if AExpresion[1]<>')' then
					Raise Exception.Create('Sintax error!' + ' ' +' ")" expected.');

				try
					LValorIndex2 := TAnalyzers.Expression(LExpresion2);
					if LValorIndex2.ValueType <> nInt32 then
						raise Exception.Create('Sintax error!' + ' ' +' Integer number expected.');
					LIndex2 := PInteger32(LValorIndex2.ValuePointer)^;
				finally
					TValues.FreeValue(LValorIndex2);
				end;
			end;
		end;
	end;

	if LVariable.TypeNumber = nString then
		LValor := LVariable.PrivateGetValues(LIndex1,0) // Esto evita la devolucion de un char
	else
		LValor := LVariable.PrivateGetValues(LIndex1,LIndex2);


	if (LValor.ValueType = nInt32)and(AValor.ValueType=nInt32) then
		PInteger32(LValor.ValuePointer)^ := PInteger32(AValor.ValuePointer)^
	else if (LValor.ValueType = nExte)and(AValor.ValueType = nInt32) then
		PExte(LValor.ValuePointer)^ := PInteger32(AValor.ValuePointer)^
	else if (LValor.ValueType= nExte)and(AValor.ValueType=nExte) then
		PExte(LValor.ValuePointer)^ := PExte(AValor.ValuePointer)^
	else if (AValor.ValueType=nString)and(AValor.ValueType=nString) then
	begin
		if Lindex2 = 0 then
			PString(LValor.ValuePointer)^ := PString(AValor.ValuePointer)^
		else
			PString(LValor.ValuePointer)^[Lindex2] := PString(AValor.ValuePointer)^[1];
	end
	else
		raise Exception.Create('Sintax error!' + ' ' +' Types missmatch.');
end;

{ TVariable }

constructor TVariable.Create;
begin
	Rows := 0;
	Columns := 0;
	inherited;
end;

destructor TVariable.Destroy;
var
  j,k: integer;
begin
  for j := 0 to Rows-1 do
    for k := 0 to Columns-1 do
      if FPointers[j,k]<> Nil then
        FreeMem(FPointers[j,k]);
  inherited;
end;

function TVariable.GetRows: Integer;
begin
  Result := Length(FPointers);
end;

function TVariable.GetColumns: Integer;
begin
	if Length(FPointers)>0 then
		Result := Length(FPointers[0])
	else
		Result := 0;
end;

function TVariable.Information: TVariableInformation;
begin
  Result.Name := Name;
  Result.DefaultValue := ValorPorDefecto;
  Result.Rows := Rows;
  Result.Columns := Columns;
  Result.TypeNumber := TypeNumber;
end;

procedure TVariable.Initialize;
var
  j,k: integer;
	LValor1,LValor2 : TValue;
begin
	try
		LValor1 := TValues.Parse(ValorPorDefecto);
		for j := 0 to Rows-1 do
			for k := 0 to Columns-1 do
			begin
				LValor2.ValueType := Self.FTypeNumber;
				LValor2.ValuePointer := FPointers[j,k];
				TValues.Assign(LValor2,LValor1);
			end;
	finally
		TValues.FreeValue(LValor1);
	end;
end;

procedure TVariable.SetRows(const Value: Integer);
var
  j,k: integer;
  LDim : integer;
begin
  if Value < Rows then
  begin
    for j := Value downto Rows-1 do
			for k := 0 to Columns-1 do
      begin
        FreeMem(FPointers[j,k]);
        FPointers[j,k] := nil;
      end;
    SetLength(FPointers,Value);
  end
  else if Value > Rows then
  begin
    LDim := Rows;
    SetLength(FPointers,Value);
    for j := LDim to Value-1 do
    begin
      SetLength(FPointers[j],Columns);
      for k := 0 to Columns-1 do
      begin
        GetMem(FPointers[j,k], TTypes.SizeOfType(FTypeNumber));

        case TypeNumber of
          nInt32 : PInteger32(FPointers[j,k])^ := 0;
          nExte : PExte(FPointers[j,k])^ := 0.0;
          nString : PString(FPointers[j,k])^ := '';
        end;
      end;
    end;
  end;
end;

procedure TVariable.SetColumns(const Value: Integer);
var
  j,k: integer;
  LDim : integer;
begin
  if Value < Columns then
  begin
    for j := 0 to Rows-1 do
    begin
      for k := Columns-1 to Value do
      begin
        FreeMem(FPointers[j,k]);
        FPointers[j,k] := nil;
      end;
      SetLength(FPointers[j],Value);
    end;
  end
  else if Value > Columns then
  begin
    LDim := Columns;
    for j := 0 to Rows-1 do
    begin
      SetLength(FPointers[j],Value);
      for k := LDim to Value-1 do
      begin
        GetMem(FPointers[j,k], TTypes.SizeOfType(FTypeNumber));

        case TypeNumber of
          nInt32 : PInteger32(FPointers[j,k])^ := 0;
          nExte : PExte(FPointers[j,k])^ := 0.0;
          nString : PString(FPointers[j,k])^ := '';
        end;
      end;
    end;
  end;
end;

procedure TVariable.SetTypeNumber(const Value: integer);
var
  j,k: integer;
begin
  if FTypeNumber <> Value then
  begin
    for j := 0 to Rows-1 do
      for k := 0 to Columns-1 do
      begin
        FreeMem(FPointers[j,k]);
        GetMem(FPointers[j,k], TTypes.SizeOfType(FTypeNumber));
        case Value of
          nInt32 : PInteger32(FPointers[j,k])^ := 0;
          nExte : PExte(FPointers[j,k])^ := 0.0;
          nString : PString(FPointers[j,k])^ := '';
        end;
      end;
    FTypeNumber := Value;
  end;

end;

function TVariable.GetValues(i1, i2: integer): TValue;
begin
	if (i1<0)or(i1>Rows-1) then
		Raise Exception.Create('Row index out of range!');
	if Self.TypeNumber = nString then
	begin
		if Length(PString(FPointers[i1,0])^)< i2 then
			Raise Exception.Create('Character index out of range!');
	end
	else if (i2<0)or(i2>Columns-1) then
		Raise Exception.Create('Column index out of range!');

	Result := DEFAULT_VALUE;
	TValues.SetValueType(Result,TypeNumber);
	case TypeNumber of
		nInt32 : PInteger32(Result.ValuePointer)^ := PInteger32(FPointers[i1,i2])^;
		nString :
			begin
				if i2 = 0 then
					PString(Result.ValuePointer)^ := PString(FPointers[i1,i2])^
				else
					PString(Result.ValuePointer)^ := PString(FPointers[i1,0])^[i2];
			end;
		nExte : PExte(Result.ValuePointer)^ := PExte(FPointers[i1,i2])^;
	else
		raise Exception.Create('Type not supported!');
	end;
end;

function TVariable.PrivateGetValues(i1, i2: integer): TValue;
begin
	if (i1<0)or(i1>Rows-1) then
		Raise Exception.Create('Row index out of range!');
	if Self.TypeNumber = nString then
	begin
		if Length(PString(FPointers[i1,0])^)< i2 then
			Raise Exception.Create('Character index out of range!');
	end
	else if (i2<0)or(i2>Columns-1) then
		Raise Exception.Create('Column index out of range!');
	Result.ValueType := TypeNumber;
	Result.ValuePointer := FPointers[i1,i2];
end;

initialization
	Variables := TVariables.Create;

finalization
	Variables.Free;

end.

