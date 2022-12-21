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
  Data.Bind.DBLinks, Fmx.Bind.DBLinks, FMX.TabControl, aUnit, System.Generics.Collections,
  untAgregar_Articulos;

type
  TFrArticulos = class(TForm)
    Label1: TLabel;
    Image1: TImage;
    lvArticulos: TListView;
    imgAgregar_Articulos: TImage;
    procedure Image1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure imgAgregar_ArticulosClick(Sender: TObject);

  private
    { Private declarations }
    list: TObjectList<TArticulos>;
    procedure addlvArticulos(art: TArticulos; const indice: integer);
    procedure lis_Art;
    procedure pintar_articulos(item: TListViewItem; art: TArticulos);
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
    aux: TImage;
begin

    item:= lvArticulos.Items.AddItem(indice);
    item.Tag := art.id;
    item.Data['txtNombreP']:= art.Nombre;
    item.Data['txtPrecio']:= art.Precio;

    aux:= TImage.Create(nil);
    aux.Bitmap.LoadFromStream(art.Foto);
    item.Data['imgArticulo']:= aux.Bitmap;
    aux.Free
end;

procedure TFrArticulos.FormCreate(Sender: TObject);
begin
    list:= listado_Articulos;

end;


procedure TFrArticulos.FormShow(Sender: TObject);
begin
   lis_Art
end;

procedure TFrArticulos.Image1Click(Sender: TObject);
begin
   Self.Close;
end;

procedure TFrArticulos.imgAgregar_ArticulosClick(Sender: TObject);
var untAgregar_Articulos:  TAgregar_Articulos;
begin
   untAgregar_Articulos:= TAgregar_Articulos.Create(Self);
   untAgregar_Articulos.Show;
end;

procedure TFrArticulos.lis_Art;
var A: Integer;
begin
   for A:= 0 to list.Count - 1 do
   begin
      addlvArticulos(list[A], A);
   end;
end;

procedure TFrArticulos.pintar_articulos(item: TListViewItem; art: TArticulos);
begin
   item.Text:= art.Nombre;
   art.Precio.ToString;

end;

end.
