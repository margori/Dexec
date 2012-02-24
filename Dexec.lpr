program Dexec;

{$MODE Delphi}

uses
  Forms,
  SysUtils,
  Dialogs,
  Graphics,
  Interfaces,
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
  UFormSplash in 'Formularios/UFormSplash.pas' {formSplash},
  UConfiguracion in 'UConfiguracion.pas';

{$R *.res}
const
  ESPERA_RELEASE = 2;
var
  LInicio: TDateTime;
  LSegundos: integer;
begin
  LInicio := Now;

  Application.Initialize;

  formSplash := TformSplash.Create(Application);
  formSplash.Label2.Caption := '';
  formSplash.Show;
  Application.ProcessMessages;

  Application.Title := 'Dexec';
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TformCrt, formCrt);
  Application.CreateForm(TFormPropiedades, FormPropiedades);
  Application.CreateForm(TformPropiedadesVariables, formPropiedadesVariables);
  Application.CreateForm(TformPropiedadesArchivos, formPropiedadesArchivos);
  Application.CreateForm(TformAcercade, formAcercade);
  Application.CreateForm(TformPropiedadesSalida, formPropiedadesSalida);
  repeat
    LSegundos := Trunc((Now - LInicio) * 24 * 3600);
  until (LSegundos >= ESPERA_RELEASE);

  formSplash.Free;

  Application.Run;
end.

