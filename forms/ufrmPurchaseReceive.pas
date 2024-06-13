unit ufrmPurchaseReceive;

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
  cxGridDBDataDefinitions, cxSpinEdit;

type
  TfrmPurchaseReceive = class(TfrmDefaultInput)
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    edRecNo: TcxTextEdit;
    cxLabel4: TcxLabel;
    cxLabel6: TcxLabel;
    edNotes: TcxMemo;
    dtReceive: TcxDateEdit;
    cxLabel8: TcxLabel;
    edSupplier: TcxButtonEdit;
    cxGrdMain: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    colKode: TcxGridDBColumn;
    colNama: TcxGridDBColumn;
    colUOM: TcxGridDBColumn;
    colQty: TcxGridDBColumn;
    cxLabel7: TcxLabel;
    cxLookupGudang: TcxExtLookupComboBox;
    colWarehouse: TcxGridDBColumn;
    Label2: TLabel;
    colItemID: TcxGridDBColumn;
    colKonversi: TcxGridDBColumn;
    Label1: TLabel;
    btnGenerate: TcxButton;
    cxLabel11: TcxLabel;
    edReferensi: TcxTextEdit;
    cxLabel12: TcxLabel;
    cxGrdMainColumn1: TcxGridDBColumn;
    pmMain: TPopupMenu;
    SetSebagaiBarangBonus1: TMenuItem;
    stylBonus: TcxStyle;
    Label3: TLabel;
    colHrgBeli: TcxGridDBColumn;
    colPriceType: TcxGridDBColumn;
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
    procedure btnGenerateClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure cxGrdMainColumn1GetDisplayText(Sender: TcxCustomGridTableItem;
        ARecord: TcxCustomGridRecord; var AText: string);
    procedure SetSebagaiBarangBonus1Click(Sender: TObject);
    procedure cxGrdMainStylesGetContentStyle(Sender: TcxCustomGridTableView;
      ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem;
      var AStyle: TcxStyle);
  private
    DisableTrigger: Boolean;
    FCDS: TClientDataset;
    FCDSClone: TClientDataset;
    FCDSUOM: TClientDataset;
    FCDSDummy: TClientDataset;
    FPurcRec: TPurchaseReceive;
    procedure CalculateAll;
    procedure CDSAfterDelete(DataSet: TDataSet);
    procedure CDSAfterInsert(DataSet: TDataSet);
    function DC: TcxGridDBDataController;
    procedure FocusToGrid;
    procedure GenerateDummy;
    function GetCDS: TClientDataset;
    function GetCDSClone: TClientDataset;
    function GetCDSUOM: TClientDataset;
    function GetCDSDummy: TClientDataset;
    function GetPurcRec: TPurchaseReceive;
    procedure InitView;
    procedure LookupItem(aKey: string = '');
    procedure LookupSupplier(sKey: string = '');
    procedure SetBarangBonus;
    procedure SetItemToGrid(aItem: TItem);
    procedure UpdateData;
    function ValidateData: Boolean;
    property CDS: TClientDataset read GetCDS write FCDS;
    property CDSClone: TClientDataset read GetCDSClone write FCDSClone;
    property CDSUOM: TClientDataset read GetCDSUOM write FCDSUOM;
    property CDSDummy: TClientDataset read GetCDSDummy write FCDSDummy;
    property PurcRec: TPurchaseReceive read GetPurcRec write FPurcRec;
    { Private declarations }
  protected
    procedure CDSAfterPost(DataSet: TDataSet);
  public
    function GetGroupName: string; override;
    procedure LoadByID(aID: Integer; IsReadOnly: Boolean = True);
    { Public declarations }
  end;

var
  frmPurchaseReceive: TfrmPurchaseReceive;

implementation

uses
  uAppUtils, uDXUtils, ufrmCXServerLookup, cxDataUtils, uSupplier, uWarehouse,
  uFinancialTransaction, uAccount, uVariable, ufrmLookupItem;

{$R *.dfm}

procedure TfrmPurchaseReceive.btnGenerateClick(Sender: TObject);
begin
  inherited;
  GenerateDummy;
end;

procedure TfrmPurchaseReceive.btnPrintClick(Sender: TObject);
begin
  inherited;
  TPurchaseReceive.PrintData(PurcRec.ID);
end;

procedure TfrmPurchaseReceive.btnSaveClick(Sender: TObject);
begin
  inherited;
  if not ValidateData then exit;
  UpdateData;
  if PurcRec.SaveRepeat(False) then
  begin
    btnPrint.Click;
//    TAppUtils.InformationBerhasilSimpan;
    Self.ModalResult := mrOK;
  end;
end;

procedure TfrmPurchaseReceive.CalculateAll;
begin
  if CDS.State in [dsInsert, dsEdit] then
    CDS.Post;
end;

procedure TfrmPurchaseReceive.CDSAfterInsert(DataSet: TDataSet);
begin
  inherited;
  DataSet.FieldByName('Warehouse').AsInteger := VarToInt(cxLookupGudang.EditValue);
end;

procedure TfrmPurchaseReceive.CDSAfterPost(DataSet: TDataSet);
begin
  inherited;
  if DisableTrigger then exit;
  CalculateAll;
end;

procedure TfrmPurchaseReceive.colDiscPropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;
  CalculateAll;
end;

procedure TfrmPurchaseReceive.colKodePropertiesButtonClick(Sender: TObject;
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

procedure TfrmPurchaseReceive.colKodePropertiesValidate(Sender: TObject;
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

procedure TfrmPurchaseReceive.colQtyPropertiesEditValueChanged(Sender: TObject);
begin
  inherited;
  CalculateAll;
end;

procedure TfrmPurchaseReceive.colUOMPropertiesCloseUp(Sender: TObject);
begin
  inherited;
  with TcxExtLookup(colUOM.Properties).DataController.filter do
  begin
    BeginUpdate;
    Root.Clear;
    EndUpdate;
  end;
end;

procedure TfrmPurchaseReceive.colUOMPropertiesEditValueChanged(Sender: TObject);
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

procedure TfrmPurchaseReceive.colUOMPropertiesInitPopup(Sender: TObject);
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

procedure TfrmPurchaseReceive.cxGrdMainEditKeyDown(Sender:
    TcxCustomGridTableView; AItem: TcxCustomGridTableItem; AEdit:
    TcxCustomEdit; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (Key = VK_F5) and (aItem = colKode) then
  begin
    LookupItem(VarToStr(AEdit.EditingValue));
  end;
end;

procedure TfrmPurchaseReceive.cxGrdMainStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  inherited;
  if ARecord = nil then exit;
  if VarToFloat(ARecord.Values[colPriceType.Index]) = 1
   then
    AStyle := stylBonus;
end;

function TfrmPurchaseReceive.DC: TcxGridDBDataController;
begin
  Result := cxGrdMain.DataController;
end;

procedure TfrmPurchaseReceive.edNotesKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
begin
  inherited;
  if Key = VK_RETURN then
  begin
    FocusToGrid;
  end;
end;

procedure TfrmPurchaseReceive.edSupplierKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmPurchaseReceive.edSupplierPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  inherited;
  LookupSupplier;
end;

procedure TfrmPurchaseReceive.FocusToGrid;
begin
  cxGrid1.SetFocus;
  cxGrid1.FocusedView := cxGrdMain;
  if cxGrdMain.DataController.RecordCount = 0 then
  begin
    CDS.Append;
    cxGrdMain.Controller.EditingController.ShowEdit;
  end;
end;

procedure TfrmPurchaseReceive.FormCreate(Sender: TObject);
begin
  inherited;
  InitView;
  Self.AssignKeyDownEvent;
  LoadByID(0, False);
end;

procedure TfrmPurchaseReceive.FormKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
begin
  inherited;
  if Key = VK_F1 then
    edRecno.SetFocus;

  if Key = VK_F2 then
  begin
    FocusToGrid;
  end;

  if Key = VK_F6 then
    SetBarangBonus;
end;

function TfrmPurchaseReceive.GetCDS: TClientDataset;
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

function TfrmPurchaseReceive.GetCDSClone: TClientDataset;
begin
  if FCDSClone = nil then
  begin
    FCDSClone := CDS.ClonedDataset(Self);
  end;
  Result := FCDSClone;
end;

function TfrmPurchaseReceive.GetCDSUOM: TClientDataset;
begin
  if FCDSUOM = nil then
  begin
    FCDSUOM := TDBUtils.OpenDataset('select id, uom from tuom',Self);
  end;
  Result := FCDSUOM;
end;

function TfrmPurchaseReceive.GetPurcRec: TPurchaseReceive;
begin
  if FPurcRec = nil then
    FPurcRec := TPurchaseReceive.Create;
  Result := FPurcRec;
end;

procedure TfrmPurchaseReceive.InitView;
begin
  cxGrdMain.PrepareFromCDS(CDS);
  TcxExtLookup(colWarehouse.Properties).LoadFromSQL(Self,
    'select id, nama from twarehouse where is_external = 0','nama');
  TcxExtLookup(colUOM.Properties).LoadFromCDS(CDSUOM, 'id', 'uom', ['id'], Self);
  cxLookupGudang.Properties.LoadFromSQL(Self,
    'select id, nama from twarehouse where is_external = 0','nama');


  cxLookupGudang.SetDefaultValue();

end;

procedure TfrmPurchaseReceive.LoadByID(aID: Integer; IsReadOnly: Boolean =
    True);
var
  lItem: TTransDetail;
begin
  if FPurcRec <> nil then
    FreeAndNil(FPurcRec);

  PurcRec.LoadByID(aID);


  if (aID <> 0) and (not IsReadOnly) then
  begin
    if not IsValidTransDate(PurcRec.TransDate) then
      IsReadOnly := True;

    if not PurcRec.ValidateUpdate then
    begin
      TAppUtils.Warning('BTB ini sudah dibuatkan invoice, tidak bisa dilakukan edit/hapus. Silahkan hapus BTB dari invoice terlebih dahulu');
      IsReadOnly := True;
    end;

  end;

  //def uom
  if aID = 0 then
  begin
    PurcRec.TransDate := Now();
    PurcRec.Recno := PurcRec.GenerateNo;
  end;

  edRecNo.Text := PurcRec.RecNo;
  dtReceive.Date := PurcRec.TransDate;
  edNotes.Text := PurcRec.Notes;
  edReferensi.Text := PurcRec.Referensi;

  if PurcRec.Supplier <> nil then
  begin
    PurcRec.Supplier.ReLoad(False);
    edSupplier.Text := PurcRec.Supplier.Nama;
  end;

  if PurcRec.Warehouse <> nil then
    cxLookupGudang.EditValue := PurcRec.Warehouse.ID;

  CDS.EmptyDataSet;
  for lItem in PurcRec.Items do
  begin
    CDS.Append;
    lItem.UpdateToDataset(CDS);
    lItem.Item.ReLoad(False);
    CDS.FieldByName('Kode').AsString := lItem.Item.Kode;
    CDS.FieldByName('Nama').AsString := lItem.Item.Nama;


    CDS.Post;
  end;
  CalculateAll;
  btnSave.Enabled := not IsReadOnly;
end;

procedure TfrmPurchaseReceive.LookupItem(aKey: string = '');
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

procedure TfrmPurchaseReceive.CDSAfterDelete(DataSet: TDataSet);
begin
  inherited;
  CalculateAll;
end;

procedure TfrmPurchaseReceive.cxGrdMainColumn1GetDisplayText(Sender:
    TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
  inherited;
  if ARecord = nil then exit;
  AText := VarToStr(ARecord.RecordIndex + 1);
end;

procedure TfrmPurchaseReceive.GenerateDummy;
var
  i: Integer;
  iCount: Integer;
  lItem: TItem;
begin
  LoadByID(0, False);
  dtReceive.Date := Now() - (Random(90));

  if PurcRec.Supplier = nil then
    PurcRec.Supplier := TSupplier.Create;
  while true do
  begin
    if PurcRec.Supplier.LoadByID(Random(126)) then
      break;
  end;
  edSupplier.Text := PurcRec.Supplier.Nama;
  cxLookupGudang.SetDefaultValue();
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
//  PurcRec.SaveRepeat();

end;

function TfrmPurchaseReceive.GetCDSDummy: TClientDataset;
begin
  if FCDSDummy = nil then
  begin
    FCDSDummy := TDBUtils.OpenDataset('select * from titem where nama like ''oli%'' ',Self);
  end;
  Result := FCDSDummy;
end;

function TfrmPurchaseReceive.GetGroupName: string;
begin
  Result := 'Inventory';
end;

procedure TfrmPurchaseReceive.LookupSupplier(sKey: string = '');
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
      if PurcRec.Supplier = nil then
        PurcRec.Supplier := TSupplier.Create;
      PurcRec.Supplier.LoadByID(cxLookup.FieldValue('id'));
      edSupplier.Text := PurcRec.Supplier.Nama;
    end;
  Finally
    cxLookup.Free;
  End;
end;

procedure TfrmPurchaseReceive.SetBarangBonus;
begin
  if not TAppUtils.Confirm('Anda yakin menjadikan Barang ini menjadi barang bonus?')  then exit;
  if CDS.State in [dsInsert, dsEdit] then CDS.Post;
  CDS.Edit;
  CDS.FieldByName('PriceType').AsInteger  := 1;
  CDS.FieldByName('Harga').AsInteger      := 0;
  CDS.Post;
  CalculateAll;
end;

procedure TfrmPurchaseReceive.SetItemToGrid(aItem: TItem);
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

procedure TfrmPurchaseReceive.SetSebagaiBarangBonus1Click(Sender: TObject);
begin
  SetBarangBonus;
end;

procedure TfrmPurchaseReceive.UpdateData;
var
  lItem: TTransDetail;
begin

  PurcRec.Recno := edRecno.Text;
  PurcRec.TransDate := dtReceive.Date;
  PurcRec.Notes := edNotes.Text;
  PurcRec.ModifiedDate := Now();
  PurcRec.ModifiedBy := UserLogin;
  PurcRec.Referensi  := edReferensi.Text;

  if PurcRec.Warehouse = nil then
    PurcRec.Warehouse := TWarehouse.Create;

  PurcRec.Warehouse.LoadByID(VarToInt(cxLookupGudang.EditValue));

 
  PurcRec.Items.Clear;

  CDS.First;
  while not CDS.Eof do
  begin
    lItem := TTransDetail.Create;
    lItem.SetFromDataset(CDS);
    PurcRec.Items.Add(lItem);
    CDS.Next;
  end;

end;

function TfrmPurchaseReceive.ValidateData: Boolean;
begin
  Result := False;
  CalculateAll;

  if PurcRec.Supplier = nil then
  begin
    TAppUtils.Warning('Supplier belum dipilih');
    edSupplier.SetFocus;
    exit;
  end;

  if PurcRec.Supplier.ID = 0 then
  begin
    TAppUtils.Warning('Supplier belum dipilih');
    edSupplier.SetFocus;
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

  if CDS.Locate('Warehouse', 0, []) or CDS.Locate('Warehouse', null, []) then
  begin
    TAppUtils.Warning('Warehouse tidak boleh kosong' + #13 + 'Baris : ' +IntTostr(CDS.RecNo));
    exit;
  end;

  if edReferensi.Text = '' then
  begin
    TAppUtils.Warning('Referensi tidak boleh kosong');
    exit;
  end;

  if not IsValidTransDate(dtReceive.Date) then exit;

  Result := TAppUtils.Confirm('Anda yakin data sudah sesuai?');

end;

end.
