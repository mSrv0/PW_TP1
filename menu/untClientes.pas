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
  FireDAC.Comp.Client;

type
  TfmClientes = class(TForm)
    Label1: TLabel;
    Image1: TImage;
    rectBusqueda: TRectangle;
    Edit1: TEdit;
    Image3: TImage;
    Buscar: TButton;
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
  private
    procedure ListarClientes;
    procedure AddCliente(Cid: integer; direccion, nombre: string; telefono: double);

    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmClientes: TfmClientes;

implementation

{$R *.fmx}
uses untPrincipal, Frame.ClienteCard;

procedure TfmClientes.AddCliente(Cid: integer;
                                 direccion, nombre: string;
                                 telefono: double);
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

procedure TfmClientes.ListarClientes;
var cli: TCliente;
    list: TObjectList<TCliente>;
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

   list:= listado_clientes;
   for k:= 0 to list.Count - 1 do
      begin
      cli:= list[k];
      //pinto el cliente
      AddCliente(cli.Id, cli.Domicilio, cli.RazonSocial, cli.Telefono);
      end;

   //libero el listado
   list.Free
end;

procedure TfmClientes.FormShow(Sender: TObject);
begin
   ListarClientes;
end;

end.
