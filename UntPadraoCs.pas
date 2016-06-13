unit UntPadraoCs;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Vcl.StdCtrls,
  Vcl.ExtCtrls, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids,
  Vcl.DBGrids, Vcl.ComCtrls, Vcl.Buttons;

type
  TfrmPadraoCs = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    edt_nome: TLabeledEdit;
    btn_filtrar_sc: TButton;
    btn_filtrar_ft: TButton;
    FDQryCons: TFDQuery;
    GroupBox1: TGroupBox;
    dtpDe: TDateTimePicker;
    dtpAte: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    RadioGroup1: TRadioGroup;
    BitBtn1: TBitBtn;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPadraoCs: TfrmPadraoCs;

implementation

{$R *.dfm}

uses UntDM;

procedure TfrmPadraoCs.BitBtn1Click(Sender: TObject);
begin
  Close;
end;


end.
