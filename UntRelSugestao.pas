unit UntRelSugestao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UntPadraoRel1, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  frxClass, frxDBSet, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type
  TfrmRelSugestao = class(TfrmPadraoRel)
    GroupBox1: TGroupBox;
    ComboBox1: TComboBox;
    FDQuery2: TFDQuery;
    procedure FormActivate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelSugestao: TfrmRelSugestao;

implementation

{$R *.dfm}

procedure TfrmRelSugestao.BitBtn1Click(Sender: TObject);
var StrLiga:string;
begin
  StrLiga := ' AND ';
  FDQuery1.Close;
  with FDQuery1.sql do
    begin
      clear;
      Add('SELECT Produto.ID, Produto.Nome, Produto.Pr_custo, Produto.Qtde_real, '
      +'Produto.Qtde_minima, (Produto.Qtde_minima - Produto.Qtde_real) AS QtSuges, '
      +'(Produto.Qtde_minima - Produto.Qtde_real)* Produto.Pr_custo AS CustoSuges, '
      +' Categoria.Nome AS CatNome '
      +'FROM Produto INNER JOIN Categoria ON Produto.Id_categoria = Categoria.ID '
      +'WHERE (Produto.Comp = '+QuotedStr('N')+') AND (Produto.Qtde_minima - Produto.Qtde_real > 0)' );

      if ComboBox1.ItemIndex <> 0 then
        Add(StrLiga + 'Categoria.Nome = ' + QuotedStr(ComboBox1.Text));
    end;
  //ShowMessage ( FDQuery1.sql.Text);
  inherited;
end;

procedure TfrmRelSugestao.FormActivate(Sender: TObject);
begin
  inherited;
  ComboBox1.Items.Clear;
  ComboBox1.Items.Add('Todas');
  FDQuery2.Open();
  FDQuery2.First;
  while not FDQuery2.Eof do
    begin
      Combobox1.Items.Add(FDQuery2.FieldByName('nome').asString);
      FDQuery2.Next;
    end;
  FDQuery2.Close;
  Combobox1.ItemIndex := 0;
end;

end.
