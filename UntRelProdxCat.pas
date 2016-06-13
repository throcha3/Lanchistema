unit UntRelProdxCat;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UntPadraoRel1, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  frxClass, frxDBSet, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type
  TfrmRelProdxCat = class(TfrmPadraoRel)
    RadioGroup2: TRadioGroup;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelProdxCat: TfrmRelProdxCat;

implementation

{$R *.dfm}

procedure TfrmRelProdxCat.BitBtn1Click(Sender: TObject);
var strLiga,st:string;
begin
  st:= '';
  StrLiga := ' WHERE ';
  FDQuery1.Close;
  with FDQuery1.sql do
    begin
      clear;
      Add('SELECT  Produto.ID,Produto.Status ,Produto.Nome AS ProdNome, '
      +'Categoria.Nome AS CatNome FROM Produto INNER JOIN '
      +'Categoria ON Produto.Id_categoria = Categoria.ID ');
      case RadioGroup2.ItemIndex of
        1: st := 'S';
        2: st := 'N';
      end;
      if st <> '' then
        try
          Add(StrLiga + 'Produto.Status = ' + QuotedStr(st));
        except
          on EconvertError do;
        end;
      Add('GROUP BY PRODUTO.ID, Produto.Nome, Categoria.Nome, Produto.Status '
      +'ORDER BY CatNome ');
    end;
  //ShowMessage ( FDQuery1.sql.Text);
  inherited;
end;

procedure TfrmRelProdxCat.FormActivate(Sender: TObject);
begin
  inherited;
  RadioGroup2.ItemIndex := 0;
end;

end.
