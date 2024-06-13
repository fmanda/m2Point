inherited frmCashReceiptDP: TfrmCashReceiptDP
  Caption = 'Cash Receipt / Uang Muka Customer'
  ClientHeight = 340
  ClientWidth = 447
  KeyPreview = True
  OnKeyDown = FormKeyDown
  ExplicitWidth = 463
  ExplicitHeight = 379
  PixelsPerInch = 96
  TextHeight = 13
  inherited cxGroupBox2: TcxGroupBox
    Top = 305
    TabOrder = 1
    ExplicitTop = 305
    ExplicitWidth = 464
    Width = 447
    inherited btnCancel: TcxButton
      Left = 362
      ExplicitLeft = 379
    end
    inherited btnPrint: TcxButton
      Left = 276
      ExplicitLeft = 293
    end
    inherited btnSave: TcxButton
      Left = 190
      OnClick = btnSaveClick
      ExplicitLeft = 207
    end
  end
  inherited Panel2: TPanel
    Top = 284
    Width = 447
    TabOrder = 2
    ExplicitTop = 284
    ExplicitWidth = 464
    inherited lbEscape: TLabel
      Left = 367
      Height = 17
      ExplicitLeft = 384
    end
    inherited lgndSave: TLabel
      Left = 202
      Height = 17
      ExplicitLeft = 219
    end
    inherited lgndPrint: TLabel
      Left = 289
      Height = 17
      ExplicitLeft = 306
    end
  end
  object cxGroupBox1: TcxGroupBox [2]
    Left = 0
    Top = 0
    Align = alClient
    Caption = '  Data  [F1] '
    TabOrder = 0
    ExplicitWidth = 464
    Height = 284
    Width = 447
    object cxLabel1: TcxLabel
      Left = 60
      Top = 55
      Caption = 'No. Bukti'
    end
    object edRefno: TcxTextEdit
      Left = 107
      Top = 54
      TabStop = False
      Properties.CharCase = ecUpperCase
      TabOrder = 0
      Width = 118
    end
    object cxLabel6: TcxLabel
      Left = 64
      Top = 158
      Caption = 'Catatan'
    end
    object edNotes: TcxMemo
      Left = 107
      Top = 156
      TabOrder = 3
      Height = 40
      Width = 259
    end
    object dtTransDate: TcxDateEdit
      Left = 276
      Top = 54
      TabStop = False
      Properties.ImmediatePost = True
      Properties.SaveTime = False
      Properties.ShowTime = False
      TabOrder = 1
      Width = 90
    end
    object cxLabel8: TcxLabel
      Left = 233
      Top = 55
      Caption = 'Tanggal'
    end
    object cxLabel5: TcxLabel
      Left = 42
      Top = 120
      Caption = 'Amount'
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -17
      Style.Font.Name = 'Tahoma'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      Properties.Alignment.Horz = taRightJustify
      AnchorX = 104
    end
    object crCash: TcxCurrencyEdit
      Left = 107
      Top = 119
      TabStop = False
      EditValue = 0.000000000000000000
      ParentFont = False
      Properties.Alignment.Horz = taRightJustify
      Properties.DisplayFormat = ',0.##;(,0.##)'
      Properties.ReadOnly = False
      Style.Color = clMoneyGreen
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -24
      Style.Font.Name = 'Consolas'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 4
      Width = 170
    end
    object lbRekening: TcxLabel
      Left = 22
      Top = 98
      Caption = 'Rekening Tujuan'
      Properties.Alignment.Horz = taRightJustify
      AnchorX = 106
    end
    object cxLookupRekening: TcxExtLookupComboBox
      Left = 107
      Top = 97
      Properties.ImmediatePost = True
      TabOrder = 2
      Width = 259
    end
    object cxLabel2: TcxLabel
      Left = 56
      Top = 76
      Caption = 'Customer'
      Properties.Alignment.Horz = taRightJustify
      AnchorX = 106
    end
    object cxLookupCustomer: TcxExtLookupComboBox
      Left = 107
      Top = 75
      Properties.ImmediatePost = True
      TabOrder = 11
      Width = 259
    end
    object cxLabel3: TcxLabel
      Left = 27
      Top = 198
      Caption = 'Acc Uang Muka'
      Properties.Alignment.Horz = taRightJustify
      AnchorX = 104
    end
    object cxLookupAcc: TcxExtLookupComboBox
      Left = 107
      Top = 197
      Enabled = False
      Properties.ImmediatePost = True
      TabOrder = 13
      Width = 259
    end
  end
  inherited styleRepo: TcxStyleRepository
    PixelsPerInch = 96
  end
end
