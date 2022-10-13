object DataModule1: TDataModule1
  OnCreate = DataModuleCreate
  Height = 237
  Width = 389
  object Conexion: TFDConnection
    ConnectionName = 'Conexion'
    Params.Strings = (
      'Database=C:\PuenteWeb\PW_TP1\DataBase-Tienda\e-commerce.db'
      'LockingMode=Normal'
      'DriverID=sQLite')
    Connected = True
    LoginPrompt = False
    BeforeConnect = ConexionBeforeConnect
    Left = 80
    Top = 40
  end
  object FDPhysSQLiteDriverLink: TFDPhysSQLiteDriverLink
    Left = 192
    Top = 39
  end
end
