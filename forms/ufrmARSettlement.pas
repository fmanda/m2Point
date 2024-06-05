unit ufrmARSettlement;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ufrmDefaultInput, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  Vcl.Menus, Vcl.StdCtrls, Vcl.ExtCtrls, cxButtons, cxGroupBox, Vcl.ComCtrls,
  dxCore, cxDateUtils, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB,
  cxDBData, cxButtonEdit, cxCalendar, cxCurrencyEdit, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGrid, cxLookupEdit, cxDBLookupEdit, cxDBExtLookupComboBox,
  cxDropDownEdit, cxMaskEdit, cxMemo, cxTextEdit, cxLabel,
  uFinancialTransaction, Datasnap.DBClient, uTransDetail,
  cxGridDBDataDefinitions, uItem, cxDataUtils, uAppUtils, cxSpinEdit,
  cxCheckBox, uCustomer;
type
  TfrmARSettlement = class(TfrmDefaultInput)
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    edRefno: TcxTextEdit;
    cxLabel4: TcxLabel;
    cxLabel6: TcxLabel;
    edNotes: TcxMemo;
    dtTransDate: TcxDateEdit;
    cxLabel8: TcxLabel;
    crOthers: TcxCurrencyEdit;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    crBayar: TcxCurrencyEdit;
    lbNoMedia: TcxLabel;
    cxGrid1: TcxGrid;
    cxGrdMain: TcxGridDBTableView;
    colInvoiceNo: TcxGridDBColumn;
    colInvoiceDate: TcxGridDBColumn;
    colInvoiceAmt: TcxGridDBColumn;
    colInvoiceRemain: TcxGridDBColumn;
    colPaidAmt: TcxGridDBColumn;
    colReturNo: TcxGridDBColumn;
    colReturRemain: TcxGridDBColumn;
    colReturAmt: TcxGridDBColumn;
    colInvoiceID: TcxGridDBColumn;
    colReturID: TcxGridDBColumn;
    cxGrdCost: TcxGridDBTableView;
    colCostAccount: TcxGridDBColumn;
    colCostNotes: TcxGridDBColumn;
    colCostAmount: TcxGridDBColumn;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1Level2: TcxGridLevel;
    Label1: TLabel;
    Label2: TLabel;
    cxLookupCustomer: TcxExtLookupComboBox;
    colCustomer: TcxGridDBColumn;
    colCustomerID: TcxGridDBColumn;
    edCashReceipt: TcxButtonEdit;
    cxLabel7: TcxLabel;
    crRemain: TcxCurrencyEdit;
    crTotal: TcxCurrencyEdit;
    cxLabel5: TcxLabel;
    dtCashReceipt: TcxDateEdit;
    cxLabel9: TcxLabel;
    ckFilterSalesman: TcxCheckBox;
    crRetur: TcxCurrencyEdit;
    procedure btnSaveClick(Sender: TObject);
    procedure cxGrdMainEditKeyDown(Sender: TcxCustomGridTableView; AItem:
        TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word; Shift:
        TShiftState);
    procedure dtDueDateKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure colCostAmountPropertiesEditValueChanged(Sender: TObject);
    procedure colInvoiceNoPropertiesButtonClick(Sender: TObject; AButtonIndex:
        Integer);
    procedure colInvoiceNoPropertiesValidate(Sender: TObject; var DisplayValue:
        Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure colPaidAmtPropertiesEditValueChanged(Sender: TObject);
    procedure colReturAmtPropertiesEditValueChanged(Sender: TObject);
    procedure colReturNoPropertiesButtonClick(Sender: TObject; AButtonIndex:
        Integer);
    procedure colReturNoPropertiesValidate(Sender: TObject; var DisplayValue:
        Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure edCashReceiptPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
  private
    FCDS: TClientDataset;
    FCDSClone: TClientDataset;
    FCDSCloneCost: TClientDataset;
    FCDSCost: TClientDataset;
    FARSettlement: TARSettlement;
    FCashReceipt: TCashReceipt;
    procedure CalculateAll;
    procedure CDSAfterDelete(DataSet: TDataSet);
    function DC: TcxGridDBDataController;
    function DCCost: TcxGridDBDataController;
    procedure FocusToGrid;
    procedure FocusToGridCost;
    function GetCDS: TClientDataset;
    function GetCDSClone: TClientDataset;
    function GetCDSCloneCost: TClientDataset;
    function GetCDSCost: TClientDataset;
    function GetARSettlement: TARSettlement;
    function GetCashReceipt: TCashReceipt;
    procedure InitView;
    procedure LoadCashReceipt(aID: Integer);
    procedure LookupInvoice(sKey: string = '');
    procedure LookupRetur;
    procedure LookupCashReceipt;
    procedure SetInvoiceToGrid(AInvoice: TSalesInvoice);
    procedure SetReturToGrid(aRetur: TSalesRetur);
    procedure UpdateData;
    function ValidateData: Boolean;
    property CashReceipt: TCashReceipt read GetCashReceipt write FCashReceipt;
    property CDS: TClientDataset read GetCDS write FCDS;
    property CDSClone: TClientDataset read GetCDSClone write FCDSClone;
    property CDSCloneCost: TClientDataset read GetCDSCloneCost write FCDSCloneCost;
    property CDSCost: TClientDataset read GetCDSCost write FCDSCost;
    { Private declarations }
  public
    function GetGroupName: string; override;
    procedure LoadByID(aID: Integer; IsReadOnly: Boolean = False);
    property ARSettlement: TARSettlement read GetARSettlement write FARSettlement;
    { Public declarations }
  end;

var
  frmARSettlement: TfrmARSettlement;

implementation

uses
  uDBUtils, uDXUtils, System.DateUtils,
  ufrmCXServerLookup, uSupplier, uAccount, uVariable, uSalesman, ufrmCXLookup;

{$R *.dfm}

procedure TfrmARSettlement.btnSaveClick(Sender: TObject);
begin
  inherited;
  if not ValidateData then exit;
  UpdateData;
  if ARSettlement.SaveRepeat() then
  begin
//    TAppUtils.InformationBerhasilSimpan;
    Self.ModalResult := mrOK;
  end;
end;

procedure TfrmARSettlement.CalculateAll;
var
  dOthers: Double;
  dPaid: Double;
  dRetur: Double;
begin
  if CDS.State in [dsInsert, dsEdit] then
    CDS.Post;

  CDS.DisableControls;
  CDSCost.DisableControls;
//  DisableTrigger := True;
  Try
    dPaid := 0;
    dOthers := 0;
    dRetur := 0;

    CDSClone.First;
    while not CDSClone.Eof do
    begin
      dPaid   := dPaid +  CDSClone.FieldByName('Amount').AsFloat;
      dRetur  := dRetur +  CDSClone.FieldByName('ReturAmt').AsFloat;
      CDSClone.Next;
    end;

    CDSCloneCost.First;
    while not CDSCloneCost.Eof do
    begin
      dOthers   := dOthers +  CDSCloneCost.FieldByName('Amount').AsFloat;
      CDSCloneCost.Next;
    end;

    crBayar.Value   := dPaid;
    crRetur.Value   := dRetur;
    crOthers.Value  := dOthers;
    crTotal.Value   := dPaid + dOthers;
  Finally
    CDS.EnableControls;
    CDSCost.EnableControls;
//    DisableTrigger := False;
  End;
end;



procedure TfrmARSettlement.CDSAfterDelete(DataSet: TDataSet);
begin
  inherited;
  CalculateAll;
end;

procedure TfrmARSettlement.colCostAmountPropertiesEditValueChanged(Sender:
    TObject);
begin
  inherited;
  DCCost.Post;
  CalculateAll;
end;

procedure TfrmARSettlement.colInvoiceNoPropertiesButtonClick(Sender: TObject;
    AButtonIndex: Integer);
begin
  inherited;
  LookupInvoice;
end;

procedure TfrmARSettlement.colInvoiceNoPropertiesValidate(Sender: TObject; var
    DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
var
  lSales: TSalesInvoice;
begin
  inherited;
  lSales := TSalesInvoice.Create;
  Try
    lSales.LoadByCode(VarToStr(DisplayValue));
    SetInvoiceToGrid(lSales);
  Finally
    lSales.Free;
  End;
end;

procedure TfrmARSettlement.colPaidAmtPropertiesEditValueChanged(Sender:
    TObject);
begin
  inherited;
  CalculateAll;
end;

procedure TfrmARSettlement.colReturAmtPropertiesEditValueChanged(Sender:
    TObject);
begin
  inherited;
  DC.Post;
  CalculateAll;
end;

procedure TfrmARSettlement.colReturNoPropertiesButtonClick(Sender: TObject;
    AButtonIndex: Integer);
begin
  inherited;
  LookupRetur();
end;

procedure TfrmARSettlement.colReturNoPropertiesValidate(Sender: TObject; var
    DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
//var
//  lRet: TPurchaseRetur;
begin
  inherited;
//  lRet := TPurchaseRetur.Create;
//  Try
//    lRet.LoadByCode(VarToStr(DisplayValue));
//    SetReturToGrid(lRet);
//  Finally
//    lRet.Free;
//  End;
end;

procedure TfrmARSettlement.cxGrdMainEditKeyDown(Sender: TcxCustomGridTableView;
    AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word; Shift:
    TShiftState);
begin
  inherited;
  if (Key = VK_F5) and (aItem = colInvoiceNo) then
  begin
    LookupInvoice(VarToStr(AEdit.EditingValue));
  end;
  if (Key = VK_F5) and (aItem = colReturNo) then
  begin
    LookupRetur();
  end;
end;

function TfrmARSettlement.DC: TcxGridDBDataController;
begin
  Result := cxGrdMain.DataController;
end;

function TfrmARSettlement.DCCost: TcxGridDBDataController;
begin
  Result := cxGrdCost.DataController;
end;

procedure TfrmARSettlement.dtDueDateKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
begin
  inherited;
  if Key = VK_RETURN then
  begin
    FocusToGrid;
  end;
end;

procedure TfrmARSettlement.edCashReceiptPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  inherited;
  LookupCashReceipt;
end;

procedure TfrmARSettlement.FocusToGrid;
begin
  cxGrid1.SetFocus;
  cxGrid1.FocusedView := cxGrdMain;
  if cxGrdMain.DataController.RecordCount = 0 then
  begin
    CDS.Append;
    cxGrdMain.Controller.EditingController.ShowEdit;
  end;
end;

procedure TfrmARSettlement.FocusToGridCost;
begin
  cxGrid1.SetFocus;
  cxGrid1.FocusedView := cxGrdCost;
  if CDSCost.RecordCount = 0 then
  begin
    CDSCost.Append;
    cxGrdCost.Controller.EditingController.ShowEdit;
  end;
end;

procedure TfrmARSettlement.FormCreate(Sender: TObject);
begin
  inherited;
  Self.AssignKeyDownEvent;
  InitView;
  cxGrid1.FocusedView := cxGrdMain;
  LoadByID(0);
end;

procedure TfrmARSettlement.FormKeyDown(Sender: TObject; var Key: Word; Shift:
    TShiftState);
begin
  inherited;
  if Key = VK_F1 then
    edRefno.SetFocus;

  if Key = VK_F2 then
    FocusToGrid
  else if Key = VK_F3 then
    FocusToGridCost
  else if Key = VK_F4 then
    ckFilterSalesman.Checked := not ckFilterSalesman.Checked;

end;

function TfrmARSettlement.GetCDS: TClientDataset;
begin
  if FCDS = nil then
  begin
    FCDS := TFinancialTransaction.CreateDataSet(Self, False);
    FCDS.AddField('InvoiceNo',ftString);
    FCDS.AddField('Customer',ftString);
    FCDS.AddField('CustomerID',ftInteger);
    FCDS.AddField('InvoiceDate',ftDateTime);
    FCDS.AddField('ReturNo',ftString);
    FCDS.AddField('InvoiceAmt',ftFloat);
    FCDS.AddField('InvoiceRemain',ftFloat);
    FCDS.AddField('ReturRemain',ftFloat);
    FCDS.AfterDelete := CDSAfterDelete;
    FCDS.CreateDataSet;
  end;
  Result := FCDS;
end;

function TfrmARSettlement.GetCDSClone: TClientDataset;
begin
  if FCDSClone = nil then
  begin
    FCDSClone := CDS.ClonedDataset(Self);
  end;
  Result := FCDSClone;
end;

function TfrmARSettlement.GetCDSCloneCost: TClientDataset;
begin
  if FCDSCloneCost = nil then
  begin
    FCDSCloneCost := CDSCost.ClonedDataset(Self);
  end;
  Result := FCDSCloneCost;
end;

function TfrmARSettlement.GetCDSCost: TClientDataset;
begin
  if FCDSCost = nil then
  begin
    FCDSCost := TFinancialTransaction.CreateDataSet(Self, False);
    FCDSCost.AfterDelete := CDSAfterDelete;
    FCDSCost.CreateDataSet;
  end;
  Result := FCDSCost;
end;

function TfrmARSettlement.GetGroupName: string;
begin
  Result := 'Hutang & Piutang';
end;

function TfrmARSettlement.GetARSettlement: TARSettlement;
begin
  if FARSettlement = nil then
    FARSettlement := TARSettlement.Create;
  Result := FARSettlement;
end;

function TfrmARSettlement.GetCashReceipt: TCashReceipt;
begin
  if FCashReceipt = nil then
    FCashReceipt := TCashReceipt.Create;
  Result := FCashReceipt;
end;

procedure TfrmARSettlement.InitView;
begin
  cxGrdMain.PrepareFromCDS(CDS);
  cxGrdCost.PrepareFromCDS(CDSCost);

  cxLookupCustomer.Properties.LoadFromSQL(Self,
    'select id, kode,  nama, alamat from tcustomer','nama');
  TcxExtLookup(colCostAccount.Properties).LoadFromSQL(Self,
    'select id, kode + '' - '' + nama as nama from taccount where isdetail = 1','nama');
end;

procedure TfrmARSettlement.LoadByID(aID: Integer; IsReadOnly: Boolean = False);
var
  lItem: TFinancialTransaction;
  lSalesInv: TSalesInvoice;
  lSalesRet: TSalesRetur;
begin
  if FARSettlement <> nil then
    FreeAndNil(FARSettlement);

  ARSettlement.LoadByID(aID);

  if aID = 0 then
  begin
    ARSettlement.TransDate := Now();
    ARSettlement.Refno     := ARSettlement.GenerateNo;
//    ARSettlement.Media     := -1;
  end;

  if (aID <> 0) and (not IsReadOnly) then
  begin
    IsReadOnly := not IsValidTransDate(ARSettlement.TransDate);
  end;

  edRefno.Text        := ARSettlement.Refno;

  dtTransDate.Date    := ARSettlement.TransDate;

  if dtTransDate.Date <= 0 then dtTransDate.Clear;


  if ARSettlement.CashReceipt <> nil then
    LoadCashReceipt(ARSettlement.CashReceipt.ID);

  cxLookupCustomer.Clear;
  if ARSettlement.Customer <> nil then
    cxLookupCustomer.EditValue := ARSettlement.Customer.ID;

  edNotes.Text        := ARSettlement.Notes;

  CDS.EmptyDataSet;
  CDSCost.EmptyDataSet;
  CDS.DisableControls;
  CDSCost.DisableControls;

  lSalesInv := TSalesInvoice.Create;
  lSalesRet := TSalesRetur.Create;
  Try
    for lItem in ARSettlement.Items do
    begin
      if lItem.DebetAmt > 0 then continue;
      if lItem.SalesInvoice = nil then
      begin
        CDSCost.Append;
        lItem.UpdateToDataset(CDSCost);
        CDSCost.Post;
      end else
      begin
        CDS.Append;
        lItem.UpdateToDataset(CDS);
        if lItem.SalesInvoice <> nil then
        begin
          if lSalesInv.LoadByID(lItem.SalesInvoice.ID) then
          begin
            CDS.FieldByName('InvoiceNo').AsString     := lSalesInv.InvoiceNo;
            CDS.FieldByName('InvoiceDate').AsDateTime := lSalesInv.TransDate;
            CDS.FieldByName('InvoiceAmt').AsFloat     := lSalesInv.Amount;
            CDS.FieldByName('InvoiceRemain').AsFloat  := lSalesInv.GetRemain + lItem.Amount + lItem.ReturAmt;
            if lSalesInv.Customer <> nil then
            begin
              lSalesInv.Customer.ReLoad(False);
              CDS.FieldByName('CustomerID').AsInteger := lSalesInv.Customer.ID;
              CDS.FieldByName('Customer').AsString    := lSalesInv.Customer.Nama;
            end;
          end;
        end;
        if lItem.SalesRetur <> nil then
        begin
          if lSalesRet.LoadByID(lItem.SalesRetur.ID) then
          begin
            CDS.FieldByName('ReturNo').AsString       := lSalesRet.Refno;
            CDS.FieldByName('ReturRemain').AsFloat    := lSalesRet.Amount - lSalesRet.PaidAmount + lItem.ReturAmt;
          end;
        end;
        CDS.Post;
      end;
    end;
    CalculateAll;
  Finally
    CDS.EnableControls;
    CDSCost.EnableControls;
    FreeAndNil(lSalesInv);
    FreeAndNil(lSalesRet);
  End;

  btnSave.Enabled := not IsReadOnly;
end;

procedure TfrmARSettlement.LoadCashReceipt(aID: Integer);
begin
  CashReceipt.LoadByID(aID);

  if CashReceipt.Customer<>nil then
    cxLookupCustomer.EditValue  := CashReceipt.Customer.ID;


  edCashReceipt.Text          := CashReceipt.refno;
  dtCashReceipt.Date          := CashReceipt.TransDate;
  crRemain.Value              := CashReceipt.Remain;

end;

procedure TfrmARSettlement.LookupInvoice(sKey: string = '');
var
  cxLookup: TfrmCXLookup;
  lInvoice: TSalesInvoice;
  S: string;
begin
  if (ckFilterSalesman.Checked) and (VarToInt(cxLookupCustomer.EditValue) = 0) then
  begin
    TAppUtils.Warning('Salesman harus dipilih terlebih dahulu'
      +#13 + 'Atau non aktifkan [Filter Faktur atas Salesman] agar bisa memilih faktur tanpa salesman'
    );
    exit;
  end;

  S := 'SELECT A.ID, A.INVOICENO, B.NAMA AS CUSTOMER,'
      +' A.TRANSDATE, A.DUEDATE, '
      +' A.AMOUNT, A.PAIDAMOUNT, A.RETURAMOUNT, A.NOTES,'
      +' (A.AMOUNT - A.PAIDAMOUNT - A.RETURAMOUNT) AS REMAIN'
      +' FROM TSALESINVOICE A'
      +' INNER JOIN TCUSTOMER B ON A.CUSTOMER_ID = B.ID'
      +' WHERE (A.AMOUNT - ISNULL(A.PAIDAMOUNT,0) - ISNULL(A.RETURAMOUNT,0)) > '
      + FloatToStr(AppVariable.Toleransi_Piutang);

  if ckFilterSalesman.Checked then
    S := S + ' and a.customer_id = ' + IntToStr(VarToInt(cxLookupCustomer.EditValue));

//  cxLookup := TfrmCXServerLookup.Execute(S, 'ID', 0, 0 );
  cxLookup := TfrmCXLookup.Execute(S, True );
  Try
    cxLookup.PreFilter('INVOICENO', sKey);
    cxLookup.HideFields(['ID']);
    cxLookup.cxGridView.EnableFiltering();
    if cxLookup.ShowModal = mrOK then
    begin
      while not cxLookup.Data.Eof do
      begin
        if CDSClone.Locate('SalesInvoice', cxLookup.Data.FieldByName('ID').AsInteger, [loCaseInsensitive]) then
        begin
          TAppUtils.Warning('Faktur : ' + cxLookup.Data.FieldByName('INVOICENO').AsString + ' sudah ada di Grid Input');
          cxLookup.Data.Next;
          continue;
        end;

        lInvoice := TSalesInvoice.Create;
        Try
          lInvoice.LoadByID(cxLookup.Data.FieldByName('ID').AsInteger);
          SetInvoiceToGrid(lInvoice);
        Finally
          lInvoice.Free;
        End;

        cxLookup.Data.Next;
        if not cxLookup.Data.Eof then DC.Append;
      end;
    end;
  Finally
    cxLookup.Free;
  End;
end;

procedure TfrmARSettlement.LookupRetur;
var
  aCustomerID: Integer;
  cxLookup: TfrmCXServerLookup;
  lRetur: TSalesRetur;
  S: string;
begin
  aCustomerID  := VarToInt(cxGrdMain.Controller.FocusedRecord.Values[colCustomerID.Index]);
  if aCustomerID = 0 then
  begin
    TAppUtils.Warning('Customer belum terisi');
    exit;
  end;

  S := 'SELECT A.ID, A.REFNO, A.TRANSDATE,  B.NAMA AS CUSTOMER,'
      +' A.AMOUNT, A.PAIDAMOUNT, A.NOTES,'
      +' (A.AMOUNT - A.PAIDAMOUNT) AS REMAIN'
      +' FROM TSALESRETUR A'
      +' INNER JOIN TCUSTOMER B ON A.CUSTOMER_ID = B.ID'
      +' WHERE (A.AMOUNT - ISNULL(A.PAIDAMOUNT,0)) > '
      + FloatToStr(AppVariable.Toleransi_Piutang)
      +' AND A.CUSTOMER_ID = ' + IntToStr(aCustomerID);


  cxLookup := TfrmCXServerLookup.Execute(S, 'ID', 0, 0 );
  Try
//    cxLookup.PreFilter('REFNO', '');
    if cxLookup.ShowModal = mrOK then
    begin
      lRetur := TSalesRetur.Create;
      Try
        lRetur.LoadByID(VarToInt(cxLookup.FieldValue('ID')));
        SetReturToGrid(lRetur);
      Finally
        lRetur.Free;
      End;
    end;
  Finally
    cxLookup.Free;
  End;
end;

procedure TfrmARSettlement.LookupCashReceipt;
var
  cxLookup: TfrmCXServerLookup;
  S: string;
begin
  S := 'select A.ID, A.REFNO, A.AMOUNT, A.PAIDAMOUNT, A.AMOUNT-A.PAIDAMOUNT AS REMAIN,'
      +' A.TRANSDATE, C.NAMA AS CUSTOMER, A.NOTES'
      +' from TCASHRECEIPT a'
      +' LEFT JOIN TCUSTOMER C ON A.CUSTOMER_ID = C.ID '
      +' WHERE a.IS_DOWNPAYMENT=1 AND (A.AMOUNT - ISNULL(A.PAIDAMOUNT,0) ) > '
      + FloatToStr(AppVariable.Toleransi_Piutang);


  cxLookup := TfrmCXServerLookup.Execute(S, 'ID');
  Try
    if cxLookup.ShowModal = mrOK then
    begin
      LoadCashReceipt(cxLookup.FieldValue('id'));
    end;
  Finally
    cxLookup.Free;
  End;
end;

procedure TfrmARSettlement.SetInvoiceToGrid(AInvoice: TSalesInvoice);
begin
  if AInvoice = nil then exit;
  DC.SetEditValue(colInvoiceID.Index, AInvoice.ID, evsValue);
  DC.SetEditValue(colInvoiceNo.Index, AInvoice.InvoiceNo, evsValue);

  AInvoice.Customer.ReLoad(False);
  DC.SetEditValue(colCustomerID.Index, AInvoice.Customer.ID, evsValue);
  DC.SetEditValue(colCustomer.Index, AInvoice.Customer.Nama, evsValue);

  DC.SetEditValue(colInvoiceDate.Index, AInvoice.TransDate, evsValue);
  DC.SetEditValue(colInvoiceAmt.Index, AInvoice.Amount, evsValue);
  DC.SetEditValue(colPaidAmt.Index, AInvoice.GetRemain, evsValue);
  DC.SetEditValue(colReturAmt.Index, 0, evsValue);
  DC.SetEditValue(colInvoiceRemain.Index, AInvoice.GetRemain, evsValue);
  DC.SetEditValue(colReturID.Index, 0, evsValue);
  DC.SetEditValue(colReturNo.Index, '', evsValue);
  DC.SetEditValue(colReturAmt.Index, 0, evsValue);
  DC.SetEditValue(colReturRemain.Index, 0, evsValue);
  CalculateAll;
end;

procedure TfrmARSettlement.SetReturToGrid(aRetur: TSalesRetur);
begin
  if aRetur = nil then exit;
  DC.SetEditValue(colReturID.Index, aRetur.ID, evsValue);
  DC.SetEditValue(colReturNo.Index, aRetur.Refno, evsValue);
  DC.SetEditValue(colReturRemain.Index, aRetur.Amount - aRetur.PaidAmount, evsValue);
  DC.SetEditValue(colReturAmt.Index, aRetur.Amount - aRetur.PaidAmount, evsValue);
  CalculateAll;
end;

procedure TfrmARSettlement.UpdateData;
var
  lItem: TFinancialTransaction;
begin
  ARSettlement.Refno         := edRefno.Text;
  ARSettlement.TransDate     := dtTransDate.Date;
  ARSettlement.DueDate       := dtTransDate.Date;
//  ARSettlement.Media         := cbMedia.ItemIndex;
//  ARSettlement.MediaNo       := edNoMedia.Text;
  ARSettlement.CashReceipt   := TCashReceipt.CreateID(CashReceipt.ID);
  ARSettlement.Amount        := crTotal.Value;
  ARSettlement.ReturAmount   := crRetur.Value;
  ARSettlement.Notes         := edNotes.Text;
  ARSettlement.ModifiedBy    := UserLogin;
  ARSettlement.ModifiedDate  := Now();

  if ARSettlement.Customer = nil then
    ARSettlement.Customer := TCustomer.Create;


  ARSettlement.Customer.ID := VarToInt(cxLookupCustomer.EditValue);
  ARSettlement.Items.Clear;

  //header debet
  lItem                 := TFinancialTransaction.Create;
  lItem.DebetAmt        := ARSettlement.Amount;
  lItem.CreditAmt       := 0;
  lItem.Amount          := ARSettlement.Amount;
  lItem.TransDate       := ARSettlement.TransDate;
  lItem.Notes           := 'ARSettlement : ' + ARSettlement.Refno;
//  lItem.Rekening        := TRekening.CreateID(ARSettlement.Rekening.ID);

  if CashReceipt.Account<>nil then
    lItem.Account         := TAccount.CreateID(CashReceipt.Account.ID);
  ARSettlement.Items.Add(lItem);

  CDS.First;
  while not CDS.Eof do
  begin
    lItem               := TFinancialTransaction.Create;
    lItem.SetFromDataset(CDS);
    lItem.SetToCredit; //pembayaran piutang
    lItem.TransDate     := ARSettlement.TransDate;
    lItem.Notes         := 'ARSettlement : ' + ARSettlement.Refno;
    ARSettlement.Items.Add(lItem);
    CDS.Next;
  end;

  CDSCost.First;
  while not CDSCost.Eof do
  begin
    lItem               := TFinancialTransaction.Create;
    lItem.SetFromDataset(CDSCost);
    lItem.SetToCredit; //pembayaran biaya (sebagai pendapatan)
    lItem.TransDate     := ARSettlement.TransDate;
//    lItem.Notes         := 'Sales ARSettlement : ' + ARSettlement.Refno;
    ARSettlement.Items.Add(lItem);
    CDSCost.Next;
  end;
end;

function TfrmARSettlement.ValidateData: Boolean;
begin
  Result := False;

  if (ckFilterSalesman.Checked) and (VarToInt(cxLookupCustomer.EditValue) = 0) then
  begin
    TAppUtils.Warning('Customer harus dipilih terlebih dahulu'
      +#13 + 'Atau non aktifkan [Filter Faktur atas Customer] agar bisa menyimpan data'
    );
    exit;
  end;


  if crTotal.Value <= 0 then
  begin
    TAppUtils.Warning('Total <= 0');
    exit;
  end;

//  if CDS.RecordCount = 0 then
//  begin
//    TAppUtils.Warning('Data Faktur tidak boleh kosong' + #13 + 'Baris : ' +IntTostr(CDS.RecNo));
//    exit;
//  end;
  if cxGrdMain.DataController.RecordCount = 0 then
  begin
    TAppUtils.Warning('Data Item tidak boleh kosong');
    exit;
  end;

  if CDS.Locate('SalesInvoice', null, []) or CDS.Locate('SalesInvoice', 0, []) then
  begin
    TAppUtils.Warning('Invoice tidak boleh kosong' + #13 + 'Baris : ' +IntTostr(CDS.RecNo));
    exit;
  end;

  if (crTotal.Value-crRemain.Value)> AppVariable.Toleransi_Piutang then
  begin
    TAppUtils.Warning('Nilai Total Pembayaran melebih Sisan Remain Cash Receipt');
    exit;
  end;


  CDS.First;
  while not CDS.Eof do
  begin
    if (CDS.FieldByName('SalesRetur').AsInteger = 0)
      and (CDS.FieldByName('ReturAmt').AsFloat > 0) then
    begin
      TAppUtils.Warning('Nomor Retur kosong, tetapi ada nominal Retur');
      exit;
    end;

    if (CDS.FieldByName('ReturAmt').AsFloat - CDS.FieldByName('ReturRemain').AsFloat) > 1
    then
    begin
      TAppUtils.Warning('Nilai Potong retur melebihi Sisa Retur yang bisa dipotongkan'
        + #13 + 'Baris : ' +IntTostr(CDS.RecNo)
      );
      exit;
    end;

    if (CDS.FieldByName('Amount').AsFloat
      + CDS.FieldByName('ReturAmt').AsFloat
      - CDS.FieldByName('InvoiceRemain').AsFloat) > AppVariable.Toleransi_Piutang
    then
    begin
      TAppUtils.Warning('Nilai Pembayaran melebihi Sisa Hutang'
        + #13 + 'Baris : ' +IntTostr(CDS.RecNo)
        + #13 + 'Setting Toleransi Sisa Hutang / Piutang : ' +FloatToStr(AppVariable.Toleransi_Piutang)
      );
      exit;
    end;

    if (CDS.FieldByName('Amount').AsFloat < 0) then
    begin
      TAppUtils.Warning('Nilai Pembayaran tidak boleh < 0'
        + #13 + 'Baris : ' +IntTostr(CDS.RecNo)
      );
      exit;
    end;

    if (CDS.FieldByName('ReturAmt').AsFloat < 0) then
    begin
      TAppUtils.Warning('Nilai Pembayaran tidak boleh < 0'
        + #13 + 'Baris : ' +IntTostr(CDS.RecNo)
      );
      exit;
    end;

    if (CDS.FieldByName('Amount').AsFloat <= 0) and (CDS.FieldByName('ReturAmt').AsFloat <= 0)
    then
    begin
      TAppUtils.Warning('Nilai Total Pembayaran (Cash & Retur) tidak boleh <= 0'
        + #13 + 'Baris : ' +IntTostr(CDS.RecNo)
      );
      exit;
    end;
    CDS.Next;
  end;




  if not IsValidTransDate(dtTransDate.Date) then exit;

  Result := TAppUtils.Confirm('Anda yakin data sudah sesuai?');
end;

end.
