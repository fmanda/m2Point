inherited frmPostingJournal: TfrmPostingJournal
  Caption = 'Posting Journal'
  ClientHeight = 242
  ClientWidth = 388
  ExplicitWidth = 404
  ExplicitHeight = 281
  PixelsPerInch = 96
  TextHeight = 13
  inherited cxGroupBox2: TcxGroupBox
    Top = 186
    ExplicitTop = 228
    ExplicitWidth = 483
    ExplicitHeight = 56
    Height = 56
    Width = 388
    inherited btnCancel: TcxButton
      Left = 303
      Height = 46
    end
    inherited btnPrint: TcxButton
      Left = 217
      Height = 46
    end
    inherited btnSave: TcxButton
      Left = 5
      Width = 206
      Height = 46
      Align = alClient
      Caption = '&Process'
      OptionsImage.ImageIndex = 4
      Visible = False
      OnClick = btnSaveClick
      ExplicitLeft = 5
      ExplicitTop = 6
      ExplicitWidth = 185
      ExplicitHeight = 46
    end
  end
  inherited Panel2: TPanel
    Top = 165
    Width = 388
    Visible = False
    inherited lbEscape: TLabel
      Left = 308
      Height = 17
    end
    inherited lgndSave: TLabel
      Left = 143
      Height = 17
      Visible = False
    end
    inherited lgndPrint: TLabel
      Left = 230
      Height = 17
    end
  end
  object cxGroupBox1: TcxGroupBox [2]
    AlignWithMargins = True
    Left = 0
    Top = 3
    Margins.Left = 0
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alClient
    Caption = ' Periode '
    Style.TextStyle = [fsBold]
    TabOrder = 2
    ExplicitWidth = 415
    ExplicitHeight = 110
    Height = 162
    Width = 388
    object cbMonth: TcxComboBox
      Left = 79
      Top = 32
      Properties.Items.Strings = (
        'Januari'
        'Februari'
        'Maret'
        'April'
        'Mei'
        'Juni'
        'Juli'
        'Agustus'
        'September'
        'Oktober'
        'November'
        'Desember')
      Properties.OnChange = cbMonthPropertiesChange
      TabOrder = 0
      Text = 'Januari'
      Width = 98
    end
    object cbBulan: TCheckBox
      Left = 26
      Top = 34
      Width = 42
      Height = 17
      Caption = 'Bulan'
      TabOrder = 1
      OnClick = cbBulanClick
    end
    object spYear: TcxSpinEdit
      Left = 179
      Top = 32
      Properties.OnChange = spYearPropertiesChange
      TabOrder = 2
      Value = 2024
      Width = 74
    end
    object cxLabel3: TcxLabel
      Left = 27
      Top = 57
      Caption = 'Tanggal'
    end
    object dtStart: TcxDateEdit
      Left = 79
      Top = 56
      Properties.SaveTime = False
      Properties.ShowTime = False
      TabOrder = 4
      Width = 98
    end
    object cxLabel1: TcxLabel
      Left = 179
      Top = 56
      Caption = 's/d'
    end
    object dtEnd: TcxDateEdit
      Left = 200
      Top = 56
      Properties.SaveTime = False
      Properties.ShowTime = False
      TabOrder = 6
      Width = 98
    end
  end
  inherited styleRepo: TcxStyleRepository
    PixelsPerInch = 96
  end
end
