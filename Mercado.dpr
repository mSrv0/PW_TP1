program Mercado;



uses
  System.StartUpCopy,
  FMX.Forms,
  Frame.ClienteCard in 'Frames\Frame.ClienteCard.pas' {ClienteCard: TFrame},
  moduloDatos_u in 'dm_manager\moduloDatos_u.pas' {DataModule1: TDataModule},
  UnitLogin in 'login\UnitLogin.pas' {FLogin},
  logUnit in 'db\logUnit.pas',
  cUnit in 'db\cUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TFLogin, FLogin);
  Application.Run;
end.
