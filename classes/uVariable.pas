unit uVariable;

interface

uses
  System.Classes, uCustomer, System.SysUtils, Datasnap.DBClient, uAccount;

type
  TVariable = class(TComponent)
  private
    FDef_Cust_Bengkel: string;
    FKode_Pusat: string;
    FKode_Cabang: string;
    FAlamat_1: string;
    FAlamat_2: string;
    FDef_Cust_Umum: string;
    FTelp: string;
    FDef_Rekening: string;
    FAccount_Expense: string;
    FAccount_OtherIncome: string;
    FAccount_Inventory: string;
    FAccount_COGS: string;
    FAccount_AR: string;
    FAccount_AP: string;
    FAccount_DP: string;
    FAccount_TempAP: string;
    FAccount_StockAdjustment: string;
    FNama_Cabang: string;
    FToleransi_Piutang: Double;
    FCheck_Stock: Integer;
    FCheck_CreditLimit: Integer;
  public
    function GetAccountExpense: TAccount;
    function GetAccountOthIncome: TAccount;
    procedure LoadVariable;
    function UpdateVariable: Boolean;
    property Def_Cust_Bengkel: string read FDef_Cust_Bengkel write
        FDef_Cust_Bengkel;
    property Kode_Pusat: string read FKode_Pusat write FKode_Pusat;
    property Kode_Cabang: string read FKode_Cabang write FKode_Cabang;
    property Alamat_1: string read FAlamat_1 write FAlamat_1;
    property Alamat_2: string read FAlamat_2 write FAlamat_2;
    property Def_Cust_Umum: string read FDef_Cust_Umum write FDef_Cust_Umum;
    property Telp: string read FTelp write FTelp;
    property Def_Rekening: string read FDef_Rekening write FDef_Rekening;
    property Account_Expense: string read FAccount_Expense write FAccount_Expense;
    property Account_OtherIncome: string read FAccount_OtherIncome write
        FAccount_OtherIncome;
    property Account_Inventory: string read FAccount_Inventory write
        FAccount_Inventory;
    property Account_COGS: string read FAccount_COGS write FAccount_COGS;
    property Account_AR: string read FAccount_AR write FAccount_AR;
    property Account_AP: string read FAccount_AP write FAccount_AP;
    property Account_DP: string read FAccount_DP write FAccount_DP;
    property Account_TempAP: string read FAccount_TempAP write FAccount_TempAP;
    property Account_StockAdjustment: string read FAccount_StockAdjustment write
        FAccount_StockAdjustment;
    property Nama_Cabang: string read FNama_Cabang write FNama_Cabang;
    property Toleransi_Piutang: Double read FToleransi_Piutang write
        FToleransi_Piutang;
    property Check_Stock: Integer read FCheck_Stock write FCheck_Stock;
    property Check_CreditLimit: Integer read FCheck_CreditLimit write
        FCheck_CreditLimit;
  end;


var
  AppVariable  : TVariable;
//  User : TUser;

implementation

uses
  uDBUtils, Data.DB, Vcl.Forms;

function TVariable.GetAccountExpense: TAccount;
begin
//  Result := nil;
  if Account_Expense = '' then
    raise Exception.Create('Account Expense belum diset');

  Result := TAccount.Create;
  Result.LoadByCode(Account_Expense);
end;

function TVariable.GetAccountOthIncome: TAccount;
begin
//  Result := nil;
  if Account_OtherIncome = '' then
    raise Exception.Create('Account Other Income belum diset');

  Result := TAccount.Create;
  Result.LoadByCode(Account_OtherIncome);
end;

procedure TVariable.LoadVariable;
var
  lCDS: TClientDataset;
  S: string;
begin
  S := 'select * from TVariable';
  lCDS := TDBUtils.OpenDataset(S, nil);
  Try
    //def
    Toleransi_Piutang := 100;

    if lCDS.Locate('varname','Kode_Pusat',[loCaseInsensitive]) then
      Kode_Pusat := lCDS.FieldByName('VarValue').AsString;
    if lCDS.Locate('varname','Kode_Cabang',[loCaseInsensitive]) then
      Kode_Cabang := lCDS.FieldByName('VarValue').AsString;
    if lCDS.Locate('varname','Alamat_1',[loCaseInsensitive]) then
      Alamat_1 := lCDS.FieldByName('VarValue').AsString;
    if lCDS.Locate('varname','Alamat_2',[loCaseInsensitive]) then
      Alamat_2 := lCDS.FieldByName('VarValue').AsString;
    if lCDS.Locate('varname','Telp',[loCaseInsensitive]) then
      Telp := lCDS.FieldByName('VarValue').AsString;
    if lCDS.Locate('varname','Def_Cust_Umum',[loCaseInsensitive]) then
      Def_Cust_Umum := lCDS.FieldByName('VarValue').AsString;
//    if lCDS.Locate('varname','Def_Cust_Bengkel',[loCaseInsensitive]) then
//      Def_Cust_Bengkel := lCDS.FieldByName('VarValue').AsString;
    if lCDS.Locate('varname','Def_Rekening',[loCaseInsensitive]) then
      Def_Rekening := lCDS.FieldByName('VarValue').AsString;
    if lCDS.Locate('varname','Toleransi_Piutang',[loCaseInsensitive]) then
      Toleransi_Piutang := lCDS.FieldByName('VarValue').AsFloat;
    if lCDS.Locate('varname','Account_Expense',[loCaseInsensitive]) then
      Account_Expense := lCDS.FieldByName('VarValue').AsString;
    if lCDS.Locate('varname','Account_OtherIncome',[loCaseInsensitive]) then
      Account_OtherIncome := lCDS.FieldByName('VarValue').AsString;
    if lCDS.Locate('varname','Nama_Cabang',[loCaseInsensitive]) then
      Nama_Cabang := lCDS.FieldByName('VarValue').AsString;

    if lCDS.Locate('varname','Check_Stock',[loCaseInsensitive]) then
      Check_Stock := lCDS.FieldByName('VarValue').AsInteger;

    if lCDS.Locate('varname','Check_CreditLimit',[loCaseInsensitive]) then
      Check_CreditLimit := lCDS.FieldByName('VarValue').AsInteger;

    if lCDS.Locate('varname','Account_Inventory',[loCaseInsensitive]) then
      Account_Inventory := lCDS.FieldByName('VarValue').AsString;

    if lCDS.Locate('varname','Account_COGS',[loCaseInsensitive]) then
      Account_COGS := lCDS.FieldByName('VarValue').AsString;

    if lCDS.Locate('varname','Account_AR',[loCaseInsensitive]) then
      Account_AR := lCDS.FieldByName('VarValue').AsString;

    if lCDS.Locate('varname','Account_AP',[loCaseInsensitive]) then
      Account_AP := lCDS.FieldByName('VarValue').AsString;

    if lCDS.Locate('varname','Account_TempAP',[loCaseInsensitive]) then
      Account_TempAP := lCDS.FieldByName('VarValue').AsString;

    if lCDS.Locate('varname','Account_DP',[loCaseInsensitive]) then
      Account_DP := lCDS.FieldByName('VarValue').AsString;

    if lCDS.Locate('varname','Account_StockAdjustment',[loCaseInsensitive]) then
      Account_StockAdjustment := lCDS.FieldByName('VarValue').AsString;

  Finally
    lCDS.Free;
  End;
end;

function TVariable.UpdateVariable: Boolean;
var
  SS: TStrings;
begin
  SS := TStringList.Create;
  Try
    SS.Add('delete from TVariable;');
    SS.Add('insert into tvariable(varname, varvalue) values(''Kode_Pusat'','
      + QuotedStr(Kode_Pusat) + ');');
    SS.Add('insert into tvariable(varname, varvalue) values(''Kode_Cabang'','
      + QuotedStr(Kode_Cabang) + ');');
    SS.Add('insert into tvariable(varname, varvalue) values(''Alamat_1'','
      + QuotedStr(Alamat_1) + ');');
    SS.Add('insert into tvariable(varname, varvalue) values(''Alamat_2'','
      + QuotedStr(Alamat_2) + ');');
    SS.Add('insert into tvariable(varname, varvalue) values(''Telp'','
      + QuotedStr(Telp) + ');');
    SS.Add('insert into tvariable(varname, varvalue) values(''Def_Cust_Umum'','
      + QuotedStr(Def_Cust_Umum) + ');');
//    SS.Add('insert into tvariable(varname, varvalue) values(''Def_Cust_Bengkel'','
//      + QuotedStr(Def_Cust_Bengkel) + ');');

    SS.Add('insert into tvariable(varname, varvalue) values(''Def_Rekening'','
      + QuotedStr(Def_Rekening) + ');');

    SS.Add('insert into tvariable(varname, varvalue) values(''Toleransi_Piutang'','
      + FloatToStr(Toleransi_Piutang) + ');');

    SS.Add('insert into tvariable(varname, varvalue) values(''Account_Expense'','
      + QuotedStr(Account_Expense) + ');');
    SS.Add('insert into tvariable(varname, varvalue) values(''Account_OtherIncome'','
      + QuotedStr(Account_OtherIncome) + ');');
    SS.Add('insert into tvariable(varname, varvalue) values(''Nama_Cabang'','
      + QuotedStr(Nama_Cabang) + ');');

    SS.Add('insert into tvariable(varname, varvalue) values(''Check_Stock'','
      + IntToStr(Check_Stock) + ');');

    SS.Add('insert into tvariable(varname, varvalue) values(''Check_CreditLimit'','
      + IntToStr(Check_CreditLimit) + ');');

    SS.Add('insert into tvariable(varname, varvalue) values(''Account_Inventory'','
      + QuotedStr(Account_Inventory) + ');');

    SS.Add('insert into tvariable(varname, varvalue) values(''Account_COGS'','
      + QuotedStr(Account_COGS) + ');');

    SS.Add('insert into tvariable(varname, varvalue) values(''Account_AR'','
      + QuotedStr(Account_AR) + ');');

    SS.Add('insert into tvariable(varname, varvalue) values(''Account_AP'','
      + QuotedStr(Account_AP) + ');');

    SS.Add('insert into tvariable(varname, varvalue) values(''Account_TempAP'','
      + QuotedStr(Account_TempAP) + ');');

    SS.Add('insert into tvariable(varname, varvalue) values(''Account_DP'','
      + QuotedStr(Account_DP) + ');');

    SS.Add('insert into tvariable(varname, varvalue) values(''Account_StockAdjustment'','
      + QuotedStr(Account_StockAdjustment) + ');');


    Result := TDBUtils.ExecuteSQL(SS);
  Finally
    SS.Free;
  End;
end;

//initialization
//  AppVariable := TVariable.Create(Application);
//  AppVariable.LoadVariable;

end.
