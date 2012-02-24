unit UFormSplash;

interface

uses
	Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TformSplash = class(TForm)
    Bevel1: TBevel;
    Label2: TLabel;
    Image1: TImage;
    labelEdicion: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
	end;

var
  formSplash: TformSplash;

implementation

{$R *.dfm}

procedure TformSplash.FormCreate(Sender: TObject);
begin
	// TODO: Translate Components
{$IFDEF DEBUG}
	labelEdicion.Caption := 'Debug';
{$ENDIF}
end;

end.