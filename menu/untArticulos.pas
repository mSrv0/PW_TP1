unit untArticulos;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Data.Bind.Components, Data.Bind.DBScope,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Datasnap.DBClient, Datasnap.Provider,
  System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.Grid,
  Data.Bind.DBLinks, Fmx.Bind.DBLinks;

type
  TFrArticulos = class(TForm)
    Label1: TLabel;
    Image1: TImage;
    lvArticulos: TListView;
    QueryArt: TFDQuery;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    ClientDataSet1: TClientDataSet;
    DataSetProvider1: TDataSetProvider;
    LinkFillControlToField1: TLinkFillControlToField;
    BindList1: TBindList;
    BindDBImageLink1: TBindDBImageLink;
    BindSourceDB2: TBindSourceDB;
    procedure FormShow(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
    procedure ListarArticulos;
    procedure addArticulo(nombre: string; precio: Currency);
  public
    { Public declarations }
  end;

var
  FrArticulos: TFrArticulos;

implementation

{$R *.fmx}

uses moduloDatos_u;


procedure TFrArticulos.addArticulo(nombre: string; precio: Currency);
var item: TListViewItem;
begin
   item:= lvArticulos.Items.Add;

end;


procedure TFrArticulos.FormShow(Sender: TObject);
begin
   ListarArticulos;
end;

procedure TFrArticulos.Image1Click(Sender: TObject);
begin
   Self.Close;
end;

procedure TFrArticulos.ListarArticulos;
begin
   lvArticulos.Items.CheckedCount()

end;

procedure TFrArticulos.SpeedButton1Click(Sender: TObject);
begin
   //lvArticulos.EditMode := not lvArticulos.EditMode;
end;

end.
