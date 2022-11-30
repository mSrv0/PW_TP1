unit cUnit;

interface

uses System.SysUtils, System.DateUtils, FireDAC.Comp.Client,
     FireDAC.Comp.DataSet, System.Classes, System.Notification,
     System.IOUtils, System.JSON, FMX.Dialogs, Data.DB, System.Generics.Collections, REST.Json, REST.Types, REST.Response.Adapter, uJSON;

type
  TCliente = class(TObject)
  private
    Fid: Integer;
    FrazonSocial: String;
    Fdomicilio: String;
    Flocalidad: String;
    Ftelefono: string;
    Femail: String;
    FSOYJSON: Boolean;
    FActionsList: TObjectList<TObject>;
    function getId: Integer;
    function getRazonSocial: String;
    function getDomicilio: String;
    function getLocalidad: String;
    function getTelefono: string;
    function getEmail: String;
    procedure setRazonSocial(const Value: string);
    procedure setDomicilio(const Value: string);
    procedure setLocalidad(const Value: string);
    procedure setTelefono(const Value: string);
    procedure setEmail(const Value: string);

    procedure update;
    procedure updateApi;
    procedure insert;
    procedure insertApi;
    function load: Boolean;
    function loadApi: Boolean;
    procedure delete;
    procedure deleteApi;
  protected
    destructor Destroy;
  public
    constructor Create;
    function cargar(const idCli: integer; json: Boolean = False): Boolean;
    procedure guardar;
    procedure modificar;
    procedure eliminar;

    function asString: string;
  published
    property Id: integer read getId;
    property RazonSocial: string read getRazonSocial write setRazonSocial;
    property Domicilio: string read getDomicilio write setDomicilio;
    property Localidad: string read getLocalidad write setLocalidad;
    property Telefono: string read getTelefono write setTelefono;
    property Email: string read getEmail write setEmail;
end;


function listado_clientes: TObjectList<TCliente>;



implementation

uses moduloDatos_u, untLista;



function listado_clientes: TObjectList<TCliente>;
var cli: TCliente;
    fdq: TFDQuery;
begin
   //creo el listado de clientes
   Result:= TObjectList<TCliente>.Create;

   fdq:= DataModule1.inicializarFDQ;
   fdq.SQL.Add('Select id from clientes');
   DataModule1.actualizarFDQ(fdq);

   //recorro el fdq y cargo el listado de clientes
   while not (fdq.Eof) do
      begin
      cli:= TCliente.Create;
      cli.cargar(fdq.FieldByName('id').AsInteger);
      Result.Add(cli);
      fdq.Next
      end;

   DataModule1.liberarFDQ(fdq)
end;

{ TCliente }

function TCliente.asString: string;
begin
   Result:= RazonSocial
end;

function TCliente.cargar(const idCli: integer; json: Boolean = False): Boolean;
begin
   Fid:= idCli;
   FSOYJSON:= json;
   if (not FSOYJSON) then
      Result:= load
   else
      Result:= loadApi
end;

constructor TCliente.Create;
begin
  inherited;
  FActionsList:= TObjectList<TObject>.Create;
  FSOYJSON:= False
end;

procedure TCliente.delete;
var fdq: TFDQuery;
begin
   fdq:=DataModule1.inicializarFDQ;
   fdq.SQL.Add('Delete from clientes WHERE (id = :id)');
   fdq.ParamByName('id').AsInteger:= Fid;
   fdq.ExecSQL;
   DataModule1.liberarFDQ(fdq);
end;

procedure TCliente.deleteApi;
begin

end;

destructor TCliente.Destroy;
begin
  inherited;
  FActionsList.Free;
end;

procedure TCliente.eliminar;
begin
   delete
end;

function TCliente.getDomicilio: String;
begin
   Result:= Fdomicilio;
end;

function TCliente.getEmail: String;
begin
  Result:= Femail;
end;

function TCliente.getId: Integer;
begin
  Result:= Fid;
end;

function TCliente.getLocalidad: String;
begin
  Result:= Flocalidad;
end;

function TCliente.getRazonSocial: String;
begin
  Result:= FrazonSocial;
end;

function TCliente.getTelefono: string;
begin
  Result:= Ftelefono;
end;

procedure TCliente.guardar;
begin
   if (not FSOYJSON) then
      insert
   else
      insertApi
end;

procedure TCliente.insert;
var fdq: TFDQuery;
begin
   fdq:=DataModule1.inicializarFDQ;
   fdq.SQL.Add('Insert into clientes (domicilio, localidad, telefono, email)');
   fdq.SQL.Add('values (:domicilio, :localidad, :telefono, :email)');
   fdq.ParamByName('razon_social').AsString:= FrazonSocial;
   fdq.ParamByName('domicilio').AsString:= Fdomicilio;
   fdq.ParamByName('localidad').AsString:= Flocalidad;
   fdq.ParamByName('telefono').AsString:= Ftelefono;
   fdq.ParamByName('email').AsString:= Femail;
   fdq.ExecSQL;
   DataModule1.liberarFDQ(fdq);
end;

procedure TCliente.insertApi;
begin
//
end;

function TCliente.load: Boolean;
var fdqC: TFDQuery;
begin
  fdqC:= DataModule1.inicializarFDQ;
  fdqC.SQL.Add('Select * from clientes where (id = :idC)');
  fdqC.ParamByName('idC').AsInteger:= Fid;
  DataModule1.actualizarFDQ(fdqC);

  // Inicia carga de los datos de clientes
  FrazonSocial:= fdqC.FieldByName('razon_social').AsString;
  Fdomicilio:= fdqC.FieldByName('domicilio').AsString;
  Flocalidad:= fdqC.FieldByName('localidad').AsString;
  Ftelefono:= fdqC.FieldByName('telefono').AsString;
  Femail:= fdqC.FieldByName('email').AsString;

  DataModule1.liberarFDQ(fdqC);
  Result:= True
end;

function TCliente.loadApi: Boolean;
  var
    obj_reques : TJSONObject;
    mrest : TMovil_Envio_Servidor;
    baseURL : string;
begin
   baseURL := 'http://6f3a07758d88.sn.mynetname.net:65002/cliente/one/' + Fid.ToString;
   mrest := TMovil_Envio_Servidor.Create(baseURL, rmGET);
   if (mrest.ejecutar) then
     begin
      obj_reques := mrest.restRP.JSONValue as TJSONObject;
      FrazonSocial := obj_reques.FindValue('RazonSocial').Value;
      Fdomicilio := obj_reques.FindValue('Domicilio').Value;
      Femail := obj_reques.FindValue('Email').Value;
      Ftelefono := obj_reques.FindValue('Telefono').Value;
     end
end;

procedure TCliente.modificar;
begin
   if (not FSOYJSON) then
      update
   else
      updateApi
end;

procedure TCliente.setDomicilio(const Value: string);
begin
   FDomicilio:=Value;
end;

procedure TCliente.setEmail(const Value: string);
begin
   FEmail:=Value;
end;

procedure TCliente.setLocalidad(const Value: string);
begin
   FLocalidad:=Value;
end;

procedure TCliente.setRazonSocial(const Value: string);
begin
   FRazonSocial:=Value;
end;

procedure TCliente.setTelefono(const Value: string);
begin
   FTelefono:=Value;
end;

procedure TCliente.update;
var fdq: TFDQuery;
begin
   fdq:=DataModule1.inicializarFDQ;
   fdq.SQL.Add('UPDATE clientes SET domicilio = :domicilio, localidad = :localidad, telefono = :telefono, email = :email WHERE (id = :id)');
   fdq.ParamByName('id').AsInteger:= Fid;
   fdq.ParamByName('domicilio').AsString:= Fdomicilio;
   fdq.ParamByName('localidad').AsString:= Flocalidad;
   fdq.ParamByName('telefono').AsString:= Ftelefono;
   fdq.ParamByName('email').AsString:= Femail;
   fdq.ExecSQL;
   DataModule1.liberarFDQ(fdq)
end;

procedure TCliente.updateApi;
  var
  mrest : TMovil_Envio_Servidor;
  urlBASE : String;
begin
  urlBASE := 'http://6f3a07758d88.sn.mynetname.net:65002/cliente/' + Fid.ToString;
  mrest := TMovil_Envio_Servidor.Create(urlBASE, rmPUT);
  mrest.envia_json(TJson.ObjectToJsonObject(self));
end;

//Metodo para edicion

end.
