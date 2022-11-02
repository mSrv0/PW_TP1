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
  Data.Bind.DBLinks, Fmx.Bind.DBLinks, FMX.TabControl, aUnit
  ;

type
  TFrArticulos = class(TForm)
    Label1: TLabel;
    Image1: TImage;
    lvArticulos: TListView;
    QueryArt: TFDQuery;
    procedure Image1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
    procedure addlvArticulos(art: TArticulos; const indice: integer);
    procedure listado_Art;
  public
    { Public declarations }
  end;

var
  FrArticulos: TFrArticulos;

implementation

{$R *.fmx}

uses moduloDatos_u;


procedure TFrArticulos.addlvArticulos(art: TArticulos; const indice: Integer);
var item: TListViewItem;
begin
    item:= lvArticulos.Items.AddItem(indice);
    item.Tag := art.Id;
    item.Data['txtNombreP']:= art.Nombre;
    item.Data['txtPrecio']:= art.Precio;
    item.Data['imgArticulo']:= art.Foto;
end;


{procedure TFrArticulos.FormCreate(Sender: TObject);
begin
   list:= listado_Articulos;
end;}

procedure TFrArticulos.FormShow(Sender: TObject);
begin
   listado_Art;
end;

procedure TFrArticulos.Image1Click(Sender: TObject);
begin
   Self.Close;
end;

procedure TFrArticulos.listado_Art;
begin
   aUnit.listado_Articulos()
end;

end.
