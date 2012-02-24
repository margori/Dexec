unit UAnalizadores;

interface

uses UVariables, UValores;

type
  TAnalizadores = class
    class procedure Sentencia(S: String);
    class function Expresion(S: String): TValor;
    class function Operando(S: String): TValor;
    class function Condicion(S: String): Boolean;
  end;

implementation

uses SysUtils, UTipos,
  UProcedimientos, UFunciones, UExtractores, UOperadores;

class function TAnalizadores.Operando(S: String): TValor;
var
  i,p : string;
begin
  if S<>'' then
    if (S[1]='(') and (S[Length(S)]=')') then
    begin
      S := Copy(S,2,Length(S)-2);
      Result := Expresion(S);
    end
    else
    begin
      i := TExtractores.ExtraerIdentificador(S);
      if Variables.EsVariable(i) then
      begin
        p := TExtractores.ExtraerExpresion(s);
				Result := Variables.Valor(i+p);
      end
      else if Funciones.EsFuncion(i) then
      begin
        p := TExtractores.ExtraerParametros(s);
				Result := Funciones.Funcion(i).Valor(p);
      end
      else
        Result := TValores.StringAValor(i+s);
    end;
end;

class procedure TAnalizadores.Sentencia(S: String);
var
	i : string;
	p : string;
	LValor : TValor;
begin
	i := Uppercase(TExtractores.ExtraerIdentificador(s));
	if Variables.EsVariable(i) then
	begin
//		LVariable := Variables.Variable(i);

		p := TExtractores.ExtraerExpresion(s);

		if Copy(s,1,2)<>':=' then
			raise Exception.Create('Sintax error!' + ' ' + '":=" expected.');

		delete(s,1,2);
		s := trim(s);
		try
			LValor := Expresion(S);
			Variables.Asignar(i+p,LValor);
		finally
			TValores.FreeValor(LValor);
		end;
	end
	else if Procedimientos.EsProcedimiento(i) then
	begin
		p := TExtractores.ExtraerParametros(s);
		Procedimientos.Procedimiento(i).Valor(p);
	end
	else
			raise Exception.Create('Sintax error!' + ' ' + 'Unknown identifier.');
end;

class function TAnalizadores.Expresion(S: String): TValor;
var
	Operando1, Operando2,OperandoAux : string;
	Valor1, Valor2, Valor3: TValor;
	Operador1,Operador2: String;
	Operador1N,Operador2N : integer;
begin
	S := Trim(s);
	Valor1 := VALOR_VACIO;
	Valor2 := VALOR_VACIO;

	Operando1 := '';
	Operando2 := '';
	OperandoAux := '';

	Operando1 := TExtractores.ExtraerOperando(S);

	try
		if Operando1<>'' then
			Valor1 := Operando(Operando1);
		Operador1 := TExtractores.ExtraerOperador(S);
		if Operador1<>'' then
		begin
			if (Valor1.Tipo = nIndef) and Not EsOperadorUnario(Operador1) then
				raise Exception.Create('Sintax error!' + ' ' +'Unary operator expected.');

			repeat
				Operando2 := TExtractores.ExtraerOperando(S);

				Operador2 := TExtractores.ExtraerOperador(S);

				if Operando2='' then
				begin
					if Not EsOperadorUnario(Operador2) then
						raise Exception.Create('Sintax error!' + ' ' +'Operator expected.');
					if OperandoAux='' then
						OperandoAux := Operador2
					else
						OperandoAux := OperandoAux + ' '+ Operador2;
				end
				else if Operador2<>'' then
				begin
					if OperandoAux='' then
						OperandoAux := Operando2
					else
						OperandoAux := OperandoAux + ' '+ Operando2;

					Operador1N := OperadorNivel(Operador1);
					Operador2N := OperadorNivel(Operador2);

					if Operador1N>=Operador2N then
					begin
						Valor2 := Expresion(OperandoAux);
						Valor3 := Evaluar(Operador1,Valor1,Valor2);
						TValores.FreeValor(Valor1);
						TValores.FreeValor(Valor2);
						Valor1 := Valor3;
						Operador1 := Operador2;
						OperandoAux:= '';
					end
					else
					begin
						OperandoAux := OperandoAux+ ' ' + Operador2;
					end;
				end
				else
				begin
					if OperandoAux='' then
						OperandoAux := Operando2
					else
						OperandoAux := OperandoAux + ' '+ Operando2;
					Valor2 := Expresion(OperandoAux);
					Valor3 := Evaluar(Operador1,Valor1,Valor2);
					TValores.FreeValor(Valor1);
					TValores.FreeValor(Valor2);
					Valor1 := Valor3;
					Operador1 := Operador2;
					OperandoAux:= '';
				end;
			until Operador2='';
		end;

		Result := TValores.CopiarValor(Valor1);
	finally
		TValores.FreeValor(Valor1);
		TValores.FreeValor(Valor2);
	end;
end;

class function TAnalizadores.Condicion(S: String): Boolean;
var
	LValor : TValor;
begin
	try
		LValor := Expresion(S);
		Result := PInt32(LValor.Puntero)^ <> 0;
	finally
		TValores.FreeValor(LValor);
	end;
end;

end.
