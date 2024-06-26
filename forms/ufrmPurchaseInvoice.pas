unit ufrmPurchaseInvoice;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ufrmDefaultInput, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  Vcl.Menus, Vcl.StdCtrls, cxButtons, cxGroupBox, Vcl.ComCtrls, dxCore,
  cxDateUtils, cxButtonEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, cxMemo,
  cxTextEdit, cxLabel, cxCurrencyEdit, cxRadioGroup, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxNavigator, Datasnap.DBClient,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGrid, cxLookupEdit, cxDBLookupEdit,
  cxDBExtLookupComboBox, Vcl.ExtCtrls, uTransDetail, uDBUtils, uItem,
  cxGridDBDataDefinitions, cxSpinEdit, uFinancialTransaction, ufrmCXLookup,
  DateUtils;
type
  TfrmPurchaseInvoice = class(TfrmDefaultInput)
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    edNoInv: TcxTextEdit;
    cxLabel4: TcxLabel;
    cxLabel6: TcxLabel;
    edNotes: TcxMemo;
    dtInvoice: TcxDateEdit;
    cxLabel8: TcxLabel;
    dtJtTempo: TcxDateEdit;
    cxLabel9: TcxLabel;
    edSupplier: TcxButtonEdit;
    crSubTotal: TcxCurrencyEdit;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    crPPN: TcxCurrencyEdit;
    cxLabel5: TcxLabel;
    crTotal: TcxCurrencyEdit;
    cxGrdMain: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    colKode: TcxGridDBColumn;
    colNama: TcxGridDBColumn;
    colUOM: TcxGridDBColumn;
    colQty: TcxGridDBColumn;
    colDisc: TcxGridDBColumn;
    colSubTotal: TcxGridDBColumn;
    cbBayar: TcxComboBox;
    cxLabel10: TcxLabel;
    colWarehouse: TcxGridDBColumn;
    Label2: TLabel;
    colItemID: TcxGridDBColumn;
    colKonversi: TcxGridDBColumn;
    colPPN: TcxGridDBColumn;
    Label1: TLabel;
    cxLabel13: TcxLabel;
    cxLookupRekening: TcxExtLookupComboBox;
    spTempo: TcxSpinEdit;
    cxLabel11: TcxLabel;
    edReferensi: TcxTextEdit;
    cxLabel12: TcxLabel;
    cxGrdMainColumn1: TcxGridDBColumn;
    colHrgBeli: TcxGridDBColumn;
    pmMain: TPopupMenu;
    SetSebagaiBarangBonus1: TMenuItem;
    stylBonus: TcxStyle;
    Label3: TLabel;
    colPriceType: TcxGridDBColumn;
    btnLoadRec: TcxButton;
    cxGrid1Level2: TcxGridLevel;
    cxGrdOthers: TcxGridDBTableView;
    colOthAccCode: TcxGridDBColumn;
    colOthAccName: TcxGridDBColumn;
    colOthDescription: TcxGridDBColumn;
    colOthDebet: TcxGridDBColumn;
    colOthCredit: TcxGridDBColumn;
    cxLabel7: TcxLabel;
    crOthers: TcxCurrencyEdit;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1DBTableView1Column1: TcxGridDBColumn;
    procedure cxGrdMainEditKeyDown(Sender: TcxCustomGridTableView; AItem:
        TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word; Shift:
        TShiftState);
    procedure edNotesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure colKodePropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure colKodePropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure colUOMPropertiesInitPopup(Sender: TObject);
    procedure colUOMPropertiesCloseUp(Sender: TObject);
    procedure colUOMPropertiesEditValueChanged(Sender: TObject);
    procedure edSupplierKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure colQtyPropertiesEditValueChanged(Sender: TObject);
    procedure colDiscPropertiesEditValueChanged(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure edSupplierPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure cbBayarPropertiesEditValueChanged(Sender: TObject);
    procedure btnGenerateClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure cxGrdMainColumn1GetDisplayText(Sender: TcxCustomGridTableItem;
        ARecord: TcxCustomGridRecord; var AText: string);
    procedure SetSebagaiBarangBonus1Click(Sender: TObject);
    procedure spTempoPropertiesEditValueChanged(Sender: TObject);
    procedure cxGrdMainStylesGetContentStyle(Sender: TcxCustomGridTableView;
      ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem;
      var AStyle: TcxStyle);
    procedure btnLoadRecClick(Sender: TObject);
    procedure colPPNPropertiesEditValueChanged(Sender: TObject);
    procedure colOthDebetPropertiesEditValueChanged(Sender: TObject);
    procedure colOthCreditPropertiesEditValueChanged(Sender: TObject);
  private
    DisableTrigger: Boolean;
    FCDS: TClientDataset;
    FCDSOthers: TClientDataset;
    FCDSClone: TClientDataset;
    FCDSUOM: TClientDataset;
    FCDSDummy: TClientDataset;
    FCDSAccount: TClientDataset;
    FCDSCloneOth: TClientDataset;
    FPurchInv: TPurchaseInvoice;
    procedure CalculateAll;
    procedure CDSAfterDelete(DataSet: TDataSet);
    procedure CDSAfterInsert(DataSet: TDataSet);
    function DC: TcxGridDBDataController;
    procedure FocusToGrid;
    procedure GenerateDummy;
    function GetCDS: TClientDataset;
    function GetCDSOthers: TClientDataset;
    function GetCDSClone: TClientDataset;
    function GetCDSUOM: TClientDataset;
    function GetCDSDummy: TClientDataset;
    function GetCDSAccount: TClientDataset;
    function GetCDSCloneOth: TClientDataset;
    function GetPurchInv: TPurchaseInvoice;
    procedure InitView;
    procedure LoadReceive(aPRID: Integer);
    procedure LookupItem(aKey: string = '');
    procedure LookupReceive;
    procedure LookupSupplier(sKey: string = '');
    procedure SetBarangBonus;
    procedure SetItemToGrid(aItem: TItem);
    procedure UpdateData;
    function ValidateData: Boolean;
    property CDS: TClientDataset read GetCDS write FCDS;
    property CDSOthers: TClientDataset read GetCDSOthers write FCDSOthers;
    property CDSClone: TClientDataset read GetCDSClone write FCDSClone;
    property CDSUOM: TClientDataset read GetCDSUOM write FCDSUOM;
    property CDSDummy: TClientDataset read GetCDSDummy write FCDSDummy;
    property CDSAccount: TClientDataset read GetCDSAccount write FCDSAccount;
    property CDSCloneOth: TClientDataset read GetCDSCloneOth write FCDSCloneOth;
    property PurchInv: TPurchaseInvoice read GetPurchInv write FPurchInv;
    { Private declarations }
  protected
    procedure CDSAfterPost(DataSet: TDataSet);
  public
    function GetGroupName: string; override;
    procedure LoadByID(aID: Integer; IsReadOnly: Boolean = True);
    { Public declarations }
  end;

var
  frmPurchaseInvoice: TfrmPurchaseInvoice;

implementation

uses
  uAppUtils, uDXUtils, ufrmCXServerLookup, cxDataUtils, uSupplier, uWarehouse,
  uAccount, uVariable, ufrmLookupItem;

{$R *.dfm}

procedure TfrmPurchaseInvoice.btnGenerateClick(Sender: TObject);
begin
  inherited;
  GenerateDummy;
end;

procedure TfrmPurchaseInvoice.btnLoadRecClick(Sender: TObject);
begin
  inherited;
  LookupReceive;
end;

procedure TfrmPurchaseInvoice.btnPrintClick(Sender: TObject);
begin
  inherited;
  TPurchaseInvoice.PrintData(PurchInv.ID);
end;

procedure TfrmPurchaseInvoice.btnSaveClick(Sender: TObject);
begin
  inherited;
  if not ValidateData then exit;
  UpdateData;
  if PurchInv.SaveRepeat(2, False) then
  begin
    btnPrint.Click;
//    TAppUtils.InformationBerhasilSimpan;
    Self.ModalResult := mrOK;
  end;
end;

procedure TfrmPurchaseInvoice.CalculateAll;
var
  dOth: Double;
  dPPN: Double;
  dSubTotal: Double;
  lHrgNet: Double;
begin
  if CDS.State in [dsInsert, dsEdit] then
    CDS.Post;

  if CDSOthers.State in [dsInsert, dsEdit] then
    CDSOthers.Post;


  CDS.DisableControls;
  CDSOthers.DisableControls;
  DisableTrigger := True;
  Try
    dSubTotal := 0;
    dPPN := 0;
    dOth := 0;

    CDSClone.First;
    while not CDSClone.Eof do
    begin
      CDSClone.Edit;
      lHrgNet :=
        (1 - (CDSClone.FieldByName('DiscP').AsFloat /100))
        * CDSClone.FieldByName('Harga').AsFloat;


      CDSClone.FieldByName('SubTotal').AsFloat :=
        lHrgNet * CdSClone.FieldByName('QTY').AsFloat;
      dSubTotal := dSubTotal +  CDSClone.FieldByName('SubTotal').AsFloat;
      dPPN :=  dPPN + (CDSClone.FieldByName('PPN').AsFloat * CDSClone.FieldByName('SubTotal').AsFloat / 100);

      CDSClone.Post;
      CDSClone.Next;
    end;

    CDSCloneOth.First;
    while not CDSCloneOth.Eof do
    begin
      dOth := dOth +  CDSCloneOth.FieldByName('DebetAmt').AsFloat
        - CDSCloneOth.FieldByName('CreditAmt').AsFloat;
      CDSCloneOth.Next;
    end;


    crSubTotal.Value  := dSubTotal;
    crPPN.Value       := dPPN;
    crOthers.Value    := dOth;
    crTotal.Value     := dSubTotal + dPPN + dOth;
  Finally
    CDS.EnableControls;
    CDSOthers.EnableControls;
    DisableTrigger := False;
  End;
end;

procedure TfrmPurchaseInvoice.cbBayarPropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;
  if cbBayar.ItemIndex = PaymentFlag_Cash then
  begin
    spTempo.Value   := 0;
    dtJtTempo.Date  := dtInvoice.Date;
  end;

  cxLookupRekening.Enabled := cbBayar.ItemIndex = PaymentFlag_Cash;
  dtJtTempo.Enabled := cbBayar.ItemIndex = PaymentFlag_Credit;
  spTempo.Visible := cbBayar.ItemIndex = PaymentFlag_Credit;

  cxLookupRekening.Enabled := cbBayar.ItemIndex = PaymentFlag_Cash
end;

procedure TfrmPurchaseInvoice.CDSAfterInsert(DataSet: TDataSet);
begin
  inherited;
  //do nothing
end;

procedure TfrmPurchaseInvoice.CDSAfterPost(DataSet: TDataSet);
begin
  inherited;
  if DisableTrigger then exit;
  CalculateAll;
end;

procedure TfrmPurchaseInvoice.colDiscPropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;
  CalculateAll;
end;

procedure TfrmPurchaseInvoice.colKodePropertiesButtonClick(Sender: TObject;
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

procedure TfrmPurchaseInvoice.colKodePropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
var
  lItem: TItem;
begin
  inherited;
  lItem := TItem.Create;
  Try
    if lItem.LoadByCode(VarToStr(DisplayValue)) then
      SetItemToGrid(lItem)
    else
    begin
      Error := True;
      ErrorText := 'Kode Barang : ' + VarToStr(DisplayValue) + ' tidak ditemukan';
    end;
  Finally
    lItem.Free;
  End;
end;

procedure TfrmPurchaseInvoice.colOthCreditPropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;
  CalculateAll;
end;

procedure TfrmPurchaseInvoice.colOthDebetPropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;
  CalculateAll;
end;

procedure TfrmPurchaseInvoice.colPPNPropertiesEditValueChanged(Sender: TObject);
begin
  inherited;
  CalculateAll;
end;

procedure TfrmPurchaseInvoice.colQtyPropertiesEditValueChanged(Sender: TObject);
begin
  inherited;
  CalculateAll;
end;

procedure TfrmPurchaseInvoice.colUOMPropertiesCloseUp(Sender: TObject);
begin
  inherited;
  with TcxExtLookup(colUOM.Properties).DataController.filter do
  begin
    BeginUpdate;
    Root.Clear;
    EndUpdate;
  end;
end;

procedure TfrmPurchaseInvoice.colUOMPropertiesEditValueChanged(Sender: TObject);
var
  lItemUOM: TItemUOM;
begin
  inherited;

  lItemUOM := TItemUOM.GetItemUOM(
    VarToInt(cxGrdMain.Controller.FocusedRecord.Values[colItemID.Index]),
    VarToInt(cxGrdMain.Controller.FocusedRecord.Values[colUOM.Index])
  );
  if lItemUOM = nil then exit;
  Try
    DC.SetEditValue(colKonversi.Index, lItemUOM.Konversi, evsValue);
    DC.SetEditValue(colHrgBeli.Index, lItemUOM.HargaBeli, evsValue);


    CalculateAll;
    colQty.FocusWithSelection;
    cxGrdMain.Controller.EditingController.ShowEdit;
  Finally
    FreeAndNil(lItemUOM);
  End;
end;

procedure TfrmPurchaseInvoice.colUOMPropertiesInitPopup(Sender: TObject);
var
  lItem: TItem;
  lItemUOM: TItemUOM;
begin
  inherited;
  if cxGrdMain.Controller.FocusedRecord = nil then exit;
  lItem := TItem.Create;
  Try
    lItem.LoadByID(VarToInt(cxGrdMain.Controller.FocusedRecord.Values[colItemID.Index]));
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

procedure TfrmPurchaseInvoice.cxGrdMainEditKeyDown(Sender:
    TcxCustomGridTableView; AItem: TcxCustomGridTableItem; AEdit:
    TcxCustomEdit; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (Key = VK_F5) and (aItem = colKode) then
  begin
    LookupItem(VarToStr(AEdit.EditingValue));
  end;
end;

procedure TfrmPurchaseInvoice.cxGrdMainStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  inherited;
  if ARecord = nil then exit;
  if VarToFloat(ARecord.Values[colPriceType.Index]) = 1
   then
    AStyle := stylBonus;
end;

function TfrmPurchaseInvoice.DC: TcxGridDBDataController;
begin
  Result := cxGrdMain.DataController;
end;

procedure TfrmPurchaseInvoice.edNotesKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
begin
  inherited;
  if Key = VK_RETURN then
  begin
    FocusToGrid;
  end;
end;

procedure TfrmPurchaseInvoice.edSupplierKeyDown(Sender: TObject; var Key: Word;
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
    LookupSupplier(sKey);
  end else if Key = VK_RETURN then
  begin
    SelectNext(Screen.ActiveControl, True, True);
  end;
end;

procedure TfrmPurchaseInvoice.edSupplierPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  inherited;
  LookupSupplier;
end;

procedure TfrmPurchaseInvoice.FocusToGrid;
begin
  cxGrid1.SetFocus;
  cxGrid1.FocusedView := cxGrdMain;
  if cxGrdMain.DataController.RecordCount = 0 then
  begin
    CDS.Append;
    cxGrdMain.Controller.EditingController.ShowEdit;
  end;
end;

procedure TfrmPurchaseInvoice.FormCreate(Sender: TObject);
begin
  inherited;
  InitView;
  Self.AssignKeyDownEvent;
  LoadByID(0, False);
end;

procedure TfrmPurchaseInvoice.FormKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
begin
  inherited;
  if Key = VK_F1 then
    edNoInv.SetFocus;

  if Key = VK_F2 then
  begin
    FocusToGrid;
  end;

  if Key = VK_F6 then
    SetBarangBonus;
end;

function TfrmPurchaseInvoice.GetCDS: TClientDataset;
begin
  if FCDS = nil then
  begin
    FCDS := TPurchaseInvoiceItem.CreateDataSet(Self, False);
    FCDS.AddField('Kode',ftString);
    FCDS.AddField('Nama',ftString);
    FCDS.AddField('SubTotal',ftFloat);
    FCDS.AddField('DiscP',ftFloat);

    FCDS.AddField('RecNo',ftString);

    FCDS.AfterInsert := CDSAfterInsert;
    FCDS.AfterDelete := CDSAfterDelete;
//    FCDS.AfterPost := CDSAfterPost;
//    FCDS.AddField('ItemObject',ftInteger);
    FCDS.CreateDataSet;
    DisableTrigger := False;
  end;
  Result := FCDS;
end;

function TfrmPurchaseInvoice.GetCDSClone: TClientDataset;
begin
  if FCDSClone = nil then
  begin
    FCDSClone := CDS.ClonedDataset(Self);
  end;
  Result := FCDSClone;
end;

function TfrmPurchaseInvoice.GetCDSUOM: TClientDataset;
begin
  if FCDSUOM = nil then
  begin
    FCDSUOM := TDBUtils.OpenDataset('select id, uom from tuom',Self);
  end;
  Result := FCDSUOM;
end;

function TfrmPurchaseInvoice.GetPurchInv: TPurchaseInvoice;
begin
  if FPurchInv = nil then
    FPurchInv := TPurchaseInvoice.Create;
  Result := FPurchInv;
end;

procedure TfrmPurchaseInvoice.InitView;
begin
  cxGrdMain.PrepareFromCDS(CDS);
  cxGrdOthers.PrepareFromCDS(CDSOthers);
//  TcxExtLookup(colWarehouse.Properties).LoadFromSQL(Self,
//    'select id, nama from twarehouse where is_external = 0','nama');
  TcxExtLookup(colUOM.Properties).LoadFromCDS(CDSUOM, 'id', 'uom', ['id'], Self);
//  cxLookupGudang.Properties.LoadFromSQL(Self,
//    'select id, nama from twarehouse where is_external = 0','nama');

  cxLookupRekening.Properties.LoadFromSQL(Self,
    'select id, nama from trekening','nama');


  TcxExtLookup(colOthAccCode.Properties).LoadFromCDS(CDSAccount, 'id', 'kode', ['id'], Self);
  TcxExtLookup(colOthAccName.Properties).LoadFromCDS(CDSAccount, 'id', 'nama', ['id'], Self);


  if PurchInv.Rekening = nil then
    PurchInv.Rekening := TRekening.Create;

  PurchInv.Rekening.LoadByCode(AppVariable.Def_Rekening);
  cxLookupRekening.EditValue := PurchInv.Rekening.ID;

  cxGrid1.FocusedView := cxGrdMain;
end;

procedure TfrmPurchaseInvoice.LoadByID(aID: Integer; IsReadOnly: Boolean =
    True);
var
  lInvItem: TPurchaseInvoiceItem;
  lItem: TFinancialTransaction;
begin
  if FPurchInv <> nil then
    FreeAndNil(FPurchInv);

  PurchInv.LoadByID(aID);


  if (aID <> 0) and (not IsReadOnly) then
  begin
    if not IsValidTransDate(PurchInv.TransDate) then
      IsReadOnly := True;

    if not PurchInv.ValidateUpdate then
    begin
      TAppUtils.Warning('Invoice Sudah ada Pembayaran, Tidak bisa edit/hapus data');
      IsReadOnly := True;
    end;

  end;

  //def uom
  if aID = 0 then
  begin
    PurchInv.TransDate := Now();
    PurchInv.DueDate  := Now();
    PurchInv.PaymentFlag := PaymentFlag_Credit;
    PurchInv.InvoiceNo := PurchInv.GenerateNo;
  end;
  cbBayar.ItemIndex := PurchInv.PaymentFlag;
  cbBayarPropertiesEditValueChanged(Self);

  edNoInv.Text := PurchInv.InvoiceNo;
  dtInvoice.Date := PurchInv.TransDate;
  dtJtTempo.Date := PurchInv.DueDate;
  spTempo.Value := PurchInv.DueDate - PurchInv.TransDate;

  crSubTotal.Value := PurchInv.SubTotal;
  crPPN.Value := PurchInv.PPN;
  crTotal.Value := PurchInv.Amount;
  edNotes.Text := PurchInv.Notes;
  edReferensi.Text := PurchInv.Referensi;

  if PurchInv.Supplier <> nil then
  begin
    PurchInv.Supplier.ReLoad(False);
    edSupplier.Text := PurchInv.Supplier.Nama;
  end;


  CDS.EmptyDataSet;
  for lInvItem in PurchInv.InvItems do
  begin
    CDS.Append;
    lInvItem.UpdateToDataset(CDS);
    lInvItem.Item.ReLoad(False);
    CDS.FieldByName('Kode').AsString := lInvItem.Item.Kode;
    CDS.FieldByName('Nama').AsString := lInvItem.Item.Nama;
    CDS.FieldByName('DiscP').AsFloat := 0;

    if lInvItem.Harga > 0 then
      CDS.FieldByName('DiscP').AsFloat := lInvItem.Discount / lInvItem.Harga * 100;


    CDS.Post;
  end;

  CDSOthers.EmptyDataSet;
  for lItem in PurchInv.Items do
  begin
    CDSOthers.Append;
    lItem.UpdateToDataset(CDSOthers);
    CDSOthers.Post;
  end;

  CalculateAll;
  btnSave.Enabled := not IsReadOnly;
end;

procedure TfrmPurchaseInvoice.LookupItem(aKey: string = '');
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
        +' C.HARGABELI'
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

procedure TfrmPurchaseInvoice.CDSAfterDelete(DataSet: TDataSet);
begin
  inherited;
  CalculateAll;
end;

procedure TfrmPurchaseInvoice.cxGrdMainColumn1GetDisplayText(Sender:
    TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
  inherited;
  if ARecord = nil then exit;
  AText := VarToStr(ARecord.RecordIndex + 1);
end;

procedure TfrmPurchaseInvoice.GenerateDummy;
var
  i: Integer;
  iCount: Integer;
  lItem: TItem;
begin
  LoadByID(0, False);
  cbBayar.ItemIndex := PaymentFlag_Credit;
  dtInvoice.Date := Now() - (Random(90));

  if PurchInv.Supplier = nil then
    PurchInv.Supplier := TSupplier.Create;
  while true do
  begin
    if PurchInv.Supplier.LoadByID(Random(126)) then
      break;
  end;        
  edSupplier.Text := PurchInv.Supplier.Nama;
  dtJtTempo.Date := dtInvoice.Date + Random(14);

  cxLookupRekening.SetDefaultValue();
  edNotes.Text := 'Dummy Data';

  iCount := 20; //Random(15)+3;
  lItem := TItem.Create;
  Try
    DC.RecordCount := 0;
    CDSDummy.First;
    for i := 0 to iCount do
    begin

      if not lItem.LoadByID(CDSDummy.FieldByName('ID').AsInteger) then continue;
      if lItem.ItemUOMs[0].HargaBeli = 0 then continue;


      if i>0 then DC.Append;

      SetItemToGrid(lItem);
      DC.SetEditValue(colQty.Index, 10*Random(9)+5 , evsValue);
      CalculateAll;
      DC.Post;

      CDSDummy.Next;
    end;
  Finally
    lItem.Free;
  End;

//  if not TAppUtils.Confirm('Is it Okay?') then exit;
//  if not ValidateData then exit;
//  UpdateData;
//  PurchInv.SaveRepeat();

end;

function TfrmPurchaseInvoice.GetCDSOthers: TClientDataset;
begin
  if FCDSOthers = nil then
  begin
    FCDSOthers := TFinancialTransaction.CreateDataSet(Self, False);
//    FCDSOthers.AfterInsert := CDSAfterInsert;
    FCDSOthers.AfterDelete := CDSAfterDelete;
//    FCDSOthers.AfterPost := CDSAfterPost;
//    FCDSOthers.AddField('ItemObject',ftInteger);
    FCDSOthers.CreateDataSet;
    DisableTrigger := False;
  end;
  Result := FCDSOthers;
end;

function TfrmPurchaseInvoice.GetCDSDummy: TClientDataset;
begin
  if FCDSDummy = nil then
  begin
    FCDSDummy := TDBUtils.OpenDataset('select * from titem where nama like ''oli%'' ',Self);
  end;
  Result := FCDSDummy;
end;

function TfrmPurchaseInvoice.GetCDSAccount: TClientDataset;
begin
  if FCDSAccount = nil then
  begin
    FCDSAccount := TDBUtils.OpenDataset('select id, kode, nama from taccount',Self);
  end;
  Result := FCDSAccount;
end;

function TfrmPurchaseInvoice.GetCDSCloneOth: TClientDataset;
begin
  if FCDSCloneOth = nil then
  begin
    FCDSCloneOth := CDSOthers.ClonedDataset(Self);
  end;
  Result := FCDSCloneOth;
end;

function TfrmPurchaseInvoice.GetGroupName: string;
begin
  Result := 'Inventory';
end;

procedure TfrmPurchaseInvoice.LoadReceive(aPRID: Integer);
var
  lItem: TTransDetail;
  lPR: TPurchaseReceive;
begin
  if CDS.Locate('PurchaseReceive', aPRID, [loCaseInsensitive]) then
  begin
    TAppUtils.Warning('BTB sudah ada di grid, silahkan dihapus terlebih dahulu');
    exit;
  end;


  lPR := TPurchaseReceive.Create;
  try
    lPR.LoadByID(aPRID);

    for lItem in lPR.Items do
    begin
      CDS.Append;

      CDS.FieldByName('PurchaseReceive').AsInteger := lPR.ID;
      CDS.FieldByName('RecNo').AsString   := lPR.RecNo;
      CDS.FieldByName('TransDetail_ID').AsInteger   := lItem.ID;

      if lItem.Item <> nil  then
      begin

        CDS.FieldByName('Item').AsInteger := lItem.Item.ID;
        lItem.Item.ReLoad();
        CDS.FieldByName('Kode').AsString  := lItem.Item.Kode;
        CDS.FieldByName('Nama').AsString  := lItem.Item.Nama;
        CDS.FieldByName('PPN').AsFloat    := lItem.Item.PPN;
      end;

      if lItem.UOM <> nil  then
      begin
        CDS.FieldByName('UOM').AsInteger  := lItem.UOM.ID;
      end;

      CDS.FieldByName('Qty').AsFloat      := lItem.Qty;
      CDS.FieldByName('Harga').AsFloat    := lItem.Harga;
      CDS.FieldByName('Discount').AsFloat := lItem.Discount;


      if lItem.Harga <> 0 then
        CDS.FieldByName('DiscP').AsFloat  := lItem.Discount / lItem.Harga * 100;

      CDS.Post;
    end;

    CalculateAll;

  finally
    lPR.Free;
  end;
end;

procedure TfrmPurchaseInvoice.LookupReceive;
var
  cxLookup: TfrmCXLookup;
  S: string;
begin
  if edSupplier.Text = '' then
  begin
    TAppUtils.Warning('Supplier belum dipilih');
    exit;
  end;

  S := 'select a.id, a.RECNO, a.REFERENSI, a.TRANSDATE, b.NAMA as SUPPLIER,'
      +' a.MODIFIEDDATE, a.MODIFIEDBY'
      +' from TPURCHASERECEIVE a'
      +' inner join TSUPPLIER b on a.SUPPLIER_ID = b.ID'
      +' where a.transdate between :d1 and :d2'
      +' AND A.SUPPLIER_ID = ' + IntToStr(PurchInv.Supplier.ID);

  cxLookup := TfrmCXLookup.ExecuteRange(S, StartOfTheYear(Now()-360), EndOfTheMonth(Now()), False ,
    'Lookup Data Purchase Receive'
  );

  Try
    cxLookup.HideFields(['ID']);
    if cxLookup.ShowModal = mrOK then
    begin
      LoadReceive(cxLookup.Data.FieldByName('ID').AsInteger);
    end;
  finally
    cxLookup.Free;
  end;

end;

procedure TfrmPurchaseInvoice.LookupSupplier(sKey: string = '');
var
  cxLookup: TfrmCXServerLookup;
  S: string;
begin
  S := 'select * from TSUPPLIER';
  cxLookup := TfrmCXServerLookup.Execute(S, 'ID');
  Try
    cxLookup.PreFilter('Nama', sKey);
    if cxLookup.ShowModal = mrOK then
    begin
      if PurchInv.Supplier = nil then
        PurchInv.Supplier := TSupplier.Create;
      PurchInv.Supplier.LoadByID(cxLookup.FieldValue('id'));
      edSupplier.Text := PurchInv.Supplier.Nama;
    end;
  Finally
    cxLookup.Free;
  End;
end;

procedure TfrmPurchaseInvoice.SetBarangBonus;
begin
  if not TAppUtils.Confirm('Anda yakin menjadikan Barang ini menjadi barang bonus?')  then exit;
  if CDS.State in [dsInsert, dsEdit] then CDS.Post;
  CDS.Edit;
  CDS.FieldByName('PriceType').AsInteger  := 1;
  CDS.FieldByName('DiscP').AsInteger      := 0;
  CDS.FieldByName('Harga').AsInteger      := 0;
  CDS.Post;
  CalculateAll;
end;

procedure TfrmPurchaseInvoice.SetItemToGrid(aItem: TItem);
var
  lItemUOM: TItemUOM;
begin
  if aItem = nil then exit;

  DC.SetEditValue(colItemID.Index, aItem.ID, evsValue);
//  DC.SetEditValue(colItemObject, Integer(aItem), evsValue);
  DC.SetEditValue(colKode.Index, aItem.Kode, evsValue);
  DC.SetEditValue(colNama.Index, aItem.Nama, evsValue);
  DC.SetEditValue(colUOM.Index, 0, evsValue);
  DC.SetEditValue(colQty.Index, 0, evsValue);
  DC.SetEditValue(colKonversi.Index, 0, evsValue);
  DC.SetEditValue(colHrgBeli.Index, 0, evsValue);
  DC.SetEditValue(colDisc.Index, 0, evsValue);
  DC.SetEditValue(colSubTotal.Index, 0, evsValue);
  DC.SetEditValue(colPPN.Index, aItem.PPN, evsValue);

  //def uom
  if aItem.StockUOM <> nil then
  begin
    DC.SetEditValue(colUOM.Index, aItem.StockUOM.ID, evsValue);
//    colUOMPropertiesEditValueChanged(nil);
    lItemUOM := TItemUOM.GetItemUOM(
      VarToInt(cxGrdMain.Controller.FocusedRecord.Values[colItemID.Index]),
      VarToInt(cxGrdMain.Controller.FocusedRecord.Values[colUOM.Index])
    );
    if lItemUOM = nil then exit;
    Try
      DC.SetEditValue(colKonversi.Index, lItemUOM.Konversi, evsValue);
      DC.SetEditValue(colHrgBeli.Index, lItemUOM.HargaBeli, evsValue);
    Finally
      FreeAndNil(lItemUOM);
    End;
  end;
end;

procedure TfrmPurchaseInvoice.SetSebagaiBarangBonus1Click(Sender: TObject);
begin
  SetBarangBonus;
end;

procedure TfrmPurchaseInvoice.spTempoPropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;
  dtJtTempo.Date := dtInvoice.Date + spTempo.Value;
end;

procedure TfrmPurchaseInvoice.UpdateData;
var
  lFinItem: TFinancialTransaction;
  lItem: TPurchaseInvoiceItem;
begin

  PurchInv.InvoiceNo := edNoInv.Text;
  PurchInv.TransDate := dtInvoice.Date;
  PurchInv.DueDate  := dtJtTempo.Date;
  PurchInv.Notes := edNotes.Text;
  PurchInv.PaymentFlag := cbBayar.ItemIndex;
  PurchInv.SubTotal := crSubTotal.Value;
  PurchInv.PPN := crPPN.Value;
  PurchInv.Amount := crTotal.Value;
  PurchInv.ModifiedDate := Now();
  PurchInv.ModifiedBy := UserLogin;
  PurchInv.Referensi  := edReferensi.Text;

  if PurchInv.Rekening = nil then
    PurchInv.Rekening := TRekening.Create;

  if PurchInv.PaymentFlag = PaymentFlag_Cash then
    PurchInv.Rekening.LoadByID(VarToInt(cxLookupRekening.EditValue))
  else
    PurchInv.Rekening.ID := 0;

  PurchInv.InvItems.Clear;
  CDS.First;
  while not CDS.Eof do
  begin
    lItem := TPurchaseInvoiceItem.Create;
    lItem.SetFromDataset(CDS);
    PurchInv.InvItems.Add(lItem);
    CDS.Next;
  end;


  PurchInv.Items.Clear;
  CDSOthers.First;
  while not CDSOthers.Eof do
  begin
    lFinItem := TFinancialTransaction.Create;
    lFinItem.SetFromDataset(CDSOthers);
    PurchInv.Items.Add(lFinItem);
    CDSOthers.Next;
  end;

end;

function TfrmPurchaseInvoice.ValidateData: Boolean;
begin
  Result := False;
  CalculateAll;

  if PurchInv.Supplier = nil then
  begin
    TAppUtils.Warning('Supplier belum dipilih');
    edSupplier.SetFocus;
    exit;
  end;

  if PurchInv.Supplier.ID = 0 then
  begin
    TAppUtils.Warning('Supplier belum dipilih');
    edSupplier.SetFocus;
    exit;
  end;

  if crTotal.Value <= 0 then
  begin
    TAppUtils.Warning('Total <= 0');
    exit;
  end;

  if (cbBayar.ItemIndex = 0) and (VarToInt(cxLookupRekening.EditValue) = 0) then
  begin
    TAppUtils.Warning('Untuk Pembayaran Cash, Rekening Kas wajib diisi');
    exit;
  end;

  CDSClone.Last;
  if (CDSClone.FieldByName('Item').AsInteger = 0)
    and (CDSCLone.FieldByName('UOM').AsInteger = 0)
    and (CDSClone.FieldByName('Qty').AsFloat = 0)
  then
  begin
    CDSClone.Delete;
  end;

//  if CDS.State in [dsInsert, dsEdit] then CDS.Post;

//  if CDS.RecordCount = 0 then
//  begin
//    TAppUtils.Warning('Data Item tidak boleh kosong' + #13 + 'Baris : ' +IntTostr(CDS.RecNo));
//    exit;
//  end;
  if cxGrdMain.DataController.RecordCount = 0 then
  begin
    TAppUtils.Warning('Data Item tidak boleh kosong');
    exit;
  end;

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

//  if CDS.Locate('Harga', 0, []) then
//  begin
//    TAppUtils.Warning('Harga tidak boleh 0' + #13 + 'Baris : ' +IntTostr(CDS.RecNo));
//    exit;
//  end;

//  if CDS.Locate('Warehouse', 0, []) or CDS.Locate('Warehouse', null, []) then
//  begin
//    TAppUtils.Warning('Warehouse tidak boleh kosong' + #13 + 'Baris : ' +IntTostr(CDS.RecNo));
//    exit;
//  end;

  if edReferensi.Text = '' then
  begin
    TAppUtils.Warning('Referensi tidak boleh kosong');
    exit;
  end;

  if not IsValidTransDate(dtInvoice.Date) then exit;

  Result := TAppUtils.Confirm('Anda yakin data sudah sesuai?');

end;

end.
