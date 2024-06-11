unit uFinancialTransaction;

interface

uses
  CRUDObject, uDBUtils, Sysutils, uItem, System.Generics.Collections,
  uWarehouse, uSupplier, uCustomer, uSalesman, uAccount, uTransDetail,
  uDMReport, uVariable;

type
  TFinancialTransaction = class;
  TPurchaseInvoice = class;
  TPurchaseRetur = class;
  TPurchaseInvoiceItem = class;
  TSalesInvoice = class;
  TSalesRetur = class;

  TCRUDFinance = class(TCRUDObject)
  private
    FAmount: Double;
    FItems: TObjectList<TFinancialTransaction>;
    FTransDate: TDateTime;
    FClosed: Integer;
    FModifiedBy: String;
    FModifiedDate: TDateTime;
    FRefno: string;
    FDueDate: TDateTime;
    FNotes: string;
    function GetItems: TObjectList<TFinancialTransaction>;
  protected
    function GetRefno: String; dynamic;
    procedure PrepareDetailObject(AObjItem: TCRUDObject); override;
  public
    destructor Destroy; override;
    function GenerateNo: String; virtual; abstract;
    function GetHeaderFlag: Integer; virtual; abstract;
    function SaveRepeat(aRepeatCount: Integer = 2; DoShowMsg: Boolean = True):
        Boolean;
    property Items: TObjectList<TFinancialTransaction> read GetItems write FItems;
  published
    property Amount: Double read FAmount write FAmount;
    property TransDate: TDateTime read FTransDate write FTransDate;
    property Closed: Integer read FClosed write FClosed;
    property ModifiedBy: String read FModifiedBy write FModifiedBy;
    property ModifiedDate: TDateTime read FModifiedDate write FModifiedDate;
    [AttributeOfCode]
    property Refno: string read FRefno write FRefno;
    property DueDate: TDateTime read FDueDate write FDueDate;
    property Notes: string read FNotes write FNotes;
  end;

  TFinancialTransaction = class(TCRUDObject)
  private
    FDebetAmt: Double;
    FReturAmt: Double;
    FSalesInvoice: TSalesInvoice;
    FNotes: string;
    FHeader_ID: Integer;
    FHeader_Flag: Integer;
    FSalesRetur: TSalesRetur;
    FRekening: TRekening;
    FAccount: TAccount;
    FCreditAmt: Double;
    FAmount: Double;
    FMedia: Integer;
    FMediaNo: string;
    FRefNo: string;
    FPurchaseInvoice: TPurchaseInvoice;
    FPurchaseRetur: TPurchaseRetur;
    FTransDate: TDateTime;
    FTransType: Integer;
  protected
    function GetSQLDeleteDetails(Header_ID: Integer): String; override;
    function GetSQLRetrieveDetails(Header_ID: Integer): String; override;
  public
    destructor Destroy; override;
    function HasRetur: Boolean;
    procedure SetToDebet;
    procedure SetToCredit;
  published
    property DebetAmt: Double read FDebetAmt write FDebetAmt;
    property ReturAmt: Double read FReturAmt write FReturAmt;
    property SalesInvoice: TSalesInvoice read FSalesInvoice write FSalesInvoice;
    property Notes: string read FNotes write FNotes;
    [AttributeOfHeader]
    property Header_ID: Integer read FHeader_ID write FHeader_ID;
    property Header_Flag: Integer read FHeader_Flag write FHeader_Flag;
    property SalesRetur: TSalesRetur read FSalesRetur write FSalesRetur;
    property Rekening: TRekening read FRekening write FRekening;
    property Account: TAccount read FAccount write FAccount;
    property CreditAmt: Double read FCreditAmt write FCreditAmt;
    property Amount: Double read FAmount write FAmount;
    property Media: Integer read FMedia write FMedia;
    property MediaNo: string read FMediaNo write FMediaNo;
    property RefNo: string read FRefNo write FRefNo;
    property PurchaseInvoice: TPurchaseInvoice read FPurchaseInvoice write
        FPurchaseInvoice;
    property PurchaseRetur: TPurchaseRetur read FPurchaseRetur write FPurchaseRetur;
    property TransDate: TDateTime read FTransDate write FTransDate;
    property TransType: Integer read FTransType write FTransType;
  end;

  TCashTransfer = class(TCRUDFinance)
  private
    FRekening: TRekening;
  protected
  public
    destructor Destroy; override;
    function GenerateNo: String; override;
    function GetHeaderFlag: Integer; override;
  published
    property Rekening: TRekening read FRekening write FRekening;
  end;

  TCashReceipt = class(TCRUDFinance)
  private
    FAccount: TAccount;
    FRekening: TRekening;
    FCustomer: TCustomer;
    FIs_DownPayment: Integer;
    FPaidAmount: Double;
  protected
  public
    destructor Destroy; override;
    function GenerateNo: String; override;
    function GetCodeTrans: string;
    function GetHeaderFlag: Integer; override;
    function IsDownPayment: Boolean;
    function Remain: Double;
    function UpdateRemain(aDate: TDateTime = 0; AddedPaidAmt: Double = 0): Boolean;
  published
    property Account: TAccount read FAccount write FAccount;
    property Rekening: TRekening read FRekening write FRekening;
    property Customer: TCustomer read FCustomer write FCustomer;
    property Is_DownPayment: Integer read FIs_DownPayment write FIs_DownPayment;
    property PaidAmount: Double read FPaidAmount write FPaidAmount;
  end;

  TCashPayment = class(TCRUDFinance)
  private
    FRekening: TRekening;
    FTahunZakat: Integer;
  protected
    function AfterSaveToDB: Boolean; override;
    function BeforeDeleteFromDB: Boolean; override;
    function BeforeSaveToDB: Boolean; override;
  public
    destructor Destroy; override;
    function GenerateNo: String; override;
    function GetHeaderFlag: Integer; override;
    function UpdateRemain(aIsRevert: Boolean = False): Boolean;
  published
    property Rekening: TRekening read FRekening write FRekening;
    property TahunZakat: Integer read FTahunZakat write FTahunZakat;
  end;

  TARSettlement = class(TCRUDFinance)
  private
    FReturAmount: Double;
    FCustomer: TCustomer;
    FCashReceipt: TCashReceipt;
  protected
    function AfterSaveToDB: Boolean; override;
    function BeforeDeleteFromDB: Boolean; override;
    function BeforeSaveToDB: Boolean; override;
  public
    destructor Destroy; override;
    function GetHeaderFlag: Integer; override;
    class function CreateOrGetFromRetur(aSalesRetur: TSalesRetur): TARSettlement;
    function GenerateNo: string; override;
    function UpdateRemain(aIsRevert: Boolean = False): Boolean;
    function UpdateRemainCR(aIsRevert: Boolean = False): Boolean;
  published
    property Customer: TCustomer read FCustomer write FCustomer;
    property CashReceipt: TCashReceipt read FCashReceipt write FCashReceipt;
    property ReturAmount: Double read FReturAmount write FReturAmount;
  end;


  TPurchasePayment = class(TCRUDFinance)
  private
    FMedia: Integer;
    FMediaNo: string;
    FPaymentFlag: Integer;
    FRekening: TRekening;
    FSupplier: TSupplier;
    FReturAmount: Double;
  protected
    function AfterSaveToDB: Boolean; override;
    function BeforeDeleteFromDB: Boolean; override;
    function BeforeSaveToDB: Boolean; override;
  public
    destructor Destroy; override;
    class function CreateOrGetFromInv(aPurchaseInv: TPurchaseInvoice):
        TPurchasePayment;
    class function CreateOrGetFromRetur(aPurchaseRetur: TPurchaseRetur):
        TPurchasePayment;
    function GenerateNo: String; override;
    function GetHeaderFlag: Integer; override;
    function UpdateRemain(aIsRevert: Boolean = False): Boolean;
  published
    property Media: Integer read FMedia write FMedia;
    property MediaNo: string read FMediaNo write FMediaNo;
    property PaymentFlag: Integer read FPaymentFlag write FPaymentFlag;
    property Rekening: TRekening read FRekening write FRekening;
    property Supplier: TSupplier read FSupplier write FSupplier;
    property ReturAmount: Double read FReturAmount write FReturAmount;
  end;


  TPurchaseInvoice = class(TCRUDFinance)
  private
    FSubTotal: Double;
    FPPN: Double;
    FSupplier: TSupplier;
    FInvItems: TObjectList<TPurchaseInvoiceItem>;
    FInvoiceNo: String;
    FPaidOff: Integer;
    FReferensi: string;
    FPaidAmount: Double;
    FPaidOffDate: TDatetime;
    FPaymentFlag: Integer;
    FRekening: TRekening;
    FReturAmount: Double;
    FStatus: Integer;
    function GetInvItems: TObjectList<TPurchaseInvoiceItem>;
  protected
    function AfterSaveToDB: Boolean; override;
    function BeforeDeleteFromDB: Boolean; override;
    function BeforeSaveToDB: Boolean; override;
    function GetRefno: String; override;
  public
    constructor Create;
    destructor Destroy; override;
    function GenerateNo: String; override;
    function GetHeaderFlag: Integer; override;
    function GetRemain: Double;
    function GetTotalBayar: Double;
    class procedure PrintData(aInvoiceID: Integer);
    function UpdateRemain(aDate: TDateTime = 0; AddedPaidAmt: Double = 0;
        AddedReturAmt: Double = 0): Boolean;
    property InvItems: TObjectList<TPurchaseInvoiceItem> read GetInvItems write
        FInvItems;
  published
    property SubTotal: Double read FSubTotal write FSubTotal;
    property PPN: Double read FPPN write FPPN;
    property Supplier: TSupplier read FSupplier write FSupplier;
    property InvoiceNo: String read FInvoiceNo write FInvoiceNo;
    property PaidOff: Integer read FPaidOff write FPaidOff;
    property Referensi: string read FReferensi write FReferensi;
    property PaidAmount: Double read FPaidAmount write FPaidAmount;
    property PaidOffDate: TDatetime read FPaidOffDate write FPaidOffDate;
    property PaymentFlag: Integer read FPaymentFlag write FPaymentFlag;
    property Rekening: TRekening read FRekening write FRekening;
    property ReturAmount: Double read FReturAmount write FReturAmount;
    property Status: Integer read FStatus write FStatus;
  end;

  TPurchaseRetur = class(TCRUDTransDetail)
  private
    FSubTotal: Double;
    FPPN: Double;
    FSupplier: TSupplier;
    FRefno: string;
    FAmount: Double;
    FPaidAmount: Double;
    FNotes: string;
    FReturFlag: Integer;
    FStatus: Integer;
    FInvoice: TPurchaseInvoice;
    FWarehouse: TWarehouse;
  protected
    function AfterSaveToDB: Boolean; override;
    function BeforeDeleteFromDB: Boolean; override;
    function BeforeSaveToDB: Boolean; override;
    function GetRefno: String; override;
  public
    destructor Destroy; override;
    procedure ClearInvoice;
    procedure ClearSupplier;
    function GenerateNo: String; override;
    function GetHeaderFlag: Integer; override;
    function GetRemain: Double;
    class procedure PrintData(aReturID: Integer);
    procedure SetGenerateNo; override;
    function UpdateRemain(AddedPaidAmt: Double = 0): Boolean;
  published
    property SubTotal: Double read FSubTotal write FSubTotal;
    property PPN: Double read FPPN write FPPN;
    property Supplier: TSupplier read FSupplier write FSupplier;
    [AttributeOfCode]
    property Refno: string read FRefno write FRefno;
    property Amount: Double read FAmount write FAmount;
    property PaidAmount: Double read FPaidAmount write FPaidAmount;
    property Notes: string read FNotes write FNotes;
    property ReturFlag: Integer read FReturFlag write FReturFlag;
    property Status: Integer read FStatus write FStatus;
    property Invoice: TPurchaseInvoice read FInvoice write FInvoice;
    property Warehouse: TWarehouse read FWarehouse write FWarehouse;
  end;

  TPurchaseInvoiceItem = class(TCRUDObject)
  private
    FDiscount: Double;
    FHarga: Double;
    FItem: TItem;
    FPPN: Double;
    FPurchaseReceive: TPurchaseReceive;
    FPurchaseInvoice: TPurchaseInvoice;
    FQty: Double;
    FKonversi: Double;
    FTotal: Double;
    FTransDetail_ID: Integer;
    FUOM: TUOM;
  published
    property Discount: Double read FDiscount write FDiscount;
    property Harga: Double read FHarga write FHarga;
    property Item: TItem read FItem write FItem;
    property PPN: Double read FPPN write FPPN;
    property PurchaseReceive: TPurchaseReceive read FPurchaseReceive write
        FPurchaseReceive;
    [AttributeOfHeader]
    property PurchaseInvoice: TPurchaseInvoice read FPurchaseInvoice write
        FPurchaseInvoice;
    property Qty: Double read FQty write FQty;
    property Konversi: Double read FKonversi write FKonversi;
    property Total: Double read FTotal write FTotal;
    property TransDetail_ID: Integer read FTransDetail_ID write FTransDetail_ID;
    property UOM: TUOM read FUOM write FUOM;
  end;


  TSalesInvoiceItem = class(TCRUDObject)
  private
    FDiscount: Double;
    FHarga: Double;
    FItem: TItem;
    FPPN: Double;
    FDeliveryOrder: TDeliveryOrder;
    FHargaAvg: Double;
    FLastCost: Double;
    FSalesInvoice: TSalesInvoice;
    FQty: Double;
    FKonversi: Double;
    FTransDetail_ID: Integer;
    FTotal: Double;
    FUOM: TUOM;
  published
    property Discount: Double read FDiscount write FDiscount;
    property Harga: Double read FHarga write FHarga;
    property Item: TItem read FItem write FItem;
    property PPN: Double read FPPN write FPPN;
    property DeliveryOrder: TDeliveryOrder read FDeliveryOrder write FDeliveryOrder;
    property HargaAvg: Double read FHargaAvg write FHargaAvg;
    property LastCost: Double read FLastCost write FLastCost;
    [AttributeOfHeader]
    property SalesInvoice: TSalesInvoice read FSalesInvoice write FSalesInvoice;
    property Qty: Double read FQty write FQty;
    property Konversi: Double read FKonversi write FKonversi;
    property TransDetail_ID: Integer read FTransDetail_ID write FTransDetail_ID;
    property Total: Double read FTotal write FTotal;
    property UOM: TUOM read FUOM write FUOM;
  end;


  TSalesInvoice = class(TCRUDFinance)
  private
    FSubTotal: Double;
    FPPN: Double;
    FCustomer: TCustomer;
    FInvItems: TObjectList<TSalesInvoiceItem>;
    FInvoiceNo: String;
    FSalesman: TSalesman;
    FPaidOff: Integer;
    FPaidAmount: Double;
    FPaidOffDate: TDatetime;
    FPaymentFlag: Integer;
    FRekening: TRekening;
    FReturAmount: Double;
    FStatus: Integer;
    function GetInvItems: TObjectList<TSalesInvoiceItem>;
    function UpdateHargaDO: Boolean;
  protected
    function AfterSaveToDB: Boolean; override;
    function BeforeDeleteFromDB: Boolean; override;
    function BeforeSaveToDB: Boolean; override;
    function GetRefno: String; override;
    function LogLevel: Integer; override;
  public
    constructor Create;
    destructor Destroy; override;
    function GenerateNo: String; override;
    function GetHeaderFlag: Integer; override;
    function GetRemain: Double;
    function GetTotalBayar: Double;
    class procedure PrintData(aInvoiceID: Integer);
    function UpdateRemain(aDate: TDateTime = 0; AddedPaidAmt: Double = 0;
        AddedReturAmt: Double = 0): Boolean;
    property InvItems: TObjectList<TSalesInvoiceItem> read GetInvItems write
        FInvItems;
  published
    property SubTotal: Double read FSubTotal write FSubTotal;
    property PPN: Double read FPPN write FPPN;
    property Customer: TCustomer read FCustomer write FCustomer;
    property InvoiceNo: String read FInvoiceNo write FInvoiceNo;
    property Salesman: TSalesman read FSalesman write FSalesman;
    property PaidOff: Integer read FPaidOff write FPaidOff;
    property PaidAmount: Double read FPaidAmount write FPaidAmount;
    property PaidOffDate: TDatetime read FPaidOffDate write FPaidOffDate;
    property PaymentFlag: Integer read FPaymentFlag write FPaymentFlag;
    property Rekening: TRekening read FRekening write FRekening;
    property ReturAmount: Double read FReturAmount write FReturAmount;
    property Status: Integer read FStatus write FStatus;
  end;


  TSalesRetur = class(TCRUDTransDetail)
  private
    FAmount: Double;
    FPaidAmount: Double;
    FInvoice: TSalesInvoice;
    FNotes: string;
    FPPN: Double;
    FRefno: string;
    FReturFlag: Integer;
    FStatus: Integer;
    FSubTotal: Double;
    FCustomer: TCustomer;
    FSalesman: TSalesman;
    FWarehouse: TWarehouse;
  protected
    function AfterSaveToDB: Boolean; override;
    function BeforeDeleteFromDB: Boolean; override;
    function BeforeSaveToDB: Boolean; override;
    function GetRefno: String; override;
  public
    procedure ClearInvoice;
    procedure ClearCustomer;
    function GenerateNo: String; override;
    function GetHeaderFlag: Integer; override;
    function GetRemain: Double;
    class procedure PrintData(aReturID: Integer);
    procedure SetGenerateNo; override;
    function UpdateRemain(AddedPaidAmt: Double = 0): Boolean;
  published
    property Amount: Double read FAmount write FAmount;
    property PaidAmount: Double read FPaidAmount write FPaidAmount;
    property Invoice: TSalesInvoice read FInvoice write FInvoice;
    property Notes: string read FNotes write FNotes;
    property PPN: Double read FPPN write FPPN;
    [AttributeOfCode]
    property Refno: string read FRefno write FRefno;
    property ReturFlag: Integer read FReturFlag write FReturFlag;
    property Status: Integer read FStatus write FStatus;
    property SubTotal: Double read FSubTotal write FSubTotal;
    property Customer: TCustomer read FCustomer write FCustomer;
    property Salesman: TSalesman read FSalesman write FSalesman;
    property Warehouse: TWarehouse read FWarehouse write FWarehouse;
  end;



const
  HeaderFlag_PurchaseInvoice : Integer = 100;
  HeaderFlag_PurchasePayment : Integer = 110;

  HeaderFlag_SalesInvoice : Integer = 200;
  HeaderFlag_ARSettlement : Integer = 210;

  HeaderFlag_CashTransfer : Integer = 300;
  HeaderFlag_CashReceipt : Integer = 400;
  HeaderFlag_CashPayment : Integer = 500;

  Media_Cash : Integer = 0;
  Media_Tranfer : Integer = 1;
  Media_Cek : Integer = 2;


  PaymentFlag_Cash  : Integer = 0;
  PaymentFlag_Credit : Integer = 1;

implementation

uses
  System.StrUtils, System.Classes, uAppUtils, System.DateUtils,
  FireDAC.Comp.Client;

destructor TCRUDFinance.Destroy;
begin
  inherited;
  if FItems <> nil then FItems.Free;
end;

function TCRUDFinance.GetItems: TObjectList<TFinancialTransaction>;
begin
  if FItems = nil then
  begin
    FItems := TObjectList<TFinancialTransaction>.Create();
  end;
  Result := FItems;
end;

function TCRUDFinance.GetRefno: String;
begin
  Result := Refno;
end;

procedure TCRUDFinance.PrepareDetailObject(AObjItem: TCRUDObject);
begin
  if AObjItem is TFinancialTransaction then
  begin
    TFinancialTransaction(AObjItem).Header_Flag := GetHeaderFlag;
    TFinancialTransaction(AObjItem).TransDate := TransDate;
    TFinancialTransaction(AObjItem).Refno := GetRefno;
  end;

//  if AObjItem is TAvgCostUpdate then
//  begin
//    TAvgCostUpdate(AObjItem).Header_Flag  := GetHeaderFlag;
//  end;
end;

function TCRUDFinance.SaveRepeat(aRepeatCount: Integer = 2; DoShowMsg: Boolean
    = True): Boolean;
var
  iRepeat: Integer;
begin
  Result := False;

  if Self.ID > 0 then
  begin
    Result := Self.SaveToDB();
    exit;
  end else
  begin
    //hanya berlaku utk baru
    iRepeat := 0;
    while iRepeat <= aRepeatCount do
    begin
      Try
        Self.RefNo := GenerateNo;
        inc(iRepeat);
        Result := Self.SaveToDB();

        if Result then
        begin
          if DoShowMsg then
            TAppUtils.Information('Data Berhasil Disimpan dengan nomor bukti : ' + Self.GetRefno);
        end else
        begin
          TAppUtils.Error('SaveToDB Result = False without exception ???');
        end;

        exit; //sukses or error without exception we must exist
      except
        on E:Exception do
        begin
          if Pos('unique key', LowerCase(E.Message)) > 0 then
          begin
            if (iRepeat > aRepeatCount) or (not TAppUtils.Confirm('Terdeteksi Ada Nomor Bukti sudah terpakai, Otomatis Generate Baru dan Simpan?'
              + #13 +'Percobaan Simpan ke : ' + IntToStr(iRepeat)
              + #13#13 +'Pesan Error : '
              + #13 + E.Message
            ))
            then
            begin
              E.Message := 'Gagal Mengulang Simpan ke- ' + IntToStr(iRepeat-1) + #13 + E.Message;
              raise;
            end;
          end else
            Raise;
        end;
      End;
    end;
  end;
end;

destructor TFinancialTransaction.Destroy;
begin
  inherited;
  if FRekening <> nil then FreeAndNil(FRekening);
  if FAccount <> nil then FreeAndNil(FAccount);
  if FSalesInvoice <> nil then FreeAndNil(FSalesInvoice);
  if FSalesRetur <> nil then FreeAndNil(FSalesRetur);
  if FPurchaseInvoice <> nil then FreeAndNil(FPurchaseInvoice);
  if FPurchaseRetur <> nil then FreeAndNil(FPurchaseRetur);
end;

function TFinancialTransaction.GetSQLDeleteDetails(Header_ID: Integer): String;
var
  sFilter : String;
begin
//  if UpperCase(Self.GetTableName) = 'TFinancialTransaction' then
//    Raise Exception.Create('Must override GetSQLDeleteDetails for TFinancialTransaction');

  sFilter := 'Header_flag = ' + IntToStr(Header_Flag)
    +' AND Header_ID = ' + IntToStr(Header_ID);

  Result  := Format(SQL_Delete,[Self.GetTableName,sFilter]);
end;

function TFinancialTransaction.GetSQLRetrieveDetails(Header_ID: Integer): String;
var
//  lPO: TCRUDPOItem;
  sFilter : String;
begin
//  if UpperCase(Self.GetTableName) = 'TFinancialTransaction' then
//    Raise Exception.Create('Must override GetSQLRetrieveDetails for TFinancialTransaction');

  sFilter := 'Header_flag = ' + IntToStr(Header_Flag)
    +' And Header_ID = ' + IntToStr(Header_ID);
  Result  := Format(SQL_Select,['*', Self.GetTableName,sFilter]);
//
//  lPO := TCRUDPOItem.Create;
//  Result := Result + lPO.GetHeaderField;
end;

function TFinancialTransaction.HasRetur: Boolean;
begin
  Result :=  False;
  if FSalesRetur <> nil then
    Result := FSalesRetur.ID > 0;
end;

procedure TFinancialTransaction.SetToDebet;
begin
  Self.DebetAmt := Self.Amount;
  Self.CreditAmt := 0;
end;

procedure TFinancialTransaction.SetToCredit;
begin
  Self.DebetAmt   := 0;
  Self.CreditAmt  := Self.CreditAmt;
end;

destructor TCashPayment.Destroy;
begin
  inherited;
//  if FFeeItems <> nil then FreeAndNil(FFeeItems);
//  if Frekening <> nil then FreeAndNil(Frekening);
end;

function TCashPayment.AfterSaveToDB: Boolean;
begin
  Result := Self.UpdateRemain;
end;

function TCashPayment.BeforeDeleteFromDB: Boolean;
begin
  Result := Self.UpdateRemain(True);
end;

function TCashPayment.BeforeSaveToDB: Boolean;
var
  lOldPayment: TCashPayment;
begin
  Result := True;
  if Self.ID = 0 then exit;

  lOldPayment := TCashPayment.Create;
  Try
    lOldPayment.LoadByID(Self.ID);

    lOldPayment.UpdateRemain(True);
  Finally
    lOldPayment.Free;
  End;

//  Result := Self.UpdateFee(True);
//  if Result then
//    Result := Self.UpdateRemain(True);
end;

function TCashPayment.GenerateNo: String;
var
  aDigitCount: Integer;
  aPrefix: string;
  lNum: Integer;
  S: string;
begin
  lNum := 0;
  aDigitCount := 5;
  aPrefix := Cabang + '.KK' + FormatDateTime('yymm',Now()) + '.';

  if Self.TahunZakat > 2000 then
    aPrefix := Cabang + '.ZKT' + FormatDateTime('yymm',Now()) + '.';


  S := 'SELECT MAX(RefNo) FROM TCashPayment where Refno LIKE ' + QuotedStr(aPrefix + '%');

  with TDBUtils.OpenQuery(S) do
  begin
    Try
      if not eof then
        TryStrToInt(RightStr(Fields[0].AsString, aDigitCount), lNum);
    Finally
      Free;
    End;
  end;

  inc(lNum);
  Result := aPrefix + RightStr('00000' + IntToStr(lNum), aDigitCount);
end;

function TCashPayment.GetHeaderFlag: Integer;
begin
  Result := HeaderFlag_CashPayment;
end;

function TCashPayment.UpdateRemain(aIsRevert: Boolean = False): Boolean;
var
  lItem: TFinancialTransaction;
  iFactor: Integer;
begin
  Result := True;
  iFactor := 1;
  if aIsRevert then iFactor := -1;

  for lItem in Self.Items do
  begin
    if lItem.HasRetur then
    begin
      lItem.SalesRetur.ReLoad(False);
      lItem.SalesRetur.UpdateRemain(iFactor*lItem.ReturAmt);
    end;
  end;
end;

destructor TCashReceipt.Destroy;
begin
  inherited;
  if FCustomer <> nil then FreeAndNil(FCustomer);
  if FAccount <> nil then FreeAndNil(FAccount);
  if FRekening <> nil then FreeAndNil(FRekening);
end;

function TCashReceipt.GenerateNo: String;
var
  aDigitCount: Integer;
  aPrefix: string;
  lNum: Integer;
  S: string;
begin
  lNum := 0;
  aDigitCount := 5;
  aPrefix := Cabang + '.'+ GetCodeTrans + FormatDateTime('yymm',Now()) + '.';


  S := 'SELECT MAX(Refno) FROM TCashReceipt where Refno LIKE ' + QuotedStr(aPrefix + '%');

  with TDBUtils.OpenQuery(S) do
  begin
    Try
      if not eof then
        TryStrToInt(RightStr(Fields[0].AsString, aDigitCount), lNum);
    Finally
      Free;
    End;
  end;

  inc(lNum);
  Result := aPrefix + RightStr('00000' + IntToStr(lNum), aDigitCount);
end;

function TCashReceipt.GetHeaderFlag: Integer;
begin
  Result := HeaderFlag_CashReceipt;
end;

function TCashReceipt.GetCodeTrans: string;
begin
  Result := 'KM';

  if Self.IsDownPayment then
    Result := 'DP';

  // TODO -cMM: TCashReceipt.GetCodeTrans default body inserted
end;

function TCashReceipt.IsDownPayment: Boolean;
begin
  Result := Self.Is_DownPayment = 1;
end;

function TCashReceipt.Remain: Double;
begin
  Result := Amount-PaidAmount;
  // TODO -cMM: TCashReceipt.Remain default body inserted
end;

function TCashReceipt.UpdateRemain(aDate: TDateTime = 0; AddedPaidAmt: Double =
    0): Boolean;
var
  S: string;
begin
  if aDate = 0 then aDate := Now();

  Self.PaidAmount := Self.PaidAmount + AddedPaidAmt;   //utk update / revert remain dari collection

  S := 'Update TCashReceipt set PaidAmount = ' + FloatToStr(Self.PaidAmount);

  if (Self.Amount - Self.PaidAmount) <=  AppVariable.Toleransi_Piutang then
    S := S + ',PaidOff = 1, PaidOffDate = ' + TAppUtils.QuotD(aDate)
  else
    S := S + ',PaidOff = 0, PaidOffDate = NULL';


  S := S + ' where id = ' + IntToStr(Self.ID);

  Result := TDBUtils.ExecuteSQL(S, False);
end;

destructor TCashTransfer.Destroy;
begin
  inherited;
//  if FSupplier <> nil then FreeAndNil(FSupplier);
end;

function TCashTransfer.GenerateNo: String;
var
  aDigitCount: Integer;
  aPrefix: string;
  lNum: Integer;
  S: string;
begin
  lNum := 0;
  aDigitCount := 5;
  aPrefix := Cabang + '.TK' + FormatDateTime('yymm',Now()) + '.';


  S := 'SELECT MAX(Refno) FROM TCashTransfer where Refno LIKE ' + QuotedStr(aPrefix + '%');

  with TDBUtils.OpenQuery(S) do
  begin
    Try
      if not eof then
        TryStrToInt(RightStr(Fields[0].AsString, aDigitCount), lNum);
    Finally
      Free;
    End;
  end;

  inc(lNum);
  Result := aPrefix + RightStr('00000' + IntToStr(lNum), aDigitCount);
end;

function TCashTransfer.GetHeaderFlag: Integer;
begin
  Result := HeaderFlag_CashTransfer;
end;

destructor TARSettlement.Destroy;
begin
  inherited;
  if FCashReceipt <> nil then FreeAndNil(FCashReceipt);
end;

function TARSettlement.AfterSaveToDB: Boolean;
begin
  Result := Self.UpdateRemain;
end;

function TARSettlement.BeforeDeleteFromDB: Boolean;
begin
  Result := Self.UpdateRemain(True);
end;

function TARSettlement.BeforeSaveToDB: Boolean;
var
  lOldPayment: TARSettlement;
begin
  Result := True;
  if Self.ID = 0 then exit;

  lOldPayment := TARSettlement.Create;
  Try
    lOldPayment.LoadByID(Self.ID);
    lOldPayment.UpdateRemain(True);
  Finally
    lOldPayment.Free;
  End;
end;

class function TARSettlement.CreateOrGetFromRetur(aSalesRetur: TSalesRetur):
    TARSettlement;
var
  lItem: TFinancialTransaction;
begin
  if aSalesRetur.ReturFlag <> ReturFlag_Cancel then
  begin
    raise Exception.Create('Hanya Retur Batal yang bisa dipotong langsung');
  end;

  if aSalesRetur.Invoice = nil then
  begin
    raise Exception.Create('[TARSettlement.CreateOrGetFromRetur] PurchaseRetur.Invoice = nil');
  end;

//  if aSalesRetur.Rekening = nil then
//    raise Exception.Create('aSalesRetur.Rekening = nil');
  Result := TARSettlement.Create;

  //load from inv
  Result.LoadByCode(aSalesRetur.Refno);
  Result.Refno            := aSalesRetur.Refno;
  Result.TransDate        := aSalesRetur.TransDate;
  Result.DueDate          := Result.TransDate;
  Result.Amount           := 0;
  Result.ReturAmount      := aSalesRetur.Amount;
  Result.Items.Clear;

  //credit piutang
  lItem                   := TFinancialTransaction.Create;
  lItem.SalesInvoice      := TSalesInvoice.CreateID(aSalesRetur.Invoice.ID);
  lItem.DebetAmt          := 0;
  lItem.Amount            := 0;
  lItem.ReturAmt          := aSalesRetur.Amount;
  lItem.SalesRetur        := TSalesRetur.CreateID(aSalesRetur.ID);
  lItem.TransDate         := aSalesRetur.TransDate;
  lItem.Notes             := 'Retur Batal No : ' + aSalesRetur.Refno;
  Result.Items.Add(lItem);

  //debet retur penjualan : tidak perlu
end;

function TARSettlement.GenerateNo: string;
var
  aDigitCount: Integer;
  aPrefix: string;
  lNum: Integer;
  S: string;
begin
  lNum := 0;
  aDigitCount := 5;
  aPrefix := Cabang + '.SP' + FormatDateTime('yymm',Now()) + '.';


  S := 'SELECT MAX(Refno) FROM TARSettlement where Refno LIKE ' + QuotedStr(aPrefix + '%');

  with TDBUtils.OpenQuery(S) do
  begin
    Try
      if not eof then
        TryStrToInt(RightStr(Fields[0].AsString, aDigitCount), lNum);
    Finally
      Free;
    End;
  end;

  inc(lNum);
  Result := aPrefix + RightStr('00000' + IntToStr(lNum), aDigitCount);
end;

function TARSettlement.GetHeaderFlag: Integer;
begin
  Result := HeaderFlag_ARSettlement;
end;

function TARSettlement.UpdateRemain(aIsRevert: Boolean = False): Boolean;
var
  lItem: TFinancialTransaction;
  iFactor: Integer;
begin
  Result := True;
  iFactor := 1;
  if aIsRevert then iFactor := -1;

  for lItem in Self.Items do
  begin
    if lItem.SalesInvoice <> nil then
    begin
      if lItem.SalesInvoice.ID <> 0 then
      begin
        lItem.SalesInvoice.ReLoad(False);
        lItem.SalesInvoice.UpdateRemain(self.TransDate, iFactor*lItem.Amount, iFactor*lItem.ReturAmt);
      end;
    end;


    if lItem.SalesRetur <> nil then
    begin
      if lItem.SalesRetur.ID <> 0 then
      begin
        lItem.SalesRetur.ReLoad(False);
        lItem.SalesRetur.UpdateRemain(iFactor*lItem.ReturAmt);
      end;
    end;
  end;

  Self.UpdateRemainCR(aIsRevert);
end;

function TARSettlement.UpdateRemainCR(aIsRevert: Boolean = False): Boolean;
var
  lItem: TFinancialTransaction;
  iFactor: Integer;
begin
  Result := True;
  iFactor := 1;
  if aIsRevert then iFactor := -1;

  if Self.CashReceipt<>nil then
  begin
    Self.CashReceipt.UpdateRemain(self.TransDate, iFactor*Self.Amount);
  end;
end;

destructor TPurchasePayment.Destroy;
begin
  inherited;
//  if FSupplier <> nil then FreeAndNil(FSupplier);
end;

function TPurchasePayment.AfterSaveToDB: Boolean;
begin
  Result := Self.UpdateRemain;
end;

function TPurchasePayment.BeforeDeleteFromDB: Boolean;
begin
  Result := Self.UpdateRemain(True);
end;

function TPurchasePayment.BeforeSaveToDB: Boolean;
var
  lOldPurchase: TPurchasePayment;
begin
  Result := True;
  if Self.ID = 0 then exit;

  lOldPurchase := TPurchasePayment.Create;
  Try
    lOldPurchase.LoadByID(Self.ID);
    lOldPurchase.UpdateRemain(True);
  Finally
    lOldPurchase.Free;
  End;
end;

class function TPurchasePayment.CreateOrGetFromInv(aPurchaseInv:
    TPurchaseInvoice): TPurchasePayment;
var
  lItem: TFinancialTransaction;
begin
  if aPurchaseInv.Rekening = nil then
    raise Exception.Create('aPurchaseInv.Rekening = nil');

  Result := TPurchasePayment.Create;

  //load from inv
  Result.LoadByCode(aPurchaseInv.InvoiceNo);
  Result.Refno            := aPurchaseInv.InvoiceNo;
  Result.TransDate        := aPurchaseInv.TransDate;
  Result.DueDate          := Result.TransDate;
  Result.Amount           := aPurchaseInv.Amount;
  Result.PaymentFlag      := PaymentFlag_Cash;
  Result.ReturAmount      := 0;
  Result.Rekening         := TRekening.CreateID(aPurchaseInv.Rekening.ID);

  if aPurchaseInv.Supplier <> nil then
  begin
    if Result.Supplier = nil then Result.Supplier := TSupplier.Create;
    Result.Supplier.ID    := aPurchaseInv.Supplier.ID;
  end;

  Result.Items.Clear;

  //debet hutang
  lItem                   := TFinancialTransaction.Create;
  lItem.PurchaseInvoice   := TPurchaseInvoice.CreateID(aPurchaseInv.ID);
  lItem.DebetAmt          := aPurchaseInv.Amount;
  lItem.Amount            := lItem.DebetAmt;
  lItem.TransDate         := aPurchaseInv.TransDate;
  lItem.Notes             := 'Pembelian Cash No : ' + aPurchaseInv.InvoiceNo;
  lItem.TransType         := Result.PaymentFlag;
  Result.Items.Add(lItem);

  //credit cash out
  lItem                   := TFinancialTransaction.Create;
  lItem.Rekening          := TRekening.CreateID(aPurchaseInv.Rekening.ID);
  lItem.CreditAmt         := aPurchaseInv.Amount;
  lItem.Amount            := lItem.CreditAmt;
  lItem.TransDate         := aPurchaseInv.TransDate;
  lItem.Notes             := 'Pembelian Cash No : ' + aPurchaseInv.InvoiceNo;
  lItem.TransType         := Result.PaymentFlag;
  Result.Items.Add(lItem);
  Result.ModifiedBy       := UserLogin;
  Result.ModifiedDate     := Now();
end;

class function TPurchasePayment.CreateOrGetFromRetur(aPurchaseRetur:
    TPurchaseRetur): TPurchasePayment;
var
  lItem: TFinancialTransaction;
begin
  if aPurchaseRetur.ReturFlag <> ReturFlag_Cancel then
  begin
    raise Exception.Create('Hanya Retur Batalyang bisa dipotong langsung');
  end;

  if aPurchaseRetur.Invoice = nil then
  begin
    raise Exception.Create('[TPurchasePayment.CreateOrGetFromRetur] PurchaseRetur.Invoice = nil');
  end;

//  if aPurchaseRetur.Rekening = nil then
//    raise Exception.Create('aPurchaseRetur.Rekening = nil');
  Result := TPurchasePayment.Create;

  //load from inv
  Result.LoadByCode(aPurchaseRetur.Refno);
  Result.Refno            := aPurchaseRetur.Refno;
  Result.TransDate        := aPurchaseRetur.TransDate;
  Result.DueDate          := Result.TransDate;
  Result.Amount           := 0;
  Result.PaymentFlag      := PaymentFlag_Cash;
  Result.ReturAmount      := aPurchaseRetur.Amount;

  if aPurchaseRetur.Supplier <> nil then
  begin
    if Result.Supplier = nil then Result.Supplier := TSupplier.Create;
    Result.Supplier.ID    := aPurchaseRetur.Supplier.ID;
  end;


  Result.Items.Clear;

  //debet hutang
  lItem                   := TFinancialTransaction.Create;
  lItem.PurchaseInvoice   := TPurchaseInvoice.CreateID(aPurchaseRetur.Invoice.ID);
  lItem.DebetAmt          := 0;
  lItem.Amount            := 0;
  lItem.ReturAmt          := aPurchaseRetur.Amount;
  lItem.PurchaseRetur     := TPurchaseRetur.CreateID(aPurchaseRetur.ID);
  lItem.TransDate         := aPurchaseRetur.TransDate;
  lItem.Notes             := 'Retur Batal No : ' + aPurchaseRetur.Refno;
  lItem.TransType         := Result.PaymentFlag;
  Result.Items.Add(lItem);

  //credit retur penjualan : tidak perlu
end;

function TPurchasePayment.GenerateNo: String;
var
  aDigitCount: Integer;
  aPrefix: string;
  lNum: Integer;
  S: string;
begin
  lNum := 0;
  aDigitCount := 5;
  aPrefix := Cabang + '.PP' + FormatDateTime('yymm',Now()) + '.';


  S := 'SELECT MAX(Refno) FROM TPurchasePayment where Refno LIKE ' + QuotedStr(aPrefix + '%');

  with TDBUtils.OpenQuery(S) do
  begin
    Try
      if not eof then
        TryStrToInt(RightStr(Fields[0].AsString, aDigitCount), lNum);
    Finally
      Free;
    End;
  end;

  inc(lNum);
  Result := aPrefix + RightStr('00000' + IntToStr(lNum), aDigitCount);
end;

function TPurchasePayment.GetHeaderFlag: Integer;
begin
  Result := HeaderFlag_PurchasePayment;
end;

function TPurchasePayment.UpdateRemain(aIsRevert: Boolean = False): Boolean;
var
  lItem: TFinancialTransaction;
  iFactor: Integer;
begin
  Result := True;
  iFactor := 1;
  if aIsRevert then iFactor := -1;

  for lItem in Self.Items do
  begin
    if lItem.PurchaseInvoice <> nil then
    begin
      if lItem.PurchaseInvoice.ID <> 0 then
      begin
        lItem.PurchaseInvoice.ReLoad(False);
        lItem.PurchaseInvoice.UpdateRemain(self.TransDate, iFactor*lItem.Amount, iFactor*lItem.ReturAmt);
      end;
    end;


    if lItem.PurchaseRetur <> nil then
    begin
      if lItem.PurchaseRetur.ID <> 0 then
      begin
        lItem.PurchaseRetur.ReLoad(False);
        lItem.PurchaseRetur.UpdateRemain(iFactor*lItem.ReturAmt);
      end;
    end;
  end;
end;

constructor TPurchaseInvoice.Create;
begin
  inherited;
  Self.PaidOff := 0;
end;

destructor TPurchaseInvoice.Destroy;
begin
  inherited;
  if FSupplier <> nil then FreeAndNil(FSupplier);
  if FInvItems <> nil then FreeAndNil(FInvItems);
end;

function TPurchaseInvoice.AfterSaveToDB: Boolean;
var
  lPurchasePayment: TPurchasePayment;
begin
  //update avg
  if Self.PaymentFlag = PaymentFlag_Cash then
  begin
    lPurchasePayment := TPurchasePayment.CreateOrGetFromInv(Self);
    Result := lPurchasePayment.SaveToDB(False);
  end else
    Result := True;
end;

function TPurchaseInvoice.BeforeDeleteFromDB: Boolean;
var
  lPurchasePayment: TPurchasePayment;
begin


  Result := True;
  lPurchasePayment := TPurchasePayment.Create;
  Try
    if lPurchasePayment.LoadByCode(Self.InvoiceNo) then
      Result := lPurchasePayment.DeleteFromDB(False);
  Finally
    lPurchasePayment.Free;
  End;

//  Result := True;
end;

function TPurchaseInvoice.BeforeSaveToDB: Boolean;
var
  lPurchasePayment: TPurchasePayment;
begin
  Result := True;

//  if Self.PaymentFlag = PaymentFlag_Cash then
  if Self.ID = 0 then  exit;

  Self.PaidAmount   := 0; //reset , value ini hanya boleh diupdate di method UpdateRemain
  Self.ReturAmount  := 0;
  Self.PaidOff      := 0;
  Self.PaidOffDate  := 0;

  //hanya edit
  lPurchasePayment :=  TPurchasePayment.Create;
  Try
    if lPurchasePayment.LoadByCode(Self.InvoiceNo) then
      Result := lPurchasePayment.DeleteFromDB(False);
  Finally
    lPurchasePayment.Free;
  End;
end;

function TPurchaseInvoice.GenerateNo: String;
var
  aDigitCount: Integer;
  aPrefix: string;
  lNum: Integer;
  S: string;
begin
  lNum := 0;
  aDigitCount := 5;
  aPrefix := Cabang + '.FB' + FormatDateTime('yymm',Now()) + '.';


  S := 'SELECT MAX(InvoiceNo) FROM TPurchaseInvoice where InvoiceNo LIKE ' + QuotedStr(aPrefix + '%');

  with TDBUtils.OpenQuery(S) do
  begin
    Try
      if not eof then
        TryStrToInt(RightStr(Fields[0].AsString, aDigitCount), lNum);
    Finally
      Free;
    End;
  end;

  inc(lNum);
  Result := aPrefix + RightStr('00000' + IntToStr(lNum), aDigitCount);
end;

function TPurchaseInvoice.GetInvItems: TObjectList<TPurchaseInvoiceItem>;
begin
  if FInvItems = nil then
  begin
    FInvItems := TObjectList<TPurchaseInvoiceItem>.Create();
  end;
  Result := FInvItems;
end;

function TPurchaseInvoice.GetHeaderFlag: Integer;
begin
  Result := HeaderFlag_PurchaseInvoice;
end;

function TPurchaseInvoice.GetRefno: String;
begin
  Result := InvoiceNO;
end;

function TPurchaseInvoice.GetRemain: Double;
begin
  Result := Self.Amount - Self.PaidAmount - Self.ReturAmount;
end;

function TPurchaseInvoice.GetTotalBayar: Double;
begin
  Result := Self.PaidAmount + Self.ReturAmount;
end;

class procedure TPurchaseInvoice.PrintData(aInvoiceID: Integer);
var
  S: string;
begin
  S := 'SELECT * FROM FN_SLIP_PURCHASEINVOICE(' + IntToStr(aInvoiceID) + ')';
  DMReport.ExecuteReport('SlipPurchaseInvoice', S);
end;


function TPurchaseInvoice.UpdateRemain(aDate: TDateTime = 0; AddedPaidAmt:
    Double = 0; AddedReturAmt: Double = 0): Boolean;
var
  S: string;
begin
  if aDate = 0 then aDate := Now();

  Self.PaidAmount := Self.PaidAmount + AddedPaidAmt;   //utk update / revert remain dari collection
  Self.ReturAmount := Self.ReturAmount + AddedReturAmt;

  S := 'Update TPurchaseInvoice set PaidAmount = ' + FloatToStr(Self.PaidAmount)
  + ', ReturAmount = ' + FloatToSTr(Self.ReturAmount);

  if (Self.Amount - Self.GetTotalBayar) <=  AppVariable.Toleransi_Piutang then
    S := S + ',PaidOff = 1, PaidOffDate = ' + TAppUtils.QuotD(aDate)
  else
    S := S + ',PaidOff = 0, PaidOffDate = NULL';


  S := S + ' where id = ' + IntToStr(Self.ID);

  Result := TDBUtils.ExecuteSQL(S, False);
end;

destructor TPurchaseRetur.Destroy;
begin
  inherited;
  if FSupplier <> nil then FreeAndNil(FSupplier);
  if FInvoice <> nil then FreeAndNil(FInvoice);
end;

function TPurchaseRetur.AfterSaveToDB: Boolean;
var
  lPurchasePayment: TPurchasePayment;
begin
//  Result := UpdateReturAmt(False);
//  if not Result then exit;

  if Self.ReturFlag = ReturFlag_Cancel then
  begin
    lPurchasePayment := TPurchasePayment.CreateOrGetFromRetur(Self);
    Result := lPurchasePayment.SaveToDB(False);
  end else
    Result := True;
end;

function TPurchaseRetur.BeforeDeleteFromDB: Boolean;
var
  lPurchasePayment: TPurchasePayment;
begin
  Result := True;

  lPurchasePayment := TPurchasePayment.Create;
  Try
    if lPurchasePayment.LoadByCode(Self.Refno) then
      Result := lPurchasePayment.DeleteFromDB(False);
  Finally
    lPurchasePayment.Free;
  End;

//  Result := True;
end;

function TPurchaseRetur.BeforeSaveToDB: Boolean;
var
  litem: TTransDetail;
  lPurchasePayment: TPurchasePayment;
begin
  Result := True;
  for lItem in Self.Items do
    lItem.SetAvgCost;

  if Self.ID = 0 then  exit;

  Self.PaidAmount   := 0; //reset , value ini hanya boleh diupdate di method UpdateRemain

  lPurchasePayment := TPurchasePayment.Create;
  Try
    if lPurchasePayment.LoadByCode(Self.Refno) then
      Result := lPurchasePayment.DeleteFromDB(False);
  Finally
    lPurchasePayment.Free;
  End;
end;

procedure TPurchaseRetur.ClearInvoice;
begin
  FreeAndNil(FInvoice);
end;

procedure TPurchaseRetur.ClearSupplier;
begin
  FreeAndNil(FSupplier);
end;

function TPurchaseRetur.GenerateNo: String;
var
  aDigitCount: Integer;
  aPrefix: string;
  lNum: Integer;
  S: string;
begin
  lNum := 0;
  aDigitCount := 5;
  aPrefix := Cabang + '.RB' + FormatDateTime('yymm',Now()) + '.';


  S := 'SELECT MAX(Refno) FROM TPurchaseRetur where Refno LIKE ' + QuotedStr(aPrefix + '%');

  with TDBUtils.OpenQuery(S) do
  begin
    Try
      if not eof then
        TryStrToInt(RightStr(Fields[0].AsString, aDigitCount), lNum);
    Finally
      Free;
    End;
  end;

  inc(lNum);
  Result := aPrefix + RightStr('00000' + IntToStr(lNum), aDigitCount);
end;

function TPurchaseRetur.GetHeaderFlag: Integer;
begin
  Result := HeaderFlag_PurchaseRetur;
end;

function TPurchaseRetur.GetRefno: String;
begin
  Result := Refno;
end;

function TPurchaseRetur.GetRemain: Double;
begin
  Result := Self.Amount - Self.PaidAmount;
end;

class procedure TPurchaseRetur.PrintData(aReturID: Integer);
var
  S: string;
begin
  S := 'SELECT * FROM FN_SLIP_PURCHASERETUR(' + IntToStr(aReturID) + ')';
  DMReport.ExecuteReport('SlipPurchaseRetur', S);
end;

procedure TPurchaseRetur.SetGenerateNo;
begin
  if Self.ID = 0 then Self.Refno := Self.GenerateNo;
end;

function TPurchaseRetur.UpdateRemain(AddedPaidAmt: Double = 0): Boolean;
var
  S: string;
begin
  Self.PaidAmount := Self.PaidAmount + AddedPaidAmt;   //utk update / revert remain dari collection

  S := 'Update TPurchaseRetur set PaidAmount = ' + FloatToStr(Self.PaidAmount);

  if (Self.Amount - Self.PaidAmount) <=  AppVariable.Toleransi_Piutang then
    S := S + ',PaidOff = 1, PaidOffDate = ' + TAppUtils.QuotD(Now())
  else
    S := S + ',PaidOff = 0, PaidOffDate = NULL';

  S := S + ' where id = ' + IntToStr(Self.ID);

  Result := TDBUtils.ExecuteSQL(S, False);
end;

constructor TSalesInvoice.Create;
begin
  inherited;
  Self.PaidOff := 0;
end;

destructor TSalesInvoice.Destroy;
begin
  inherited;
  if FCustomer <> nil then FreeAndNil(FCustomer);
  if FInvItems <> nil then FreeAndNil(FInvItems);
end;

function TSalesInvoice.AfterSaveToDB: Boolean;
begin
  Result := UpdateHargaDO;
end;

function TSalesInvoice.BeforeDeleteFromDB: Boolean;
var
  lPurchasePayment: TPurchasePayment;
begin


  Result := True;
  lPurchasePayment := TPurchasePayment.Create;
  Try
    if lPurchasePayment.LoadByCode(Self.InvoiceNo) then
      Result := lPurchasePayment.DeleteFromDB(False);
  Finally
    lPurchasePayment.Free;
  End;

//  Result := True;
end;

function TSalesInvoice.BeforeSaveToDB: Boolean;
var
  lPurchasePayment: TPurchasePayment;
begin
  Result := True;

//  if Self.PaymentFlag = PaymentFlag_Cash then
  if Self.ID = 0 then  exit;

  Self.PaidAmount   := 0; //reset , value ini hanya boleh diupdate di method UpdateRemain
  Self.ReturAmount  := 0;
  Self.PaidOff      := 0;
  Self.PaidOffDate  := 0;

  //hanya edit
  lPurchasePayment :=  TPurchasePayment.Create;
  Try
    if lPurchasePayment.LoadByCode(Self.InvoiceNo) then
      Result := lPurchasePayment.DeleteFromDB(False);
  Finally
    lPurchasePayment.Free;
  End;
end;

function TSalesInvoice.GenerateNo: String;
var
  aDigitCount: Integer;
  aPrefix: string;
  lNum: Integer;
  S: string;
begin
  lNum := 0;
  aDigitCount := 5;
  aPrefix := Cabang + '.FB' + FormatDateTime('yymm',Now()) + '.';


  S := 'SELECT MAX(InvoiceNo) FROM TSalesInvoice where InvoiceNo LIKE ' + QuotedStr(aPrefix + '%');

  with TDBUtils.OpenQuery(S) do
  begin
    Try
      if not eof then
        TryStrToInt(RightStr(Fields[0].AsString, aDigitCount), lNum);
    Finally
      Free;
    End;
  end;

  inc(lNum);
  Result := aPrefix + RightStr('00000' + IntToStr(lNum), aDigitCount);
end;

function TSalesInvoice.GetInvItems: TObjectList<TSalesInvoiceItem>;
begin
  if FInvItems = nil then
  begin
    FInvItems := TObjectList<TSalesInvoiceItem>.Create();
  end;
  Result := FInvItems;
end;

function TSalesInvoice.GetHeaderFlag: Integer;
begin
  Result := HeaderFlag_PurchaseInvoice;
end;

function TSalesInvoice.GetRefno: String;
begin
  Result := InvoiceNO;
end;

function TSalesInvoice.GetRemain: Double;
begin
  Result := Self.Amount - Self.PaidAmount - Self.ReturAmount;
end;

function TSalesInvoice.GetTotalBayar: Double;
begin
  Result := Self.PaidAmount + Self.ReturAmount;
end;

function TSalesInvoice.LogLevel: Integer;
begin
  Result := 2; //0 : no log
  //1 : all
  //2 : update and delete only
 end;

class procedure TSalesInvoice.PrintData(aInvoiceID: Integer);
var
  S: string;
begin
  S := 'SELECT * FROM FN_SLIP_SALESINVOICE(' + IntToStr(aInvoiceID) + ')';
  DMReport.ExecuteReport('SlipSalesInvoice', S);
end;

function TSalesInvoice.UpdateRemain(aDate: TDateTime = 0; AddedPaidAmt:
    Double = 0; AddedReturAmt: Double = 0): Boolean;
var
  S: string;
begin
  if aDate = 0 then aDate := Now();

  Self.PaidAmount := Self.PaidAmount + AddedPaidAmt;   //utk update / revert remain dari collection
  Self.ReturAmount := Self.ReturAmount + AddedReturAmt;

  S := 'Update TSalesInvoice set PaidAmount = ' + FloatToStr(Self.PaidAmount)
  + ', ReturAmount = ' + FloatToSTr(Self.ReturAmount);

  if (Self.Amount - Self.GetTotalBayar) <=  AppVariable.Toleransi_Piutang then
    S := S + ',PaidOff = 1, PaidOffDate = ' + TAppUtils.QuotD(aDate)
  else
    S := S + ',PaidOff = 0, PaidOffDate = NULL';


  S := S + ' where id = ' + IntToStr(Self.ID);

  Result := TDBUtils.ExecuteSQL(S, False);
end;

function TSalesInvoice.UpdateHargaDO: Boolean;
var
  S: string;
begin
  S := 'update c set c.HARGA = b.HARGA '
    +' from TSALESINVOICE a '
    +' inner join TSALESINVOICEITEM b on a.id = b.SalesInvoice_ID '
    +' inner join TTRANSDETAIL c on b.TRANSDETAIL_ID = c.ID '
    +' where a.id = ' + IntToStr(Self.ID);

  Result := TDBUtils.ExecuteSQL(S, False);
end;

function TSalesRetur.AfterSaveToDB: Boolean;
var
  lSalesPayment: TARSettlement;
begin
//  Result := UpdateReturAmt(False);
//  if not Result then exit;

  if Self.ReturFlag = ReturFlag_Cancel then
  begin
    lSalesPayment := TARSettlement.CreateOrGetFromRetur(Self);
    Result := lSalesPayment.SaveToDB(False);
  end else
    Result := True;
end;

function TSalesRetur.BeforeDeleteFromDB: Boolean;
var
  lSalesPayment: TARSettlement;
begin
  Result := True;

  lSalesPayment := TARSettlement.Create;
  Try
    if lSalesPayment.LoadByCode(Self.Refno) then
      Result := lSalesPayment.DeleteFromDB(False);
  Finally
    lSalesPayment.Free;
  End;

//  Result := True;
end;

function TSalesRetur.BeforeSaveToDB: Boolean;
var
  litem: TTransDetail;
  lSalesPayment: TARSettlement;
begin
  Result := True;
  for lItem in Self.Items do
    lItem.SetAvgCost;

  if Self.ID = 0 then  exit;

  Self.PaidAmount   := 0; //reset , value ini hanya boleh diupdate di method UpdateRemain

  lSalesPayment := TARSettlement.Create;
  Try
    if lSalesPayment.LoadByCode(Self.Refno) then
      Result := lSalesPayment.DeleteFromDB(False);
  Finally
    lSalesPayment.Free;
  End;
end;

procedure TSalesRetur.ClearInvoice;
begin
  FreeAndNil(FInvoice);
end;

procedure TSalesRetur.ClearCustomer;
begin
  FreeAndNil(FCustomer);
end;

function TSalesRetur.GenerateNo: String;
var
  aDigitCount: Integer;
  aPrefix: string;
  lNum: Integer;
  S: string;
begin
  lNum := 0;
  aDigitCount := 5;
  aPrefix := Cabang + '.RP' + FormatDateTime('yymm',Now()) + '.';


  S := 'SELECT MAX(Refno) FROM TSalesRetur where Refno LIKE ' + QuotedStr(aPrefix + '%');

  with TDBUtils.OpenQuery(S) do
  begin
    Try
      if not eof then
        TryStrToInt(RightStr(Fields[0].AsString, aDigitCount), lNum);
    Finally
      Free;
    End;
  end;

  inc(lNum);
  Result := aPrefix + RightStr('00000' + IntToStr(lNum), aDigitCount);
end;

function TSalesRetur.GetHeaderFlag: Integer;
begin
  Result := HeaderFlag_SalesRetur;
end;

function TSalesRetur.GetRefno: String;
begin
  Result := Refno;
end;

function TSalesRetur.GetRemain: Double;
begin
  Result := Self.Amount - Self.PaidAmount;
end;

class procedure TSalesRetur.PrintData(aReturID: Integer);
var
  S: string;
begin
  S := 'SELECT * FROM FN_SLIP_SALESRETUR(' + IntToStr(aReturID) + ')';
  DMReport.ExecuteReport('SlipSalesRetur', S);
end;

procedure TSalesRetur.SetGenerateNo;
begin
  if Self.ID = 0 then Self.Refno := Self.GenerateNo;
end;

function TSalesRetur.UpdateRemain(AddedPaidAmt: Double = 0): Boolean;
var
  S: string;
begin
  Self.PaidAmount := Self.PaidAmount + AddedPaidAmt;   //utk update / revert remain dari collection

  S := 'Update TSalesRetur set PaidAmount = ' + FloatToStr(Self.PaidAmount);

  if (Self.Amount - Self.PaidAmount) <=  AppVariable.Toleransi_Piutang then
    S := S + ',PaidOff = 1, PaidOffDate = ' + TAppUtils.QuotD(Now())
  else
    S := S + ',PaidOff = 0, PaidOffDate = NULL';


  S := S + ' where id = ' + IntToStr(Self.ID);

  Result := TDBUtils.ExecuteSQL(S, False);
end;




end.
