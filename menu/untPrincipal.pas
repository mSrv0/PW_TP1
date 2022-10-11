unit untPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, System.Actions, FMX.ActnList, FMX.Gestures, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Datasnap.Provider,
  Datasnap.DBClient, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope;

type
  TFmPrincipal = class(TForm)
    lyTooBar: TLayout;
    ImgMenu: TImage;
    Image2: TImage;
    Label1: TLabel;
    lyBusqueda: TLayout;
    StyleBook1: TStyleBook;
    rectBusqueda: TRectangle;
    Edit1: TEdit;
    Image3: TImage;
    Buscar: TButton;
    lySwitch: TLayout;
    rectSwitch: TRectangle;
    Rectangle2: TRectangle;
    Label2: TLabel;
    Label3: TLabel;
    lvListaStore: TListView;
    RecMenu: TRectangle;
    Image4: TImage;
    backMenu: TImage;
    Label4: TLabel;
    Label5: TLabel;
    Rectangle1: TRectangle;
    Label6: TLabel;
    Rectangle3: TRectangle;
    Label7: TLabel;
    Rectangle4: TRectangle;
    Label8: TLabel;
    GestureManager1: TGestureManager;
    ActionList1: TActionList;
    ActionL: TAction;
    ActionR: TAction;
    Image1: TImage;
    imgLocal: TImage;
    imgUbic: TImage;
    imgTel: TImage;
    QueryD: TFDQuery;
    DataSetProvider1: TDataSetProvider;
    ClientDataSet1: TClientDataSet;
    QueryDid: TFDAutoIncField;
    QueryDrazon_social: TStringField;
    QueryDdomicilio: TStringField;
    QueryDlocalidad: TStringField;
    QueryDtelefono: TIntegerField;
    QueryDemail: TStringField;
    ClientDataSet1id: TAutoIncField;
    ClientDataSet1razon_social: TStringField;
    ClientDataSet1domicilio: TStringField;
    ClientDataSet1localidad: TStringField;
    ClientDataSet1telefono: TIntegerField;
    ClientDataSet1email: TStringField;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkFillControlToField1: TLinkFillControlToField;
    procedure ImgMenuClick(Sender: TObject);
    procedure backMenuClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Rectangle1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lvListaStoreItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure Rectangle4Click(Sender: TObject);
    procedure Rectangle3Click(Sender: TObject);


  private
    procedure OpenMenu(ind: boolean);
    procedure AddClienteLV(id_cliente: integer; nombre, categoria, direccion: string;
      telefono: double);
    procedure ListarClientes;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FmPrincipal: TFmPrincipal;

implementation
 uses UnitLogin, untClientes, untArticulos;
{$R *.fmx}

// Se agregan valores de Lista clientes
procedure TFmPrincipal.AddClienteLV(id_cliente: integer;
                                    nombre, categoria, direccion: string;
                                    telefono: double);

     //Camptura la imagen que tiene la vista
     //COMIENZA
var
   img: TListItemImage;
   txt: TListItemText;

begin
   with lvListaStore.Items.Add do
   begin
      height := 120;
      Tag := id_cliente;

      // Devuelve y captura los item IMG

      img := TListItemImage(Objects.FindDrawable('imgLocal'));
      img.Bitmap := imgLocal.Bitmap;

      img := TListItemImage(Objects.FindDrawable('imgTel'));
      img.Bitmap := imgTel.Bitmap;

      img := TListItemImage(Objects.FindDrawable('imgUbic'));
      img.Bitmap := imgUbic.Bitmap;

      //Devuelve y captura las caracteristicas de cada item IMG

      txt := TListItemText(Objects.FindDrawable('txtNombre'));
      txt.Text :=  nombre;

      txt := TListItemText(Objects.FindDrawable('txtCategoria'));
      txt.Text :=  categoria;

      txt := TListItemText(Objects.FindDrawable('txtTelefono'));
      txt.Text :=  '111-222-333';

      txt := TListItemText(Objects.FindDrawable('txtUbicacion'));
      txt.Text :=  direccion;
   end;
end;

 // TERMINA


procedure TFmPrincipal.OpenMenu(ind: boolean);
begin
   RecMenu.Visible := ind;
end;

procedure TFmPrincipal.Rectangle1Click(Sender: TObject);
var untClientes : TfmClientes;
begin
    untClientes := TfmClientes.Create(Application);
    untClientes.Show;
end;


procedure TFmPrincipal.Rectangle3Click(Sender: TObject);
var untArticulos :  TFrArticulos;
begin
   untArticulos := TFrArticulos.Create(Application);
   untArticulos.Show;
end;

// En el menu desplegable se ejecuta el boton "CERRAR SESION

procedure TFmPrincipal.Rectangle4Click(Sender: TObject);
begin

    MessageDlg('¿Desea salir de la aplicación?',
                   System.UITypes.TMsgDlgType.mtConfirmation, FMx.Dialogs.mbYesNo, 0,
                   procedure(const AResult: System.UITypes.TModalResult)
                     begin
                     case AResult of
                     mrYES:   Close;
                     mrNo:    Exit;
                     else     Exit;
                     end;
                 end);

end;

// Funcion de icono flecha backMenu
procedure TFmPrincipal.backMenuClick(Sender: TObject);
begin
    OpenMenu(False);
    RecMenu.AnimateFloat('Margins.Bottom', -290, 0.2,
                           TAnimationType.InOut,
                           TInterpolationType.Circular);
     RecMenu.Tag := 0;
end;


procedure TFmPrincipal.FormCreate(Sender: TObject);
begin
    RecMenu.Visible := false;
end;
           // Llama al listar los clientes
procedure TFmPrincipal.ListarClientes;
begin

end;


procedure TFmPrincipal.lvListaStoreItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
    if NOT Assigned(fmClientes) then
      Application.CreateForm(TfmClientes, fmClientes);

end;

procedure TFmPrincipal.FormShow(Sender: TObject);
begin
  ListarClientes;
end;

procedure TFmPrincipal.Image1Click(Sender: TObject);
begin
   if RecMenu.Tag = 0 then
         ActionL.Execute
   else
      ActionR.Execute;
end;

procedure TFmPrincipal.ImgMenuClick(Sender: TObject);
begin
     OpenMenu (True);
     RecMenu.AnimateFloat('Margins.Bottom', -70, 0.2,
                           TAnimationType.InOut,
                           TInterpolationType.Circular);
     RecMenu.Tag := 1;
end;


end.
