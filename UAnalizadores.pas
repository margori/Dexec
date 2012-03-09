unit UAnalizadores;

interface

uses UVariables, UValores;

type
  TAnalyzers = class
    class procedure Sentence(S: String);
    class function Expression(S: String): TValue;
    class function Operand(S: String): TValue;
    class function Condition(S: String): Boolean;
  end;

implementation

uses SysUtils, UTipos,
  UProcedimientos, UFunciones, UExtractores, UOperadores;

class function TAnalyzers.Operand(S: String): TValue;
var
  i,p : string;
begin
  if S<>'' then
    if (S[1]='(') and (S[Length(S)]=')') then
    begin
      S := Copy(S,2,Length(S)-2);
      Result := Expression(S);
    end
    else
    begin
      i := TExtractors.ExtractIdentifier(S);
      if Variables.IsVariable(i) then
      begin
        p := TExtractors.ExtractExpression(s);
				Result := Variables.Parse(i+p);
      end
      else if Functions.IsFunction(i) then
      begin
        p := TExtractors.ExtractParameters(s);
				Result := Functions.GetFunction(i).FunctionPointer(p);
      end
      else
        Result := TValues.Parse(i+s);
    end;
end;

class procedure TAnalyzers.Sentence(S: String);
var
	i : string;
	p : string;
	LValue : TValue;
begin
	i := Uppercase(TExtractors.ExtractIdentifier(s));
	if Variables.IsVariable(i) then
	begin
//		LVariable := Variables.Variable(i);

		p := TExtractors.ExtractExpression(s);

		if Copy(s,1,2)<>':=' then
			raise Exception.Create('Sintax error!' + ' ' + '":=" expected.');

		delete(s,1,2);
		s := trim(s);
		try
			LValue := Expression(S);
			Variables.Assign(i+p,LValue);
		finally
			TValues.FreeValue(LValue);
		end;
	end
	else if Procedures.IsProcedure(i) then
	begin
		p := TExtractors.ExtractParameters(s);
		Procedures.GetProcedure(i).ProcedurePointer(p);
	end
	else
			raise Exception.Create('Sintax error!' + ' ' + 'Unknown identifier.');
end;

class function TAnalyzers.Expression(S: String): TValue;
var
	LOperand1, LOperand2,LAuxiliarOperand : string;
	LValue1, LValue2, LValue3: TValue;
	LOperator1,LOperator2: String;
	LOperatorLevel1,LOperatorLevel2 : integer;
begin
	S := Trim(s);
	LValue1 := DEFAULT_VALUE;
	LValue2 := DEFAULT_VALUE;

	LOperand1 := '';
	LOperand2 := '';
	LAuxiliarOperand := '';

	LOperand1 := TExtractors.ExtractOperand(S);

	try
		if LOperand1<>'' then
			LValue1 := Operand(LOperand1);
		LOperator1 := TExtractors.ExtractOperator(S);
		if LOperator1<>'' then
		begin
			if (LValue1.ValueType = nIndef) and Not IsUnaryOperator(LOperator1) then
				raise Exception.Create('Sintax error!' + ' ' +'Unary operator expected.');

			repeat
				LOperand2 := TExtractors.ExtractOperand(S);

				LOperator2 := TExtractors.ExtractOperator(S);

				if LOperand2='' then
				begin
					if Not IsUnaryOperator(LOperator2) then
						raise Exception.Create('Sintax error!' + ' ' +'Operator expected.');
					if LAuxiliarOperand='' then
						LAuxiliarOperand := LOperator2
					else
						LAuxiliarOperand := LAuxiliarOperand + ' '+ LOperator2;
				end
				else if LOperator2<>'' then
				begin
					if LAuxiliarOperand='' then
						LAuxiliarOperand := LOperand2
					else
						LAuxiliarOperand := LAuxiliarOperand + ' '+ LOperand2;

					LOperatorLevel1 := GetOperatorLevel(LOperator1);
					LOperatorLevel2 := GetOperatorLevel(LOperator2);

					if LOperatorLevel1>=LOperatorLevel2 then
					begin
						LValue2 := Expression(LAuxiliarOperand);
						LValue3 := Evaluate(LOperator1,LValue1,LValue2);
						TValues.FreeValue(LValue1);
						TValues.FreeValue(LValue2);
						LValue1 := LValue3;
						LOperator1 := LOperator2;
						LAuxiliarOperand:= '';
					end
					else
					begin
						LAuxiliarOperand := LAuxiliarOperand+ ' ' + LOperator2;
					end;
				end
				else
				begin
					if LAuxiliarOperand='' then
						LAuxiliarOperand := LOperand2
					else
						LAuxiliarOperand := LAuxiliarOperand + ' '+ LOperand2;
					LValue2 := Expression(LAuxiliarOperand);
					LValue3 := Evaluate(LOperator1,LValue1,LValue2);
					TValues.FreeValue(LValue1);
					TValues.FreeValue(LValue2);
					LValue1 := LValue3;
					LOperator1 := LOperator2;
					LAuxiliarOperand:= '';
				end;
			until LOperator2='';
		end;

		Result := TValues.Clone(LValue1);
	finally
		TValues.FreeValue(LValue1);
		TValues.FreeValue(LValue2);
	end;
end;

class function TAnalyzers.Condition(S: String): Boolean;
var
	LValue : TValue;
begin
	try
		LValue := Expression(S);
		Result := PInteger32(LValue.ValuePointer)^ <> 0;
	finally
		TValues.FreeValue(LValue);
	end;
end;

end.
