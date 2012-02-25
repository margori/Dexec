program Dexec;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms,
  UObjetos in 'UObjetos.pas',
  UUtiles in 'UUtiles.pas',
  UAnalizadores in 'UAnalizadores.pas',
  UTipos in 'UTipos.pas',
  UConstantes in 'UConstantes.pas',
  UVariables in 'UVariables.pas',
  UEsTipo in 'UEsTipo.pas',
  UValores in 'UValores.pas',
  UProcedimientos in 'UProcedimientos.pas',
  UFunciones in 'UFunciones.pas',
  UExtractores in 'UExtractores.pas',
  UOperadores in 'UOperadores.pas',
  UArchivos in 'UArchivos.pas',
  UFormCrt in 'Formularios/UFormCrt.pas' {formCrt},
  UFormMain in 'Formularios/UFormMain.pas' {FormMain},
  UFormPropiedades in 'Formularios/UFormPropiedades.pas' {FormPropiedades},
  UFormPropiedadesVariables in 'Formularios/UFormPropiedadesVariables.pas' {formPropiedadesVariables},
  UFormPropiedadesArchivos in 'Formularios/UFormPropiedadesArchivos.pas' {formPropiedadesArchivos},
  UFormAcercaDe in 'Formularios/UFormAcercaDe.pas' {formAcercade},
  UFormPropiedadesSalida in 'Formularios/UFormPropiedadesSalida.pas' {formPropiedadesSalida},
  UValidadores in 'UValidadores.pas',
  UConfiguracion in 'UConfiguracion.pas';

{$R *.res}
begin
  Application.Initialize;
  Application.Title := 'Dexec';
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TformCrt, formCrt);
  Application.CreateForm(TFormPropiedades, FormPropiedades);
  Application.CreateForm(TformPropiedadesVariables, formPropiedadesVariables);
  Application.CreateForm(TformPropiedadesArchivos, formPropiedadesArchivos);
  Application.CreateForm(TformAcercade, formAcercade);
  Application.CreateForm(TformPropiedadesSalida, formPropiedadesSalida);
  Application.Run;
end.

