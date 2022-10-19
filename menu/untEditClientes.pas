unit untEditClientes;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects, FMX.Edit, cUnit;

type
  TfmEditClientes = class(TForm)
    btn_Editar: TButton;
    Label1: TLabel;
    img_BackCli: TImage;
    Rectangle1: TRectangle;
    Label2: TLabel;
    ed_localidad: TEdit;
    lb_RazonSocial: TLabel;
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
