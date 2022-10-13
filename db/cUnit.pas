unit cUnit;

interface

uses System.SysUtils, System.DateUtils, FireDAC.Comp.Client,
     FireDAC.Comp.DataSet, System.Classes, System.Notification,
     System.IOUtils, FMX.Dialogs, Data.DB, System.Generics.Collections;

type
  TClientes = class(TObject)
  private
    Cid: Integer;
    CrazonSocial: String;
    Cdomicilio: String;
    Clocalidad: String;
    Ctelefono: Integer;
    Cemail: String;
    CActionsList: TObjectList<TObject>;
    function getId: Integer;
    function getRazonSocial: String;
    function getDomicilio: String;
    function getLocalidad: String;
    function getTelefono: Integer;
    function getEmail: String;
  protected
    destructor Destroy;
  public
    constructor Create;
    procedure load(const idArt: integer);
    function asString: string;
  published
    property Id: integer read getId;
    property RazonSocial: string read getRazonSocial;
    property Domicilio: string read getDomicilio;
    property Localidad: string read getLocalidad;
    property Telefono: integer read getTelefono;
    property Email: string read getEmail;
end;



implementation

uses moduloDatos_u;



{ TClientes }

function TClientes.asString: string;
begin

end;

constructor TClientes.Create;
begin
  inherited;
  CActionsList:= TObjectList<TObject>.Create
end;

destructor TClientes.Destroy;
begin
  inherited;
  CActionsList.Free;
end;

function TClientes.getDomicilio: String;
begin
   Result:= Cdomicilio;
end;

function TClientes.getEmail: String;
begin
  Result:= Cemail;
end;

function TClientes.getId: Integer;
begin
  Result:= Cid;
end;

function TClientes.getLocalidad: String;
begin
  Result:= Clocalidad;
end;

function TClientes.getRazonSocial: String;
begin
  Result:= CrazonSocial;
end;

function TClientes.getTelefono: Integer;
begin
  Result:= Ctelefono;
end;

procedure TClientes.load(const idArt: integer);
var fdqC: TFDQuery;
begin
  fdqC:= DataModule1.inicializarFDQ;
  fdqC.SQL.Add('Select * from clientes where (id:= idC)');
  fdqC.ParamByName('idC').AsInteger:= Cid;
  DataModule1.actualizarFDQ(fdqC);

  // Inicia carga de los datos de clientes

  Cid:= fdqC.FieldByName('id').AsInteger;
  CrazonSocial:= fdqC.FieldByName('RazonSocial').AsString;
  Cdomicilio:= fdqC.FieldByName('domicilio').AsString;
  Clocalidad:= fdqC.FieldByName('localidad').AsString;
  Ctelefono:= fdqC.FieldByName('telefono').AsInteger;
  Cemail:= fdqC.FieldByName('email').AsString;
end;

end.
