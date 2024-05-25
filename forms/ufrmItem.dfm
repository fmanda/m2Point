inherited frmItem: TfrmItem
  Caption = 'Update Data Barang'
  ClientHeight = 560
  ClientWidth = 738
  KeyPreview = True
  OnKeyDown = FormKeyDown
  ExplicitWidth = 754
  ExplicitHeight = 599
  PixelsPerInch = 96
  TextHeight = 13
  inherited cxGroupBox2: TcxGroupBox
    Top = 525
    TabOrder = 2
    ExplicitTop = 525
    ExplicitWidth = 738
    Width = 738
    inherited btnCancel: TcxButton
      Left = 653
      ExplicitLeft = 653
    end
    inherited btnPrint: TcxButton
      Left = 567
      OnClick = btnPrintClick
      ExplicitLeft = 567
    end
    inherited btnSave: TcxButton
      Left = 481
      OnClick = btnSaveClick
      ExplicitLeft = 481
    end
    object btnDel: TcxButton
      AlignWithMargins = True
      Left = 119
      Top = 5
      Width = 103
      Height = 25
      Align = alLeft
      Caption = '&Hapus Satuan'
      OptionsImage.ImageIndex = 2
      OptionsImage.Images = frmMain.ImageList
      TabOrder = 3
      Visible = False
      OnClick = btnDelClick
    end
    object btnAdd: TcxButton
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 108
      Height = 25
      Align = alLeft
      Caption = 'T&ambah Satuan'
      OptionsImage.ImageIndex = 0
      OptionsImage.Images = frmMain.ImageList
      TabOrder = 4
      Visible = False
      OnClick = btnAddClick
    end
  end
  inherited Panel2: TPanel
    Top = 504
    Width = 738
    TabOrder = 3
    ExplicitTop = 504
    ExplicitWidth = 738
    inherited lbEscape: TLabel
      Left = 493
      Height = 17
      ExplicitLeft = 493
    end
    inherited lgndSave: TLabel
      Left = 572
      Height = 17
      ExplicitLeft = 572
    end
    inherited lgndPrint: TLabel
      Left = 659
      Height = 17
      ExplicitLeft = 659
    end
  end
  object cxGroupBox1: TcxGroupBox [2]
    Left = 0
    Top = 0
    Align = alTop
    Caption = ' Informasi Barang [F1] '
    TabOrder = 0
    Height = 177
    Width = 738
    object cxLabel1: TcxLabel
      Left = 45
      Top = 43
      Caption = 'Kode'
    end
    object edKode: TcxTextEdit
      Left = 77
      Top = 42
      Properties.CharCase = ecUpperCase
      TabOrder = 1
      Width = 145
    end
    object cxLabel2: TcxLabel
      Left = 42
      Top = 64
      Caption = 'Nama'
    end
    object edNama: TcxTextEdit
      Left = 77
      Top = 63
      Properties.CharCase = ecUpperCase
      TabOrder = 2
      Width = 292
    end
    object cxLookupGroup: TcxExtLookupComboBox
      Left = 77
      Top = 21
      Properties.OnEditValueChanged = cxLookupGroupPropertiesEditValueChanged
      TabOrder = 0
      OnKeyDown = cxLookupGroupKeyDown
      Width = 244
    end
    object cxLabel3: TcxLabel
      Left = 40
      Top = 22
      Caption = 'Group'
    end
    object cxLabel4: TcxLabel
      Left = 46
      Top = 86
      Caption = 'Merk'
    end
    object cxLookupMerk: TcxExtLookupComboBox
      Left = 77
      Top = 85
      TabOrder = 3
      Width = 292
    end
    object cxLabel5: TcxLabel
      Left = 578
      Top = 22
      Caption = 'Rak'
      Visible = False
    end
    object edRak: TcxTextEdit
      Left = 601
      Top = 21
      Properties.CharCase = ecUpperCase
      TabOrder = 6
      Visible = False
      OnKeyDown = edRakKeyDown
      Width = 81
    end
    object cxLabel6: TcxLabel
      Left = 30
      Top = 107
      Caption = 'Catatan'
    end
    object edNotes: TcxMemo
      Left = 77
      Top = 106
      TabOrder = 4
      Height = 55
      Width = 292
    end
    object crPPN: TcxCurrencyEdit
      Left = 481
      Top = 42
      TabStop = False
      EditValue = 0.000000000000000000
      Properties.Alignment.Horz = taRightJustify
      Properties.DecimalPlaces = 0
      Properties.DisplayFormat = ',0.00;(,0.00)'
      TabOrder = 7
      Width = 69
    end
    object cxLabel7: TcxLabel
      Left = 434
      Top = 43
      Caption = 'PPN (%)'
    end
    object lbModifiedBy: TcxLabel
      Left = 420
      Top = 140
      Caption = 'Modified By'
    end
    object edModifiedBy: TcxTextEdit
      Left = 481
      Top = 140
      TabStop = False
      Properties.CharCase = ecUpperCase
      TabOrder = 10
      Width = 201
    end
    object lbModified: TcxLabel
      Left = 409
      Top = 119
      Caption = 'Date Modified'
    end
    object dtModified: TcxDateEdit
      Left = 481
      Top = 118
      TabStop = False
      TabOrder = 9
      Width = 133
    end
    object chkActive: TcxCheckBox
      Left = 228
      Top = 42
      TabStop = False
      Caption = 'Active'
      State = cbsChecked
      TabOrder = 20
    end
    object cxLookUpUOM: TcxExtLookupComboBox
      Left = 481
      Top = 21
      TabOrder = 5
      Width = 69
    end
    object cxLabel8: TcxLabel
      Left = 410
      Top = 22
      Caption = 'Satuan Stock'
    end
    object cxLabel11: TcxLabel
      Left = 425
      Top = 65
      Caption = 'Lead Time'
    end
    object spLeadTime: TcxSpinEdit
      Left = 481
      Top = 64
      Properties.Alignment.Horz = taRightJustify
      Properties.MinValue = 1.000000000000000000
      TabOrder = 8
      Value = 1
      Width = 69
    end
    object cxLabel12: TcxLabel
      Left = 556
      Top = 65
      Caption = 'Hari'
    end
  end
  object pgcMain: TcxPageControl [3]
    Left = 0
    Top = 177
    Width = 738
    Height = 327
    Align = alClient
    TabOrder = 1
    Properties.ActivePage = tsUOM
    Properties.CustomButtons.Buttons = <>
    Properties.TabHeight = 30
    ClientRectBottom = 327
    ClientRectRight = 738
    ClientRectTop = 32
    object tsUOM: TcxTabSheet
      Caption = 'Konversi && Harga Satuan [F2]'
      ImageIndex = 0
      object cxGrid1: TcxGrid
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 732
        Height = 289
        Align = alClient
        TabOrder = 0
        object cxGrdUOM: TcxGridDBBandedTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.FocusCellOnTab = True
          OptionsBehavior.FocusFirstCellOnNewRecord = True
          OptionsBehavior.GoToNextCellOnEnter = True
          OptionsBehavior.FocusCellOnCycle = True
          OptionsCustomize.ColumnMoving = False
          OptionsCustomize.ColumnSorting = False
          OptionsCustomize.BandMoving = False
          OptionsData.Appending = True
          OptionsSelection.HideSelection = True
          OptionsView.GroupByBox = False
          OptionsView.BandHeaderHeight = 30
          Bands = <
            item
              Caption = 'Satuan'
              Width = 76
            end
            item
              Caption = 'Konversi'#13'(Satuan Stock)'
              Width = 144
            end
            item
              Caption = 'Harga Beli'
              Width = 188
            end
            item
              Caption = 'Harga Jual'
              Width = 195
            end
            item
              Caption = '%'
              Width = 57
            end
            item
              Caption = 'Harga Avg'
              Visible = False
              Width = 100
            end>
          object colSatuan: TcxGridDBBandedColumn
            DataBinding.FieldName = 'UOM'
            PropertiesClassName = 'TcxExtLookupComboBoxProperties'
            Position.BandIndex = 0
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object colKonversi: TcxGridDBBandedColumn
            DataBinding.FieldName = 'Konversi'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0;(,0)'
            Position.BandIndex = 1
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object colHrgBeli: TcxGridDBBandedColumn
            DataBinding.FieldName = 'HargaBeli'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0;(,0)'
            Properties.OnEditValueChanged = colHrgBeliPropertiesEditValueChanged
            Styles.Content = styleInfoBk
            Width = 72
            Position.BandIndex = 2
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object colMargin1: TcxGridDBBandedColumn
            DataBinding.FieldName = 'Margin1'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0.0;(,0.0)'
            Properties.OnEditValueChanged = colMargin1PropertiesEditValueChanged
            Styles.Content = styleMoney
            Position.BandIndex = 4
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object colHrgJual1: TcxGridDBBandedColumn
            Caption = 'HargaJual'
            DataBinding.FieldName = 'HargaJual1'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0;(,0)'
            Properties.OnEditValueChanged = colHrgJual1PropertiesEditValueChanged
            Styles.Content = styleMoney
            Position.BandIndex = 3
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
        end
        object cxGrid1Level1: TcxGridLevel
          GridView = cxGrdUOM
        end
      end
    end
    object tsHistory: TcxTabSheet
      Caption = 'History Perubahan Harga'
      ImageIndex = 1
      TabVisible = False
    end
    object tsRack: TcxTabSheet
      Caption = 'Update Informasi Rak [F3]'
      ImageIndex = 2
      object cxGrid2: TcxGrid
        Left = 0
        Top = 0
        Width = 738
        Height = 295
        Align = alClient
        TabOrder = 0
        object cxGrdRak: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Kind = skSum
            end
            item
              Kind = skSum
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.FocusCellOnTab = True
          OptionsBehavior.FocusFirstCellOnNewRecord = True
          OptionsBehavior.GoToNextCellOnEnter = True
          OptionsBehavior.FocusCellOnCycle = True
          OptionsData.Appending = True
          OptionsView.GroupByBox = False
          OptionsView.HeaderHeight = 30
          Styles.ContentOdd = styleOdd
          object colRak: TcxGridDBColumn
            DataBinding.FieldName = 'Rak'
            PropertiesClassName = 'TcxButtonEditProperties'
            Properties.Buttons = <
              item
                Default = True
                Kind = bkEllipsis
              end>
            Properties.ReadOnly = False
            Properties.OnButtonClick = colRakPropertiesButtonClick
            HeaderAlignmentHorz = taCenter
            Width = 226
          end
          object colWarehouse: TcxGridDBColumn
            DataBinding.FieldName = 'Warehouse'
            PropertiesClassName = 'TcxExtLookupComboBoxProperties'
            HeaderAlignmentHorz = taCenter
            Width = 231
          end
        end
        object cxGridLevel2: TcxGridLevel
          Caption = 'Detail Transaksi [F2]'
          GridView = cxGrdRak
        end
      end
    end
    object tsAvgCost: TcxTabSheet
      Caption = 'History Harga Pokok Penjualan / Harga Average'
      ImageIndex = 1
      object cxGroupBox3: TcxGroupBox
        Left = 0
        Top = 0
        Align = alTop
        PanelStyle.Active = True
        Style.BorderStyle = ebsFlat
        Style.LookAndFeel.NativeStyle = False
        StyleDisabled.LookAndFeel.NativeStyle = False
        TabOrder = 0
        Height = 35
        Width = 738
        object btnRefresh: TcxButton
          AlignWithMargins = True
          Left = 658
          Top = 5
          Width = 75
          Height = 25
          Align = alRight
          Caption = '&Refresh'
          OptionsImage.ImageIndex = 5
          OptionsImage.Images = frmMain.ImageList
          TabOrder = 0
          OnClick = btnRefreshClick
        end
        object EndDate: TcxDateEdit
          AlignWithMargins = True
          Left = 552
          Top = 5
          Align = alRight
          Properties.SaveTime = False
          Properties.ShowTime = False
          TabOrder = 1
          Width = 100
        end
        object StartDate: TcxDateEdit
          AlignWithMargins = True
          Left = 427
          Top = 5
          Align = alRight
          Properties.SaveTime = False
          Properties.ShowTime = False
          TabOrder = 2
          Width = 100
        end
        object cxLabel9: TcxLabel
          Left = 357
          Top = 2
          Align = alRight
          Caption = 'Filter Periode'
          Properties.Alignment.Vert = taVCenter
          AnchorY = 18
        end
        object cxLabel10: TcxLabel
          Left = 530
          Top = 2
          Align = alRight
          Caption = 's/d'
          Properties.Alignment.Vert = taVCenter
          AnchorY = 18
        end
      end
      object cxGrid: TcxGrid
        Left = 0
        Top = 35
        Width = 738
        Height = 260
        Align = alClient
        TabOrder = 1
        object cxGrdAvg: TcxGridServerModeTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          Filtering.MRUItemsList = False
          Filtering.ColumnAddValueItems = False
          Filtering.ColumnMRUItemsList = False
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.GroupByBox = False
        end
        object cxGridLevel1: TcxGridLevel
          GridView = cxGrdAvg
        end
      end
    end
  end
  inherited styleRepo: TcxStyleRepository
    Left = 824
    PixelsPerInch = 96
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 752
    Top = 48
    PixelsPerInch = 96
    object styleMoney: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
    object styleInfoBk: TcxStyle
      AssignedValues = [svColor]
      Color = clInfoBk
    end
  end
end
