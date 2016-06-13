unit UntPadrao1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.ImageList, Vcl.ImgList,
  Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Buttons,
  Vcl.ExtCtrls;

type
  TExecutar = (navegacao, sentencaSQL, exibePanels,
              desabilitaBotoes, habilitaBotoes, exibeBotoes);
  TFrmPadrao1 = class(TForm)
    FDTabela: TFDTable;
    DSPadrao: TDataSource;
    ImgLstDisabled: TImageList;
    ImgLstHot: TImageList;
    ToolBar1: TToolBar;
    btn_Pesquisa: TToolButton;
    Separador1: TToolButton;
    btn_Primeiro: TToolButton;
    btn_Anterior: TToolButton;
    btn_Proximo: TToolButton;
    btn_Ultimo: TToolButton;
    Separador2: TToolButton;
    btn_Sair: TToolButton;
    StatusBar1: TStatusBar;
    PanelFicha: TPanel;
    lbldohue: TLabel;
    lblID: TLabel;
    Panel1: TPanel;
    PanelEntrada: TPanel;
    Label1: TLabel;
    btnOk: TSpeedButton;
    ValorCampo: TEdit;
    btn_cancelar: TBitBtn;
    btn_salvar: TBitBtn;
    btn_excluir: TBitBtn;
    btn_alterar: TBitBtn;
    btn_inserir: TBitBtn;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    procedure btn_PrimeiroClick(Sender: TObject);
    procedure btn_AnteriorClick(Sender: TObject);
    procedure btn_ProximoClick(Sender: TObject);
    procedure btn_UltimoClick(Sender: TObject);
    procedure btn_InserirClick(Sender: TObject);
    procedure btn_AlterarClick(Sender: TObject);
    procedure btn_ExcluirClick(Sender: TObject);
    procedure btn_SalvarClick(Sender: TObject);
    procedure btn_CancelarClick(Sender: TObject);
    procedure btn_SairClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
    FEXecutar: TExecutar;
    procedure SetExecutar(const Value: TExecutar);
  public
    { Public declarations }
    property Executar: TExecutar read FEXecutar
                                 write SetExecutar;
  end;

var
  FrmPadrao1: TFrmPadrao1;
  //Armazena a senten�a SQL atual
  strSqlAtual: String;
  //Define o tipo do campo ID
  tipoID: integer;
  //Armazena a sente�a SQL
  strSQL: String;
  //Define o nome da tabela em uso
  nomeTabela: String;
  //Define opera��o de inclus�o
  operacaoIncluir: Integer;
  //Define as a��es de inclus�o, altera��o e exlcus�o
  modoEdicao: String;
  //Define o titulo da Janelas Filhas
  nomeJanela: String;
  //Armazena datas no formato String
  valdata1, valdata2, val1, val2: String;
  //Armazena o nome de uma tarefa em Andamento
  tarefa: String;
  //Contole do bot�o pesquisar da Janela PesqData
  tarefaClick: integer;
  //Montagem da mensagem de informa��o
  mensagem: String;

implementation

{$R *.dfm}

uses UntDM;

{ TFrmPadrao1 }

procedure TFrmPadrao1.btnOkClick(Sender: TObject);
begin
  FDTabela.Locate('ID',ValorCampo.Text,[]);
  lblID.Caption := ValorCampo.Text;
end;

procedure TFrmPadrao1.btn_AlterarClick(Sender: TObject);
begin
  FDTabela.Edit;

  //Habilita a exibi��o de Objetos
  ValorCampo.Enabled:= False;
  btnOk.Enabled:= False;
  PanelFicha.Enabled:= True;

  //Altera��o de registro
  FDTabela.FieldByName('DATA_ALT').AsDateTime:= Date;

  //Bot�es e barra de status
  Executar:= desabilitaBotoes;
  StatusBar1.Panels[2].Text:= 'Altera��o de registro';

  Executar:= exibePanels;
end;

procedure TFrmPadrao1.btn_AnteriorClick(Sender: TObject);
begin
  FDTabela.Prior;
  Executar:= navegacao;
  Executar:= exibePanels;
end;

procedure TFrmPadrao1.btn_CancelarClick(Sender: TObject);
begin
  FDTabela.Cancel;

  mensagem:= 'A inclus�o ou altera��o deste registro foi abortada.';
  Application.MessageBox(PChar(mensagem),'Aten��o',MB_OK+MB_ICONERROR);

  Executar:= habilitaBotoes;

  //Habilita a exibi��o de objetos
  ValorCampo.Text       := '';
  ValorCampo.Enabled    := True;
  btnOk.Visible         := True;
  PanelFicha.Enabled    := False;

end;

procedure TFrmPadrao1.btn_ExcluirClick(Sender: TObject);
var confExcl: integer;
begin
  Beep;
  confExcl:= Application.MessageBox(
    'Confirma a exclus�o desse registro?','Aten��o',MB_YESNO+MB_DEFBUTTON2+MB_ICONQUESTION);

    if confExcl = IDYES then
    begin
      FDTabela.Delete;
      mensagem:= 'O registro foi excluido com sucesso.';
      Application.MessageBox(PChar(mensagem),'Informa��o',MB_OK+MB_ICONINFORMATION);
    end;

    if confExcl = IDNO then
    begin
      mensagem:= 'A exclus�o desse registro foi abortada.';
      Application.MessageBox(PChar(mensagem),'Informa��o',MB_OK+MB_ICONINFORMATION);
    end;

    Executar:= habilitaBotoes;
    Executar:= exibePanels;
end;

procedure TFrmPadrao1.btn_InserirClick(Sender: TObject);
begin
  operacaoIncluir:= 1;

  if FDTabela.Active = False then
  begin
    FDTabela.Open();
  end;

  FDTabela.Insert;

  //Habilita a exibi��o de Objetos
  ValorCampo.Enabled    := False;
  btnOk.Enabled         := False;
  PanelFicha.Enabled    := True;

  //Inclus�o de registro
  FDTabela.FieldByName('STATUS').AsString:= 'S';
  FDTabela.FieldByName('DATA_INC').AsDateTime:= Date;

  //Bot�es e barra de status
  Executar:= desabilitaBotoes;
  StatusBar1.Panels[2].Text:= 'Inclus�o de novo registro';

  Executar:= exibePanels;
  operacaoIncluir:= 0;
end;

procedure TFrmPadrao1.btn_PrimeiroClick(Sender: TObject);
begin
  FDTabela.First;
  Executar:= navegacao;
  Executar:= exibePanels;
end;

procedure TFrmPadrao1.btn_ProximoClick(Sender: TObject);
begin
  FDTabela.Next;
  Executar:= navegacao;
  Executar:= exibePanels;
end;

procedure TFrmPadrao1.btn_SairClick(Sender: TObject);
begin
  FDTabela.Close;
  Close;
end;

procedure TFrmPadrao1.btn_SalvarClick(Sender: TObject);
begin
  FDTabela.Post;

  mensagem:= 'O registro foi incluido ou alterado com sucesso.';
  Application.MessageBox(PChar(mensagem),'Informa��o',MB_OK+MB_ICONINFORMATION);

  Executar:= habilitaBotoes;

  //Habilita a exibi��o de objetos
  ValorCampo.Text       := '';
  ValorCampo.Enabled    := True;
  btnOk.Visible         := True;
  PanelFicha.Enabled    := False;

end;

procedure TFrmPadrao1.btn_UltimoClick(Sender: TObject);
begin
  FDTabela.Last;
  Executar:= navegacao;
  Executar:= exibePanels;
end;

procedure TFrmPadrao1.SetExecutar(const Value: TExecutar);
begin
  FEXecutar:= Value;
  case value of
    //Habilita bot�es de navega��o
    navegacao:
      begin
        if FDTabela.Eof = True then
          begin
            btn_Proximo.Enabled:= False;
            btn_Ultimo.Enabled:= False;
          end
        else
          begin
            btn_Proximo.Enabled:= True;
            btn_Ultimo.Enabled:= True;
          end;

        if FDTabela.Bof = True then
          begin
            btn_Primeiro.Enabled:= False;
            btn_Anterior.Enabled:= False;
          end
        else
          begin
            btn_Primeiro.Enabled:= True;
            btn_Anterior.Enabled:= True;
          end;
      end;
    //Executar a senten�a SQL
    sentencaSQL:
      begin
        FDTabela.Close;
        FDTabela.Open();

        if (FDTabela.RecordCount = 0) and (operacaoIncluir = 0) then
          begin
            mensagem:= 'Nenhum registro encontrado!! ';
            Application.MessageBox(PChar(mensagem),'Informa��o',MB_OK+MB_ICONINFORMATION);
          end;
      end;
    //Exibe os textos nos paineis da barra de status
    exibePanels:
      begin
        StatusBar1.Panels[0].Text:= 'INC: ' + FDTabela.FieldByName('DATA_INC').AsString;
        StatusBar1.Panels[1].Text:= 'ALT: ' + FDTabela.FieldByName('DATA_ALT').AsString;
        StatusBar1.Panels[3].Text:=           FDTabela.FieldByName('ID').AsString;
        lblID.Caption := FDTabela.FieldByName('ID').AsString;

      if (FDTabela.RecordCount = 0) and (operacaoIncluir = 0) then
        begin
          StatusBar1.Panels[0].Text:= '';
          StatusBar1.Panels[1].Text:= '';
          StatusBar1.Panels[2].Text:= '';
          StatusBar1.Panels[3].Text:= '';
        end;

    end;
    //Desabilita bot�es ao incluir ou alterar um registro
    desabilitaBotoes:
      begin
        btn_Pesquisa.Enabled:= False;
        btn_Primeiro.Enabled:= False;
        btn_Anterior.Enabled:= False;
        btn_Proximo.Enabled:= False;
        btn_Ultimo.Enabled:= False;
        btn_Inserir.Enabled:= False;
        btn_Alterar.Enabled:= False;
        btn_Excluir.Enabled:= False;
        btn_Salvar.Enabled:= True;
        btn_Cancelar.Enabled:= True;
        btn_Sair.Enabled:= False;
      end;
    //Habilita bot�es ao Salvar ou Cancelar uma inclus�o ou altera��o
    habilitaBotoes:
      begin
        if FDTabela.RecordCount > 0 then
          begin
            btn_Pesquisa.Enabled:= True;
          end
        else
          begin
            btn_Pesquisa.Enabled:= False;
          end;
        btn_Primeiro.Enabled:= True;
        btn_Anterior.Enabled:= True;
        btn_Proximo.Enabled:= True;
        btn_Ultimo.Enabled:= True;
        btn_Inserir.Enabled:= True;
        if FDTabela.RecordCount = 0 then
          begin
            btn_Alterar.Enabled:= False;
            btn_Excluir.Enabled:= False;
          end
        else
          begin
            btn_Alterar.Enabled:= True;
            btn_Excluir.Enabled:= True;
          end;
        btn_Salvar.Enabled:= False;
        btn_Cancelar.Enabled:= False;
        btn_Sair.Enabled:= True;
      end;
      //Exibe bot�es de edi��o conforme o perfil do usuario
      exibeBotoes:
      begin
        if modoEdicao = 'NNN' then
          begin
            btn_Inserir.Visible:= False;
            btn_Alterar.Visible:= False;
            btn_Excluir.Visible:= False;
            btn_Salvar.Visible:= False;
            btn_Cancelar.Visible:= False;
          end;

        if modoEdicao = 'NNS' then
          begin
            btn_Inserir.Visible:= False;
            btn_Alterar.Visible:= False;
            btn_Excluir.Visible:= True;
            btn_Salvar.Visible:= False;
            btn_Cancelar.Visible:= False;
          end;

        if modoEdicao = 'NSN' then
          begin
            btn_Inserir.Visible:= False;
            btn_Alterar.Visible:= True;
            btn_Excluir.Visible:= False;
            btn_Salvar.Visible:= True;
            btn_Cancelar.Visible:= True;
          end;

        if modoEdicao = 'NSS' then
          begin
            btn_Inserir.Visible:= False;
            btn_Alterar.Visible:= True;
            btn_Excluir.Visible:= True;
            btn_Salvar.Visible:= True;
            btn_Cancelar.Visible:= True;
          end;

        if modoEdicao = 'SNN' then
          begin
            btn_Inserir.Visible:= True;
            btn_Alterar.Visible:= False;
            btn_Excluir.Visible:= False;
            btn_Salvar.Visible:= True;
            btn_Cancelar.Visible:= True;
          end;

        if modoEdicao = 'SSN' then
          begin
            btn_Inserir.Visible:= True;
            btn_Alterar.Visible:= True;
            btn_Excluir.Visible:= False;
            btn_Salvar.Visible:= True;
            btn_Cancelar.Visible:= True;
          end;

        if modoEdicao = 'SNS' then
          begin
            btn_Inserir.Visible:= True;
            btn_Alterar.Visible:= False;
            btn_Excluir.Visible:= True;
            btn_Salvar.Visible:= True;
            btn_Cancelar.Visible:= True;
          end;

        if modoEdicao = 'SSS' then
          begin
            btn_Inserir.Visible:= True;
            btn_Alterar.Visible:= True;
            btn_Excluir.Visible:= True;
            btn_Salvar.Visible:= True;
            btn_Cancelar.Visible:= True;
          end;
      end;
  end;
end;

end.
