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
  protected
    destructor Destroy;
  public
    constructor Create;
    procedure load(const idCli: integer);
    procedure loadC(const idcliC: integer);
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
      cli.load(fdq.FieldByName('id').AsInteger);
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

constructor TCliente.Create;
begin
  inherited;
  FActionsList:= TObjectList<TObject>.Create
end;

destructor TCliente.Destroy;
begin
  inherited;
  FActionsList.Free;
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

procedure TCliente.load(const idcli: integer);
var fdqC: TFDQuery;
begin
  fdqC:= DataModule1.inicializarFDQ;
  fdqC.SQL.Add('Select * from clientes where (id = :idC)');
  fdqC.ParamByName('idC').AsInteger:= idCli;
  DataModule1.actualizarFDQ(fdqC);

  // Inicia carga de los datos de clientes

  Fid:= fdqC.FieldByName('id').AsInteger;
  FrazonSocial:= fdqC.FieldByName('Razon_Social').AsString;
  Fdomicilio:= fdqC.FieldByName('domicilio').AsString;
  Flocalidad:= fdqC.FieldByName('localidad').AsString;
  Ftelefono:= fdqC.FieldByName('telefono').AsInteger;
  Femail:= fdqC.FieldByName('email').AsString;

  DataModule1.liberarFDQ(fdqC)
end;

procedure TCliente.loadC(const idcliC: integer);
var fdq: TFDQuery;
begin
fdq:=DataModule1.inicializarFDQ;
fdq.SQL.Add('UPDATE clientes SET domicilio:=domicilio, localidad:=localidad, telefono:=telefono, email:=email WHERE (id =: idL)');
fdq.ParamByName('idL').AsInteger:=idcliC;
DataModule1.actualizarFDQ(fdq);
end;

procedure TCliente.setDomicilio(const Value: string);
begin
Domicilio:=Value;
end;

procedure TCliente.setEmail(const Value: string);
begin
Email:=Value;
end;

procedure TCliente.setLocalidad(const Value: string);
begin
Localidad:=Value;
end;

procedure TCliente.setRazonSocial(const Value: string);
begin
RazonSocial:=Value;
end; procedure TCliente.setTelefono(const Value: Integer);
begin
Telefono:=Value;
end;

//Metodo para edicion

end.
