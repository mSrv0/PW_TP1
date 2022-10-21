unit untEditClientes;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects, FMX.Edit, cUnit, FMX.Layouts;

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
    ed_Telefono: TEdit;
    ed_Email: TEdit;
    lb_Email: TLabel;
    rec_ContBotones: TRectangle;
    Rectangle1: TRectangle;
    btn_Aceptar: TButton;
    Rectangle2: TRectangle;
    btn_Cancelar: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmEditClientes: TfmEditClientes;

implementation

{$R *.fmx}



end.
