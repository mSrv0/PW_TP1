unit logUnit;

interface

uses System.SysUtils, System.DateUtils, moduloDatos_u, FireDAC.Comp.Client,
     FireDAC.Comp.DataSet, System.Classes, System.Notification,
     System.IOUtils, FMX.Dialogs, Data.DB;

procedure actualizarFDQ(fdq: TFDQuery);
function inicializarFDQ: TFDQuery;
procedure liberarFDQ(fdq: TFDQuery);
function user_validation(var  userKey: Integer; var description : string; user, password: String): Boolean;
procedure begin_transaction;
procedure commit_transaction;
procedure rollback_transaction;

implementation
procedure actualizarFDQ(fdq: TFDQuery);
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
function inicializarFDQ: TFDQuery;
begin
   Result:= TFDQuery.Create(Nil);
   Result.ConnectionName:= DataModule1.Conexion.ConnectionName;
end;

procedure liberarFDQ(fdq: TFDQuery);
begin
   try
      fdq.Close;
      fdq.Free;
   except
   end
end;
procedure begin_transaction;
begin
   DataModule1.Conexion.StartTransaction
end;

procedure commit_transaction;
begin
   DataModule1.Conexion.Commit
end;

procedure rollback_transaction;
begin
   DataModule1.Conexion.Rollback
end;

function user_validation (var  userKey: Integer; var description : string; user, password: String): Boolean;
var
    fdq: TFDQuery;
begin
  Result:=False;
  fdq:=inicializarFDQ;
  fdq.SQL.Add('Select id, nombre, apellido from usuarios');
  fdq.SQL.Add('Where usuario=:u and password=:p');
  fdq.ParamByName('u').AsString:=user;
  fdq.ParamByName('p').AsString:=password;
  actualizarFDQ(fdq);
  Result:= (not fdq.IsEmpty);
  if (Result) then
    begin
    userKey:= fdq.FieldByName('id').AsInteger;
    description:=fdq.FieldByName('apellido').AsString + ', ' + fdq.FieldByName('nombre').AsString;
    end;
  liberarFDQ(fdq);
end;
end.
