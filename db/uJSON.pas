unit uJSON;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Rtti,
  FMX.Grid.Style, FMX.Memo.Types, FMX.Memo, FMX.ScrollBox, FMX.Grid,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.TabControl, System.Net.URLClient,
  System.Net.HttpClient, System.Net.HttpClientComponent, System.JSON, REST.Client,
  FMX.Edit, REST.Types, REST.Response.Adapter, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
TMovil_Envio_Servidor = class(TObject)
  //procesos utilizados para la comunicacion con RADSEVER
  private
	 { Private declarations }
    FrestC: TRESTClient;
    FrestRQ: TRESTRequest;
    FrestRP: TRESTResponse;
    FrestRPDSA: TRESTResponseDataSetAdapter;
    Ffdmemtable: TFDMemTable;
  protected
	 { Protected declarations }
    Destructor Destroy; override;
  public
	 { Public declarations }
    constructor Create(baseUrl: string; metodo: TRESTRequestMethod; consulta_ingreso: Boolean = False);
    procedure envia_json(jsRequest: TJSONObject); overload;
    function ejecutar: Boolean;
    procedure setTimeOut(value: Integer);
  published
	 { Published declarations }
    property restRP: TRESTResponse read FrestRP;
    property fdmemtable: TFDMemTable read Ffdmemtable;
end;

implementation


{ TMovil_Envio_Servidor }

constructor TMovil_Envio_Servidor.Create(baseUrl: string;
  metodo: TRESTRequestMethod; consulta_ingreso: Boolean);
begin
   inherited Create;

   FrestC:= TRESTClient.Create(baseUrl);
   FrestC.Accept:= 'application/json, text/plain; q=0.9, text/html;q=0.8,';
   FrestC.AcceptCharset:= 'utf-8, *;q=0.8';
   FrestC.RaiseExceptionOn500:= False;

   FrestRP:= TRESTResponse.Create(Nil);
   FrestRP.ContentType:= 'application/json';

   FrestRQ:= TRESTRequest.Create(Nil);
   FrestRQ.Client:= FrestC;
   FrestRQ.Timeout:= 5000;
   FrestRQ.Method:= metodo;
   FrestRQ.Params.Clear;
   FrestRQ.Params.AddHeader('X-Embarcadero-Master-Secret',  '83BECB29-385A-4C87-AB4E-DA2A0CD3E19A');
   FrestRQ.Params.AddHeader('X-Embarcadero-Application-Id', '2020WPSOIRAUSUARAPOLOS2019');
   FrestRQ.Response:= FrestRP;

   if ((metodo = rmGET) or consulta_ingreso) then
      begin
      Ffdmemtable:= TFDMemTable.Create(Nil);

      FrestRPDSA:= TRESTResponseDataSetAdapter.Create(Nil);
      FrestRPDSA.Dataset:= Ffdmemtable;
      FrestRPDSA.Response:= FrestRP;
      end;
end;

destructor TMovil_Envio_Servidor.Destroy;
begin
   try
      FrestRQ.Free;
      FrestRP.Free;
      FrestC.Free;
      if Assigned(FrestRPDSA) then
         FrestRPDSA.Free;
      if Assigned(Ffdmemtable) then
         Ffdmemtable.Free
   except
   end;
end;

function TMovil_Envio_Servidor.ejecutar: Boolean;
begin
   try
      FrestRQ.Execute;
      Result:= (FrestRP.StatusCode = 200)
   except
      Result:= False
   end;
end;

procedure TMovil_Envio_Servidor.envia_json(jsRequest: TJSONObject);
begin
   FrestRQ.Body.ClearBody;
   FrestRQ.AddBody(jsRequest);
end;

procedure TMovil_Envio_Servidor.setTimeOut(value: Integer);
begin
   FrestRQ.Timeout:= value
end;

end.
