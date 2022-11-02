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
    procedure lvClientesItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure Image1Click(Sender: TObject);
    procedure lbClientesItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);

  private
    list: TObjectList<TCliente>;
    procedure ListarClientes;
    procedure AddClientelb(cli: TCliente);
    procedure AddClientelv(cli: TCliente; const indice: integer);
    procedure pintar_datos_cliente(item: TListBoxItem; cli: TCliente);
    procedure pintar_cliente(item: TListViewItem; cli: TCliente);

    { Private declarations }
  public
    { Public declarations }
    fframe: TClienteCard;
  end;

var
  fmClientes: TfmClientes;


implementation

{$R *.fmx}
uses untPrincipal, untEditClientes;

procedure TfmClientes.AddClientelb(cli: TCliente);
var
   item: TListBoxItem;
begin
   item:= TListBoxItem.Create(lbClientes);
   item.Selectable := false;
   item.Tag := cli.Id;
   item.Text := '';
   item.Height := 200;
   pintar_datos_cliente(item, cli);
   lbClientes.AddObject(item);
end;


       //Agrega listado de clientes a listview
procedure TfmClientes.AddClientelv(cli: TCliente; const indice: integer);

   function par(n: integer): boolean;
   begin
      Result:= ((n mod 2) = 0)
   end;

var
   item: TListViewItem;
begin
   item:= lvClientes.Items.AddItem(indice);
   item.Tag := cli.Id;
   item.Data['txtRazon_Social']:= cli.RazonSocial;
   item.Data['txtDomicilio']:= cli.Domicilio;
   item.Data['txtTelefono']:= cli.Telefono;
   if (par(indice)) then
      item.Data['imgLocal']:= fframe.imgTienda.Bitmap
   else
      item.Data['imgLocal']:= fframe.imgTienda.Bitmap;
end;


      //INICIA RECORRIDO Y CARGA DE CLIENTES A LISTBOX
procedure TfmClientes.ListarClientes;
var k: Integer;
begin
            // Acceder a datos de card clientes
   for k:= 0 to list.Count - 1 do
      begin
      //pinto el cliente
      AddClientelb(list[k]);
      AddClientelv(list[k], k);
      end;

   //libero el listado
   //list.Free
end;

                      //SE AGREGAN AL EDIT LIST VIEW

procedure TfmClientes.lvClientesItemClick(const Sender: TObject;
  const AItem: TListViewItem);
var untEditClientes: TfmEditClientes;
begin
  untEditClientes := TfmEditClientes.Create(nil);
  untEditClientes.inicializar(list[lvClientes.ItemIndex]);
  untEditClientes.ShowModal(
       procedure(ModalResult: TModalResult)
      var ok: Boolean;
         begin
         ok:= ModalResult = mrOk;
         if ok then
         begin
            pintar_cliente(lvClientes.Items[lvClientes.ItemIndex], untEditClientes.FCli);
         end;
            untEditClientes.Close;
         end);
end;


procedure TfmClientes.pintar_cliente(item: TListViewItem; cli: TCliente);
begin
   item.Text:= cli.RazonSocial + sLineBreak +
               cli.Domicilio + sLineBreak +
               cli.Telefono.ToString;
end;

// LIST BOX
procedure TfmClientes.pintar_datos_cliente(item: TListBoxItem; cli: TCliente);
//var  frame: TClienteCard;
begin
   item.Text:= cli.RazonSocial + sLineBreak +
               cli.Domicilio + sLineBreak +
               cli.Telefono.ToString;

end;


procedure TfmClientes.FormCreate(Sender: TObject);
begin
   list:= listado_clientes;
   fframe:= TClienteCard.Create(nil);
end;

procedure TfmClientes.FormShow(Sender: TObject);
var untEditClientes: TfmEditClientes;
begin
   ListarClientes;
end;

procedure TfmClientes.Image1Click(Sender: TObject);
begin
   Self.Close;
end;


procedure TfmClientes.lbClientesItemClick(const Sender: TCustomListBox;
         const Item: TListBoxItem);
var untEditClientes: TfmEditClientes;
begin
   untEditClientes := TfmEditClientes.Create(Item);
   untEditClientes.inicializar(list[lbClientes.ItemIndex]);
   untEditClientes.ShowModal(
       procedure(ModalResult: TModalResult)
       var ok: Boolean;
         begin
         ok:= ModalResult = mrOk;
         if ok then
            begin
            pintar_datos_cliente(lbClientes.ListItems[lbClientes.ItemIndex], untEditClientes.FCli);
            end;
         untEditClientes.Close;
         end
   );

end;

end.
