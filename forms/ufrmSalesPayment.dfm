inherited frmSalesPayment: TfrmSalesPayment
  Caption = 'AR Settlement'
  ClientHeight = 550
  ClientWidth = 911
  KeyPreview = True
  OnKeyDown = FormKeyDown
  ExplicitWidth = 927
  ExplicitHeight = 589
  PixelsPerInch = 96
  TextHeight = 13
  inherited cxGroupBox2: TcxGroupBox
    Top = 515
    TabOrder = 2
    ExplicitTop = 526
    ExplicitWidth = 984
    Width = 911
    inherited btnCancel: TcxButton
      Left = 826
      ExplicitLeft = 899
    end
    inherited btnPrint: TcxButton
      Left = 740
      ExplicitLeft = 813
    end
    inherited btnSave: TcxButton
      Left = 654
      OnClick = btnSaveClick
      ExplicitLeft = 727
    end
  end
  inherited Panel2: TPanel
    Top = 494
    Width = 911
    TabOrder = 3
    ExplicitTop = 505
    ExplicitWidth = 984
    inherited lbEscape: TLabel
      Left = 831
      Height = 17
      ExplicitLeft = 904
    end
    inherited lgndSave: TLabel
      Left = 666
      Height = 17
      ExplicitLeft = 739
    end
    inherited lgndPrint: TLabel
      Left = 753
      Height = 17
      ExplicitLeft = 826
    end
    object Label1: TLabel
      AlignWithMargins = True
      Left = 219
      Top = 1
      Width = 187
      Height = 17
      Margins.Top = 1
      Margins.Right = 13
      Margins.Bottom = 1
      Align = alLeft
      Caption = 'F5 [Lookup Supplier / Faktur / Retur]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Trebuchet MS'
      Font.Style = []
      ParentFont = False
      ExplicitLeft = 3
      ExplicitHeight = 16
    end
    object Label2: TLabel
      AlignWithMargins = True
      Left = 422
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
      ExplicitLeft = 206
      ExplicitHeight = 16
    end
    object ckFilterSalesman: TcxCheckBox
      Left = 0
      Top = 0
      Align = alLeft
      Caption = 'Filter Faktur Atas Customer Terpilih [F4]'
      ParentBackground = False
      ParentColor = False
      State = cbsChecked
      Style.Color = clInfoBk
      TabOrder = 0
      ExplicitLeft = -16
      ExplicitTop = -6
    end
  end
  object cxGroupBox1: TcxGroupBox [2]
    Left = 0
    Top = 0
    Align = alTop
    Caption = '  Header Invoice [F1] '
    TabOrder = 0
    Height = 105
    Width = 911
    object cxLabel1: TcxLabel
      Left = 38
      Top = 21
      Caption = 'No. Bukti'
      Properties.Alignment.Horz = taRightJustify
      AnchorX = 85
    end
    object edRefno: TcxTextEdit
      Left = 86
      Top = 21
      TabStop = False
      Properties.CharCase = ecUpperCase
      TabOrder = 0
      Width = 102
    end
    object cxLabel4: TcxLabel
      Left = 331
      Top = 42
      Caption = 'Customer'
      Properties.Alignment.Horz = taRightJustify
      AnchorX = 381
    end
    object cxLabel6: TcxLabel
      Left = 42
      Top = 44
      Caption = 'Catatan'
      Properties.Alignment.Horz = taRightJustify
      AnchorX = 85
    end
    object edNotes: TcxMemo
      Left = 86
      Top = 42
      TabOrder = 3
      Height = 48
      Width = 206
    end
    object dtTransDate: TcxDateEdit
      Left = 208
      Top = 21
      TabStop = False
      Properties.ImmediatePost = True
      Properties.SaveTime = False
      Properties.ShowTime = False
      TabOrder = 1
      Width = 84
    end
    object cxLabel8: TcxLabel
      Left = 189
      Top = 22
      Caption = 'Tgl'
    end
    object crOthers: TcxCurrencyEdit
      Left = 694
      Top = 40
      TabStop = False
      EditValue = 0.000000000000000000
      ParentFont = False
      Properties.Alignment.Horz = taRightJustify
      Properties.DisplayFormat = ',0.##;(,0.##)'
      Properties.ReadOnly = True
      Style.Color = clCream
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -15
      Style.Font.Name = 'Consolas'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 4
      Width = 200
    end
    object cxLabel2: TcxLabel
      Left = 621
      Top = 18
      Caption = 'Nilai Bayar'
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -15
      Style.Font.Name = 'Tahoma'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      Properties.Alignment.Horz = taRightJustify
      AnchorX = 692
    end
    object cxLabel3: TcxLabel
      Left = 644
      Top = 41
      Caption = 'Others'
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -15
      Style.Font.Name = 'Tahoma'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      Properties.Alignment.Horz = taRightJustify
      AnchorX = 692
    end
    object crBayar: TcxCurrencyEdit
      Left = 694
      Top = 17
      TabStop = False
      EditValue = 0.000000000000000000
      ParentFont = False
      Properties.Alignment.Horz = taRightJustify
      Properties.DisplayFormat = ',0.##;(,0.##)'
      Properties.ReadOnly = True
      Style.Color = clCream
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -15
      Style.Font.Name = 'Consolas'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 5
      Width = 200
    end
    object lbNoMedia: TcxLabel
      Left = 314
      Top = 21
      Caption = 'Cash Receipt'
      Properties.Alignment.Horz = taRightJustify
      AnchorX = 381
    end
    object cxLookupCustomer: TcxExtLookupComboBox
      Left = 382
      Top = 42
      Enabled = False
      Properties.ImmediatePost = True
      TabOrder = 2
      Width = 200
    end
    object edCashReceipt: TcxButtonEdit
      Left = 382
      Top = 21
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.ReadOnly = True
      TabOrder = 13
      Width = 97
    end
    object cxLabel7: TcxLabel
      Left = 329
      Top = 62
      Caption = 'Sisa CR'
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -15
      Style.Font.Name = 'Tahoma'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      Properties.Alignment.Horz = taRightJustify
      AnchorX = 381
    end
    object crRemain: TcxCurrencyEdit
      Left = 382
      Top = 63
      TabStop = False
      EditValue = 0.000000000000000000
      ParentFont = False
      Properties.Alignment.Horz = taRightJustify
      Properties.DisplayFormat = ',0.##;(,0.##)'
      Properties.ReadOnly = True
      Style.Color = clCream
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -15
      Style.Font.Name = 'Consolas'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 15
      Width = 200
    end
    object crTotal: TcxCurrencyEdit
      Left = 694
      Top = 63
      TabStop = False
      EditValue = 0.000000000000000000
      ParentFont = False
      Properties.Alignment.Horz = taRightJustify
      Properties.DisplayFormat = ',0.##;(,0.##)'
      Properties.ReadOnly = True
      Style.Color = clCream
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -15
      Style.Font.Name = 'Consolas'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 16
      Width = 200
    end
    object cxLabel5: TcxLabel
      Left = 626
      Top = 64
      Caption = 'Nilai Total'
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -15
      Style.Font.Name = 'Tahoma'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      Properties.Alignment.Horz = taRightJustify
      AnchorX = 692
    end
    object cxDateEdit1: TcxDateEdit
      Left = 504
      Top = 21
      TabStop = False
      Enabled = False
      Properties.ImmediatePost = True
      Properties.SaveTime = False
      Properties.ShowTime = False
      TabOrder = 18
      Width = 78
    end
    object cxLabel9: TcxLabel
      Left = 485
      Top = 21
      Caption = 'Tgl'
    end
    object crRetur: TcxCurrencyEdit
      Left = 668
      Top = 183
      TabStop = False
      EditValue = 0.000000000000000000
      ParentFont = False
      Properties.Alignment.Horz = taRightJustify
      Properties.DisplayFormat = ',0.##;(,0.##)'
      Properties.ReadOnly = True
      Style.Color = clCream
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -15
      Style.Font.Name = 'Consolas'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 20
      Visible = False
      Width = 200
    end
  end
  object cxGrid1: TcxGrid [3]
    Left = 0
    Top = 105
    Width = 911
    Height = 389
    Align = alClient
    TabOrder = 1
    RootLevelOptions.DetailTabsPosition = dtpTop
    ExplicitTop = 99
    ExplicitHeight = 394
    object cxGrdMain: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      OnEditKeyDown = cxGrdMainEditKeyDown
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Kind = skSum
          Column = colPaidAmt
        end
        item
          Kind = skSum
          Column = colReturAmt
        end>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.FocusCellOnTab = True
      OptionsBehavior.FocusFirstCellOnNewRecord = True
      OptionsBehavior.GoToNextCellOnEnter = True
      OptionsBehavior.FocusCellOnCycle = True
      OptionsData.Appending = True
      OptionsView.Footer = True
      OptionsView.GroupByBox = False
      OptionsView.HeaderHeight = 30
      Styles.ContentOdd = styleOdd
      object colInvoiceNo: TcxGridDBColumn
        Caption = 'No. Faktur'
        DataBinding.FieldName = 'InvoiceNo'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.OnButtonClick = colInvoiceNoPropertiesButtonClick
        Properties.OnValidate = colInvoiceNoPropertiesValidate
        HeaderAlignmentHorz = taCenter
        Width = 128
      end
      object colInvoiceDate: TcxGridDBColumn
        Caption = 'Tgl Faktur'
        DataBinding.FieldName = 'InvoiceDate'
        PropertiesClassName = 'TcxDateEditProperties'
        Properties.SaveTime = False
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Options.Focusing = False
        Width = 81
      end
      object colCustomer: TcxGridDBColumn
        DataBinding.FieldName = 'Customer'
        HeaderAlignmentHorz = taCenter
        Width = 153
      end
      object colInvoiceAmt: TcxGridDBColumn
        Caption = 'Nilai Faktur'
        DataBinding.FieldName = 'InvoiceAmt'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0.##;(,0.##)'
        HeaderAlignmentHorz = taCenter
        Options.Focusing = False
        Width = 78
      end
      object colInvoiceRemain: TcxGridDBColumn
        Caption = 'Sisa Piutang'
        DataBinding.FieldName = 'InvoiceRemain'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0.##;(,0.##)'
        HeaderAlignmentHorz = taCenter
        Options.Focusing = False
        Width = 82
      end
      object colPaidAmt: TcxGridDBColumn
        Caption = 'Nilai Bayar'
        DataBinding.FieldName = 'Amount'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0.##;(,0.##)'
        Properties.OnEditValueChanged = colPaidAmtPropertiesEditValueChanged
        HeaderAlignmentHorz = taCenter
        Width = 106
      end
      object colReturNo: TcxGridDBColumn
        Caption = 'No. Retur'
        DataBinding.FieldName = 'ReturNo'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.ReadOnly = False
        Properties.OnButtonClick = colReturNoPropertiesButtonClick
        Properties.OnValidate = colReturNoPropertiesValidate
        HeaderAlignmentHorz = taCenter
        Width = 68
      end
      object colReturRemain: TcxGridDBColumn
        Caption = 'Sisa Retur'
        DataBinding.FieldName = 'ReturRemain'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0.##;(,0.##)'
        Properties.ReadOnly = True
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 74
      end
      object colReturAmt: TcxGridDBColumn
        Caption = 'Potong Retur'
        DataBinding.FieldName = 'ReturAmt'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0.##;(,0.##)'
        Properties.ReadOnly = False
        Properties.OnEditValueChanged = colReturAmtPropertiesEditValueChanged
        HeaderAlignmentHorz = taCenter
        Width = 81
      end
      object colInvoiceID: TcxGridDBColumn
        DataBinding.FieldName = 'SalesInvoice'
        PropertiesClassName = 'TcxSpinEditProperties'
        Visible = False
        Options.Editing = False
      end
      object colReturID: TcxGridDBColumn
        DataBinding.FieldName = 'SalesRetur'
        PropertiesClassName = 'TcxSpinEditProperties'
        Visible = False
        Options.Editing = False
      end
      object colCustomerID: TcxGridDBColumn
        DataBinding.FieldName = 'CustomerID'
        Visible = False
      end
    end
    object cxGrdCost: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = ',0.00;(,0.00)'
          Kind = skSum
          Column = colCostAmount
        end>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.FocusCellOnTab = True
      OptionsBehavior.FocusFirstCellOnNewRecord = True
      OptionsBehavior.GoToNextCellOnEnter = True
      OptionsBehavior.FocusCellOnCycle = True
      OptionsData.Appending = True
      OptionsView.Footer = True
      OptionsView.GroupByBox = False
      OptionsView.HeaderHeight = 30
      Styles.ContentOdd = styleOdd
      object colCostAccount: TcxGridDBColumn
        DataBinding.FieldName = 'Account'
        PropertiesClassName = 'TcxExtLookupComboBoxProperties'
        HeaderAlignmentHorz = taCenter
        Width = 205
      end
      object colCostNotes: TcxGridDBColumn
        Caption = 'Deskripsi'
        DataBinding.FieldName = 'Notes'
        PropertiesClassName = 'TcxTextEditProperties'
        HeaderAlignmentHorz = taCenter
        Width = 380
      end
      object colCostAmount: TcxGridDBColumn
        Caption = 'Nilai'
        DataBinding.FieldName = 'Amount'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;(,0.00)'
        Properties.OnEditValueChanged = colCostAmountPropertiesEditValueChanged
        HeaderAlignmentHorz = taCenter
        Width = 134
      end
    end
    object cxGrid1Level1: TcxGridLevel
      Caption = 'Detail Transaksi [F2]'
      GridView = cxGrdMain
    end
    object cxGrid1Level2: TcxGridLevel
      Caption = 'Biaya Lain [F3]'
      GridView = cxGrdCost
    end
  end
  inherited styleRepo: TcxStyleRepository
    Left = 640
    Top = 376
    PixelsPerInch = 96
  end
end
