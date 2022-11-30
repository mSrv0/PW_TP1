unit untEditClientes;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects, FMX.Edit, cUnit, FMX.Layouts,
  System.Actions, FMX.ActnList, moduloDatos_u, FMX.EditBox, FMX.NumberBox;

type
  TfmEditClientes = class(TForm)
    lb_RazonSocial: TLabel;
    lb_MasInfo: TLabel;
    img_BackCli: TImage;
    ly_ContEdits: TLayout;
    StyleBook1: TStyleBook;
    ed_Domicilio: TEdit;
    lb_Domicilio: TLabel;
    lb_Localidad: TLabel;
    ed_Localidad: TEdit;
    lb_Telefono: TLabel;
    ed_Email: TEdit;
    lb_Email: TLabel;
    rec_ContBotones: TRectangle;
    Rectangle1: TRectangle;
    btn_Aceptar: TButton;
    Rectangle2: TRectangle;
    btn_Cancelar: TButton;
    img_Edit: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Rectangle3: TRectangle;
    ActionList1: TActionList;
    ac_Editar: TAction;
    ac_EditarCampo: TAction;
    nb_Telefono: TNumberBox;
    procedure img_BackCliClick(Sender: TObject);
    procedure ac_EditarExecute(Sender: TObject);

    procedure btn_AceptarClick(Sender: TObject);
    procedure btn_CancelarClick(Sender: TObject);



  private
   var FCli: TCliente;


    { Private declarations }
  public
    { Public declarations }
    procedure inicializar(id: Integer);
  end;

var
  fmEditClientes: TfmEditClientes;

implementation

{$R *.fmx}

uses untClientes;



  // rec_ContBotones.Visible:= true;

procedure TfmEditClientes.ac_EditarExecute(Sender: TObject);
begin
    rec_ContBotones.Visible := true;
end;


procedure TfmEditClientes.btn_AceptarClick(Sender: TObject);
var cliObj : TCliente;
begin

   //primero que nada valido las entradas
   if (Trim(ed_Domicilio.Text).Length = 0) then
      begin
         ShowMessage('Debe completar el Domicilio');
         ed_Domicilio.SetFocus;
         Exit
      end;

   if (Trim(ed_Localidad.Text).Length = 0) then
      begin
         ShowMessage('Debe completar el Domicilio');
         ed_Localidad.SetFocus;
         Exit
      end;

   if (nb_Telefono.Text.Length = 0) then
      begin
         ShowMessage('Debe completar el Telefono');
         nb_Telefono.SetFocus;
         Exit
      end;

   if (Trim(ed_Email.Text).Length = 0) then
      begin
         ShowMessage('Debe completar el Email');
         ed_Email.SetFocus;
         Exit
      end;

   //pasò las validaciones

   //cargo sus datos
   FCli.Domicilio:= ed_Domicilio.Text;
   FCli.Localidad:= ed_Localidad.Text;
   FCli.Telefono:= nb_Telefono.Text;
   FCli.Email:= ed_Email.Text;

   MessageDlg('¿Desea guardar los cambior realizados?',
                   System.UITypes.TMsgDlgType.mtConfirmation, FMx.Dialogs.mbYesNo, 0,
                   procedure(const AResult: System.UITypes.TModalResult)
                     begin
                     case AResult of
                     mrYES:   begin
                              //... comienza el guardado de los datos del cliente
                              FCli.modificar;
                              Close;
                              end;
                     mrNo:    Exit;
                     else     Exit;
                     end;
                 end);
end;

procedure TfmEditClientes.btn_CancelarClick(Sender: TObject);
begin
    MessageDlg('¿Desea cancelar y salir de la edicion?',
                   System.UITypes.TMsgDlgType.mtConfirmation, FMx.Dialogs.mbYesNo, 0,
                   procedure(const AResult: System.UITypes.TModalResult)
                     begin
                     case AResult of
                     mrYES: Close;
                     mrNo:    Exit;
                     else     Exit;
                     end;
                 end);
end;

procedure TfmEditClientes.img_BackCliClick(Sender: TObject);
begin
   Self.Close;
end;

procedure TfmEditClientes.inicializar(id: Integer);
begin
   FCli:= TCliente.Create;
   FCli.cargar(id);
   //cargo los datos a editar
   lb_RazonSocial.Text:= Fcli.RazonSocial;
   lb_Domicilio.Text := FCli.Domicilio;
   lb_Localidad.Text := FCli.Localidad;
   lb_Telefono.ToString;
   lb_Telefono.Text := FCli.Telefono;
   lb_Email.Text := FCli.Email;

   ed_Domicilio.Text:= FCli.Domicilio;
   ed_Localidad.Text := FCli.Localidad;
   nb_Telefono.ToString;
   nb_Telefono.Text := FCli.Telefono;
   ed_Email.Text := FCli.Email;
end;




end.
