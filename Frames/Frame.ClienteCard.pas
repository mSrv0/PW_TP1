unit Frame.ClienteCard;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects;

type
  TClienteCard = class(TFrame)
    lbTel: TLabel;
    lbNombre: TLabel;
    lbUbi: TLabel;
    Image3: TImage;
    imgTienda: TImage;
    Z: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

uses untPrincipal, untClientes;

end.
