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
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope,
  logUnit;

type
  TFmPrincipal = class(TForm)
    lyTooBar: TLayout;
    ImgMenu: TImage;
    Image2: TImage;
    Label1: TLabel;
    StyleBook1: TStyleBook;
    RecMenu: TRectangle;
    Image4: TImage;
    backMenu: TImage;
    LBL_Usuario: TLabel;
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
    ac_CerrarSesion: TAction;
    procedure ImgMenuClick(Sender: TObject);
    procedure backMenuClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Rectangle1Click(Sender: TObject);
    procedure lvListaStoreItemClick(const Sender: TObject; const AItem: TListViewItem);
    procedure Rectangle3Click(Sender: TObject);
    procedure OpenMenu(ind: boolean);
    procedure FormDestroy(Sender: TObject);
    procedure ac_CerrarSesionExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
  private
    { Private declarations }
    FUsuarioLogueado: TUsuario;
  public
    { Public declarations }
    procedure inicializar(const idUsu: Integer);
  end;

var
  FmPrincipal: TFmPrincipal;

implementation
 uses UnitLogin, untClientes, untArticulos;
{$R *.fmx}


//En el menu desplegable se ejecuta el boton "CERRAR SESION"
procedure TFmPrincipal.ac_CerrarSesionExecute(Sender: TObject);
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

         //FUNCION ONCLICK AL APARTADO ARTICULOS

procedure TFmPrincipal.Rectangle3Click(Sender: TObject);
var untArticulos :  TFrArticulos;
begin
   untArticulos := TFrArticulos.Create(Application);
   untArticulos.Show;

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
  FUsuarioLogueado:= TUsuario.Create;
    RecMenu.Visible := false;

    // Llama al listar los clientes
end;

procedure TFmPrincipal.FormDestroy(Sender: TObject);
begin
  if Assigned(FUsuarioLogueado) then
    FUsuarioLogueado.Free
end;

     //CONSULTA Y CONTROL DEL BOTON NATIVO DE ANDROID BACK
procedure TFmPrincipal.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
   ac_CerrarSesionExecute(nil);
   Key:= 0;
end;

procedure TFmPrincipal.lvListaStoreItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
    if NOT Assigned(fmClientes) then
      Application.CreateForm(TfmClientes, fmClientes);

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

procedure TFmPrincipal.inicializar(const idUsu: Integer);
begin
  FUsuarioLogueado.load(idUsu);
  LBL_Usuario.Text:= ('Bienvenido/a ' + FUsuarioLogueado.asString)
end;

end.
