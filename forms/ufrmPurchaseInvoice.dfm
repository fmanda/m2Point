inherited frmPurchaseInvoice: TfrmPurchaseInvoice
  Caption = 'Faktur Pembelian Barang'
  ClientHeight = 631
  ClientWidth = 967
  KeyPreview = True
  OnKeyDown = FormKeyDown
  ExplicitWidth = 983
  ExplicitHeight = 670
  PixelsPerInch = 96
  TextHeight = 13
  inherited cxGroupBox2: TcxGroupBox
    Top = 596
    TabOrder = 2
    ExplicitTop = 552
    ExplicitWidth = 978
    Width = 967
    inherited btnCancel: TcxButton
      Left = 882
      ExplicitLeft = 893
    end
    inherited btnPrint: TcxButton
      Left = 796
      OnClick = btnPrintClick
      ExplicitLeft = 807
    end
    inherited btnSave: TcxButton
      Left = 710
      OnClick = btnSaveClick
      ExplicitLeft = 721
    end
    object btnLoadRec: TcxButton
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 164
      Height = 25
      Align = alLeft
      Caption = 'Tambah Penerimaan / BTB'
      OptionsImage.ImageIndex = 1
      OptionsImage.Images = frmMain.ImageList
      TabOrder = 3
      OnClick = btnLoadRecClick
    end
  end
  object cxGroupBox1: TcxGroupBox [1]
    Left = 0
    Top = 0
    Align = alTop
    Caption = '  Header Invoice [F1] '
    TabOrder = 0
    DesignSize = (
      967
      135)
    Height = 135
    Width = 967
    object cxLabel1: TcxLabel
      Left = 13
      Top = 28
      Caption = 'No. Invoice'
    end
    object edNoInv: TcxTextEdit
      Left = 73
      Top = 28
      TabStop = False
      Properties.CharCase = ecUpperCase
      TabOrder = 0
      Width = 131
    end
    object cxLabel4: TcxLabel
      Left = 30
      Top = 69
      Caption = 'Supplier'
    end
    object cxLabel6: TcxLabel
      Left = 388
      Top = 69
      Caption = 'Catatan'
    end
    object edNotes: TcxMemo
      Left = 431
      Top = 68
      TabOrder = 8
      OnKeyDown = edNotesKeyDown
      Height = 40
      Width = 250
    end
    object dtInvoice: TcxDateEdit
      Left = 257
      Top = 28
      TabStop = False
      Properties.ImmediatePost = True
      Properties.SaveTime = False
      Properties.ShowTime = False
      TabOrder = 1
      Width = 85
    end
    object cxLabel8: TcxLabel
      Left = 215
      Top = 29
      Caption = 'Tanggal'
    end
    object dtJtTempo: TcxDateEdit
      Left = 257
      Top = 89
      TabStop = False
      Properties.ImmediatePost = True
      Properties.ReadOnly = True
      Properties.SaveTime = False
      Properties.ShowTime = False
      TabOrder = 6
      Width = 85
    end
    object cxLabel9: TcxLabel
      Left = 205
      Top = 90
      Caption = 'Jt. Tempo'
    end
    object edSupplier: TcxButtonEdit
      Left = 73
      Top = 68
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.OnButtonClick = edSupplierPropertiesButtonClick
      TabOrder = 3
      OnKeyDown = edSupplierKeyDown
      Width = 269
    end
    object crSubTotal: TcxCurrencyEdit
      Left = 771
      Top = 10
      TabStop = False
      Anchors = [akTop, akRight]
      EditValue = 0.000000000000000000
      ParentFont = False
      Properties.Alignment.Horz = taRightJustify
      Properties.DisplayFormat = ',0.##;(,0.##)'
      Properties.ReadOnly = True
      Style.Color = clCream
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -16
      Style.Font.Name = 'Consolas'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 9
      Width = 185
    end
    object cxLabel2: TcxLabel
      Left = 703
      Top = 11
      Anchors = [akTop, akRight]
      Caption = 'Sub Total'
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -15
      Style.Font.Name = 'Tahoma'
      Style.Font.Style = []
      Style.IsFontAssigned = True
    end
    object cxLabel3: TcxLabel
      Left = 739
      Top = 37
      Anchors = [akTop, akRight]
      Caption = 'PPN'
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -15
      Style.Font.Name = 'Tahoma'
      Style.Font.Style = []
      Style.IsFontAssigned = True
    end
    object crPPN: TcxCurrencyEdit
      Left = 771
      Top = 36
      TabStop = False
      Anchors = [akTop, akRight]
      EditValue = 0.000000000000000000
      ParentFont = False
      Properties.Alignment.Horz = taRightJustify
      Properties.DisplayFormat = ',0.##;(,0.##)'
      Properties.ReadOnly = True
      Style.Color = clCream
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -16
      Style.Font.Name = 'Consolas'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 10
      Width = 185
    end
    object cxLabel5: TcxLabel
      Left = 716
      Top = 91
      Anchors = [akTop, akRight]
      Caption = 'TOTAL'
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -17
      Style.Font.Name = 'Tahoma'
      Style.Font.Style = []
      Style.IsFontAssigned = True
    end
    object crTotal: TcxCurrencyEdit
      Left = 771
      Top = 88
      TabStop = False
      Anchors = [akTop, akRight]
      EditValue = 0.000000000000000000
      ParentFont = False
      Properties.Alignment.Horz = taRightJustify
      Properties.DisplayFormat = ',0.##;(,0.##)'
      Properties.ReadOnly = True
      Style.Color = clMoneyGreen
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -24
      Style.Font.Name = 'Consolas'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 11
      Width = 185
    end
    object cbBayar: TcxComboBox
      Left = 73
      Top = 89
      Properties.CharCase = ecUpperCase
      Properties.Items.Strings = (
        'CASH'
        'TEMPO')
      Properties.OnEditValueChanged = cbBayarPropertiesEditValueChanged
      TabOrder = 4
      Text = 'CASH'
      Width = 89
    end
    object cxLabel10: TcxLabel
      Left = 14
      Top = 90
      Caption = 'Cara Bayar'
    end
    object cxLabel13: TcxLabel
      Left = 382
      Top = 49
      Caption = 'Rekening'
    end
    object cxLookupRekening: TcxExtLookupComboBox
      Left = 431
      Top = 48
      TabOrder = 7
      Width = 250
    end
    object spTempo: TcxSpinEdit
      Left = 162
      Top = 89
      Properties.ImmediatePost = True
      Properties.OnEditValueChanged = spTempoPropertiesEditValueChanged
      TabOrder = 5
      Width = 42
    end
    object cxLabel11: TcxLabel
      Left = 13
      Top = 49
      Caption = '* Referensi'
    end
    object edReferensi: TcxTextEdit
      Left = 73
      Top = 48
      Properties.CharCase = ecUpperCase
      TabOrder = 2
      Width = 131
    end
    object cxLabel12: TcxLabel
      Left = 204
      Top = 53
      Caption = '* Faktur Supplier / Surat Jalan'
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clNavy
      Style.Font.Height = -9
      Style.Font.Name = 'Tahoma'
      Style.Font.Style = [fsItalic]
      Style.IsFontAssigned = True
    end
    object cxLabel7: TcxLabel
      Left = 721
      Top = 63
      Anchors = [akTop, akRight]
      Caption = 'Others'
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -15
      Style.Font.Name = 'Tahoma'
      Style.Font.Style = []
      Style.IsFontAssigned = True
    end
    object crOthers: TcxCurrencyEdit
      Left = 771
      Top = 62
      TabStop = False
      Anchors = [akTop, akRight]
      EditValue = 0.000000000000000000
      ParentFont = False
      Properties.Alignment.Horz = taRightJustify
      Properties.DisplayFormat = ',0.##;(,0.##)'
      Properties.ReadOnly = True
      Style.Color = clCream
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -16
      Style.Font.Name = 'Consolas'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 25
      Width = 185
    end
  end
  object cxGrid1: TcxGrid [2]
    Left = 0
    Top = 135
    Width = 967
    Height = 440
    Align = alClient
    TabOrder = 1
    RootLevelOptions.DetailTabsPosition = dtpTop
    ExplicitTop = 120
    ExplicitHeight = 454
    object cxGrdMain: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      OnEditKeyDown = cxGrdMainEditKeyDown
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Kind = skSum
          Column = colQty
        end
        item
          Kind = skSum
          Column = colSubTotal
        end>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.FocusCellOnTab = True
      OptionsBehavior.FocusFirstCellOnNewRecord = True
      OptionsBehavior.GoToNextCellOnEnter = True
      OptionsBehavior.FocusCellOnCycle = True
      OptionsCustomize.ColumnSorting = False
      OptionsData.Inserting = False
      OptionsView.Footer = True
      OptionsView.GroupByBox = False
      OptionsView.HeaderHeight = 30
      Styles.ContentOdd = styleOdd
      Styles.OnGetContentStyle = cxGrdMainStylesGetContentStyle
      object cxGrdMainColumn1: TcxGridDBColumn
        Caption = 'No.'
        OnGetDisplayText = cxGrdMainColumn1GetDisplayText
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Options.Focusing = False
        Width = 41
      end
      object colKode: TcxGridDBColumn
        Caption = 'Kode Barang'
        DataBinding.FieldName = 'Kode'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.ReadOnly = True
        Properties.OnButtonClick = colKodePropertiesButtonClick
        Properties.OnValidate = colKodePropertiesValidate
        HeaderAlignmentHorz = taCenter
        Width = 107
      end
      object colNama: TcxGridDBColumn
        Caption = 'Nama Barang'
        DataBinding.FieldName = 'Nama'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.ReadOnly = True
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Options.Focusing = False
        Width = 272
      end
      object colUOM: TcxGridDBColumn
        Caption = 'Satuan'
        DataBinding.FieldName = 'UOM'
        PropertiesClassName = 'TcxExtLookupComboBoxProperties'
        Properties.ImmediatePost = True
        Properties.OnCloseUp = colUOMPropertiesCloseUp
        Properties.OnEditValueChanged = colUOMPropertiesEditValueChanged
        Properties.OnInitPopup = colUOMPropertiesInitPopup
        HeaderAlignmentHorz = taCenter
        Width = 49
      end
      object colQty: TcxGridDBColumn
        DataBinding.FieldName = 'Qty'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0.##;(,0.##)'
        Properties.OnEditValueChanged = colQtyPropertiesEditValueChanged
        HeaderAlignmentHorz = taCenter
        Width = 53
      end
      object colHrgBeli: TcxGridDBColumn
        DataBinding.FieldName = 'Harga'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;(,0.00)'
        HeaderAlignmentHorz = taCenter
        Width = 79
      end
      object colPPN: TcxGridDBColumn
        DataBinding.FieldName = 'PPN'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.##;(,0.##)'
        Properties.OnEditValueChanged = colPPNPropertiesEditValueChanged
        HeaderAlignmentHorz = taCenter
      end
      object colDisc: TcxGridDBColumn
        Caption = 'Disc %'
        DataBinding.FieldName = 'DiscP'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0.##;(,0.##)'
        Properties.ReadOnly = False
        Properties.OnEditValueChanged = colDiscPropertiesEditValueChanged
        HeaderAlignmentHorz = taCenter
        Width = 50
      end
      object colSubTotal: TcxGridDBColumn
        Caption = 'Sub Total'
        DataBinding.FieldName = 'SubTotal'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0.##;(,0.##)'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Options.Focusing = False
        Width = 100
      end
      object colWarehouse: TcxGridDBColumn
        Caption = 'Receive No'
        DataBinding.FieldName = 'RecNo'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.ReadOnly = True
        HeaderAlignmentHorz = taCenter
        Width = 153
      end
      object colItemID: TcxGridDBColumn
        DataBinding.FieldName = 'Item'
        Visible = False
        Options.Editing = False
      end
      object colKonversi: TcxGridDBColumn
        DataBinding.FieldName = 'Konversi'
        Visible = False
        Options.Editing = False
      end
      object colPriceType: TcxGridDBColumn
        DataBinding.FieldName = 'PriceType'
        Visible = False
      end
    end
    object cxGrdOthers: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = ',0.##;(,0.##)'
          Kind = skSum
          Column = colOthDebet
        end
        item
          Format = ',0.##;(,0.##)'
          Kind = skSum
          Column = colOthCredit
        end>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.FocusCellOnTab = True
      OptionsBehavior.FocusFirstCellOnNewRecord = True
      OptionsBehavior.GoToNextCellOnEnter = True
      OptionsBehavior.FocusCellOnCycle = True
      OptionsCustomize.ColumnSorting = False
      OptionsData.Appending = True
      OptionsView.Footer = True
      OptionsView.GroupByBox = False
      OptionsView.HeaderHeight = 30
      Styles.ContentOdd = styleOdd
      object colOthAccCode: TcxGridDBColumn
        Caption = 'Account Code'
        DataBinding.FieldName = 'Account'
        PropertiesClassName = 'TcxExtLookupComboBoxProperties'
        Properties.ImmediatePost = True
        HeaderAlignmentHorz = taCenter
        Width = 99
      end
      object colOthAccName: TcxGridDBColumn
        Caption = 'Account Name'
        DataBinding.FieldName = 'Account'
        PropertiesClassName = 'TcxExtLookupComboBoxProperties'
        Properties.ImmediatePost = True
        HeaderAlignmentHorz = taCenter
        Width = 242
      end
      object colOthDescription: TcxGridDBColumn
        DataBinding.FieldName = 'Notes'
        PropertiesClassName = 'TcxTextEditProperties'
        HeaderAlignmentHorz = taCenter
        Width = 286
      end
      object colOthDebet: TcxGridDBColumn
        Caption = 'Debet'
        DataBinding.FieldName = 'DebetAmt'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0.##;(,0.##)'
        Properties.OnEditValueChanged = colOthDebetPropertiesEditValueChanged
        HeaderAlignmentHorz = taCenter
        Width = 95
      end
      object colOthCredit: TcxGridDBColumn
        Caption = 'Credit'
        DataBinding.FieldName = 'CreditAmt'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0.##;(,0.##)'
        Properties.OnEditValueChanged = colOthCreditPropertiesEditValueChanged
        HeaderAlignmentHorz = taCenter
        Width = 114
      end
    end
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      object cxGrid1DBTableView1Column1: TcxGridDBColumn
        DataBinding.FieldName = 'Notes'
      end
    end
    object cxGrid1Level1: TcxGridLevel
      Caption = 'Detail Transaksi [F2]'
      GridView = cxGrdMain
    end
    object cxGrid1Level2: TcxGridLevel
      Caption = 'Others / BIaya Lain [F3]'
      GridView = cxGrdOthers
    end
  end
  inherited Panel2: TPanel
    Top = 575
    Width = 967
    TabOrder = 3
    ExplicitTop = 531
    ExplicitWidth = 978
    inherited lbEscape: TLabel
      Left = 887
      Height = 17
      ExplicitLeft = 898
    end
    inherited lgndSave: TLabel
      Left = 722
      Height = 17
      ExplicitLeft = 733
    end
    inherited lgndPrint: TLabel
      Left = 809
      Height = 17
      ExplicitLeft = 820
    end
    object Label2: TLabel
      AlignWithMargins = True
      Left = 319
      Top = 1
      Width = 84
      Height = 17
      Margins.Top = 1
      Margins.Right = 13
      Margins.Bottom = 1
      Align = alLeft
      Caption = 'Esc [Cancel Edit]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Trebuchet MS'
      Font.Style = []
      ParentFont = False
      ExplicitHeight = 16
    end
    object Label1: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 1
      Width = 175
      Height = 17
      Margins.Top = 1
      Margins.Right = 13
      Margins.Bottom = 1
      Align = alLeft
      Caption = 'F5 [Lookup Data Barang / Supplier]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Trebuchet MS'
      Font.Style = []
      ParentFont = False
      ExplicitHeight = 16
    end
    object Label3: TLabel
      AlignWithMargins = True
      Left = 194
      Top = 1
      Width = 109
      Height = 17
      Margins.Top = 1
      Margins.Right = 13
      Margins.Bottom = 1
      Align = alLeft
      Caption = 'F6 [Set Barang Bonus]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Trebuchet MS'
      Font.Style = []
      ParentFont = False
      ExplicitHeight = 16
    end
  end
  inherited styleRepo: TcxStyleRepository
    Left = 344
    Top = 400
    PixelsPerInch = 96
    object stylBonus: TcxStyle
      AssignedValues = [svColor]
      Color = 8454016
    end
  end
  object pmMain: TPopupMenu
    Left = 416
    Top = 408
    object SetSebagaiBarangBonus1: TMenuItem
      Caption = 'Set Sebagai Barang Bonus'
      Enabled = False
      OnClick = SetSebagaiBarangBonus1Click
    end
  end
end
