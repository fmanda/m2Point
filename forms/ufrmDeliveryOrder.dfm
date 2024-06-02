inherited frmDeliveryOrder: TfrmDeliveryOrder
  Caption = 'Delivery Order / Surat Jalan'
  ClientHeight = 567
  ClientWidth = 713
  KeyPreview = True
  OnKeyDown = FormKeyDown
  ExplicitWidth = 729
  ExplicitHeight = 606
  PixelsPerInch = 96
  TextHeight = 13
  inherited cxGroupBox2: TcxGroupBox
    Top = 532
    TabOrder = 1
    ExplicitTop = 532
    ExplicitWidth = 713
    Width = 713
    inherited btnCancel: TcxButton
      Left = 628
      ExplicitLeft = 628
    end
    inherited btnPrint: TcxButton
      Left = 542
      Visible = True
      OnClick = btnPrintClick
      ExplicitLeft = 542
    end
    inherited btnSave: TcxButton
      Left = 436
      Width = 100
      OnClick = btnSaveClick
      ExplicitLeft = 436
      ExplicitWidth = 100
    end
  end
  inherited Panel2: TPanel
    Top = 511
    Width = 713
    TabOrder = 2
    ExplicitTop = 528
    ExplicitWidth = 713
    inherited lbEscape: TLabel
      Left = 633
      ExplicitLeft = 633
    end
    inherited lgndSave: TLabel
      Left = 458
      Margins.Right = 25
      ExplicitLeft = 458
    end
    inherited lgndPrint: TLabel
      Left = 555
      Visible = True
      ExplicitLeft = 555
    end
    object Label2: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 1
      Width = 90
      Height = 16
      Margins.Top = 1
      Margins.Bottom = 1
      Align = alLeft
      Caption = '[F5: Lookup Data]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Trebuchet MS'
      Font.Style = []
      ParentFont = False
    end
  end
  object cxGridItem: TcxGrid [2]
    Left = 0
    Top = 113
    Width = 713
    Height = 398
    Align = alClient
    TabOrder = 0
    RootLevelOptions.DetailTabsPosition = dtpTop
    ExplicitTop = 112
    object cxGrdItem: TcxGridDBTableView
      PopupMenu = pmMain
      Navigator.Buttons.CustomButtons = <>
      OnEditKeyDown = cxGrdItemEditKeyDown
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = ',0.##;(,0.##)'
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
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnSorting = False
      OptionsData.Appending = True
      OptionsSelection.HideSelection = True
      OptionsSelection.InvertSelect = False
      OptionsView.Footer = True
      OptionsView.GroupByBox = False
      OptionsView.HeaderHeight = 30
      Styles.ContentOdd = styleOdd
      object colNo: TcxGridDBColumn
        Caption = 'No.'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        OnGetDisplayText = colNoGetDisplayText
        HeaderAlignmentHorz = taCenter
        Options.Focusing = False
        Width = 39
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
        Properties.OnValidate = colKodePropertiesValidate
        HeaderAlignmentHorz = taCenter
        Width = 131
      end
      object colNama: TcxGridDBColumn
        Caption = 'Nama Barang'
        DataBinding.FieldName = 'Nama'
        PropertiesClassName = 'TcxTextEditProperties'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Options.Focusing = False
        Width = 372
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
        Width = 56
      end
      object colQty: TcxGridDBColumn
        DataBinding.FieldName = 'Qty'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0.##;(,0.##)'
        Properties.OnEditValueChanged = colQtyPropertiesEditValueChanged
        HeaderAlignmentHorz = taCenter
        Width = 71
      end
      object colWarehouse: TcxGridDBColumn
        Caption = 'Gudang'
        DataBinding.FieldName = 'Warehouse'
        PropertiesClassName = 'TcxExtLookupComboBoxProperties'
        Visible = False
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
    end
    object cxGridItemLevel1: TcxGridLevel
      Caption = 'Detail Barang [F2]'
      GridView = cxGrdItem
    end
  end
  object cxGroupBox1: TcxGroupBox [3]
    Left = 0
    Top = 0
    Align = alTop
    Caption = '  Header Invoice [F1] '
    TabOrder = 3
    Height = 113
    Width = 713
    object cxLabel1: TcxLabel
      Left = 30
      Top = 27
      Caption = 'Nomor DO'
    end
    object edNoDO: TcxTextEdit
      Left = 86
      Top = 26
      TabStop = False
      Properties.CharCase = ecUpperCase
      TabOrder = 0
      Text = '01.FPK.1906.0001'
      Width = 109
    end
    object cxLabel4: TcxLabel
      Left = 35
      Top = 48
      Caption = 'Customer'
    end
    object cxLabel6: TcxLabel
      Left = 344
      Top = 27
      Caption = 'Catatan'
    end
    object edNotes: TcxMemo
      Left = 387
      Top = 26
      TabStop = False
      TabOrder = 4
      OnKeyDown = edNotesKeyDown
      Height = 64
      Width = 214
    end
    object dtInvoice: TcxDateEdit
      Left = 244
      Top = 26
      TabStop = False
      Properties.ImmediatePost = True
      Properties.SaveTime = False
      Properties.ShowTime = False
      TabOrder = 1
      Width = 85
    end
    object cxLabel8: TcxLabel
      Left = 202
      Top = 27
      Caption = 'Tanggal'
    end
    object edCustomer: TcxButtonEdit
      Left = 86
      Top = 47
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.OnButtonClick = edCustomerPropertiesButtonClick
      Properties.OnValidate = edCustomerPropertiesValidate
      TabOrder = 2
      OnKeyDown = edCustomerKeyDown
      Width = 243
    end
    object cxLabel7: TcxLabel
      Left = 44
      Top = 70
      Caption = 'Gudang'
    end
    object cxLookupGudang: TcxExtLookupComboBox
      Left = 86
      Top = 69
      TabOrder = 3
      Width = 243
    end
  end
  inherited styleRepo: TcxStyleRepository
    Left = 232
    Top = 424
    PixelsPerInch = 96
    object styleUmum: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
    object styleBengkel: TcxStyle
      AssignedValues = [svColor]
      Color = clSkyBlue
    end
    object styleGrosir: TcxStyle
      AssignedValues = [svColor]
      Color = 9877758
    end
    object styleKeliling: TcxStyle
      AssignedValues = [svColor]
      Color = 6612733
    end
  end
  object pmMain: TPopupMenu
    Left = 232
    Top = 368
    object UpdateKeHargaUmum1: TMenuItem
      Caption = 'Update ke Harga Umum'
    end
    object UpdatekeHargaGrosir1: TMenuItem
      Caption = 'Update ke Harga Bengkel'
    end
    object UpdatekeHargaGrosir2: TMenuItem
      Caption = 'Update ke Harga Grosir'
    end
    object UpdatekeHargaKeliling1: TMenuItem
      Caption = 'Update ke Harga Keliling'
    end
  end
end
