unit untEditLista;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Controls.Presentation, FMX.Layouts, cUnit, uJSON, FMX.Objects;

type
  TfmEditLista = class(TForm)
    bt_Cambiar: TButton;
    bt_Cancelar: TButton;
    ed_Domicilio: TEdit;
    ed_Email: TEdit;
    ed_RazonSocial: TEdit;
    ed_Telefono: TEdit;
    lb_Domicilio: TLabel;
    lb_Email: TLabel;
    lb_RazonSocial: TLabel;
    lb_Telefono: TLabel;
    rec_Domicilio: TRectangle;
    rec_Botones: TRectangle;
    rec_Email: TRectangle;
    rec_RazonSocial: TRectangle;
    rec_Telefono: TRectangle;
    procedure bt_CancelarClick(Sender: TObject);
    procedure bt_CambiarClick(Sender: TObject);
  private
    FCliente : TCliente;
    { Private declarations }
  public
    { Public declarations }
    procedure inicializar(cli: TCliente);
  end;

var
  fmEditLista: TfmEditLista;

implementation

{$R *.fmx}

procedure TfmEditLista.bt_CambiarClick(Sender: TObject);
begin
   if (Trim(ed_RazonSocial.Text).Length = 0) then
      begin
         ShowMessage('El campo RazonSocial debe modificarse');
         ed_RazonSocial.SetFocus;
         Exit
      end;

   if (Trim(ed_Domicilio.Text).Length = 0) then
      begin
         ShowMessage('El campo Domicilio debe modificarse');
         ed_Domicilio.SetFocus;
         Exit
      end;

   if (Trim(ed_Telefono.Text).Length = 0) then
      begin
         ShowMessage('El campo Telefono debe modificarse');
         ed_Telefono.SetFocus;
         Exit
      end;

   if (Trim(ed_Email.Text).Length = 0) then
      begin
         ShowMessage('El campo Email debe modificarse');
         ed_Email.SetFocus;
         Exit
      end;

{   if (ed_RazonSocial.Text = '') then
    FCliente.RazonSocial else
    FCliente.RazonSocial := ed_RazonSocial.Text;}

  MessageDlg('¿Desea guardar los cambior realizados?',
               System.UITypes.TMsgDlgType.mtConfirmation, FMx.Dialogs.mbYesNo, 0,
               procedure(const AResult: System.UITypes.TModalResult)
                 begin
                 case AResult of
                 mrYES:     begin
                            FCliente.RazonSocial := ed_RazonSocial.Text;
                            FCliente.Domicilio := ed_Domicilio.Text;
                            FCliente.Telefono := ed_Telefono.Text;
                            FCliente.Email := ed_Email.Text;
                            //... comienza el guardado de los datos del cliente
                            FCliente.modificar;
                            ModalResult:= mrOk
                            end;
                 mrNo:    Exit;
                 else     Exit;
                 end;
             end);
end;

procedure TfmEditLista.bt_CancelarClick(Sender: TObject);
begin
    MessageDlg('¿Desea cancelar y salir de la edicion?',
                   System.UITypes.TMsgDlgType.mtConfirmation, FMx.Dialogs.mbYesNo, 0,
                   procedure(const AResult: System.UITypes.TModalResult)
                     begin
                     case AResult of
                     mrYES: ModalResult:= mrCancel;
                     mrNo:    Exit;
                     else     Exit;
                     end;
                 end);
end;

procedure TfmEditLista.inicializar(cli: TCliente);
begin
  FCliente := cli;
  lb_RazonSocial.Text := 'Razon Social: ';
  lb_Domicilio.Text :=  'Domicilio: ';
  lb_Telefono.Text := 'Telefono: ';
  lb_Email.Text := 'Email: ';

  ed_RazonSocial.Text := cli.RazonSocial;
  ed_Domicilio.Text := cli.Domicilio;
  ed_Telefono.Text := cli.Telefono;
  ed_Email.Text := cli.Email;
end;

end.
