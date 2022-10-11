unit moduloDatos_u;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.FMXUI.Wait, Data.DB,
  FireDAC.Comp.Client, System.IOUtils;

type
  TDataModule1 = class(TDataModule)
    Conexion: TFDConnection;
    FDPhysSQLiteDriverLink: TFDPhysSQLiteDriverLink;
    procedure ConexionBeforeConnect(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function nombre_de_la_conexion: string;
  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TDataModule1.ConexionBeforeConnect(Sender: TObject);
begin

   {IF DEFINED(IOS) OR DEFINED(ANDROID)}
      Conexion.Params.Values['Database']:= TPath.Combine(TPath.GetDocumentsPath, 'e-commerce.db');
   {ENDIF}

end;

procedure TDataModule1.DataModuleCreate(Sender: TObject);
var b : Boolean;
begin
 Conexion.Connected := True;
 b := Conexion.Connected;
end;

function TDataModule1.nombre_de_la_conexion: string;
begin
   Result:= Conexion.ConnectionName
end;

end.
