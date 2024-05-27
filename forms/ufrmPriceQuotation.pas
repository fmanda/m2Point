unit ufrmPriceQuotation;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ufrmDefaultInput, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  Vcl.Menus, Vcl.StdCtrls, Vcl.ExtCtrls, cxButtons, cxGroupBox, Vcl.ComCtrls,
  dxCore, cxDateUtils, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB,
  cxDBData, cxDBExtLookupComboBox, cxCurrencyEdit, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridBandedTableView,
  cxGridDBBandedTableView, cxClasses, cxGridCustomView, cxGrid, cxMaskEdit,
  cxDropDownEdit, cxCalendar, cxMemo, cxTextEdit, cxLabel, cxCheckBox,
  cxButtonEdit, uPriceQuotation, Datasnap.DBClient, cxGridDBDataDefinitions,
  uItem;

type
  TfrmPriceQuotation = class(TfrmDefaultInput)
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    edRefno: TcxTextEdit;
    cxLabel6: TcxLabel;
    edNotes: TcxMemo;
    dtQuot: TcxDateEdit;
    cxLabel8: TcxLabel;
    cxGrid1: TcxGrid;
    cxGrdMain: TcxGridDBBandedTableView;
    colSatuan: TcxGridDBBandedColumn;
    colKonversi: TcxGridDBBandedColumn;
    colHrgBeli: TcxGridDBBandedColumn;
    colMargin: TcxGridDBBandedColumn;
    colHrgJual: TcxGridDBBandedColumn;
    cxGrid1Level1: TcxGridLevel;
    colItemCode: TcxGridDBBandedColumn;
    colItemName: TcxGridDBBandedColumn;
    chkActive: TcxCheckBox;
    lbModifiedBy: TcxLabel;
    edModifiedBy: TcxTextEdit;
    lbModified: TcxLabel;
    dtModified: TcxDateEdit;
    Label1: TLabel;
    Label2: TLabel;
    colItemID: TcxGridDBBandedColumn;
    cxMemo1: TcxMemo;
    styleGreen: TcxStyle;
    pmGrid: TPopupMenu;
    F6LookupDataBarangterakhirdiinputedit1: TMenuItem;
    procedure cxGrdMainEditKeyDown(Sender: TcxCustomGridTableView; AItem:
        TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word; Shift:
        TShiftState);
    procedure edNotesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure colItemCodePropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure colItemCodePropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure colHrgBeliPropertiesEditValueChanged(Sender: TObject);
    procedure colMargin1PropertiesEditValueChanged(Sender: TObject);
    procedure colHrgJual1PropertiesEditValueChanged(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure F6LookupDataBarangterakhirdiinputedit1Click(Sender: TObject);
  private
    FCDS: TClientDataset;
    FCDSClone: TClientDataset;
    FCDSUOM: TClientDataset;
    FPriceQuot: TPriceQuotation;
    procedure CalcSellPrice(IsMargin: Boolean);
    function DC: TcxGridDBDataController;
    procedure FocusToGrid;
    function GetCDS: TClientDataset;
    function GetCDSClone: TClientDataset;
    function GetCDSUOM: TClientDataset;
    function GetPriceQuot: TPriceQuotation;
    procedure InitView;
    procedure LookupItem(aKey: string = '');
    procedure LookupRecent;
    procedure SetItemToGrid(aItem: TItem);
    procedure UpdateData;
    procedure UpdateItemName;
    function ValidateData: Boolean;
    property CDS: TClientDataset read GetCDS write FCDS;
    property CDSClone: TClientDataset read GetCDSClone write FCDSClone;
    property CDSUOM: TClientDataset read GetCDSUOM write FCDSUOM;
    property PriceQuot: TPriceQuotation read GetPriceQuot write FPriceQuot;
    { Private declarations }
  protected
  public
    function GetGroupName: string; override;
    procedure LoadByID(aID: Integer; IsReadOnly: Boolean = False);
    { Public declarations }
  published
  end;

var
  frmPriceQuotation: TfrmPriceQuotation;

implementation

uses
  uDXUtils, Dateutils, uDBUtils, ufrmCXServerLookup, cxDataUtils, uAppUtils,
  Strutils, ufrmCXLookup;

{$R *.dfm}

procedure TfrmPriceQuotation.btnSaveClick(Sender: TObject);
begin
  inherited;
  if not ValidateData then exit;
  UpdateData;
  if PriceQuot.SaveToDB then
  begin
    UpdateItemName;
    TAppUtils.InformationBerhasilSimpan;
    Self.ModalResult := mrOK;
  end;
end;

procedure TfrmPriceQuotation.CalcSellPrice(IsMargin: Boolean);
var
  iRec: TcxCustomGridRecord;
  lHargaBeli: Double;
begin
  cxGrdMain.DataController.Post();
  iRec      := cxGrdMain.Controller.FocusedRecord;
  if iRec = nil then exit;

  lHargaBeli := iRec.Values[colHrgBeli.Index];

  if IsMargin then
  begin
    cxGrdMain.DataController.SetEditValue(colHrgJual.Index,
          lHargaBeli * (1 + (iRec.Values[colMargin.Index] /100)),  evsValue);
  end else
  begin
    if lHargaBeli = 0 then exit;

    cxGrdMain.DataController.SetEditValue(colMargin.Index,
          (iRec.Values[colHrgJual.Index] - lHargaBeli) / lHargaBeli * 100,  evsValue);

  end;

end;

procedure TfrmPriceQuotation.colHrgBeliPropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;
  CalcSellPrice(False);
end;

procedure TfrmPriceQuotation.colHrgJual1PropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;
  CalcSellPrice(False);
end;

procedure TfrmPriceQuotation.colItemCodePropertiesButtonClick(Sender: TObject;
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

procedure TfrmPriceQuotation.colItemCodePropertiesValidate(Sender: TObject;
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

procedure TfrmPriceQuotation.colMargin1PropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;
  CalcSellPrice( True);
end;

procedure TfrmPriceQuotation.cxGrdMainEditKeyDown(Sender:
    TcxCustomGridTableView; AItem: TcxCustomGridTableItem; AEdit:
    TcxCustomEdit; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (Key = VK_F5) and (aItem = colItemCode) then
  begin
    LookupItem(VarToStr(AEdit.EditingValue));
  end;
  if (Key = VK_F6) and (aItem = colItemCode) then
  begin
    LookupRecent;
  end;
end;

function TfrmPriceQuotation.DC: TcxGridDBDataController;
begin
  Result := cxGrdMain.DataController;
end;

procedure TfrmPriceQuotation.edNotesKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
begin
  inherited;
  if Key = VK_Return then
    FocusToGrid;
end;

procedure TfrmPriceQuotation.F6LookupDataBarangterakhirdiinputedit1Click(
    Sender: TObject);
begin
  inherited;
  LookupRecent;
end;

procedure TfrmPriceQuotation.FocusToGrid;
begin
  cxGrid1.SetFocus;
  cxGrid1.FocusedView := cxGrdMain;
  if cxGrdMain.DataController.RecordCount = 0 then
  begin
    CDS.Append;
    cxGrdMain.Controller.EditingController.ShowEdit;
  end;
end;

procedure TfrmPriceQuotation.FormCreate(Sender: TObject);
begin
  inherited;
  cxGrdMain.OptionsView.Header := False;
  Self.AssignKeyDownEvent;
  InitView;
  LoadByID(0);
end;

procedure TfrmPriceQuotation.FormKeyDown(Sender: TObject; var Key: Word; Shift:
    TShiftState);
begin
  inherited;
  if Key = VK_F2 then
    FocusToGrid
  else if Key = VK_F1 then
    edNotes.SetFocus;

end;

function TfrmPriceQuotation.GetCDS: TClientDataset;
begin
  if FCDS = nil then
  begin
    FCDS := TPriceQuotationItem.CreateDataSet(Self, False);
    FCDS.AddField('ItemCode', ftString);
    FCDS.AddField('ItemName', ftString);
//    FCDS.AddField('Konversi', ftFloat);
    FCDS.AddField('Margin',ftFloat);
    FCDS.CreateDataSet;
  end;
  Result := FCDS;
end;

function TfrmPriceQuotation.GetCDSClone: TClientDataset;
begin
  if FCDSClone = nil then
  begin
    FCDSClone := CDS.ClonedDataset(Self);
  end;
  Result := FCDSClone;
end;

function TfrmPriceQuotation.GetCDSUOM: TClientDataset;
begin
  if FCDSUOM = nil then
    FCDSUOM := TDBUtils.OpenDataset(
        'select id, uom from tuom', Self
      );
  Result := FCDSUOM;
end;

function TfrmPriceQuotation.GetGroupName: string;
begin
  Result := 'Master Data';
end;

function TfrmPriceQuotation.GetPriceQuot: TPriceQuotation;
begin
  if FPriceQuot = nil then
    FPriceQuot := TPriceQuotation.Create;
  Result := FPriceQuot;
end;

procedure TfrmPriceQuotation.InitView;
begin
  cxGrdMain.PrepareFromCDS(CDS);
  TcxExtLookup(colSatuan.Properties).LoadFromCDS(CDSUOM, 'id','uom', Self);
end;

procedure TfrmPriceQuotation.LoadByID(aID: Integer; IsReadOnly: Boolean =
    False);
var
  lItem: TPriceQuotationItem;
begin
  if FPriceQuot <> nil then
    FreeAndNil(FPriceQuot);

  if aID = 0 then
  begin
    PriceQuot.TransDate := Now();
    PriceQuot.Refno := PriceQuot.GenerateNo;
    PriceQuot.IsActive := 1;
  end else
    PriceQuot.LoadByID(aID);

  edRefno.Text := PriceQuot.Refno;
  dtQuot.Date := PriceQuot.TransDate;
  edNotes.Text := PriceQuot.Notes;
  dtModified.Date := PriceQuot.ModifiedDate;
  edModifiedBy.Text := PriceQuot.ModifiedBy;
  chkActive.Checked := PriceQuot.IsActive = 1;

  CDS.EmptyDataSet;
  for lItem in PriceQuot.Items do
  begin
    CDS.Append;
    lItem.UpdateToDataset(CDS);

    lItem.Item.ReLoad();
    CDS.FieldByName('ItemCode').AsString := lItem.Item.Kode;
    CDS.FieldByName('ItemName').AsString := lItem.Item.Nama;

    if lItem.HargaBeli = 0 then
    begin
      CDS.FieldByName('Margin').AsFloat := 0;
    end else
    begin
      CDS.FieldByName('Margin').AsFloat := (lItem.HargaJual - lItem.HargaBeli) / lItem.HargaBeli * 100;
    end;

    CDS.Post;
  end;

end;

procedure TfrmPriceQuotation.LookupItem(aKey: string = '');
var
  cxLookup: TfrmCXServerLookup;
  lItem: TItem;
  s: string;







begin
  lItem  := TItem.Create;
  Try
    s := 'SELECT A.ID, A.KODE, A.NAMA, C.NAMA AS MERK, B.NAMA AS ITEMGROUP'
        +' FROM TITEM A'
        +' LEFT JOIN TITEMGROUP B ON A.GROUP_ID = B.ID'
        +' LEFT JOIN TMERK C ON A.MERK_ID = C.ID';

    cxLookup := TfrmCXServerLookup.Execute(S,'ID');
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

procedure TfrmPriceQuotation.LookupRecent;
var
  cxLookup: TfrmCXLookup;
  lItem: TItem;
  s: string;
begin
  lItem  := TItem.Create;
  Try
    s := 'select a.ID, a.KODE, a.NAMA, e.NAMA as MERK,'
        +' c.UOM as STOCKUOM, b.HARGAJUAL, '
        +' A.MODIFIEDBY, A.MODIFIEDDATE'
        +' from titem a'
        +' inner join TITEMUOM b on a.id = b.ITEM_ID and a.STOCKUOM_ID = b.UOM_ID'
        +' inner join TUOM c on a.STOCKUOM_ID = c.id'
        +' left join TITEMGROUP d on a.GROUP_ID = d.id'
        +' left join TMERK e on a.MERK_ID = e.id'
        +' WHERE cast(A.MODIFIEDDATE as DATE) BETWEEN :STARTDATE AND :ENDDATE'
        +' ORDER BY A.MODIFIEDDATE DESC';

    cxLookup := TfrmCXLookup.ExecuteRange(S, Now(), Now(), True);
    cxLookup.HideFields(['ID']);
    try
      cxLookup.lblFilterData.Caption := 'Filter Modified Date : ';
      cxLookup.Width := 1000;
      if cxLookup.ShowModal = mrOK then
      begin
        while not cxLookup.Data.Eof do
        begin
//          if lItem.ID > 0 then
          CDS.Append;
          lItem.LoadByID(cxLookup.Data.FieldByName('ID').AsInteger);
          SetItemToGrid(lItem);
          cxLookup.Data.Next;
        end;
      end;
    finally
      cxLookup.Free;
    end;
  Finally
    FreeAndNil(lItem);
  End;
end;

procedure TfrmPriceQuotation.SetItemToGrid(aItem: TItem);
var
  i: Integer;
  IsAppendRec: Boolean;
  lItemUOM: TItemUOM;
begin
  if aItem = nil then exit;

  //locate
  CDSClone.Filtered := True;
  Try
    CDSClone.Filter := 'Item = ' + IntToStr(aItem.ID);
    CDSClone.First;
    while not CDSClone.Eof do
    begin
      CDSClone.Delete;
    end;
  Finally
    CDSClone.Filtered := False;
  End;

  //1set uom
  if aItem.ItemUOMs.Count = 0 then exit;

  IsAppendRec := False;

  for i := 0 to aItem.ItemUOMs.Count-1 do
  begin
    lItemUOM := aItem.ItemUOMs[i];

    if IsAppendRec then
    begin
      if CDS.State in [dsInsert, dsEdit] then CDS.Post;
      CDS.Append;
      cxGrdMain.Controller.EditingController.ShowEdit;
    end;
//      DC.FocusedRecordIndex := DC.AppendRecord;

    DC.SetEditValue(colItemID.Index, aItem.ID, evsValue);
    DC.SetEditValue(colItemCode.Index, aItem.Kode, evsValue);
    DC.SetEditValue(colItemName.Index, aItem.Nama, evsValue);
    DC.SetEditValue(colSatuan.Index, lItemUOM.UOM.ID, evsValue);
    DC.SetEditValue(colKonversi.Index, lItemUOM.Konversi, evsValue);

    DC.SetEditValue(colHrgBeli.Index, lItemUOM.HargaBeli, evsValue);
    DC.SetEditValue(colHrgJual.Index, lItemUOM.HargaJual, evsValue);

    DC.SetEditValue(colMargin.Index, lItemUOM.GetMargin, evsValue);
    DC.Post();

    IsAppendRec := True;
  end;

  DC.FocusedRecordIndex := DC.RecordCount-1;
  cxGrdMain.Controller.FocusedItem := colHrgBeli;
  cxGrdMain.Controller.EditingController.ShowEdit;
//  colHrgBeli.Focus
//  if iOriginRec <= DC.RecordCount then
//    DC.FocusedRecordIndex := iOriginRec;

end;

procedure TfrmPriceQuotation.UpdateData;
var
  lItem: TPriceQuotationItem;
begin
  PriceQuot.Refno := edRefno.Text;
  PriceQuot.TransDate := dtQuot.Date;
  PriceQuot.Notes := edNotes.Text;
  PriceQuot.ModifiedDate := Now();
  PriceQuot.ModifiedBy := UserLogin;
  PriceQuot.IsActive := TAppUtils.BoolToInt(chkActive.Checked);

  PriceQuot.Items.Clear;
  CDS.First;
  while not CDS.Eof do
  begin
    lItem := TPriceQuotationItem.Create;
    lItem.SetFromDataset(CDS);
    PriceQuot.Items.Add(lItem);
    CDS.Next;
  end;

end;

procedure TfrmPriceQuotation.UpdateItemName;
var
  SS: TStrings;
begin
  SS := TStringList.Create;
  Try
    CDS.First;
    while not CDS.Eof do
    begin
      SS.Add('Update TItem Set Nama = ' + QuotedStr(CDS.FieldByName('ItemName').AsString)
        + ' where ID = ' + IntToSTr(CDS.FieldByName('Item').AsInteger) + ';'
      );
      CDS.Next;
    end;
    TDBUtils.ExecuteSQL(SS);
  Finally
    SS.Free;
  End;
end;

function TfrmPriceQuotation.ValidateData: Boolean;
var
  bWarningHJ: Boolean;
begin
  Result := False;

//  if CDS.RecordCount = 0 then
//  begin
//    TAppUtils.Warning('Data Item tidak boleh kosong');
//    exit;
//  end;
  if cxGrdMain.DataController.RecordCount = 0 then
  begin
    TAppUtils.Warning('Data Item tidak boleh kosong');
    exit;
  end;

  //warning
  bWarningHJ := False;
  CDS.First;
  while not CDS.Eof do
  begin
    if (CDS.FieldByName('HargaJual').AsFloat < CDS.FieldByName('HargaBeli').AsFloat)
    then
    begin
      bWarningHJ := True;
      break;
    end;
    CDS.Next;
  end;

  if bWarningHJ then
  begin
    if not TAppUtils.Confirm('Ada harga jual yang < harga beli, Apakah anda yakin lanjut simpan? ') then
      exit;
  end;


  Result := TAppUtils.Confirm('Anda yakin data sudah sesuai?');

end;

end.
