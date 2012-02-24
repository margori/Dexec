unit UFormAcercaDe;

interface

uses
	SysUtils, Variants, Classes, Graphics, Controls,
	Forms, Dialogs, StdCtrls, ExtCtrls;

type
  TformAcercade = class(TForm)
    imgLogo: TImage;
    imgNombre: TImage;
    labelVersion: TLabel;
    labelEdicion: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
		procedure FormCreate(Sender: TObject);
		procedure FormShow(Sender: TObject);
    procedure formClick(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);
	private
	public
		{ Public declarations }
  end;

var
  formAcercade: TformAcercade;

implementation

{$R *.dfm}

procedure TformAcercade.FormCreate(Sender: TObject);
begin
	// TODO: Translate Components;
end;

procedure TformAcercade.FormShow(Sender: TObject);
begin
	Self.Left := (Screen.Width - Self.Width) div 2;
	Self.Top := (Screen.Height - Self.Height) div 2;
end;

procedure TformAcercade.formClick(Sender: TObject);
begin
	Self.Close;
end;

procedure TformAcercade.Label3Click(Sender: TObject);
begin
	// TODO: Open Dexec website.
end;

procedure TformAcercade.Label4Click(Sender: TObject);
begin
	// TODO: Open Dexec website.
end;

end.