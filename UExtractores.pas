unit UExtractores;

interface

type
  TExtractors = class
    class function ExtractOperand(var S: String): String;
    class function ExtractOperator(var S: string): String;
    class function ExtractParameters(var S: String): String;
    class function ExtractIdentifier(var S: String): String;
    class function ExtractExpression(var S : String): String;
  end;

implementation

uses UConstantes, Sysutils, UOperadores;

class function TExtractors.ExtractOperand(var S: String): String;
var
	LControl : string;
begin
	Result := '';
	while S<>'' do
	begin
		if S[1] = '"' then
		begin
			if Copy(LControl,Length(LControl),1) <> '"' then
				LControl := LControl + '""';
		end else if (S[1] = '(')and((LControl='') or (Copy(LControl,Length(LControl),1) <> '"')) then
			LControl := LControl + '(';

		if (s[1] in ALLOWED_CHARS)or(LControl<>'') then
    		begin
			Result := Result + S[1];

			if (S[1] = '"')and (Copy(LControl,Length(LControl),1) = '"') then
        			LControl := copy(LControl,1,Length(LControl)-1)
      			else if (S[1] = ')')and (Copy(LControl,Length(LControl),1) = '(') then
        			LControl := Copy(LControl,1,Length(LControl)-1);
    			end
		else
			Break;

    		Delete(s,1,1);
	end;

  	if LControl<>'' then
		raise Exception.Create('Sintax error!');

  	if IsOperator(Result) then
  	begin
    		S := Result + S;
    		Result := '';
	end
	else
    		S := Trim(S);
end;

class function TExtractors.ExtractOperator(var S: string): String;
var
	j : integer;
begin
  s := trim(s);
  Result := '';
  for j := Low(Operators) to High(Operators) do
  begin
    if Copy(s,1,Length(Operators[j].OperatorString))=Operators[j].OperatorString then
    begin
      Result := Operators[j].OperatorString;
      delete(s,1,Length(Operators[j].OperatorString));
      s := trim(s);
      break;
    end;
  end;

end;

class function TExtractors.ExtractIdentifier(var S: String): String;
var j: integer;
begin
	S := trim(S);
	result := '';
	for j := 1 to Length(S) do
	begin
		if (Result = '') and ((S[j] in LETTERS)) then
			Result := Result + S[j]
		else if (Result <> '') and ((S[j] in LETTERS) or (S[j] in DIGITS) or
			(S[j] in ALLOWED_CHARS)) then
			Result := Result + S[j]
		else
			Break;
	end;
  S := Trim(Copy(S,Length(Result)+1,Length(S)));
end;

class function TExtractors.ExtractParameters(var S: String): String;
var
  e : String;
begin
  if S = '' then
    Result := #10#13
  else if S[1] <> '(' then
		raise Exception.Create('Parameter error!')
	else
	begin
		Delete(s,1,1);
		Result := '';
		repeat
			e := ExtractExpression(s);
			Result := Result + e + #10#13;

			if (S[1]= SEPARATOR) then
				Delete(S,1,1)
			else if (S[1]<>')') then
        raise Exception.Create('Sintax error! ";" o ")" missed.');
    until S[1] = ')';
    delete(s,1,1);
  end;

end;

class function TExtractors.ExtractExpression(var S : String): String;
var
  LOperand : string;
  LOperator : string;
  LReady : Boolean;
begin
  Result := '';
  LReady := false;
  repeat
    LOperator := ExtractOperator(S);
    if (LOperator<>'') then
      if IsUnaryOperator(LOperator) then
        Result := Result + ' ' + LOperator
      else
      begin
        S := Result + S;
        Result := '';
        Break;
      end;

    LOperand := ExtractOperand(S);
    if LOperand='' then
    begin
      S := Result + S;
      Result := '';
      break;
    end;

    if Result = '' then
      Result := LOperand
    else
      Result := Result + ' ' + LOperand;

    LOperator := ExtractOperator(S);
    if LOperator<>'' then
    begin
      Result := Result + ' ' + LOperator;
      LReady := False;
    end else
      LReady := True;
  until LReady;
end;

end.
