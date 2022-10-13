unit logUnit;

interface

uses System.SysUtils, System.DateUtils, FireDAC.Comp.Client,
     FireDAC.Comp.DataSet, System.Classes, System.Notification,
     System.IOUtils, FMX.Dialogs, Data.DB, System.Generics.Collections;

type
  TUsuario = class(TObject)
  private
    Fid: Integer;
    FNombre: string;
    FApellido: string;
    FUsuario: string;
    FPassword: string;
    FAccionList: TObjectList<TObject>;
    function getApellido: string;
    function getid: Integer;
    function getNombre: string;
    function getPassword: string;
    function getUsuario: string;
  protected
    destructor Destroy;
  public
    constructor Create;
    procedure load(const idUsu: Integer);
    function asString: string;
  published
    property id: Integer read getid;
    property Nombre: string read getNombre;
    property Apellido: string read getApellido;
    property Usuario: string read getUsuario;
    property Password: string read getPassword;
  end;  //type TUsuario

function user_validation(var  userKey: Integer; var description : string; user, password: String): Boolean;

implementation

uses moduloDatos_u;

function user_validation (var  userKey: Integer; var description : string; user, password: String): Boolean;
var
    fdq: TFDQuery;
begin
  Result:=False;
  fdq:= DataModule1.inicializarFDQ;
  fdq.SQL.Add('Select id, nombre, apellido from usuarios');
  fdq.SQL.Add('Where usuario=:u and password=:p');
  fdq.ParamByName('u').AsString:=user;
  fdq.ParamByName('p').AsString:=password;
  DataModule1.actualizarFDQ(fdq);
  Result:= (not fdq.IsEmpty);
  if (Result) then
    begin
    userKey:= fdq.FieldByName('id').AsInteger;
    description:=fdq.FieldByName('apellido').AsString + ', ' + fdq.FieldByName('nombre').AsString;
    end;
  DataModule1.liberarFDQ(fdq);
end;
{ TUsuario }

function TUsuario.asString: string;
begin
  Result:= FApellido + ', '+ FNombre
end;

constructor TUsuario.Create;
begin
   inherited;
   FAccionList:= TObjectList<TObject>.Create
end;

destructor TUsuario.Destroy;
begin
  inherited;
  FAccionList.Free
end;

function TUsuario.getApellido: string;
begin
  Result:= FApellido
end;

function TUsuario.getid: Integer;
begin
  Result:= Fid
end;

function TUsuario.getNombre: string;
begin
  Result:= FNombre
end;

function TUsuario.getPassword: string;
begin
  Result:= FPassword
end;

function TUsuario.getUsuario: string;
begin
  Result:= FUsuario
end;

procedure TUsuario.load(const idUsu: Integer);
var fdqU: TFDQuery;
begin
  fdqU:= DataModule1.inicializarFDQ;
  fdqU.SQL.Add('Select * from usuarios where (id = :bla)');
  fdqU.ParamByName('bla').AsInteger:= idUsu;
  DataModule1.actualizarFDQ(fdqU);

  //inicia la carga de las propiedades del usuario
  Fid:= fdqU.FieldByName('id').AsInteger;
  FNombre:= fdqU.FieldByName('Nombre').AsString;
  FApellido:= fdqU.FieldByName('Apellido').AsString;
  FUsuario:= fdqU.FieldByName('Usuario').AsString;
  FPassword:= fdqU.FieldByName('Password').AsString;

  DataModule1.liberarFDQ(fdqU)
end;

end.
