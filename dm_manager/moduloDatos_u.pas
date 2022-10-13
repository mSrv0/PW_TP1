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
    procedure begin_transaction;
    procedure commit_transaction;
    procedure rollback_transaction;

    procedure actualizarFDQ(fdq: TFDQuery);
    function inicializarFDQ: TFDQuery;
    procedure liberarFDQ(fdq: TFDQuery);

  end; //type DataModule1

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

procedure TDataModule1.begin_transaction;
begin
   Conexion.StartTransaction
end;

procedure TDataModule1.commit_transaction;
begin
   Conexion.Commit
end;

procedure TDataModule1.rollback_transaction;
begin
   Conexion.Rollback
end;

procedure TDataModule1.actualizarFDQ(fdq: TFDQuery);
begin
   fdq.Close;
   try
      fdq.Open;
   except
      on e: Exception do
      begin
      fdq.Active:= False;
      raise Exception.Create('Error en la consulta: ' + sLineBreak + e.Message)
      end
   end //try except
end;

function TDataModule1.inicializarFDQ: TFDQuery;
begin
   Result:= TFDQuery.Create(Nil);
   Result.ConnectionName:= Conexion.ConnectionName;
end;

procedure TDataModule1.liberarFDQ(fdq: TFDQuery);
begin
   try
      fdq.Close;
      fdq.Free;
   except
   end
end;

end.
