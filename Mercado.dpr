program Mercado;



uses
  System.StartUpCopy,
  FMX.Forms,
  moduloDatos_u in 'dm_manager\moduloDatos_u.pas' {DataModule1: TDataModule},
  UnitLogin in 'login\UnitLogin.pas' {FLogin};
{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TFLogin, FLogin);
  Application.Run;
end.
