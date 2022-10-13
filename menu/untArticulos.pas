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
  FireDAC.Comp.Client;

type
  TFrArticulos = class(TForm)
    Label1: TLabel;
    Image1: TImage;
    lvArticulos: TListView;
    QueryArt: TFDQuery;
    procedure FormShow(Sender: TObject);
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

procedure TFrArticulos.ListarArticulos;
begin

end;

end.
