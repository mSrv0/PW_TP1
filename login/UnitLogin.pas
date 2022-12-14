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
  Data.FMTBcd, Data.SqlExpr, Data.Bind.Components, Data.Bind.DBScope, FMX.Ani;

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
    TM_Password: TTimer;
    img_ShowPassword: TImage;
    procedure SQLQuery1ParseInsertSql(var FieldNames: TStrings; SQL: string;
      var BindAllFields: Boolean; var TableName: string);
    procedure bt_LoginClick(Sender: TObject);
    procedure CreaCuentaClick(Sender: TObject);
    procedure TM_PasswordTimer(Sender: TObject);
    procedure img_ShowPasswordClick(Sender: TObject);
    procedure ed_PasswordKeyUp(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure ed_UsuarioKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
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


procedure TFLogin.ed_PasswordKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
   if (KeyChar = chr(ord(vkAccept))) then
      bt_LoginClick(Sender);
end;

procedure TFLogin.ed_UsuarioKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
    if (KeyChar = chr(ord(vkAccept))) and (Trim(ed_Usuario.Text) <> '') then
      ed_Password.SetFocus;
end;

procedure TFLogin.bt_LoginClick(Sender: TObject);
 var
untPrincipal : TFmPrincipal;
begin
      if (trim(ed_Usuario.Text) = '') then
        begin
              ShowMessage('Debe contener un usuario');
              ed_Usuario.SetFocus;
              exit
        end;
      if (trim(ed_Password.Text) = '') then
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
        ed_Usuario.Text := ('');
        ed_Password.Text := ('');
        end;
      SaveState.Stream.Clear; // LIMPIA USUARIO Y CONTRASE?A
end;       



procedure TFLogin.SQLQuery1ParseInsertSql(var FieldNames: TStrings; SQL: string;
  var BindAllFields: Boolean; var TableName: string);
begin
 FieldNames.Create
end;
           //BOTON MUESTRA POR UN LAPSO DE TIEMPO LA CONTRASE?A
procedure TFLogin.img_ShowPasswordClick(Sender: TObject);
begin
   ed_Password.Password:= False;
   TM_Password.Enabled:= True;
end;
              // TEMPORIZADOR PARA MOSTRAR CONTRASE?A
procedure TFLogin.TM_PasswordTimer(Sender: TObject);
begin
   ed_Password.Password:= True;
   TM_Password.Enabled:= False;
end;

end.
