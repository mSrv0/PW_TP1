unit UnitLogin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl,
  FMX.Objects, FMX.Edit, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.FMXUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, System.Notification,
  Data.FMTBcd, Data.SqlExpr, Data.Bind.Components, Data.Bind.DBScope;

type
  TFLogin = class(TForm)
    TabControl: TTabControl;
    TabLogin: TTabItem;
    TabCuenta1: TTabItem;
    TabCuenta2: TTabItem;
    Image1: TImage;
    Layout1: TLayout;
    Label1: TLabel;
    ed_Usuario: TEdit;
    bt_Login: TButton;
    CreaCuenta: TLabel;
    Image2: TImage;
    Layout2: TLayout;
    Label3: TLabel;
    DE_Name: TEdit;
    DE_Password: TEdit;
    btnSiguiente1: TButton;
    Label4: TLabel;
    Label5: TLabel;
    DE_Email: TEdit;
    Image3: TImage;
    Layout3: TLayout;
    Label6: TLabel;
    Button2: TButton;
    Label7: TLabel;
    Label8: TLabel;
    DE_Ciudad: TEdit;
    Layout4: TLayout;
    CP: TEdit;
    DE_Direccion: TEdit;
    DE_Barrio: TEdit;
    StyleBook1: TStyleBook;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    ed_Password: TEdit;
    procedure SQLQuery1ParseInsertSql(var FieldNames: TStrings; SQL: string;
      var BindAllFields: Boolean; var TableName: string);
    procedure bt_LoginClick(Sender: TObject);
    procedure CreaCuentaClick(Sender: TObject);
  private
    { Private declarations }
    FUserKey: Integer;
    FUserDescription: string;
  public
    { Public declarations }
  end;

var
  FLogin: TFLogin;

implementation

{$R *.fmx}
{$R *.SmXhdpiPh.fmx ANDROID}
 uses untPrincipal, moduloDatos_u, logUnit;

procedure TFLogin.CreaCuentaClick(Sender: TObject);
var UnitLogin : TFLogin;
begin
   TabCuenta1.Create(Application);

end;

procedure TFLogin.bt_LoginClick(Sender: TObject);
 var
untPrincipal : TFmPrincipal;
begin
      if (ed_Usuario.Text = '') then
        begin
              ShowMessage('Debe contener un usuario');
              exit
        end;
      if (ed_Password.Text = '') then
        begin
              ShowMessage('Debe contener un password');
              exit
        end;
      if user_validation(FUserKey, FUserDescription, trim(ed_Usuario.Text), trim(ed_Password.Text)) then
        begin
        untPrincipal := TFmPrincipal.Create(Application);
        untPrincipal.inicializar(FUserKey);
        untPrincipal.Show;
        ShowMessage('Bienvenido/a ' + FUserDescription);
        end;
end;

procedure TFLogin.SQLQuery1ParseInsertSql(var FieldNames: TStrings; SQL: string;
  var BindAllFields: Boolean; var TableName: string);
begin
 FieldNames.Create
end;

end.
