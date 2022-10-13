unit untClientes;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Edit, FMX.ListBox, cUnit;

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
    procedure FormShow(Sender: TObject);
  private
    procedure ListarClientes;
    procedure AddCliente(Cid: integer; direccion, nombre: string;
      telefono: double);

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

begin
            // Acceder a datos de card clientes

    AddCliente(0, 'Dir. Teodoro Planas 4141', 'Makro', 111-222-333);
    AddCliente(0, 'Dir. Teodoro Planas 4141', 'Makro', 111-222-333);
    AddCliente(0, 'Dir. Teodoro Planas 4141', 'Makro', 111-222-333);
    AddCliente(0, 'Dir. Teodoro Planas 4141', 'Makro', 111-222-333);
    AddCliente(0, 'Dir. Teodoro Planas 4141', 'Makro', 111-222-333);
    AddCliente(0, 'Dir. Teodoro Planas 4141', 'Makro', 111-222-333);

end;

procedure TfmClientes.FormShow(Sender: TObject);
begin
   ListarClientes;
end;

end.
