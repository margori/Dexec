unit UEsTipo;

interface

type
  TEsTipo = class
  public
    class function Entero(s : string): boolean;
    class function Real(s : string): boolean;
    class function Cadena(s : string): boolean;
    class function EsLogico(s : string): boolean;
  end;

implementation
uses Sysutils, UConstantes;

{ TEsTipo }

class function TEsTipo.Entero(s: string): boolean;
begin
	result := true;
	while length(s) > 0 do
	begin
		result := result and ((s[1] in ['0'..'9']) or (s[1] = '#')
			or (s[1] = '+') or (s[1] = '-'));
		delete(s, 1, 1);
	end;
end;

class function TEsTipo.EsLogico(s: string): boolean;
begin
	s := ansilowercase(s);
	result := (s = LogTrue) or (s = LogFalse);
end;

class function TEsTipo.Real(s: string): boolean;
begin
	result := true;
	while length(s) > 0 do
	begin
		result := result and ((s[1] in ['0'..'9']) or (s[1] = '.')
			or (s[1] = ',')or (s[1] = '#') or (s[1] = '-')or(s[1] = '+')
			or(upcase(s[1]) = 'E'));
		delete(s, 1, 1);
	end;
end;

class function TEsTipo.Cadena(s: string): boolean;
begin
  if Length(s)>=2 then
    result := (s[1] = '"') and (s[Length(s)] = '"')
  else
    Result := False;
end;

end.
