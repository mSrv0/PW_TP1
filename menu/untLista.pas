unit untLista;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, uJSON, FMX.Memo.Types, FMX.ScrollBox,
  FMX.Memo, System.JSON, FMX.Edit, REST.Types, System.Rtti, FMX.Grid.Style, FMX.Grid,
  FMX.TabControl, System.Net.Mime, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, untEditLista,
  cUnit;

type
  TfmLista = class(TForm)
    btnLoad: TCornerButton;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    stg_Data: TStringGrid;
    StringColumn1: TStringColumn;
    StringColumn2: TStringColumn;
    lblStatus: TLabel;
    sc_id: TStringColumn;
    procedure btnLoadClick(Sender: TObject);
    procedure stg_DataCellClick(const Column: TColumn; const Row: Integer);
    procedure refrescarDatoEnGrilla(const r: integer; const cli: TCliente);
  private
     procedure fnClearStringGrid(FStringGrid : TStringGrid); //ctrl + shift + c
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmLista: TfmLista;

implementation

{$R *.fmx}
{$R *.LgXhdpiPh.fmx ANDROID}

CONST
      COL_RAZONSOCIAL= 0;
      COL_CODIGO = 1;
      COL_ID = 2;

procedure TfmLista.btnLoadClick(Sender: TObject);
var
  mrest : TMovil_Envio_Servidor;
  ok : boolean;
  baseURL : string;
  JObjectData : TJSONObject;
  JArrayJSON : TJSONArray;
  i : integer;
begin
  ok := False;
  baseURL := 'http://6f3a07758d88.sn.mynetname.net:65002/cliente';
  mrest := TMovil_Envio_Servidor.Create(baseURL, rmGET);
  try
    ok:= mrest.ejecutar;
    if ok then
      begin
          fnClearStringGrid(stg_Data);
          stg_Data.RowCount := mrest.fdmemtable.RecordCount;
          i := 0;
          while (not mrest.fdmemtable.Eof) do
            begin
              stg_Data.Cells[COL_RAZONSOCIAL, i] := mrest.fdmemtable.FieldByName('RazonSocial').asString;
              stg_Data.Cells[COL_CODIGO, i] := mrest.fdmemtable.FieldByName('Codigo').asString;
              stg_Data.Cells[COL_ID, i] := mrest.fdmemtable.FieldByName('id').asInteger.ToString;
              //stg_Data.Cells[2, i] := mrest.fdmemtable.FieldByName('Domicilio').asString;
              //stg_Data.Cells[3, i] := mrest.fdmemtable.FieldByName('Localidad').asString;
              //stg_Data.Cells[4, i] := mrest.fdmemtable.FieldByName('Telefono').asString;
              Inc(i);
              mrest.fdmemtable.Next
            end;
      end;
  finally
    if ok then
      lblStatus.Text := 'Ok'
    else
      lblStatus.Text := 'No'
  end;
end;

procedure TfmLista.fnClearStringGrid(FStringGrid: TStringGrid);
begin
  FStringGrid.RowCount := 0;
end;

procedure TfmLista.refrescarDatoEnGrilla(const r: integer; const cli: TCliente);
begin
  stg_Data.BeginUpdate;
  stg_Data.Cells[COL_RAZONSOCIAL, r]:= cli.RazonSocial;
  stg_Data.EndUpdate
end;

procedure TfmLista.stg_DataCellClick(const Column: TColumn; const Row: Integer);
var untEditLista : TfmEditLista;
    id, pos: Integer;
    obj_cli: TCliente;
    mrest : TMovil_Envio_Servidor;
    baseURL : string;
begin
   if (stg_Data.RowCount = 0) then
     Exit;

   pos := stg_Data.Row;
   //obtengo la llave
   id:= (stg_Data.Cells[COL_ID, Row]).ToInteger;
     //creo el objeto cliente a editar
     obj_cli:= TCliente.Create;
     //validacion de carga "recordar que viene de una api"
     if obj_cli.cargar(id, True) then
        begin
        untEditLista:= TfmEditLista.Create(Application);
        untEditLista.ShowModal(
          procedure(ModalResult: TModalResult)
          var ok: Boolean;
            begin
            ok:= ModalResult = mrOk;
            if (ok) then
               begin
                  refrescarDatoEnGrilla(pos, obj_cli);
                  obj_cli.Free;
               end;
            end //pocedure
          ); //modal
        untEditLista.inicializar(obj_cli);
        end //if
     else
       ShowMessage('Error en la carga del cliente.')
end;

end.
