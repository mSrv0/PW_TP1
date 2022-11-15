unit aUnit;

interface

uses  System.SysUtils, System.DateUtils, FireDAC.Comp.Client,
     FireDAC.Comp.DataSet, System.Classes, System.Notification,
     System.IOUtils, FMX.Dialogs, Data.DB, System.Generics.Collections;

type
   TArticulos = class(TObject)
   private
    Aid: Integer;
    ANombre: String;
    AFoto: TMemoryStream;
    APrecio: Currency;

    AActionsList: TObjectList<TObject>;
    function getid: Integer;
    function getNombre: String;
    function getFoto: TMemoryStream;
    function getPrecio: Currency;
    procedure setNombre(const Value: string);
    procedure setFoto(const Value: TMemoryStream);
    procedure setPrecio(const Value: Currency);

    procedure update;
    procedure insert;
    procedure load;
    procedure delete;
  protected
    destructor Destroy;
  public
    constructor Create;
    procedure cargar(const idArt: integer);
    procedure guardar;
    procedure modificar;
    procedure eliminar;

    function asString: string;
  published
    property id: integer read getId;
    property Nombre: string read getNombre write setNombre;
    property Precio: Currency read getPrecio write setPrecio;
    property Foto: TMemoryStream read getFoto;
end;

function listado_Articulos: TObjectList<TArticulos>;


implementation

uses  moduloDatos_u;

function listado_Articulos: TObjectList<TArticulos>;
var art: TArticulos;
    fdq: TFDQuery;
begin
   //creo el listado de articulos
   Result:= TObjectList<TArticulos>.Create;

   fdq:= DataModule1.inicializarFDQ;
   fdq.SQL.Add('Select id from productos');
   DataModule1.actualizarFDQ(fdq);

   //recorro el fdq y cargo el listado de articulos
   while not (fdq.Eof) do
      begin
      art:= TArticulos.Create;
      art.cargar(fdq.FieldByName('id').AsInteger);
      Result.Add(art);
      fdq.Next
      end;

   DataModule1.liberarFDQ(fdq)
end;

        //LLAMADO A TArticulos
function TArticulos.asString: string;
begin
   Result:= Nombre
end;

procedure TArticulos.cargar(const idArt: integer);
begin
   Aid:= idArt;
   load
end;

constructor TArticulos.Create;
begin
   inherited;
   AActionsList:= TObjectList<TObject>.Create;
   AFoto:= TMemoryStream.Create;
end;

procedure TArticulos.delete;
var fdq: TFDQuery;
begin
   fdq:=DataModule1.inicializarFDQ;
   fdq.SQL.Add('Delete from productos WHERE (id = :id)');
   fdq.ParamByName('id').AsInteger:= Aid;
   fdq.ExecSQL;
   DataModule1.liberarFDQ(fdq);
end;

destructor TArticulos.Destroy;
begin
  inherited;
  AActionsList.Free;
  AFoto.Free
end;

procedure TArticulos.eliminar;
begin
   delete
end;


function TArticulos.getFoto: TMemoryStream;
begin
   Result:= AFoto;
end;

function TArticulos.getPrecio: Currency;
begin
  Result:= APrecio;
end;

function TArticulos.getId: Integer;
begin
  Result:= Aid;
end;

function TArticulos.getNombre: String;
begin
  Result:= ANombre;
end;

procedure TArticulos.guardar;
begin
   insert;
end;

procedure TArticulos.insert;
var fdq: TFDQuery;
begin
   fdq:=DataModule1.inicializarFDQ;
   fdq.SQL.Add('Insert into productos (nombre, foto, precio)');
   fdq.SQL.Add('values (:nombre, :foto, :precio)');
   fdq.ParamByName('nombre').AsString:= ANombre;
   fdq.ParamByName('foto').AsStream:= AFoto;
   fdq.ParamByName('precio').AsCurrency:= APrecio;
   fdq.ExecSQL;
   DataModule1.liberarFDQ(fdq);
end;

procedure TArticulos.load;
var fdqA: TFDQuery;
begin
  fdqA:= DataModule1.inicializarFDQ;
  fdqA.SQL.Add('Select nombre, precio, foto from productos where (id = :id)');
  fdqA.ParamByName('id').AsInteger:= Aid;
  DataModule1.actualizarFDQ(fdqA);

  // Inicia carga de los articulos
  ANombre:= fdqA.FieldByName('nombre').AsString;
  APrecio:= fdqA.FieldByName('precio').AsCurrency;

  TBlobField(fdqA.FieldByName('foto')).SaveToStream(AFoto);

  DataModule1.liberarFDQ(fdqA)
end;

procedure TArticulos.modificar;
begin
   update
end;

procedure TArticulos.setNombre(const Value: string);
begin
   ANombre:=Value;
end;

procedure TArticulos.setPrecio(const Value: Currency);
begin
   APrecio:=Value;
end;

procedure TArticulos.setFoto(const Value: TMemoryStream);
begin
   AFoto:= Value;
end;


procedure TArticulos.update;
var fdq: TFDQuery;
begin
   fdq:=DataModule1.inicializarFDQ;
   fdq.SQL.Add('UPDATE productos SET nombre = :nombre, precio = :precio, foto = :foto WHERE (id = :id)');
   fdq.ParamByName('id').AsInteger:= Aid;
   fdq.ParamByName('nombre').AsString:= ANombre;
   fdq.ParamByName('precio').AsCurrency:= APrecio;
   fdq.ParamByName('foto').AsStream:= AFoto;
   fdq.ExecSQL;
   DataModule1.liberarFDQ(fdq)
end;



end.
