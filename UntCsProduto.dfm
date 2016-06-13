inherited frmCsProduto: TfrmCsProduto
  Caption = 'Consulta de Produtos'
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    inherited btn_filtrar_ft: TButton
      Left = 295
      OnClick = btn_filtrar_ftClick
      ExplicitLeft = 295
    end
  end
  inherited Panel2: TPanel
    inherited DBGrid1: TDBGrid
      DataSource = DataSource1
      Columns = <
        item
          Expanded = False
          FieldName = 'ID'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Nome'
          Width = 200
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Pr_venda'
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Qtde_real'
          Title.Caption = 'Qtde'
          Width = 40
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Data_inc'
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Data_alt'
          Width = 70
          Visible = True
        end>
    end
  end
  inherited Panel3: TPanel
    inherited edt_nome: TLabeledEdit
      EditLabel.Width = 31
      EditLabel.Caption = 'Nome:'
      EditLabel.ExplicitLeft = 54
      EditLabel.ExplicitTop = 15
      EditLabel.ExplicitWidth = 31
    end
    inherited btn_filtrar_sc: TButton
      OnClick = btn_filtrar_scClick
    end
  end
  inherited FDQryCons: TFDQuery
    SQL.Strings = (
      'select * from Produto')
    Left = 552
    Top = 121
  end
  inherited DataSource1: TDataSource
    Top = 121
  end
end
