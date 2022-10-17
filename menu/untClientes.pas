unit untClientes;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Edit, FMX.ListBox,
  cUnit, System.Generics.Collections, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView,
  FMX.TabControl, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Frame.ClienteCard;

type
  TfmClientes = class(TForm)
    Label1: TLabel;
    Image1: TImage;
    lbClientBar: TListBox;
    ListBoxItem1: TListBoxItem;
    Rectangle1: TRectangle;
    Label2: TLabel;
    ListBoxItem2: TListBoxItem;
    Rectangle2: TRectangle;
    Label3: TLabel;
    ListBoxItem3: TListBoxItem;
    Rectangle3: TRectangle;
    Label4: TLabel;
    ListBoxItem4: TListBoxItem;
    Rectangle4: TRectangle;
    Label5: TLabel;
    lbClientes: TListBox;
    StyleBook1: TStyleBook;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    lvClientes: TListView;
    FDQuery1: TFDQuery;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lvClientesItemClickEx(const Sender: TObject; ItemIndex: Integer;
      const LocalClickPos: TPointF; const ItemObject: TListItemDrawable);
  private
    list: TObjectList<TCliente>;
    procedure ListarClientes;
    procedure AddClientelb(Cid: integer; direccion, nombre: string; telefono: double);
    procedure AddClientelv(Cid: integer; direccion, nombre: string; telefono: double; const indice: integer);

    { Private declarations }
  public
    { Public declarations }
    FFrame: TClienteCard;
  end;

var
  fmClientes: TfmClientes;

implementation

{$R *.fmx}
uses untPrincipal;

procedure TfmClientes.AddClientelb(Cid: integer; direccion, nombre: string; telefono: double);
var
   item: TListBoxItem;
   frame: TClienteCard;
begin
   item:= TListBoxItem.Create(lbClientes);
   item.Selectable := false;
   item.Text := '';
   item.Height := 200;
   item.Tag := Cid;


   // ACA SE MUESTRAN LOS MARCOS/CARDS
    frame := TClienteCard.Create(item);
    //frame.imgTienda;
    frame.lbNombre.Text := nombre;
    frame.lbUbi.Text := direccion;
    frame.lbTel.Text := '111-222-333';

    item.AddObject(frame);

   lbClientes.AddObject(item);
end;


       //Agrega listado de clientes a listview
procedure TfmClientes.AddClientelv(Cid: integer; direccion, nombre: string; telefono: double; const indice: integer);

   function par(n: integer): boolean;
   begin
      Result:= ((n mod 2) = 0)
   end;

var
   item: TListViewItem;
begin
   item:= lvClientes.Items.AddItem(indice);
   item.Data['txtRazon_Social']:= nombre;
   item.Data['txtDomicilio']:= direccion;
   item.Data['txtTelefono']:= telefono;
   if (par(indice)) then
      item.Data['imgLocal']:= fframe.ImgLocal.Bitmap
   else
      item.Data['imgLocal']:= fframe.imgTienda.Bitmap;
   item.Tag := Cid;
end;


      //INICIA RECORRIDO Y CARGA DE CLIENTES A LISTBOX
procedure TfmClientes.ListarClientes;
var cli: TCliente;
    k: Integer;
begin
            // Acceder a datos de card clientes

{    AddCliente(0, 'Dir. Teodoro Planas 4141', 'Makro', 111-222-333);
    AddCliente(0, 'Dir. Teodoro Planas 4141', 'Makro', 111-222-333);
    AddCliente(0, 'Dir. Teodoro Planas 4141', 'Makro', 111-222-333);
    AddCliente(0, 'Dir. Teodoro Planas 4141', 'Makro', 111-222-333);
    AddCliente(0, 'Dir. Teodoro Planas 4141', 'Makro', 111-222-333);
    AddCliente(0, 'Dir. Teodoro Planas 4141', 'Makro', 111-222-333);
}


   for k:= 0 to list.Count - 1 do
      begin
      cli:= list[k];
      //pinto el cliente
      AddClientelb(cli.Id, cli.Domicilio, cli.RazonSocial, cli.Telefono);
      AddClientelv(cli.Id, cli.Domicilio, cli.RazonSocial, cli.Telefono, k);
      end;

   //libero el listado
   //list.Free
end;

procedure TfmClientes.lvClientesItemClickEx(const Sender: TObject;
  ItemIndex: Integer; const LocalClickPos: TPointF;
  const ItemObject: TListItemDrawable);
var cli: TCliente;
begin
   cli:= list[itemindex];
   ShowMessage('Soy el Cliente: '+ sLineBreak + cli.asString);
end;

procedure TfmClientes.FormCreate(Sender: TObject);
begin
   list:= listado_clientes;
   FFrame:= TClienteCard.Create(nil);
end;

procedure TfmClientes.FormShow(Sender: TObject);
begin
   ListarClientes;
end;
       // (cli.Id, cli.Domicilio, cli.RazonSocial, cli.Telefono)
end.
