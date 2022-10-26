unit cUnit;

interface

uses System.SysUtils, System.DateUtils, FireDAC.Comp.Client,
     FireDAC.Comp.DataSet, System.Classes, System.Notification,
     System.IOUtils, FMX.Dialogs, Data.DB, System.Generics.Collections;

type
  TCliente = class(TObject)
  private
    Fid: Integer;
    FrazonSocial: String;
    Fdomicilio: String;
    Flocalidad: String;
    Ftelefono: Integer;
    Femail: String;
    FActionsList: TObjectList<TObject>;
    function getId: Integer;
    function getRazonSocial: String;
    function getDomicilio: String;
    function getLocalidad: String;
    function getTelefono: Integer;
    function getEmail: String;
    procedure setRazonSocial(const Value: string);
    procedure setDomicilio(const Value: string);
    procedure setLocalidad(const Value: string);
    procedure setTelefono(const Value: Integer);
    procedure setEmail(const Value: string);


    procedure update;
    procedure insert;
    procedure load;
    procedure delete;
  protected
    destructor Destroy;
  public
    constructor Create;
    procedure cargar(const idCli: integer);
    procedure guardar;
    procedure modificar;
    procedure eliminar;

    function asString: string;
  published
    property Id: integer read getId;
    property RazonSocial: string read getRazonSocial write setRazonSocial;
    property Domicilio: string read getDomicilio write setDomicilio;
    property Localidad: string read getLocalidad write setLocalidad;
    property Telefono: integer read getTelefono write setTelefono;
    property Email: string read getEmail write setEmail;
end;


function listado_clientes: TObjectList<TCliente>;



implementation

uses moduloDatos_u;



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

procedure TCliente.cargar(const idCli: integer);
begin
   Fid:= idCli;
   load
end;

constructor TCliente.Create;
begin
  inherited;
  FActionsList:= TObjectList<TObject>.Create
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

function TCliente.getTelefono: Integer;
begin
  Result:= Ftelefono;
end;

procedure TCliente.guardar;
begin
   insert
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
   fdq.ParamByName('telefono').AsInteger:= Ftelefono;
   fdq.ParamByName('email').AsString:= Femail;
   fdq.ExecSQL;
   DataModule1.liberarFDQ(fdq);
end;

procedure TCliente.load;
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
  Ftelefono:= fdqC.FieldByName('telefono').AsInteger;
  Femail:= fdqC.FieldByName('email').AsString;

  DataModule1.liberarFDQ(fdqC)
end;

procedure TCliente.modificar;
begin
   update
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

procedure TCliente.setTelefono(const Value: Integer);
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
   fdq.ParamByName('telefono').AsInteger:= Ftelefono;
   fdq.ParamByName('email').AsString:= Femail;
   fdq.ExecSQL;
   DataModule1.liberarFDQ(fdq)
end;

//Metodo para edicion

end.
