unit ufrmCashReceiptDP;

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
  cxGridDBDataDefinitions, uItem, cxDataUtils, uAppUtils, cxSpinEdit, uVariable;
type
  TfrmCashReceiptDP = class(TfrmDefaultInput)
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    edRefno: TcxTextEdit;
    cxLabel6: TcxLabel;
    edNotes: TcxMemo;
    dtTransDate: TcxDateEdit;
    cxLabel8: TcxLabel;
    cxLabel5: TcxLabel;
    crCash: TcxCurrencyEdit;
    lbRekening: TcxLabel;
    cxLookupRekening: TcxExtLookupComboBox;
    cxLabel2: TcxLabel;
    cxLookupCustomer: TcxExtLookupComboBox;
    cxLabel3: TcxLabel;
    cxLookupAcc: TcxExtLookupComboBox;
    procedure btnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    FCashReceipt: TCashReceipt;
    FCDSAccount: TClientDataset;
    FDefaultAccountID: Integer;
    function GetCashReceipt: TCashReceipt;
    function GetCDSAccount: TClientDataset;
    procedure InitView;
    procedure UpdateData;
    function ValidateData: Boolean;
    property CDSAccount: TClientDataset read GetCDSAccount write FCDSAccount;
    property DefaultAccountID: Integer read FDefaultAccountID write
        FDefaultAccountID;
    { Private declarations }
  public
    function GetGroupName: string; override;
    procedure LoadByID(aID: Integer; IsReadOnly: Boolean = False);
    property CashReceipt: TCashReceipt read GetCashReceipt write FCashReceipt;
    { Public declarations }
  end;

var
  frmCashReceiptDP: TfrmCashReceiptDP;

implementation

uses
  uDBUtils, uDXUtils, System.DateUtils,
  ufrmCXServerLookup, uSupplier, uAccount, uCustomer;

{$R *.dfm}

procedure TfrmCashReceiptDP.btnSaveClick(Sender: TObject);
begin
  inherited;
  if not ValidateData then exit;
  UpdateData;
  if CashReceipt.SaveRepeat() then
  begin
//    TAppUtils.InformationBerhasilSimpan;
    Self.ModalResult := mrOK;
  end;
end;

procedure TfrmCashReceiptDP.FormCreate(Sender: TObject);
begin
  inherited;
  Self.AssignKeyDownEvent;
  InitView;
  LoadByID(0);
end;

procedure TfrmCashReceiptDP.FormKeyDown(Sender: TObject; var Key: Word; Shift:
    TShiftState);
begin
  inherited;
  if Key = VK_F1 then
    edRefno.SetFocus;
end;

function TfrmCashReceiptDP.GetCashReceipt: TCashReceipt;
begin
  if FCashReceipt = nil then
  begin
    FCashReceipt := TCashReceipt.Create;
    FCashReceipt.IS_DOwnPayment := 1;
  end;
  Result := FCashReceipt;
end;

function TfrmCashReceiptDP.GetCDSAccount: TClientDataset;
begin
  if FCDSAccount = nil then
  begin
    FCDSAccount := TDBUtils.OpenDataset('select id, kode, nama from taccount',Self);
  end;
  Result := FCDSAccount;
end;

function TfrmCashReceiptDP.GetGroupName: string;
begin
  Result := 'Penjualan & Kas';
end;

procedure TfrmCashReceiptDP.InitView;
begin
  cxLookupRekening.Properties.LoadFromSQL(Self,
    'select id, nama from trekening','nama');
  cxLookupCustomer.Properties.LoadFromSQL(Self,
    'select id, kode, nama, alamat, telp from TCUSTOMER','nama');

  cxLookupAcc.Properties.LoadFromSQL(Self,
    'select id, kode +'' - '' + nama as account from taccount','account');

  if CDSAccount.Locate('kode', AppVariable.Account_DP, [loCaseInsensitive]) then
    DefaultAccountID := CDSAccount.FieldByName('id').AsInteger;

end;

procedure TfrmCashReceiptDP.LoadByID(aID: Integer; IsReadOnly: Boolean = False);
begin
  if FCashReceipt <> nil then
    FreeAndNil(FCashReceipt);

  CashReceipt.LoadByID(aID);
  if aID = 0 then
  begin
    CashReceipt.TransDate := Now();
    CashReceipt.Refno     := CashReceipt.GenerateNo;

  end;
  if (aID <> 0) and (not IsReadOnly) then
  begin
    IsReadOnly := not IsValidTransDate(CashReceipt.TransDate);
  end;

  crCash.Value        := CashReceipt.Amount;
  edRefno.Text        := CashReceipt.Refno;
  dtTransDate.Date    := CashReceipt.TransDate;
  if dtTransDate.Date <= 0 then dtTransDate.Clear;
  edNotes.Text        := CashReceipt.Notes;
  cxLookupRekening.Clear;

  if CashReceipt.Rekening <> nil then
  begin
    cxLookupRekening.EditValue := CashReceipt.Rekening.ID;
  end;

  if CashReceipt.Customer<>nil then
    cxLookupCustomer.EditValue  := CashReceipt.Customer.ID;
  if CashReceipt.Account<>nil then
    cxLookupAcc.EditValue       := CashReceipt.Account.ID
  else
    cxLookupAcc.EditValue       := DefaultAccountID;

  
  btnSave.Enabled := not IsReadOnly;
end;

procedure TfrmCashReceiptDP.UpdateData;
var
  lItem: TFinancialTransaction;
begin
  CashReceipt.Refno         := edRefno.Text;
  CashReceipt.TransDate     := dtTransDate.Date;
  CashReceipt.Amount        := crCash.Value;
  CashReceipt.Notes         := edNotes.Text;
  CashReceipt.ModifiedBy    := UserLogin;
  CashReceipt.ModifiedDate  := Now();

  if CashReceipt.Customer = nil then
    CashReceipt.Customer    := TCustomer.Create;

  if CashReceipt.Account = nil then
    CashReceipt.Account     := TAccount.Create;

  if CashReceipt.Rekening = nil then
    CashReceipt.Rekening    := TRekening.Create;

  CashReceipt.Customer.LoadByID(VarToInt(cxLookupCustomer.EditValue));
  CashReceipt.Account.LoadByID(VarToInt(cxLookupAcc.EditValue));
  CashReceipt.Rekening.LoadByID(VarToInt(cxLookupRekening.EditValue));


  CashReceipt.Items.Clear;

  //header debet
  lItem                 := TFinancialTransaction.Create;
  lItem.DebetAmt        := CashReceipt.Amount;
  lItem.CreditAmt       := 0;
  lItem.Amount          := CashReceipt.Amount;
  lItem.TransDate       := CashReceipt.TransDate;
  lItem.Notes           := CashReceipt.Notes;
  lItem.Rekening        := TRekening.CreateID(CashReceipt.Rekening.ID);
  CashReceipt.Items.Add(lItem);

  //detail DP
  lItem                 := TFinancialTransaction.Create;
  lItem.DebetAmt        := 0;
  lItem.CreditAmt       := CashReceipt.Amount;;
  lItem.Amount          := CashReceipt.Amount;
  lItem.TransDate       := CashReceipt.TransDate;
  lItem.Notes           := CashReceipt.Notes;
  lItem.Account         := TAccount.CreateID(VarToInt(cxLookupAcc.EditValue));
  CashReceipt.Items.Add(lItem);


end;

function TfrmCashReceiptDP.ValidateData: Boolean;
begin
  Result := False;

  if crCash.Value <= 0 then
  begin
    TAppUtils.Warning('Total <= 0');
    exit;
  end;

  if (VarToInt(cxLookupRekening.EditValue) = 0) then
  begin
    TAppUtils.Warning('Rekening Kas / Bank belum diisi');
    exit;
  end;

//  if CDS.RecordCount = 0 then
//  begin
//    TAppUtils.Warning('Detail penerimaan kosong');
//    exit;
//  end;
  
  if not IsValidTransDate(dtTransDate.Date) then exit;

  Result := TAppUtils.Confirm('Anda yakin data sudah sesuai?');
end;

end.
