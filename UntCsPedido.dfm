inherited frmCsPedido: TfrmCsPedido
  Caption = 'Consulta de Pedidos'
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
          FieldName = 'Sit'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Valor_total'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Hora'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Data_inc'
          Visible = True
        end>
    end
  end
  inherited Panel3: TPanel
    inherited edt_nome: TLabeledEdit
      EditLabel.Width = 11
      EditLabel.Caption = 'ID'
      EditLabel.ExplicitLeft = 74
      EditLabel.ExplicitTop = 15
      EditLabel.ExplicitWidth = 11
    end
    inherited btn_filtrar_sc: TButton
      OnClick = btn_filtrar_scClick
    end
  end
  inherited FDQryCons: TFDQuery
    SQL.Strings = (
      'select * from Pedido')
  end
end
