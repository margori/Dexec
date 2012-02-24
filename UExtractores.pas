unit UExtractores;

interface

type
  TExtractores = class
    class function ExtraerOperando(var S: String): String;
    class function ExtraerOperador(var S: string): String;
    class function ExtraerParametros(var S: String): String;
    class function ExtraerIdentificador(var S: String): String;
    class function ExtraerExpresion(var S : String): String;
  end;

implementation

uses UConstantes, Sysutils, UOperadores;

class function TExtractores.ExtraerOperando(var S: String): String;
var
	Control : string;
begin
	Result := '';
	while S<>'' do
	begin
		if S[1] = '"' then
		begin
			if Copy(Control,Length(Control),1) <> '"' then
				Control := Control + '""';
		end else if (S[1] = '(')and((Control='') or (Copy(Control,Length(Control),1) <> '"')) then
			Control := Control + '(';

		if (s[1] in Validos)or(Control<>'') then
    		begin
			Result := Result + S[1];

			if (S[1] = '"')and (Copy(Control,Length(Control),1) = '"') then
        			Control := copy(Control,1,Length(Control)-1)
      			else if (S[1] = ')')and (Copy(Control,Length(Control),1) = '(') then
        			Control := Copy(Control,1,Length(Control)-1);
    			end
		else
			Break;

    		Delete(s,1,1);
	end;

  	if Control<>'' then
		raise Exception.Create('Sintax error!');

  	if EsOperador(Result) then
  	begin
    		S := Result + S;
    		Result := '';
	end
	else
    		S := Trim(S);
end;

class function TExtractores.ExtraerOperador(var S: string): String;
var
	j : integer;
begin
  s := trim(s);
  Result := '';
  for j := Low(Operadores) to High(Operadores) do
  begin
    if Copy(s,1,Length(OPeradores[j].Cadena))=OPeradores[j].Cadena then
    begin
      Result := OPeradores[j].Cadena;
      delete(s,1,Length(OPeradores[j].Cadena));
      s := trim(s);
      break;
    end;
  end;

end;

class function TExtractores.ExtraerIdentificador(var S: String): String;
var j: integer;
begin
	S := trim(S);
	result := '';
	for j := 1 to Length(S) do
	begin
		if (Result = '') and ((S[j] in Letras)) then
			Result := Result + S[j]
		else if (Result <> '') and ((S[j] in Letras) or (S[j] in Digitos) or
			(S[j] in Validos)) then
			Result := Result + S[j]
		else
			Break;
	end;
  S := Trim(Copy(S,Length(Result)+1,Length(S)));
end;

class function TExtractores.ExtraerParametros(var S: String): String;
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
			e := ExtraerExpresion(s);
			Result := Result + e + #10#13;

			if (S[1]= SEPARADOR) then
				Delete(S,1,1)
			else if (S[1]<>')') then
        raise Exception.Create('Sintax error! ";" o ")" missed.');
    until S[1] = ')';
    delete(s,1,1);
  end;

end;

class function TExtractores.ExtraerExpresion(var S : String): String;
var
  LOperando : string;
  LOperador : string;
  LListo : Boolean;
begin
  Result := '';
  LListo := false;
  repeat
    LOperador := ExtraerOperador(S);
    if (LOperador<>'') then
      if EsOperadorUnario(LOperador) then
        Result := Result + ' ' + LOperador
      else
      begin
        S := Result + S;
        Result := '';
        Break;
      end;

    LOperando := ExtraerOperando(S);
    if LOperando='' then
    begin
      S := Result + S;
      Result := '';
      break;
    end;

    if Result = '' then
      Result := LOperando
    else
      Result := Result + ' ' + LOperando;

    LOperador := ExtraerOperador(S);
    if LOperador<>'' then
    begin
      Result := Result + ' ' + LOperador;
      LListo := False;
    end else
      LListo := True;
  until LListo;
end;

end.