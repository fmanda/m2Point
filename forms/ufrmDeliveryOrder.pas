unit ufrmDeliveryOrder;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ufrmDefaultInput, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  Vcl.Menus, Vcl.StdCtrls, Vcl.ExtCtrls, cxButtons, cxGroupBox, Vcl.ComCtrls,
  dxCore, cxDateUtils, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBExtLookupComboBox, cxCurrencyEdit, cxButtonEdit, cxMaskEdit, cxCalendar,
  cxMemo, cxTextEdit, cxLabel, cxRadioGroup, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxSplitter, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, uTransDetail,
  cxGridDBDataDefinitions, uItem, Datasnap.DBClient, cxSpinEdit;

type
  TfrmDeliveryOrder = class(TfrmDefaultInput)
    cxGridItem: TcxGrid;
    cxGrdItem: TcxGridDBTableView;
    colKode: TcxGridDBColumn;
    colNama: TcxGridDBColumn;
    colUOM: TcxGridDBColumn;
    colQty: TcxGridDBColumn;
    colWarehouse: TcxGridDBColumn;
    colItemID: TcxGridDBColumn;
    colKonversi: TcxGridDBColumn;
    cxGridItemLevel1: TcxGridLevel;
    Label2: TLabel;
    styleUmum: TcxStyle;
    styleBengkel: TcxStyle;
    styleGrosir: TcxStyle;
    styleKeliling: TcxStyle;
    pmMain: TPopupMenu;
    UpdateKeHargaUmum1: TMenuItem;
    UpdatekeHargaGrosir1: TMenuItem;
    UpdatekeHargaGrosir2: TMenuItem;
    UpdatekeHargaKeliling1: TMenuItem;
    colNo: TcxGridDBColumn;
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    edNoDO: TcxTextEdit;
    cxLabel4: TcxLabel;
    cxLabel6: TcxLabel;
    edNotes: TcxMemo;
    dtInvoice: TcxDateEdit;
    cxLabel8: TcxLabel;
    edCustomer: TcxButtonEdit;
    cxLabel7: TcxLabel;
    cxLookupGudang: TcxExtLookupComboBox;
    colHarga: TcxGridDBColumn;
    procedure edCustomerKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edNotesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure colKodePropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure colKodePropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure colUOMPropertiesCloseUp(Sender: TObject);
    procedure colUOMPropertiesEditValueChanged(Sender: TObject);
    procedure colUOMPropertiesInitPopup(Sender: TObject);
    procedure colQtyPropertiesEditValueChanged(Sender: TObject);
    procedure colDiscPropertiesEditValueChanged(Sender: TObject);
    procedure edCustomerPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure btnSaveClick(Sender: TObject);
    procedure cxGrdItemEditKeyDown(Sender: TcxCustomGridTableView; AItem:
        TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word; Shift:
        TShiftState);
    procedure rbHargaPropertiesEditValueChanged(Sender: TObject);
    procedure edCustomerPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure colSrvQtyPropertiesEditValueChanged(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure colSrvDiscPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure colNoGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
        TcxCustomGridRecord; var AText: string);
    procedure rbHargaOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnPaymentClick(Sender: TObject);
    procedure colDiscPPropertiesEditValueChanged(Sender: TObject);
  private
    DisableTrigger: Boolean;
    FCDS: TClientDataset;
    FCDSClone: TClientDataset;
    FCDSUOM: TClientDataset;
    FCDSValidate: TClientDataset;
    FDevOrder: TDeliveryOrder;
    procedure CDSAfterDelete(DataSet: TDataSet);
    procedure CDSAfterInsert(DataSet: TDataSet);
    function CheckCreditLimit: Boolean;
    function CheckStock: Boolean;
    function DC: TcxGridDBDataController;
    procedure FocusToGrid;
    function GetCDS: TClientDataset;
    function GetCDSClone: TClientDataset;
    function GetCDSUOM: TClientDataset;
    function GetDevOrder: TDeliveryOrder;
    procedure InitView;
    procedure LoadCreditLimitUsed(ResetCreditLimit: Boolean = False; AEditedValue:
        Double = 0);
    procedure LookupItem(aKey: string = '');
    procedure LookupCustomer(sKey: string = '');
    procedure SetCDSValidate(const Value: TClientDataset);
    procedure SetItemToGrid(aItem: TItem; IsFromLookup: Boolean = False);
    procedure UpdateData;
    function ValidateData(WithPaymentDlg: Boolean = False): Boolean;
    property CDS: TClientDataset read GetCDS write FCDS;
    property CDSClone: TClientDataset read GetCDSClone write FCDSClone;
    property CDSUOM: TClientDataset read GetCDSUOM write FCDSUOM;
    property DevOrder: TDeliveryOrder read GetDevOrder write FDevOrder;
    { Private declarations }
  protected
    property CDSValidate: TClientDataset read FCDSValidate write SetCDSValidate;
  public
    function GetGroupName: string; override;
    procedure LoadByID(aID: Integer; IsReadOnly: Boolean = True);
    { Public declarations }
  published
  end;

var
  frmDeliveryOrder: TfrmDeliveryOrder;

implementation

uses
  uDXUtils, uDBUtils, uAppUtils, ufrmCXServerLookup, uCustomer, cxDataUtils,
  uWarehouse, uSalesman, uVariable, uAccount, uSettingFee,
  ufrmDialogPayment, uPrintStruk, ufrmAuthUser, uStockCheck, ufrmLookupItem;

{$R *.dfm}

procedure TfrmDeliveryOrder.btnPaymentClick(Sender: TObject);
begin
  inherited;
  btnSaveClick(Sender);
end;

procedure TfrmDeliveryOrder.btnPrintClick(Sender: TObject);
begin
  inherited;
  TDeliveryOrder.PrintData(DevOrder.ID);
end;

procedure TfrmDeliveryOrder.btnSaveClick(Sender: TObject);
begin
  inherited;

  if not ValidateData() then exit;
  UpdateData;
  if DevOrder.SaveRepeat(False) then
  begin
//    TAppUtils.InformationBerhasilSimpan;
//    Self.ModalResult := mrOK;
    try
      btnPrint.Click;
    except
      on E:Exception do
      begin
        TAppUtils.Error(
          'Gagal Cetak DO, Silahkan cetak ulang dari Browse' + #13 +
          E.Message);
      end;
    end;
    LoadByID(0, False);
  end;
end;

procedure TfrmDeliveryOrder.CDSAfterDelete(DataSet: TDataSet);
begin
  inherited;
//  CalculateAll;
end;

procedure TfrmDeliveryOrder.CDSAfterInsert(DataSet: TDataSet);
begin
  inherited;
  DataSet.FieldByName('Warehouse').AsInteger := VarToInt(cxLookupGudang.EditValue);
end;

function TfrmDeliveryOrder.CheckCreditLimit: Boolean;
begin
  Result := True;
end;

function TfrmDeliveryOrder.CheckStock: Boolean;
var
  lCalc: TStockCheck;
  lCDS: TClientDataSet;
  lItem: TTransDetail;
  lOldDO: TDeliveryOrder;
  QTYPCS: Integer;
begin
  Result := AppVariable.Check_Stock <> 1;
  if Result then exit;

  lCalc := TStockCheck.Create(dtInvoice.Date);
  lOldDO := TDeliveryOrder.Create;
  Application.ProcessMessages;

  lCDS := TClientDataSet.Create(Self);
  Try
    lCDS.CloneCursor(CDS, True);
    lCDS.First;
    while not lCDS.Eof do
    begin
      QTYPCS   := lCDS.FieldByName('QTY').AsInteger * lCDS.FieldByName('Konversi').AsInteger;
      lCalc.AddCalcItem(
        lCDS.FieldByName('Item').AsInteger,
        lCDS.FieldByName('Warehouse').AsInteger,
        QTYPCS
      );
      lCDS.Next;
    end;

    //apabila edit
    If DevOrder.ID <> 0 then
    begin
      lOldDO.LoadByID(DevOrder.ID);
      for lItem in lOldDO.Items do
      begin
        lCalc.AddOnHandPCS(
            lItem.Item.ID,
            lItem.Warehouse.ID,
            lItem.Qty * lItem.Konversi
          );
      end;
    end;
    Result := lCalc.CheckStockIgnore(True);
  finally
    lCDS.Free;
    lOldDO.Free;
    lCalc.Free;
  End;
end;

procedure TfrmDeliveryOrder.colDiscPPropertiesEditValueChanged(Sender: TObject);
begin
  inherited;
//  CalculateAll;
end;

procedure TfrmDeliveryOrder.colDiscPropertiesEditValueChanged(Sender: TObject);
begin
  inherited;
//  CalculateAll;
end;

procedure TfrmDeliveryOrder.colKodePropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
var
  sKey: string;
  Edit: TcxCustomEdit;
begin
  inherited;
  Edit := Sender as TcxCustomEdit;
  sKey := VarToStr(Edit.EditingValue);
  LookupItem(sKey);
end;

procedure TfrmDeliveryOrder.colKodePropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
var
  lItem: TItem;
begin
  inherited;
  lItem := TItem.Create;
  Try
    if lItem.LoadByCode(VarToStr(DisplayValue)) then
      SetItemToGrid(lItem, True)
    else
    begin
      Error := True;
      ErrorText := 'Kode Barang : ' + VarToStr(DisplayValue) + ' tidak ditemukan';
    end;
  Finally
    lItem.Free;
  End;
end;

procedure TfrmDeliveryOrder.colNoGetDisplayText(Sender: TcxCustomGridTableItem;
    ARecord: TcxCustomGridRecord; var AText: string);
begin
  inherited;
  if ARecord = nil then exit;
  AText := VarToStr(ARecord.RecordIndex + 1);
end;

procedure TfrmDeliveryOrder.colQtyPropertiesEditValueChanged(Sender: TObject);
begin
  inherited;
//  CalculateAll;
end;

procedure TfrmDeliveryOrder.colSrvDiscPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;
  if VarToFloat(DisplayValue) = 0 then exit;

  if not TfrmAuthUser.Authorize('Autorisasi Diskon') then
  begin
    ErrorText := 'User tidak mendapatkan autorisasi diskon';
    Error := True;
  end;
end;

procedure TfrmDeliveryOrder.colSrvQtyPropertiesEditValueChanged(Sender: TObject);
begin
  inherited;
//  CalculateAll;
end;

procedure TfrmDeliveryOrder.colUOMPropertiesCloseUp(Sender: TObject);
begin
  inherited;
  with TcxExtLookup(colUOM.Properties).DataController.filter do
  begin
    BeginUpdate;
    Root.Clear;
    EndUpdate;
  end;
end;

procedure TfrmDeliveryOrder.colUOMPropertiesEditValueChanged(Sender: TObject);
var
  lItemUOM: TItemUOM;
begin
  inherited;

  lItemUOM := TItemUOM.GetItemUOM(
    VarToInt(cxGrdItem.Controller.FocusedRecord.Values[colItemID.Index]),
    VarToInt(cxGrdItem.Controller.FocusedRecord.Values[colUOM.Index])
  );
  if lItemUOM = nil then exit;
  Try
    DC.SetEditValue(colKonversi.Index, lItemUOM.Konversi, evsValue);

//    CalculateAll;
    colQty.FocusWithSelection;
    cxGrdItem.Controller.EditingController.ShowEdit;
  Finally
    FreeAndNil(lItemUOM);
  End;
end;

procedure TfrmDeliveryOrder.colUOMPropertiesInitPopup(Sender: TObject);
var
  lItem: TItem;
  lItemUOM: TItemUOM;
begin
  inherited;
  if cxGrdItem.Controller.FocusedRecord = nil then exit;
  lItem := TItem.Create;
  Try
    lItem.LoadByID(VarToInt(cxGrdItem.Controller.FocusedRecord.Values[colItemID.Index]));
    with TcxExtLookup(colUOM.Properties).DataController.filter do
    begin
      BeginUpdate;
      Root.Clear;
      Root.BoolOperatorKind := fboOr;

      for lItemUOM in lItem.ItemUOMs do
      begin
        Root.AddItem(
          TcxGridDBTableView(TcxExtLookup(colUOM.Properties).View).GetColumnByFieldName('ID'),
          foEqual, lItemUOM.UOM.ID, '');
      end;
      Active := True;
      EndUpdate;
    end;
  Finally
    lItem.Free;
  End;
end;

procedure TfrmDeliveryOrder.cxGrdItemEditKeyDown(Sender: TcxCustomGridTableView;
    AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word; Shift:
    TShiftState);
begin
  inherited;
  if (Key = VK_F5) and (aItem = colKode) then
  begin
    LookupItem(VarToStr(AEdit.EditingValue));
  end;
end;

function TfrmDeliveryOrder.DC: TcxGridDBDataController;
begin
  Result := cxGrdItem.DataController;
end;

procedure TfrmDeliveryOrder.edCustomerKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
var
  Edit: TcxCustomEdit;
  sKey: string;
begin
  inherited;
  if Key = VK_F5 then
  begin
    Edit := Sender as TcxCustomEdit;
    sKey := VarToStr(Edit.EditingValue);
    LookupCustomer(sKey);
  end else if Key = VK_RETURN then
  begin
    SelectNext(Screen.ActiveControl, True, True);
  end;
end;

procedure TfrmDeliveryOrder.edCustomerPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  inherited;
  LookupCustomer;
end;

procedure TfrmDeliveryOrder.edCustomerPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;
  if DevOrder.Customer = nil then
    DevOrder.Customer := TCustomer.Create;
  DevOrder.Customer.LoadByCode(VarToStr(DisplayValue));
  LoadCreditLimitUsed;
  edCustomer.Text := DevOrder.Customer.Nama;
end;

procedure TfrmDeliveryOrder.edNotesKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
begin
  inherited;
  if Key = VK_RETURN then
  begin
  end;
end;

procedure TfrmDeliveryOrder.rbHargaOnKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
begin
  inherited;
  if Key = VK_RETURN then
  begin
    FocusToGrid;
  end;
end;

procedure TfrmDeliveryOrder.FocusToGrid;
begin
  cxGridItem.SetFocus;
  cxGridItem.FocusedView := cxGrdItem;
  if cxGrdItem.DataController.RecordCount = 0 then
  begin
    CDS.Append;
    colKode.FocusWithSelection;
    cxGrdItem.Controller.EditingController.ShowEdit;
  end;
end;

procedure TfrmDeliveryOrder.FormCreate(Sender: TObject);
begin
  inherited;
  InitView;
  Self.AssignKeyDownEvent;
  LoadByID(0,  False);
end;

procedure TfrmDeliveryOrder.FormKeyDown(Sender: TObject; var Key: Word; Shift:
    TShiftState);
begin
  inherited;
  if Key = VK_F1 then
    dtInvoice.SetFocus;

  if Key = VK_F2 then
  begin
    FocusToGrid;
  end
  else if Key = VK_F3 then
  begin
  end
  else if Key = VK_F12 then
  begin

  end else if Key = VK_F9 then
  begin

  end;

end;

function TfrmDeliveryOrder.GetCDS: TClientDataset;
begin
  if FCDS = nil then
  begin
    FCDS := TTransDetail.CreateDataSet(Self, False);
    FCDS.AddField('Kode',ftString);
    FCDS.AddField('Nama',ftString);
    FCDS.AfterInsert := CDSAfterInsert;
    FCDS.AfterDelete := CDSAfterDelete;
//    FCDS.AfterPost := CDSAfterPost;
//    FCDS.AddField('ItemObject',ftInteger);
    FCDS.CreateDataSet;
    DisableTrigger := False;
  end;
  Result := FCDS;
end;

function TfrmDeliveryOrder.GetCDSClone: TClientDataset;
begin
  if FCDSClone = nil then
  begin
    FCDSClone := CDS.ClonedDataset(Self);
  end;
  Result := FCDSClone;
end;

function TfrmDeliveryOrder.GetCDSUOM: TClientDataset;
begin
  if FCDSUOM = nil then
  begin
    FCDSUOM := TDBUtils.OpenDataset('select id, uom from tuom',Self);
  end;
  Result := FCDSUOM;
end;

function TfrmDeliveryOrder.GetGroupName: string;
begin
  Result := 'Penjualan & Kas';
end;

function TfrmDeliveryOrder.GetDevOrder: TDeliveryOrder;
begin
  if FDevOrder = nil then
    FDevOrder := TDeliveryOrder.Create;
  Result := FDevOrder;
end;

procedure TfrmDeliveryOrder.InitView;
begin
  cxGrdItem.PrepareFromCDS(CDS);


  TcxExtLookup(colWarehouse.Properties).LoadFromSQL(Self,
    'select id, nama from twarehouse where is_external = 0','nama');
  TcxExtLookup(colUOM.Properties).LoadFromCDS(CDSUOM, 'id', 'uom', ['id'], Self);
  cxLookupGudang.Properties.LoadFromSQL(Self,
    'select id, nama from twarehouse where is_external = 0','nama');

  cxLookupGudang.SetDefaultValue();

end;

procedure TfrmDeliveryOrder.LoadByID(aID: Integer; IsReadOnly: Boolean = True);
var
  lItem: TTransDetail;
begin
  if FDevOrder <> nil then
    FreeAndNil(FDevOrder);

  DevOrder.LoadByID(aID);



  CDS.EmptyDataSet;

  if aID = 0 then
  begin
    DevOrder.TransDate    := Now();
    DevOrder.DONo         := DevOrder.GenerateNo();



    cxLookupGudang.SetDefaultValue();
  end
  else
  begin
    DisableTrigger := True;
    Try
    Finally
      DisableTrigger := False;
    End;
  end;

  if (aID <> 0) and (not IsReadOnly) then
  begin
    IsReadOnly := not IsValidTransDate(DevOrder.TransDate);

    if not DevOrder.ValidateUpdate then
    begin
      TAppUtils.Warning('DO ini sudah dibuatkan invoice, tidak bisa dilakukan edit/hapus. Silahkan hapus DO dari invoice terlebih dahulu');
      IsReadOnly := True;
    end;


  end;

  edNoDO.Text := DevOrder.DONo;

//  if aID <> 0 then DisableTrigger := True;
//  Try
//    cbBayar.ItemIndex := DevOrder.PaymentFlag;
//    cbBayarPropertiesEditValueChanged(Self);
//    if SalesType = -1 then
//      SalesType := DevOrder.SalesType;
//
//    rbJenis.ItemIndex := SalesType;
//    rbJenisPropertiesEditValueChanged(Self);
//  Finally
//    DisableTrigger := False;
//  End;

  dtInvoice.Date := DevOrder.TransDate;
  edNotes.Text := DevOrder.Notes;

//  edCustomer.Clear;
  if DevOrder.Customer <> nil then
  begin
    DevOrder.Customer.ReLoad(False);
    edCustomer.Text := DevOrder.Customer.Nama;



  end;

//  cxLookupGudang.Clear;
  if DevOrder.Warehouse <> nil then
    cxLookupGudang.EditValue := DevOrder.Warehouse.ID;



  for lItem in DevOrder.Items do
  begin
    CDS.Append;
    lItem.MakePositive;
    lItem.UpdateToDataset(CDS);
    lItem.Item.ReLoad(False);
    CDS.FieldByName('Kode').AsString := lItem.Item.Kode;
    CDS.FieldByName('Nama').AsString := lItem.Item.Nama;


    CDS.Post;
  end;


//  CalculateAll;
  btnSave.Enabled := not IsReadOnly;

  if Self.Visible then
  begin
//    if rbJenis.ItemIndex = 0 then
//      FocusToGrid
//    else
      dtInvoice.SetFocus;
  end;

end;

procedure TfrmDeliveryOrder.LoadCreditLimitUsed(ResetCreditLimit: Boolean =
    False; AEditedValue: Double = 0);
begin

end;

procedure TfrmDeliveryOrder.LookupItem(aKey: string = '');
var
  cxLookup: TfrmCXServerLookup;
  lItem: TItem;
  s: string;
//  sKey: string;
begin

//  sKey := '';
//  if cxGrdMain.Controller.FocusedRecord <> nil then
//    sKey := VarToStr(cxGrdMain.Controller.FocusedRecord.Values[colKode.Index]);

  lItem  := TItem.Create;
  Try
    s := 'SELECT A.ID, A.KODE, A.NAMA, D.NAMA AS MERK, B.UOM AS UOMSTOCK,'
        +' C.HARGAJUAL '
        +' FROM TITEM A'
        +' INNER JOIN TUOM B ON A.STOCKUOM_ID = B.ID'
        +' LEFT JOIN TITEMUOM C ON A.ID = C.ITEM_ID AND C.UOM_ID = B.ID'
        +' LEFT JOIN TMERK D ON A.MERK_ID = C.ID';

    cxLookup := TfrmLookupItem.Execute(S,'ID');
    if aKey <> '' then
      cxLookup.PreFilter('Nama', aKey)
    else
      cxLookup.cxGrdMain.GetColumnByFieldName('NAMA').Focused := True;
    try
      if cxLookup.ShowModal = mrOK then
      begin
        lItem.LoadByID(cxLookup.FieldValue('ID'));
        SetItemToGrid(lItem);
      end;
    finally
      cxLookup.Free;
    end;
  Finally
    FreeAndNil(lItem);
  End;
end;

procedure TfrmDeliveryOrder.rbHargaPropertiesEditValueChanged(Sender: TObject);
begin
  inherited;
//  if CDS.RecordCount > 0 then
//  begin
//    if DevOrder.SalesType <> rbHarga.ItemIndex then
//    begin
//      //update harga
//      if TAppUtils.Confirm('Anda yakin harga diubah menjadi : ' + rbHarga.Properties.Items[rbHarga.ItemIndex].Caption + '?')
//      then
//      begin
//        UpdateHarga;
//        cxLookupFee.Clear;
//        cxLookupSalesman.Clear;
////        DevOrder.SalesType := rbHarga.ItemIndex;
//      end else
//      begin
//        rbHarga.ItemIndex := DevOrder.SalesType;
//        exit;
//      end;
//    end;
//  end;


  
end;

procedure TfrmDeliveryOrder.LookupCustomer(sKey: string = '');
var
  cxLookup: TfrmCXServerLookup;
  S: string;
begin
  S := 'select * from TCUSTOMER';
  cxLookup := TfrmCXServerLookup.Execute(S, 'ID');
  Try
    cxLookup.PreFilter('Nama', sKey);
    if cxLookup.ShowModal = mrOK then
    begin
      if DevOrder.Customer = nil then
        DevOrder.Customer := TCustomer.Create;
      DevOrder.Customer.LoadByID(cxLookup.FieldValue('id'));
      LoadCreditLimitUsed;
      edCustomer.Text := DevOrder.Customer.Nama;
    end;
  Finally
    cxLookup.Free;
  End;
end;

procedure TfrmDeliveryOrder.SetCDSValidate(const Value: TClientDataset);
begin
  if FCDSValidate = nil then
  begin
    FCDSValidate := TClientDataset.Create(Self);
    FCDSValidate.AddField('Item_ID', ftInteger);
    FCDSValidate.AddField('Kode', ftString);
    FCDSValidate.AddField('Nama', ftString);
    FCDSValidate.AddField('UOM', ftString);
    FCDSValidate.AddField('Stock', ftFloat);
    FCDSValidate.AddField('OnHand', ftFloat);
    FCDSValidate.AddField('Qty', ftFloat);
    FCDSValidate.CreateDataSet;
  end;
  FCDSValidate := Value;
end;

procedure TfrmDeliveryOrder.SetItemToGrid(aItem: TItem; IsFromLookup: Boolean =
    False);
var
  i: Integer;
  lItemUOM: TItemUOM;
  sMsg: string;
begin
  if aItem = nil then exit;

  for i := 0 to DC.RecordCount-1 do
  begin
    if i = DC.FocusedRecordIndex then continue;

    if VarToInt(DC.Values[i,colItemID.Index]) = aItem.ID then
    begin
      sMsg := 'Item : ' + aItem.Kode + ' : ' + aItem.Nama
          + #13 + 'sudah pernah diinput di baris no : ' + IntToSTr(i + 1)
          + ' sejumlah : ' + VarToStr(DC.Values[i, colQty.Index]) + ' '
          + VarToStr(DC.DisplayTexts[i, colUOM.Index])
          + #13#13 + 'Apakah Anda ingin mengganti jumlah Qty Item tersebut?';

      if TAppUtils.Confirm(sMsg) then
      begin
        DC.Cancel;
        DC.Controller.FocusedRecordIndex  := i;
        if not IsFromLookup then
          DC.Controller.FocusedItem       := colQty
        else
          DC.Controller.FocusedItem       := colUOM; //alwayas +1 from this because enter key event;

        DC.Controller.EditingController.ShowEdit;
        exit;
      end
    end;
  end;


  DC.SetEditValue(colItemID.Index, aItem.ID, evsValue);
//  DC.SetEditValue(colItemObject, Integer(aItem), evsValue);
  DC.SetEditValue(colKode.Index, aItem.Kode, evsValue);
  DC.SetEditValue(colNama.Index, aItem.Nama, evsValue);
  DC.SetEditValue(colUOM.Index, 0, evsValue);
  DC.SetEditValue(colQty.Index, 0, evsValue);
  DC.SetEditValue(colKonversi.Index, 0, evsValue);


  //def uom
  if aItem.StockUOM <> nil then
  begin
    DC.SetEditValue(colUOM.Index, aItem.StockUOM.ID, evsValue);
//    colUOMPropertiesEditValueChanged(nil);
    lItemUOM := TItemUOM.GetItemUOM(
      VarToInt(cxGrdItem.Controller.FocusedRecord.Values[colItemID.Index]),
      VarToInt(cxGrdItem.Controller.FocusedRecord.Values[colUOM.Index])
    );
    if lItemUOM = nil then exit;
    Try
      DC.SetEditValue(colHarga.Index, lItemUOM.Konversi, evsValue);
      DC.SetEditValue(colKonversi.Index, lItemUOM.Konversi, evsValue);

    Finally
      FreeAndNil(lItemUOM);
    End;
  end;
end;

procedure TfrmDeliveryOrder.UpdateData;
var
  lItem: TTransDetail;
begin

  DevOrder.DONo := edNoDO.Text;
  DevOrder.TransDate := dtInvoice.Date;
  DevOrder.Notes := edNotes.Text;

  DevOrder.ModifiedDate := Now();
  DevOrder.ModifiedBy := UserLogin;

  if DevOrder.Warehouse = nil then
    DevOrder.Warehouse := TWarehouse.Create;
  DevOrder.Warehouse.ID := VarToInt(cxLookupGudang.EditValue);


  DevOrder.Items.Clear;
  CDS.First;
  while not CDS.Eof do
  begin
    lItem := TTransDetail.Create;
    lItem.SetFromDataset(CDS);

    //user tidak memilih gudang lagi
    if lItem.Warehouse = nil then
      lItem.Warehouse := TWarehouse.Create;

    lItem.Warehouse.ID := DevOrder.Warehouse.ID;

    DevOrder.Items.Add(lItem);
    CDS.Next;
  end;


end;

function TfrmDeliveryOrder.ValidateData(WithPaymentDlg: Boolean = False):
    Boolean;
begin
  Result := False;

  if DevOrder.Customer = nil then
  begin
    TAppUtils.Warning('Customer belum dipilih');
    edCustomer.SetFocus;
    exit;
  end;

  if DevOrder.Customer.ID = 0 then
  begin
    TAppUtils.Warning('Customer belum dipilih');
    edCustomer.SetFocus;
    exit;
  end;

  if VarToInt(cxLookupGudang.EditValue) = 0 then
  begin
    TAppUtils.Warning('Gudang wajib dipilih');
    cxLookupGudang.SetFocus;
    exit;
  end;



  CDSClone.Last;
  if CDSClone.RecordCount > 0 then
  begin
    if (CDSClone.FieldByName('Item').AsInteger = 0)
      and (CDSCLone.FieldByName('UOM').AsInteger = 0)
      and (CDSClone.FieldByName('Qty').AsFloat = 0)
    then
    begin
      CDSClone.Delete;
    end;
  end;

//  if CDS.State in [dsInsert, dsEdit] then CDS.Post;

//  if CDS.RecordCount = 0 then
//  begin
//    TAppUtils.Warning('Data Item tidak boleh kosong' + #13 + 'Baris : ' +IntTostr(CDS.RecNo));
//    exit;
//  end;

  if CDS.Locate('Item', null, []) or CDS.Locate('Item', 0, []) then
  begin
    TAppUtils.Warning('Item tidak boleh kosong' + #13 + 'Baris : ' +IntTostr(CDS.RecNo));
    exit;
  end;

  if CDS.Locate('UOM', null, []) or CDS.Locate('UOM', 0, []) then
  begin
    TAppUtils.Warning('Satuan tidak boleh kosong' + #13 + 'Baris : ' +IntTostr(CDS.RecNo));
    exit;
  end;

  if CDS.Locate('Qty', 0, []) then
  begin
    TAppUtils.Warning('Qty tidak boleh 0' + #13 + 'Baris : ' +IntTostr(CDS.RecNo));
    exit;
  end;

//  if CDS.Locate('Warehouse', 0, []) or CDS.Locate('Warehouse', null, []) then
//  begin
//    TAppUtils.Warning('Warehouse tidak boleh kosong' + #13 + 'Baris : ' +IntTostr(CDS.RecNo));
//    exit;
//  end;

  if not IsValidTransDate(dtInvoice.Date) then exit;

  if not ConfirmDiffClientDate(dtInvoice.Date) then exit;


  if not CheckStock then exit;

  if not CheckCreditLimit then
  begin
//    TAppUtils.Warning('Credit Limit Customer tidak cukup');
//    edCustomer.SetFocus;
    exit;
  end;

  Result := TAppUtils.Confirm('Anda yakin data sudah sesuai?');

end;

end.
