inherited frmPurchaseReceive: TfrmPurchaseReceive
  Caption = 'Purchase Receive - BTB'
  ClientHeight = 587
  ClientWidth = 779
  KeyPreview = True
  OnKeyDown = FormKeyDown
  ExplicitWidth = 795
  ExplicitHeight = 626
  PixelsPerInch = 96
  TextHeight = 13
  inherited cxGroupBox2: TcxGroupBox
    Top = 552
    TabOrder = 2
    ExplicitTop = 552
    ExplicitWidth = 779
    Width = 779
    inherited btnCancel: TcxButton
      Left = 694
      ExplicitLeft = 694
    end
    inherited btnPrint: TcxButton
      Left = 608
      OnClick = btnPrintClick
      ExplicitLeft = 608
    end
    inherited btnSave: TcxButton
      Left = 522
      OnClick = btnSaveClick
      ExplicitLeft = 522
    end
    object btnGenerate: TcxButton
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 124
      Height = 25
      Align = alLeft
      Caption = 'Generate Dummy '
      TabOrder = 3
      Visible = False
      OnClick = btnGenerateClick
    end
  end
  object cxGroupBox1: TcxGroupBox [1]
    Left = 0
    Top = 0
    Align = alTop
    Caption = '  Header Invoice [F1] '
    TabOrder = 0
    Height = 121
    Width = 779
    object cxLabel1: TcxLabel
      Left = 13
      Top = 28
      Caption = 'No. Invoice'
    end
    object edRecNo: TcxTextEdit
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
      Top = 51
      Caption = 'Catatan'
    end
    object edNotes: TcxMemo
      Left = 431
      Top = 50
      TabOrder = 5
      OnKeyDown = edNotesKeyDown
      Height = 39
      Width = 250
    end
    object dtReceive: TcxDateEdit
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
    object cxLabel7: TcxLabel
      Left = 354
      Top = 29
      Caption = 'Gudang Tujuan'
    end
    object cxLookupGudang: TcxExtLookupComboBox
      Left = 431
      Top = 28
      TabOrder = 4
      Width = 250
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
  end
  object cxGrid1: TcxGrid [2]
    Left = 0
    Top = 121
    Width = 779
    Height = 410
    Align = alClient
    TabOrder = 1
    RootLevelOptions.DetailTabsPosition = dtpTop
    object cxGrdMain: TcxGridDBTableView
      PopupMenu = pmMain
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
        Properties.OnButtonClick = colKodePropertiesButtonClick
        HeaderAlignmentHorz = taCenter
        Width = 116
      end
      object colNama: TcxGridDBColumn
        Caption = 'Nama Barang'
        DataBinding.FieldName = 'Nama'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.ReadOnly = True
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Options.Focusing = False
        Width = 276
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
      object colWarehouse: TcxGridDBColumn
        Caption = 'Gudang'
        DataBinding.FieldName = 'Warehouse'
        PropertiesClassName = 'TcxExtLookupComboBoxProperties'
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
      object colHrgBeli: TcxGridDBColumn
        DataBinding.FieldName = 'Harga'
        Visible = False
      end
      object colPriceType: TcxGridDBColumn
        DataBinding.FieldName = 'PriceType'
        Visible = False
      end
    end
    object cxGrid1Level1: TcxGridLevel
      Caption = 'Detail Transaksi [F2]'
      GridView = cxGrdMain
    end
  end
  inherited Panel2: TPanel
    Top = 531
    Width = 779
    TabOrder = 3
    ExplicitTop = 531
    ExplicitWidth = 779
    inherited lbEscape: TLabel
      Left = 699
      Height = 17
      ExplicitLeft = 699
    end
    inherited lgndSave: TLabel
      Left = 534
      Height = 17
      ExplicitLeft = 534
    end
    inherited lgndPrint: TLabel
      Left = 621
      Height = 17
      ExplicitLeft = 621
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
    Left = 296
    Top = 320
    object SetSebagaiBarangBonus1: TMenuItem
      Caption = 'Set Sebagai Barang Bonus'
      OnClick = SetSebagaiBarangBonus1Click
    end
  end
end
