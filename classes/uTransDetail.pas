unit uTransDetail;

interface

uses
  CRUDObject, uDBUtils, Sysutils, uItem, System.Generics.Collections,
  uWarehouse, uSupplier, uCustomer, uSalesman, uAccount, uSettingFee,
  uVariable, Dateutils;

type
  TTransDetail = class;
  TAvgCostUpdate = class;
  TStockOpname = class;
  TStockOpnameItem = class;
  TStockOpnameKKSO = class;
  TKKSO = class;
  TKKSOItem = class;
  TTransferRequest = class;
  TTransferRequestItem = class;

  TCRUDTransDetail = class(TCRUDObject)
  private
    FItems: TObjectList<TTransDetail>;
    FTransDate: TDateTime;
    FClosed: Integer;
    FModifiedBy: String;
    FModifiedDate: TDateTime;
    function GetItems: TObjectList<TTransDetail>;
  protected
    function GetRefno: String; dynamic;
    procedure PrepareDetailObject(AObjItem: TCRUDObject); override;
  public
    destructor Destroy; override;
    function GenerateNo: String; virtual; abstract;
    procedure SetGenerateNo; virtual; abstract;
    function GetHeaderFlag: Integer; virtual; abstract;
    function GetTotalCost(UseLastCost: Boolean = False; IncludePPN: Boolean =
        False): Double;
    function SaveRepeat(DoShowMsg: Boolean = True; aRepeatCount: Integer = 2):
        Boolean;
    property Items: TObjectList<TTransDetail> read GetItems write FItems;
  published
    property TransDate: TDateTime read FTransDate write FTransDate;
    property Closed: Integer read FClosed write FClosed;
    property ModifiedBy: String read FModifiedBy write FModifiedBy;
    property ModifiedDate: TDateTime read FModifiedDate write FModifiedDate;
  end;

  TTransDetail = class(TCRUDObject)
  private
    FHeader_Flag: Integer;
    FHeader_ID: Integer;
    FTransDate: TDateTime;
    FKonversi: Double;
    FQty: Double;
    FItem: TItem;
    FHarga: Double;
    FDiscount: Double;
    FTotal: Double;
    FPPN: Double;
    FHargaAvg: Double;
    FLastCost: Double;
    FWarehouse: TWarehouse;
    FUOM: TUOM;
    FRefno: string;
    FTransType: Integer;
    FTransDef: string;
    FPriceType: Integer;
  protected
    function GetSQLDeleteDetails(Header_ID: Integer): String; override;
    function GetSQLRetrieveDetails(Header_ID: Integer): String; override;
  public
    destructor Destroy; override;
    procedure MakePositive;
    procedure MakeNegative;
    procedure SetAvgCost;
  published
    property Header_Flag: Integer read FHeader_Flag write FHeader_Flag;
    [AttributeOfHeader]
    property Header_ID: Integer read FHeader_ID write FHeader_ID;
    property TransDate: TDateTime read FTransDate write FTransDate;
    property Konversi: Double read FKonversi write FKonversi;
    property Qty: Double read FQty write FQty;
    property Item: TItem read FItem write FItem;
    property Harga: Double read FHarga write FHarga;
    property Discount: Double read FDiscount write FDiscount;
    property Total: Double read FTotal write FTotal;
    property PPN: Double read FPPN write FPPN;
    property HargaAvg: Double read FHargaAvg write FHargaAvg;
    property LastCost: Double read FLastCost write FLastCost;
    property Warehouse: TWarehouse read FWarehouse write FWarehouse;
    property UOM: TUOM read FUOM write FUOM;
    property Refno: string read FRefno write FRefno;
    property TransType: Integer read FTransType write FTransType;
    property TransDef: string read FTransDef write FTransDef;
    property PriceType: Integer read FPriceType write FPriceType;
  end;

  TAvgCostUpdate = class(TCRUDObject)
  private
    FHeader_Flag: Integer;
    FHeader_ID: Integer;
    FItem: TItem;
    FLastStockPCS: Double;
    FLastAvgCost: Double;
    FTransTotalPCS: Double;
    FTransDate: TDateTime;
    FNewAvgCost: Double;
    FRefno: string;
    FTransTotalValue: Double;
    FTransPricePcs: Double;
    procedure CalcNewAvg;
  protected
    function BeforeSaveToDB: Boolean; override;
    function GetSQLDeleteDetails(Header_ID: Integer): String; override;
    function GetSQLRetrieveDetails(Header_ID: Integer): String; override;
  public
    destructor Destroy; override;
    function GetTransPrice: Double;
    procedure UpdateAvgCost;
    procedure RevertAvgCost;
  published
    property Header_Flag: Integer read FHeader_Flag write FHeader_Flag;
    [AttributeOfHeader]
    property Header_ID: Integer read FHeader_ID write FHeader_ID;
    property Item: TItem read FItem write FItem;
    property LastStockPCS: Double read FLastStockPCS write FLastStockPCS;
    property LastAvgCost: Double read FLastAvgCost write FLastAvgCost;
    property TransTotalPCS: Double read FTransTotalPCS write FTransTotalPCS;
    property TransDate: TDateTime read FTransDate write FTransDate;
    property NewAvgCost: Double read FNewAvgCost write FNewAvgCost;
    property Refno: string read FRefno write FRefno;
    property TransTotalValue: Double read FTransTotalValue write FTransTotalValue;
    property TransPricePcs: Double read FTransPricePcs write FTransPricePcs;
  end;

  TTransferStock = class(TCRUDTransDetail)
  private
    FNotes: string;
    FWH_Asal: TWarehouse;
    FRefNo: string;
    FKodeCabang_Asal: string;
    FKodeCabang_Tujuan: string;
    FTransferType: Integer;
    FWH_Tujuan: TWarehouse;
  protected
    function BeforeSaveToDB: Boolean; override;
    function GetRefno: String; override;
  public
    destructor Destroy; override;
    procedure DeleteOutExceptExternal;
    function GenerateNo: String; override;
    procedure GenerateTrfOut;
    function GetHeaderFlag: Integer; override;
    class procedure PrintData(aID: Integer);
    procedure SetGenerateNo; override;
  published
    property Notes: string read FNotes write FNotes;
    property WH_Asal: TWarehouse read FWH_Asal write FWH_Asal;
    [AttributeOfCode]
    property RefNo: string read FRefNo write FRefNo;
    property KodeCabang_Asal: string read FKodeCabang_Asal write FKodeCabang_Asal;
    property KodeCabang_Tujuan: string read FKodeCabang_Tujuan write
        FKodeCabang_Tujuan;
    property TransferType: Integer read FTransferType write FTransferType;
    property WH_Tujuan: TWarehouse read FWH_Tujuan write FWH_Tujuan;
  end;


  TStockOpname = class(TCRUDObject)
  private
    FClosed: Integer;
    FItems: TObjectList<TStockOpnameItem>;
    FKKSO: TObjectList<TStockOpnameKKSO>;
    FModifiedBy: String;
    FModifiedDate: TDateTime;
    FTransDate: TDateTime;
    FRefNo: string;
    FNotes: string;
    FTranstype: Integer;
    FWarehouse: TWarehouse;
    function GetItems: TObjectList<TStockOpnameItem>;
    function GetKKSO: TObjectList<TStockOpnameKKSO>;
    function UpdateKKSO(aIsRevert: Boolean = False): Boolean;
  protected
    function AfterSaveToDB: Boolean; override;
    function BeforeDeleteFromDB: Boolean; override;
    function BeforeSaveToDB: Boolean; override;
    function GetRefno: String;
  public
    function AddKKSO(aKKSO_ID: Integer): TStockOpnameKKSO;
    function GenerateNo: String;
    function SaveRepeat(DoShowMsg: Boolean = True; aRepeatCount: Integer = 2):
        Boolean;
    procedure SetGenerateNo;
    property Items: TObjectList<TStockOpnameItem> read GetItems write FItems;
    property KKSO: TObjectList<TStockOpnameKKSO> read GetKKSO write FKKSO;
  published
    property Closed: Integer read FClosed write FClosed;
    property ModifiedBy: String read FModifiedBy write FModifiedBy;
    property ModifiedDate: TDateTime read FModifiedDate write FModifiedDate;
    property TransDate: TDateTime read FTransDate write FTransDate;
    [AttributeOfHeader]
    property RefNo: string read FRefNo write FRefNo;
    property Notes: string read FNotes write FNotes;
    property Transtype: Integer read FTranstype write FTranstype;
    property Warehouse: TWarehouse read FWarehouse write FWarehouse;
  end;


  TStockOpnameItem = class(TCRUDObject)
  private
    FHargaAvg: Double;
    FItem: TItem;
    FStockOpname: TStockOpname;
    FKonversi: Double;
    FLastCost: Double;
    FQty: Double;
    FVariant: Double;
    FQtySys: Double;
    FUOM: TUOM;
    FWarehouse: TWarehouse;
  public
    procedure SetAvgCost;
  published
    property HargaAvg: Double read FHargaAvg write FHargaAvg;
    property Item: TItem read FItem write FItem;
    [AttributeOfHeader]
    property StockOpname: TStockOpname read FStockOpname write FStockOpname;
    property Konversi: Double read FKonversi write FKonversi;
    property LastCost: Double read FLastCost write FLastCost;
    property Qty: Double read FQty write FQty;
    property Variant: Double read FVariant write FVariant;
    property QtySys: Double read FQtySys write FQtySys;
    property UOM: TUOM read FUOM write FUOM;
    property Warehouse: TWarehouse read FWarehouse write FWarehouse;
  end;

  TStockAdjustment = class(TCRUDTransDetail)
  private
    FNotes: string;
    FWarehouse: TWarehouse;
    FRefNo: string;
    FTransType: Integer;
    FStockOpname: TStockOpname;
  protected
    function BeforeSaveToDB: Boolean; override;
    function GetRefno: String; override;
  public
    destructor Destroy; override;
    procedure ClearStockOname;
    function GenerateNo: String; override;
    function GetHeaderFlag: Integer; override;
    procedure SetGenerateNo; override;
  published
    property Notes: string read FNotes write FNotes;
    property Warehouse: TWarehouse read FWarehouse write FWarehouse;
    [AttributeOfCode]
    property RefNo: string read FRefNo write FRefNo;
    property TransType: Integer read FTransType write FTransType;
    property StockOpname: TStockOpname read FStockOpname write FStockOpname;
  end;


  TKKSOItem = class(TCRUDObject)
  private
    FItem: TItem;
    FKonversi: Double;
    FQty: Double;
    FKKSO: TKKSO;
    FUOM: TUOM;
  public
    destructor Destroy; override;
  published
    property Item: TItem read FItem write FItem;
    property Konversi: Double read FKonversi write FKonversi;
    property Qty: Double read FQty write FQty;
    [AttributeOfHeader]
    property KKSO: TKKSO read FKKSO write FKKSO;
    property UOM: TUOM read FUOM write FUOM;
  end;

  TKKSO = class(TCRUDObject)
  private
    FNotes: String;
    FItems: TObjectList<TKKSOItem>;
    FRefno: String;
    FRak: String;
    FModifiedBy: String;
    FModifiedDate: TDateTime;
    FPIC: String;
    FStockOpname: TStockOpname;
    FTransDate: TDatetime;
    FWarehouse: TWarehouse;
    function GetItems: TObjectList<TKKSOItem>;
  protected
    function GetRefno: String;
  public
    destructor Destroy; override;
    function GenerateNo: String;
    class procedure PrintData(aKKSOID: Integer);
    function SaveRepeat(DoShowMsg: Boolean = True; aRepeatCount: Integer = 2):
        Boolean;
    procedure SetGenerateNo;
    property Items: TObjectList<TKKSOItem> read GetItems write FItems;
  published
    property Notes: String read FNotes write FNotes;
    property Refno: String read FRefno write FRefno;
    property Rak: String read FRak write FRak;
    property ModifiedBy: String read FModifiedBy write FModifiedBy;
    property ModifiedDate: TDateTime read FModifiedDate write FModifiedDate;
    property PIC: String read FPIC write FPIC;
    property StockOpname: TStockOpname read FStockOpname write FStockOpname;
    property TransDate: TDatetime read FTransDate write FTransDate;
    property Warehouse: TWarehouse read FWarehouse write FWarehouse;
  end;


  TStockOpnameKKSO = class(TCRUDObject)
  private
    FKKSO: TKKSO;
    FStockOpname: TStockOpname;
  public
  published
    property KKSO: TKKSO read FKKSO write FKKSO;
    [AttributeOfHeader]
    property StockOpname: TStockOpname read FStockOpname write FStockOpname;
  end;

  TTransferRequestItem = class(TCRUDObject)
  private
    FItem: TItem;
    FKonversi: Double;
    FQty: Double;
    FTransferRequest: TTransferRequest;
    FUOM: TUOM;
  public
    destructor Destroy; override;
  published
    property Item: TItem read FItem write FItem;
    property Konversi: Double read FKonversi write FKonversi;
    property Qty: Double read FQty write FQty;
    [AttributeOfHeader]
    property TransferRequest: TTransferRequest read FTransferRequest write
        FTransferRequest;
    property UOM: TUOM read FUOM write FUOM;
  end;

  TTransferRequest = class(TCRUDObject)
  private
    FNotes: String;
    FItems: TObjectList<TTransferRequestItem>;
    FRefno: String;
    FModifiedBy: String;
    FModifiedDate: TDateTime;
    FKodeCabang: String;
    FTransDate: TDatetime;
    function GetItems: TObjectList<TTransferRequestItem>;
  protected
    function GetRefno: String;
  public
    destructor Destroy; override;
    function GenerateNo: String;
    class procedure PrintData(aTransferReq: TTransferRequest);
    function SaveRepeat(DoShowMsg: Boolean = True; aRepeatCount: Integer = 2):
        Boolean;
    procedure SetGenerateNo;
    property Items: TObjectList<TTransferRequestItem> read GetItems write FItems;
  published
    property Notes: String read FNotes write FNotes;
    [AttributeOfCode]
    property Refno: String read FRefno write FRefno;
    property ModifiedBy: String read FModifiedBy write FModifiedBy;
    property ModifiedDate: TDateTime read FModifiedDate write FModifiedDate;
    property KodeCabang: String read FKodeCabang write FKodeCabang;
    property TransDate: TDatetime read FTransDate write FTransDate;
  end;


  TPurchaseReceive = class(TCRUDTransDetail)
  private
    FSupplier: TSupplier;
    FRecNo: string;
    FAvgCostItems: TObjectList<TAvgCostUpdate>;
    FNotes: string;
    FReferensi: string;
    FStatus: Integer;
    FWarehouse: TWarehouse;
    procedure GenerateAvgCost;
    function GetAvgCostItems: TObjectList<TAvgCostUpdate>;
    function GetOrAddAvgCost(aDetail: TTransDetail): TAvgCostUpdate;
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
    class procedure PrintData(aInvoiceID: Integer);
    procedure SetGenerateNo; override;
    function ValidateUpdate: Boolean;
    property AvgCostItems: TObjectList<TAvgCostUpdate> read GetAvgCostItems write
        FAvgCostItems;
  published
    property Supplier: TSupplier read FSupplier write FSupplier;
    [AttributeOfCode]
    property RecNo: string read FRecNo write FRecNo;
    property Notes: string read FNotes write FNotes;
    property Referensi: string read FReferensi write FReferensi;
    property Status: Integer read FStatus write FStatus;
    property Warehouse: TWarehouse read FWarehouse write FWarehouse;
  end;

  TDeliveryOrder = class(TCRUDTransDetail)
  private
    FDONo: string;
    FNotes: string;
    FStatus: Integer;
    FCustomer: TCustomer;
    FWarehouse: TWarehouse;
  protected
    function BeforeSaveToDB: Boolean; override;
    function GetRefno: String; override;
    function LogLevel: Integer; override;
  public
    constructor Create;
    destructor Destroy; override;
    function GenerateNo: String; reintroduce;
    function GetHeaderFlag: Integer; override;
    class procedure PrintData(aSalesInvoiceID: Integer);
    procedure SetGenerateNo; override;
    function ValidateUpdate: Boolean;
  published
    [AttributeOfCode]
    property DONo: string read FDONo write FDONo;
    property Notes: string read FNotes write FNotes;
    property Status: Integer read FStatus write FStatus;
    property Customer: TCustomer read FCustomer write FCustomer;
    property Warehouse: TWarehouse read FWarehouse write FWarehouse;
  end;

const
  HeaderFlag_PurchaseReceive : Integer = 100;
  HeaderFlag_PurchaseRetur : Integer = 150;
  HeaderFlag_DeliveryOrder : Integer = 200;
  HeaderFlag_SalesRetur : Integer = 250;
  HeaderFlag_TransferStock : Integer = 400;
  HeaderFlag_Wastage : Integer = 450;
  HeaderFlag_StockAdjustment : Integer = 500;
  Status_Inv_Created : Integer = 0;
  Status_Inv_Paid : Integer = 1;
  Status_Inv_Cancel : Integer = 2;
  Status_Inv_FullPaid : Integer = 100;

  PaymentFlag_Cash  : Integer = 0;
  PaymentFlag_Credit : Integer = 1;

  ReturFlag_Reguler : Integer = 0;
  ReturFlag_Cancel : Integer = 1;

  Transfer_Internal : Integer = 0;
  Transfer_External_Out : Integer = 1;
  Transfer_External_In : Integer = 2;

  StockOpname_Parsial : Integer = 0;
  StockOpname_Warehouse : Integer = 1;

  StockAdjustment_Direct : Integer = 0;
  StockAdjustment_FromSO : Integer = 1;

  SalesType_FrontEnd : Integer = 0;
  SalesType_Salesman : Integer = 1;


implementation

uses
  System.StrUtils, uAppUtils, uSalesFee, uDMReport,
  Datasnap.DBClient, Data.DB, uFinancialTransaction,
  FireDAC.Comp.Client;

destructor TCRUDTransDetail.Destroy;
begin
  inherited;
  if FItems <> nil then FItems.Free;
end;

function TCRUDTransDetail.GetItems: TObjectList<TTransDetail>;
begin
  if FItems = nil then
  begin
    FItems := TObjectList<TTransDetail>.Create();
  end;
  Result := FItems;
end;

function TCRUDTransDetail.GetRefno: String;
begin
  Result := '';
end;

function TCRUDTransDetail.GetTotalCost(UseLastCost: Boolean = False;
    IncludePPN: Boolean = False): Double;
var
  lCost: Double;
  lItem: TTransDetail;
begin
  Result := 0;
  for lItem in Self.Items do
  begin
    if UseLastCost then
      lCost := lItem.Qty * lItem.LastCost
    else
      lCost := lItem.Qty * lItem.HargaAvg;

    if IncludePPN then
      lCost := lCost * (100+lItem.PPN)/100;

    Result := Result + Abs(lCost);
  end;
end;

procedure TCRUDTransDetail.PrepareDetailObject(AObjItem: TCRUDObject);
begin
  if AObjItem is TTransDetail then
  begin
    TTransDetail(AObjItem).Header_Flag := GetHeaderFlag;
    TTransDetail(AObjItem).TransDate := TransDate;
    TTransDetail(AObjItem).Refno := GetRefno;
  end;

  if AObjItem is TAvgCostUpdate then
  begin
    TAvgCostUpdate(AObjItem).Header_Flag  := GetHeaderFlag;
  end;
end;

function TCRUDTransDetail.SaveRepeat(DoShowMsg: Boolean = True; aRepeatCount:
    Integer = 2): Boolean;
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
        Self.SetGenerateNo;
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

destructor TTransDetail.Destroy;
begin
  inherited;
  if FItem <> nil then FreeAndNil(FItem);
  if FUOM <> nil then FreeAndNil(FUOM);
  if FWarehouse <> nil then FreeAndNil(FWarehouse);
end;

function TTransDetail.GetSQLDeleteDetails(Header_ID: Integer): String;
var
  sFilter : String;
begin
//  if UpperCase(Self.GetTableName) = 'TTRANSDETAIL' then
//    Raise Exception.Create('Must override GetSQLDeleteDetails for TTRANSDETAIL');

  sFilter := 'Header_flag = ' + IntToStr(Header_Flag)
    +' AND Header_ID = ' + IntToStr(Header_ID);

  Result  := Format(SQL_Delete,[Self.GetTableName,sFilter]);
end;

function TTransDetail.GetSQLRetrieveDetails(Header_ID: Integer): String;
var
//  lPO: TCRUDPOItem;
  sFilter : String;
begin
//  if UpperCase(Self.GetTableName) = 'TTRANSDETAIL' then
//    Raise Exception.Create('Must override GetSQLRetrieveDetails for TTRANSDETAIL');

  sFilter := 'Header_flag = ' + IntToStr(Header_Flag)
    +' And Header_ID = ' + IntToStr(Header_ID);
  Result  := Format(SQL_Select,['*', Self.GetTableName,sFilter]);
//
//  lPO := TCRUDPOItem.Create;
//  Result := Result + lPO.GetHeaderField;
end;

procedure TTransDetail.MakePositive;
begin
  Self.Qty    := Abs(Self.Qty);
  Self.Total  := Abs(Self.Total);
  Self.PPN    := Abs(Self.Total);
end;

procedure TTransDetail.MakeNegative;
begin
  Self.Qty    := Abs(Self.Qty) * -1;
  Self.Total  := Abs(Self.Total) * -1;
  Self.PPN    := Abs(Self.Total) * -1;
end;

procedure TTransDetail.SetAvgCost;
var
  lItemUOM: TItemUOM;
begin
  lItemUOM := TItemUOM.GetItemUOM(Self.Item.ID, Self.UOM.ID);
  Try
    Self.HargaAvg := lItemUOM.HargaAvg;
    Self.LastCost := lItemUOM.HargaBeli;
    if Self.HargaAvg <= 0 then
      Self.HargaAvg := Self.LastCost;
  Finally
    lItemUOM.Free;
  End;
end;

destructor TAvgCostUpdate.Destroy;
begin
  inherited;
  if FItem <> nil then FreeAndNil(Fitem);
end;

function TAvgCostUpdate.BeforeSaveToDB: Boolean;
begin
  TransPricePcs := 0;
  if TransTotalPCS <> 0 then
    TransPricePcs := TransTotalValue / TransTotalPCS;

  UpdateAvgCost;
  Result := True;     
end;



procedure TAvgCostUpdate.CalcNewAvg;
var
  dLastStock: Double;
  lAllQty: Double;
  lAllValue: Double;
  lUOM: TItemUOM;
begin
  //set LastAvgCost;
  // Item.ReLoad(True);
  if Self.LastAvgCost = 0 then  //jika baru
  begin
    for lUOM in Item.ItemUOMs do
    begin
      if lUOM.Konversi = 0 then
        raise Exception.Create('lUOM.Konversi = 0');
      Self.LastAvgCost := lUOM.HargaAvg / lUOM.Konversi;
      break;
    end;
  end;

  //new one
  if LastStockPCS < 0 then
    dLastStock  := 0
  else
    dLastStock  := LastStockPCS;

  lAllValue   := (dLastStock * LastAvgCost) + (TransTotalValue);
  lAllQty     := dLastStock + TransTotalPCS;

  //def
  Self.NewAvgCost := 0; 
  
  if lAllQty > 0 then  
    Self.NewAvgCost :=  lAllValue / lAllQty;

  if Self.NewAvgCost <= 0 then
    Self.NewAvgCost := GetTransPrice;
end;

function TAvgCostUpdate.GetSQLDeleteDetails(Header_ID: Integer): String;
var
  sFilter : String;
begin
//  if UpperCase(Self.GetTableName) = 'TAvgCostUpdate' then
//    Raise Exception.Create('Must override GetSQLDeleteDetails for TAvgCostUpdate');

  sFilter := 'Header_flag = ' + IntToStr(Header_Flag)
    +' AND Header_ID = ' + IntToStr(Header_ID);

  Result  := Format(SQL_Delete,[Self.GetTableName,sFilter]);
end;

function TAvgCostUpdate.GetSQLRetrieveDetails(Header_ID: Integer): String;
var
//  lPO: TCRUDPOItem;
  sFilter : String;
begin
//  if UpperCase(Self.GetTableName) = 'TAvgCostUpdate' then
//    Raise Exception.Create('Must override GetSQLRetrieveDetails for TAvgCostUpdate');

  sFilter := 'Header_flag = ' + IntToStr(Header_Flag)
    +' And Header_ID = ' + IntToStr(Header_ID);
  Result  := Format(SQL_Select,['*', Self.GetTableName,sFilter]);
//
//  lPO := TCRUDPOItem.Create;
//  Result := Result + lPO.GetHeaderField;
end;

function TAvgCostUpdate.GetTransPrice: Double;
begin
  if TransTotalPCS = 0 then
    raise Exception.Create('TransTotalPCS = 0');
  Result := TransTotalValue / TransTotalPCS;
end;

procedure TAvgCostUpdate.UpdateAvgCost;
var
  lUOM: TItemUOM;
begin
  if Item.ItemUOMs.Count = 0 then  
    Item.ReLoad(True);
    
  CalcNewAvg;

  //uom
  for lUOM in Item.ItemUOMs do
  begin
    if lUOM.Konversi = 0 then
      raise Exception.Create('lUOM.Konversi = 0');
    lUOM.UpdateHargaAvg(Self.NewAvgCost * lUOM.Konversi);
  end;

end;

procedure TAvgCostUpdate.RevertAvgCost;
var
  lUOM: TItemUOM;
begin
  if Item.ItemUOMs.Count = 0 then  
    Item.ReLoad(True);
    
  for lUOM in Item.ItemUOMs do
  begin
    if lUOM.Konversi = 0 then
      raise Exception.Create('lUOM.Konversi = 0');
    lUOM.UpdateHargaAvg(Self.LastAvgCost * lUOM.Konversi);
  end;

end;

destructor TTransferStock.Destroy;
begin
  inherited;
  if FWH_Asal <> nil then FreeAndNil(FWH_Asal);
  if FWH_Tujuan <> nil then FreeAndNil(FWH_Tujuan);
end;

function TTransferStock.BeforeSaveToDB: Boolean;
var
  lItem: TTransDetail;
begin
  if Self.TransferType = Transfer_Internal then
    GenerateTrfOut; //2 sisi

  for lItem in Self.Items do
  begin
    lItem.SetAvgCost;

    if Self.TransferType = Transfer_External_Out then
    begin
      lItem.Warehouse := TWarehouse.CreateID(Self.WH_Asal.ID);
      lItem.Qty := -1 * lItem.Qty;
    end else
    if Self.TransferType = Transfer_External_In then
    begin
      lItem.Warehouse := TWarehouse.CreateID(Self.WH_Tujuan.ID);
      lItem.Qty := Abs(lItem.Qty);
    end;
  end;

  Result := True;
end;

procedure TTransferStock.DeleteOutExceptExternal;
var
  i: Integer;
begin
  if Self.TransferType <> Transfer_Internal then exit;

  for i := Self.Items.Count-1 downto 0 do
  begin
    if Self.Items[i].Qty < 0 then
      Self.Items.Delete(i);
  end;
end;

function TTransferStock.GenerateNo: String;
var
  aDigitCount: Integer;
  aPrefix: string;
  lNum: Integer;
  S: string;
begin
  lNum := 0;
  aDigitCount := 5;
  aPrefix := Cabang + '.TS' + FormatDateTime('yymm',Now()) + '.';


  S := 'SELECT MAX(Refno) FROM TTransferStock where Refno LIKE ' + QuotedStr(aPrefix + '%');

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

procedure TTransferStock.GenerateTrfOut;
var
  i: Integer;
  lItem: TTransDetail;
begin

  //delete all trf out first
  DeleteOutExceptExternal;

  for i := 0 to Self.Items.Count-1 do
  begin
    lItem             := TTransDetail.Create;
    lItem.Header_Flag := Items[i].Header_Flag;
    lItem.Header_ID   := Items[i].Header_ID;
    lItem.TransDate   := Items[i].TransDate;
    lItem.TransType   := Items[i].TransType;
    lItem.Konversi    := Items[i].Konversi;
    lItem.Qty         := Items[i].Qty * -1;

    if Items[i].Item <> nil then
      lItem.Item      := TItem.CreateID(Items[i].Item.ID);
    if Items[i].UOM <> nil then
      lItem.UOM       := TUOM.CreateID(Items[i].UOM.ID);

    if Self.WH_Asal <> nil then
      lItem.Warehouse := TWarehouse.CreateID(Self.WH_Asal.ID);

    if Self.WH_Tujuan <> nil then
      Items[i].Warehouse := TWarehouse.CreateID(Self.WH_Tujuan.ID);

    lItem.Harga       := Items[i].Harga;
    lItem.HargaAvg    := Items[i].HargaAvg;
    lItem.Discount    := Items[i].Discount;
    lItem.Total       := Items[i].Total * -1;
    lItem.PPN         := Items[i].PPN;
    lItem.Refno       := Items[i].Refno;
    lItem.TransDef    := Items[i].TransDef;

    Self.Items.Add(lItem);
  end;

end;

function TTransferStock.GetHeaderFlag: Integer;
begin
  Result := HeaderFlag_TransferStock;
end;

function TTransferStock.GetRefno: String;
begin
  Result := Refno;
end;

class procedure TTransferStock.PrintData(aID: Integer);
var
  S: string;
begin
  S := 'SELECT A.ID, A.REFNO, A.TRANSDATE, A.NOTES,'
      +' B.NAMA AS WH_ASAL, C.NAMA AS WH_TUJUAN,'
      +' CASE WHEN A.TRANSFERTYPE = 1 THEN ''KIRIM KE CABANG LAIN'' '
      +' WHEN A.TRANSFERTYPE = 2 THEN ''TERIMA DARI CABANG LAIN'' '
      +' ELSE ''ANTAR GUDANG INTERNAL'' END AS JENIS_TRANSFER,'
      +' E.KODE, E.NAMA, F.UOM, ABS(D.QTY) AS QTY'
      +' FROM TTRANSFERSTOCK A'
      +' LEFT JOIN TWAREHOUSE B ON A.WH_ASAL_ID = B.ID'
      +' LEFT JOIN TWAREHOUSE C ON A.WH_TUJUAN_ID = C.ID'
      +' INNER JOIN TTRANSDETAIL D ON A.ID = D.HEADER_ID AND D.HEADER_FLAG = 400'
      +' INNER JOIN TITEM E ON D.ITEM_ID = E.ID'
      +' INNER JOIN TUOM F ON D.UOM_ID = F.ID'
      +' WHERE (A.TRANSFERTYPE <> 0 OR D.QTY > 0)'
      +' AND A.ID = ' + IntToStr(aID) ;
  DMReport.ExecuteReport('SlipTransferStock', S);
end;

procedure TTransferStock.SetGenerateNo;
begin
  if Self.ID = 0 then Self.RefNo := Self.GenerateNo;
end;

function TStockOpname.AddKKSO(aKKSO_ID: Integer): TStockOpnameKKSO;
var
  lKKSO: TStockOpnameKKSO;
begin
  Result := nil;
  for lKKSO in Self.KKSO do
  begin
    if lKKSO.KKSO = nil then continue;
    if lKKSO.KKSO.ID = aKKSO_ID then
    begin
      Result := lKKSO;
      exit;
    end;
  end;

  if Result = nil then
  begin
    Result := TStockOpnameKKSO.Create;
    Result.KKSO := TKKSO.CreateID(aKKSO_ID);
    Self.KKSO.Add(Result);
  end;

end;

function TStockOpname.AfterSaveToDB: Boolean;
begin
  Result := Self.UpdateKKSO;
end;

function TStockOpname.BeforeDeleteFromDB: Boolean;
begin
  Result := Self.UpdateKKSO(True);
end;

function TStockOpname.BeforeSaveToDB: Boolean;
var
  litem: TStockOpnameItem;
  lOldSO: TStockOpname;
begin
  Result := True;
  for lItem in Self.Items do
    lItem.SetAvgCost;

  if Self.ID = 0 then exit;
  lOldSO := TStockOpname.Create;
  Try
    lOldSO.LoadByID(Self.ID);

    lOldSO.UpdateKKSO(True);
  Finally
    lOldSO.Free;
  End;
end;

function TStockOpname.GenerateNo: String;
var
  aDigitCount: Integer;
  aPrefix: string;
  lNum: Integer;
  S: string;
begin
  lNum := 0;
  aDigitCount := 5;
  aPrefix := Cabang + '.SO' + FormatDateTime('yymm',Now()) + '.';


  S := 'SELECT MAX(RefNo) FROM TStockOpname where RefNo LIKE ' + QuotedStr(aPrefix + '%');

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

function TStockOpname.GetItems: TObjectList<TStockOpnameItem>;
begin
  if FItems = nil then
  begin
    FItems := TObjectList<TStockOpnameItem>.Create();
  end;
  Result := FItems;
end;

function TStockOpname.GetKKSO: TObjectList<TStockOpnameKKSO>;
begin
  if FKKSO = nil then
  begin
    FKKSO := TObjectList<TStockOpnameKKSO>.Create();
  end;
  Result := FKKSO;
end;

function TStockOpname.GetRefno: String;
begin
  Result := Refno;
end;

function TStockOpname.SaveRepeat(DoShowMsg: Boolean = True; aRepeatCount:
    Integer = 2): Boolean;
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
        Self.SetGenerateNo;
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

procedure TStockOpname.SetGenerateNo;
begin
  if Self.ID = 0 then Self.RefNo := Self.GenerateNo;
end;

function TStockOpname.UpdateKKSO(aIsRevert: Boolean = False): Boolean;
var
  iSOID: Integer;
  S: string;
begin
  Result := True;
  if Self.ID = 0 then exit;

  iSOID := Self.ID;
  if aIsRevert then iSOID := 0;
  S := 'UPDATE B SET B.STOCKOPNAME_ID = ' + IntToStr(iSOID)
      +' FROM TSTOCKOPNAMEKKSO A'
      +' INNER JOIN TKKSO B ON B.ID = A.KKSO_ID'
      +' WHERE A.STOCKOPNAME_ID = ' + IntToStr(Self.ID);
  TDBUtils.ExecuteSQL(S, False);
end;

destructor TStockAdjustment.Destroy;
begin
  inherited;
  if FWarehouse <> nil then FreeAndNil(FWarehouse);
  if FStockOpname <> nil then FreeAndNil(FStockOpname);
end;

function TStockAdjustment.BeforeSaveToDB: Boolean;
var
  lItem: TTransDetail;
begin
  for lItem in Self.Items do
  begin
    lItem.SetAvgCost;
  end;

  Result := True;
end;

procedure TStockAdjustment.ClearStockOname;
begin
  if FWarehouse <> nil then FreeAndNil(FWarehouse);
  if FStockOpname <> nil then FreeAndNil(FStockOpname);
end;

function TStockAdjustment.GenerateNo: String;
var
  aDigitCount: Integer;
  aPrefix: string;
  lNum: Integer;
  S: string;
begin
  lNum := 0;
  aDigitCount := 5;
  aPrefix := Cabang + '.ADJ' + FormatDateTime('yymm',Now()) + '.';


  S := 'SELECT MAX(Refno) FROM TStockAdjustment where Refno LIKE ' + QuotedStr(aPrefix + '%');

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

function TStockAdjustment.GetHeaderFlag: Integer;
begin
  Result := HeaderFlag_StockAdjustment;
end;

function TStockAdjustment.GetRefno: String;
begin
  Result := Refno;
end;

procedure TStockAdjustment.SetGenerateNo;
begin
  if Self.ID = 0 then Self.RefNo := Self.GenerateNo;
end;

procedure TStockOpnameItem.SetAvgCost;
var
  lItemUOM: TItemUOM;
begin
  lItemUOM := TItemUOM.GetItemUOM(Self.Item.ID, Self.UOM.ID);
  Try
    Self.HargaAvg := lItemUOM.HargaAvg;
    Self.LastCost := lItemUOM.HargaBeli;

    if Self.HargaAvg <= 0 then
      Self.HargaAvg := Self.LastCost;
  Finally
    lItemUOM.Free;
  End;
end;

destructor TKKSOItem.Destroy;
begin
  inherited;
  if FItem <> nil then FreeAndNil(FItem);
  if FUOM <> nil then FreeAndNil(FUOM);
end;

destructor TKKSO.Destroy;
begin
  inherited;
  if FItems <> nil then
    FItems.Free;
end;

function TKKSO.GenerateNo: String;
var
  aDigitCount: Integer;
  aPrefix: string;
  lNum: Integer;
  S: string;
begin
  lNum := 0;
  aDigitCount := 4;
  aPrefix := Cabang + '.KKSO' + FormatDateTime('yymm',Now()) + '.';


  S := 'SELECT MAX(RefNo) FROM TKKSO where RefNo LIKE ' + QuotedStr(aPrefix + '%');

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
  Result := aPrefix + RightStr('0000' + IntToStr(lNum), aDigitCount);
end;

function TKKSO.GetItems: TObjectList<TKKSOItem>;
begin
  if FItems = nil then
  begin
    FItems := TObjectList<TKKSOItem>.Create();
  end;
  Result := FItems;
end;

function TKKSO.GetRefno: String;
begin
  Result := Refno;
end;

class procedure TKKSO.PrintData(aKKSOID: Integer);
var
  S: string;
begin
  S := 'SELECT A.ID, A.REFNO, A.TRANSDATE, E.NAMA AS GUDANG,'
      +' A.PIC, A.MODIFIEDBY, A.MODIFIEDDATE, C.KODE, C.NAMA,'
      +' D.UOM, B.QTY, B.KONVERSI, A.RAK'
      +' FROM TKKSO A'
      +' INNER JOIN TKKSOITEM B ON A.ID = B.KKSO_ID'
      +' INNER JOIN TITEM C ON B.ITEM_ID = C.ID'
      +' INNER JOIN TUOM D ON B.UOM_ID = D.ID'
      +' INNER JOIN TWAREHOUSE E ON A.WAREHOUSE_ID = E.ID'
      +' WHERE A.ID = ' + IntToStr(aKKSOID);

  DMReport.ExecuteReport('SlipKKSO', S);
end;

function TKKSO.SaveRepeat(DoShowMsg: Boolean = True; aRepeatCount: Integer =
    2): Boolean;
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
        Self.SetGenerateNo;
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

procedure TKKSO.SetGenerateNo;
begin
  if Self.ID = 0 then Self.RefNo := Self.GenerateNo;
end;

destructor TTransferRequestItem.Destroy;
begin
  inherited;
  if FItem <> nil then FreeAndNil(FItem);
  if FUOM <> nil then FreeAndNil(FUOM);
end;

destructor TTransferRequest.Destroy;
begin
  inherited;
  if FItems <> nil then
    FItems.Free;
end;

function TTransferRequest.GenerateNo: String;
var
  aDigitCount: Integer;
  aPrefix: string;
  lNum: Integer;
  S: string;
begin
  lNum := 0;
  aDigitCount := 4;
  aPrefix := Cabang + '.TRQ' + FormatDateTime('yymm',Now()) + '.';


  S := 'SELECT MAX(RefNo) FROM TTransferRequest where RefNo LIKE ' + QuotedStr(aPrefix + '%');

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
  Result := aPrefix + RightStr('0000' + IntToStr(lNum), aDigitCount);
end;

function TTransferRequest.GetItems: TObjectList<TTransferRequestItem>;
begin
  if FItems = nil then
  begin
    FItems := TObjectList<TTransferRequestItem>.Create();
  end;
  Result := FItems;
end;

function TTransferRequest.GetRefno: String;
begin
  Result := Refno;
end;

class procedure TTransferRequest.PrintData(aTransferReq: TTransferRequest);
var
  lCDS: TClientDataset;
  lDetail: TTransferRequestItem;
begin
  lCDS := TClientDataSet.Create(DMReport);
  Try
    lCDS.AddField('RefNo', ftString);
    lCDS.AddField('TransDate', ftDateTime);
    lCDS.AddField('Notes', ftString);
    lCDS.AddField('Kode', ftString);
    lCDS.AddField('Nama', ftString);
    lCDS.AddField('UOM', ftString);
    lCDS.AddField('Qty', ftFloat);
    lCDS.AddField('ModifiedDate', ftDateTime);
    lCDS.AddField('ModifiedBy', ftString);
    lCDS.CreateDataSet;


    for lDetail in aTransferReq.Items do
    begin
      lDetail.Item.ReLoad(False);
      lDetail.UOM.ReLoad(False);
      lCDS.Append;
      lCDS.FieldByName('RefNo').AsString := aTransferReq.Refno;
      lCDS.FieldByName('TransDate').AsDateTime := aTransferReq.TransDate;
      lCDS.FieldByName('Notes').AsString := aTransferReq.Notes;
      lCDS.FieldByName('ModifiedDate').AsDateTime := aTransferReq.ModifiedDate;
      lCDS.FieldByName('ModifiedBy').AsString := aTransferReq.ModifiedBy;
      lCDS.FieldByName('Kode').AsString := lDetail.Item.Kode;
      lCDS.FieldByName('Nama').AsString := lDetail.Item.Nama;
      lCDS.FieldByName('UOM').AsString := lDetail.UOM.UOM;
      lCDS.FieldByName('Qty').AsFloat := lDetail.Qty;
      lCDS.Post;
    end;


    DMReport.ExecuteReport('SlipTransferRequest', lCDS);
  Finally
//    if lCDS <> nil then
//      lCDS.Free;
  End;
end;

function TTransferRequest.SaveRepeat(DoShowMsg: Boolean = True; aRepeatCount: Integer =
    2): Boolean;
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
        Self.SetGenerateNo;
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

procedure TTransferRequest.SetGenerateNo;
begin
  if Self.ID = 0 then Self.RefNo := Self.GenerateNo;
end;

constructor TPurchaseReceive.Create;
begin
  inherited;

end;

destructor TPurchaseReceive.Destroy;
begin
  inherited;
  if FSupplier <> nil then FreeAndNil(FSupplier);
end;

function TPurchaseReceive.AfterSaveToDB: Boolean;
begin
  Result := True;
end;

function TPurchaseReceive.BeforeDeleteFromDB: Boolean;
var
  lAvg: TAvgCostUpdate;
begin
  for lAvg in Self.AvgCostItems do
  begin
    lAvg.RevertAvgCost;
  end;
  Result := True;
end;

function TPurchaseReceive.BeforeSaveToDB: Boolean;
begin
  GenerateAvgCost;
  Result := True;
end;

procedure TPurchaseReceive.GenerateAvgCost;
var
  i: Integer;
  lAvg: TAvgCostUpdate;
  lFound: Boolean;
  lItem: TTransDetail;
begin
  //AvgCostItems.Clear;
  //delete avgcostitems where item doesnt exist in transdetail
  for i := Self.AvgCostItems.Count-1 downto 0 do
  begin
    lAvg := Self.AvgCostItems[i];

    lFound := False;
    for lItem in Self.Items do
    begin
      lFound := lAvg.Item.ID = lItem.Item.ID;
      if lFound then break;
    end;

    if not lFound then
      Self.AvgCostItems.Delete(i);
  end;

  //clear transaksi
  for lAvg in Self.AvgCostItems do
  begin
    lAvg.TransTotalPCS    := 0;
    lAvg.TransTotalValue  := 0;
//    lAvg.TransDate        := Now();
  end;

  //create if not exit;
  for lItem in Self.Items do
  begin
    if lItem.Harga = 0 then continue;

    GetOrAddAvgCost(lItem);

    lItem.HargaAvg  := lItem.Harga;
    lItem.LastCost  := lItem.Harga;
  end;
end;

function TPurchaseReceive.GetAvgCostItems: TObjectList<TAvgCostUpdate>;
begin
  if FAvgCostItems = nil then
  begin
    FAvgCostItems := TObjectList<TAvgCostUpdate>.Create();
  end;
  Result := FAvgCostItems;
end;

function TPurchaseReceive.GenerateNo: String;
var
  aDigitCount: Integer;
  aPrefix: string;
  lNum: Integer;
  S: string;
begin
  lNum := 0;
  aDigitCount := 5;
  aPrefix := Cabang + '.BTB' + FormatDateTime('yymm',Now()) + '.';


  S := 'SELECT MAX(RecNo) FROM TPurchaseReceive where RecNo LIKE ' + QuotedStr(aPrefix + '%');

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

function TPurchaseReceive.GetHeaderFlag: Integer;
begin
  Result := HeaderFlag_PurchaseReceive;
end;

function TPurchaseReceive.GetOrAddAvgCost(aDetail: TTransDetail):
    TAvgCostUpdate;
var
  lAvg: TAvgCostUpdate;
  S: string;
begin
  Result := nil;
  for lAvg in Self.AvgCostItems do
  begin
    if lAvg.Item.ID = aDetail.Item.ID then
    begin
      Result := lAvg;
      break;
    end;
  end;

  if Result = nil then
  begin
    Result                    := TAvgCostUpdate.Create;
    Result.Item               := TItem.CreateID(aDetail.Item.ID);
    Result.Item.ReLoad(True);

    if Abs(Result.Item.GetAvgCostPCS(False) - (aDetail.Harga * aDetail.Konversi))<1 then
      exit;  //no need save this


    Result.LastStockPCS       := 0;
    Result.LastAvgCost        := 0;

    //getstock here
    S := 'select sum(qtypcs) from FN_STOCK_BYITEM(' + IntToStr(aDetail.Item.ID) + ', getdate())';
    with TDBUtils.OpenQuery(S) do
    begin
      Try
        if not eof then
        begin
          Result.LastStockPCS := Fields[0].AsFloat;
          Result.LastAvgCost  := Result.Item.GetAvgCostPCS(True);
        end;
      Finally
        Free;
      End;
    end;
    Self.AvgCostItems.Add(Result);
  end;

  Result.Refno            := Self.RecNo;
  Result.TransDate        := Now();
  Result.TransTotalPCS    := Result.TransTotalPCS + (aDetail.Qty * aDetail.Konversi);
  Result.TransTotalValue  := Result.TransTotalValue + (aDetail.Qty * aDetail.Harga);

end;

function TPurchaseReceive.GetRefno: String;
begin
  Result := RecNo;
end;

class procedure TPurchaseReceive.PrintData(aInvoiceID: Integer);
var
  S: string;
begin
  S := 'SELECT * FROM FN_SLIP_PURCHASERECEIVE(' + IntToStr(aInvoiceID) + ')';
  DMReport.ExecuteReport('SlipPurchaseReceive', S);
end;

procedure TPurchaseReceive.SetGenerateNo;
begin
  if Self.ID = 0 then Self.RecNo := Self.GenerateNo;
end;

function TPurchaseReceive.ValidateUpdate: Boolean;
var
  lQ: TFDQUery;
  S: string;
begin
  Result := True;

  if Self.ID = 0 then exit;


  S := 'select b.QTY'
      +' from TPURCHASERECEIVE a'
      +' inner join TPURCHASEINVOICEITEM b on a.id = b.PURCHASERECEIVE_ID '
      +' where a.id = ' + IntToStr(Self.ID);

  lQ := TDBUtils.OpenQuery(S);
  Try
    Result := lQ.eof;
  Finally
    lQ.Free;
  End;

end;

constructor TDeliveryOrder.Create;
begin
  inherited;
end;

destructor TDeliveryOrder.Destroy;
begin
  inherited;
  if FCustomer <> nil then FreeAndNil(FCustomer);
  if FWarehouse <> nil then FreeAndNil(FWarehouse);
end;

function TDeliveryOrder.BeforeSaveToDB: Boolean;
var
  lItem: TTransDetail;
begin
  for lItem in Self.Items do
  begin
    lItem.SetAvgCost;
    lItem.MakeNegative;
  end;

  Result := True;

  if Self.ID = 0 then exit;
end;

function TDeliveryOrder.GenerateNo: String;
var
  aDigitCount: Integer;
  aPrefix: string;
  fPrefix: string;
  lNum: Integer;
  S: string;
begin
  lNum := 0;
  aDigitCount := 5;
  fPrefix := 'DO';

  aPrefix := Cabang + '.' + fPrefix + FormatDateTime('yymm',Now()) + '.';
  S := 'SELECT MAX(DONo) FROM TDeliveryOrder where DONo LIKE ' + QuotedStr(aPrefix + '%');
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

function TDeliveryOrder.GetHeaderFlag: Integer;
begin
  Result := HeaderFlag_DeliveryOrder;
end;

function TDeliveryOrder.GetRefno: String;
begin
  Result := DONo;
end;

function TDeliveryOrder.LogLevel: Integer;
begin
  Result := 2; //0 : no log
  //1 : all
  //2 : update and delete only
 end;

class procedure TDeliveryOrder.PrintData(aSalesInvoiceID: Integer);
var
  S: string;
begin
  S := 'SELECT * FROM [FN_SLIP_DELIVERYORDER](' + IntToStr(aSalesInvoiceID) + ')';
  DMReport.ExecuteReport('SlipDeliveryOrder', S);
end;

procedure TDeliveryOrder.SetGenerateNo;
begin
  if Self.ID = 0 then Self.DONo := Self.GenerateNo();
end;

function TDeliveryOrder.ValidateUpdate: Boolean;
var
  lQ: TFDQUery;
  S: string;
begin
  Result := True;

  if Self.ID = 0 then exit;


  S := 'select b.QTY'
      +' from TDeliveryOrder a'
      +' inner join TSALESINVOICEITEM b on a.id = b.DELIVERYORDER_ID '
      +' where a.id = ' + IntToStr(Self.ID);

  lQ := TDBUtils.OpenQuery(S);
  Try
    Result := lQ.eof;
  Finally
    lQ.Free;
  End;

end;

end.
