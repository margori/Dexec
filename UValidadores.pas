unit UValidadores;

interface

type
  TValidadores = class
    class function EsIdentificadorValido(S: String): Boolean;
  end;

implementation

uses UConstantes;

class function TValidadores.EsIdentificadorValido(S: String): Boolean;
var
  j : integer;
begin
  Result := True;
  if Length(S)=0 then
    Result := False
  else if not (S[1] in Letras) then
    Result := False
  else
  begin
    for j := 1 to Length(S) do
      if not(S[j] in IDENTIFICADORES) then
      begin
        Result := False;
        Break;
      end;
  end;
end;

end.