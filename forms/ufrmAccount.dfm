inherited frmAccount: TfrmAccount
  Caption = 'Data Account COA'
  ClientHeight = 375
  ClientWidth = 474
  ExplicitWidth = 490
  ExplicitHeight = 414
  PixelsPerInch = 96
  TextHeight = 13
  inherited cxGroupBox2: TcxGroupBox
    Top = 340
    TabOrder = 7
    ExplicitTop = 202
    ExplicitWidth = 475
    Width = 474
    inherited btnCancel: TcxButton
      Left = 389
      ExplicitLeft = 390
    end
    inherited btnPrint: TcxButton
      Left = 303
      ExplicitLeft = 304
    end
    inherited btnSave: TcxButton
      Left = 217
      OnClick = btnSaveClick
      ExplicitLeft = 218
    end
  end
  inherited Panel2: TPanel
    Top = 319
    Width = 474
    TabOrder = 8
    ExplicitTop = 181
    ExplicitWidth = 475
    inherited lbEscape: TLabel
      Left = 394
      Height = 17
      ExplicitLeft = 395
    end
    inherited lgndSave: TLabel
      Left = 229
      Height = 17
      ExplicitLeft = 230
    end
    inherited lgndPrint: TLabel
      Left = 316
      Height = 17
      ExplicitLeft = 317
    end
  end
  object cxLabel1: TcxLabel [2]
    Left = 45
    Top = 43
    Caption = 'Kode'
  end
  object edKode: TcxTextEdit [3]
    Left = 77
    Top = 42
    Properties.CharCase = ecUpperCase
    TabOrder = 1
    Width = 145
  end
  object cxLabel2: TcxLabel [4]
    Left = 42
    Top = 64
    Caption = 'Nama'
  end
  object edNama: TcxTextEdit [5]
    Left = 77
    Top = 63
    TabOrder = 3
    Width = 292
  end
  object cxLookupAccount: TcxExtLookupComboBox [6]
    Left = 77
    Top = 21
    TabOrder = 0
    Width = 292
  end
  object cxLabel3: TcxLabel [7]
    Left = 42
    Top = 22
    Caption = 'Induk'
  end
  object chkActive: TcxCheckBox [8]
    Left = 228
    Top = 42
    TabStop = False
    Caption = 'Active'
    State = cbsChecked
    TabOrder = 2
  end
  object chkCredit: TcxCheckBox [9]
    Left = 77
    Top = 90
    TabStop = False
    Caption = 'Saldo Normal Credit'
    TabOrder = 4
  end
  object chkIsDetail: TcxCheckBox [10]
    Left = 291
    Top = 90
    TabStop = False
    Caption = 'Akun Detail'
    TabOrder = 5
  end
  object rbJenis: TcxRadioGroup [11]
    Left = 77
    Top = 117
    Caption = ' Tipe Akun '
    Properties.Items = <
      item
        Caption = 'Asset'
      end
      item
        Caption = 'Kewajiban'
      end
      item
        Caption = 'Pendapatan'
      end
      item
        Caption = 'Expense'
      end>
    ItemIndex = 0
    TabOrder = 6
    Visible = False
    Height = 92
    Width = 292
  end
  inherited styleRepo: TcxStyleRepository
    PixelsPerInch = 96
  end
end
