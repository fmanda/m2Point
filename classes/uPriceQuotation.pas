unit uPriceQuotation;

interface

uses
  CRUDObject, uItem, System.Generics.Collections;

type
  TPriceQuotationItem = class;

  TPriceQuotation = class(TCRUDObject)
  private
    FRefno: String;
    FTransDate: TDatetime;
    FIsActive: Integer;
    FDateActivated: TDatetime;
    FItems: TObjectList<TPriceQuotationItem>;
    FNotes: String;
    FModifiedBy: String;
    FModifiedDate: TDateTime;
    function GetItems: TObjectList<TPriceQuotationItem>;
  protected
    function AfterSaveToDB: Boolean; override;
    function BeforeSaveToDB: Boolean; override;
  public
    destructor Destroy; override;
    function GenerateNo: String;
    property Items: TObjectList<TPriceQuotationItem> read GetItems write FItems;
  published
    [AttributeOfCode]
    property Refno: String read FRefno write FRefno;
    property TransDate: TDatetime read FTransDate write FTransDate;
    property IsActive: Integer read FIsActive write FIsActive;
    property DateActivated: TDatetime read FDateActivated write FDateActivated;
    property Notes: String read FNotes write FNotes;
    property ModifiedBy: String read FModifiedBy write FModifiedBy;
    property ModifiedDate: TDateTime read FModifiedDate write FModifiedDate;
  end;

  TPriceQuotationItem = class(TCRUDObject)
  private
    FItem: TItem;
    FUOM: TUOM;
    FKonversi: Double;
    FHargaBeli: Double;
    FHargaJual: Double;
    FQuotation: TPriceQuotation;
    FModifiedDate: TDateTime;
    FModifiedBy: String;
  public
    destructor Destroy; override;
  published
    property Item: TItem read FItem write FItem;
    property UOM: TUOM read FUOM write FUOM;
    property Konversi: Double read FKonversi write FKonversi;
    property HargaBeli: Double read FHargaBeli write FHargaBeli;
    property HargaJual: Double read FHargaJual write FHargaJual;
    [AttributeOfHeader]
    property Quotation: TPriceQuotation read FQuotation write FQuotation;
    property ModifiedDate: TDateTime read FModifiedDate write FModifiedDate;
    property ModifiedBy: String read FModifiedBy write FModifiedBy;
  end;

implementation

uses
  uVariable, uDBUtils, Strutils, System.SysUtils;

destructor TPriceQuotation.Destroy;
begin
  inherited;
  if FItems <> nil then FItems.Free;
end;

function TPriceQuotation.AfterSaveToDB: Boolean;
var
  S : string;
begin
  Result := True;
  if Self.IsActive <> 1 then exit;

  S := 'UPDATE C SET'
      +' C.HARGABELI = B.HARGABELI,'
      +' C.HARGAJUAL = B.HARGAJUAL,'
      +' C.MODIFIEDDATE = GETDATE(),'
      +' C.MODIFIEDBY = A.MODIFIEDBY'
      +' FROM TPRICEQUOTATION A'
      +' INNER JOIN TPRICEQUOTATIONITEM B ON A.ID = B.QUOTATION_ID'
      +' INNER JOIN TITEMUOM C ON B.ITEM_ID = C.ITEM_ID AND B.UOM_ID = C.UOM_ID'
      +' WHERE A.ID = ' + IntToStr(Self.ID);

  Result := TDBUtils.ExecuteSQL(S, False);
end;

function TPriceQuotation.BeforeSaveToDB: Boolean;
begin
  Result := True;
  if (Self.IsActive = 1) and (Self.DateActivated <= 0) then
    Self.DateActivated := Now();
//  if Result then      //migrasi update remain ke Payment
//    Result := Self.UpdateRemain(Self.TransDate);
end;

function TPriceQuotation.GenerateNo: String;
var
  aDigitCount: Integer;
  aPrefix: string;
  lNum: Integer;
  S: string;
begin
  lNum := 0;
  aDigitCount := 5;
  aPrefix := Cabang + '.PQ' + FormatDateTime('yymm',Now()) + '.';


  S := 'SELECT MAX(RefNo) FROM TPriceQuotation where Refno LIKE ' + QuotedStr(aPrefix + '%');

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

function TPriceQuotation.GetItems: TObjectList<TPriceQuotationItem>;
begin
  if FItems = nil then
    FItems := TObjectList<TPriceQuotationItem>.Create();
  Result := FItems;
end;

destructor TPriceQuotationItem.Destroy;
begin
  inherited;
  if FUOM <> nil then FUOM.Free;
  if FItem <> nil then FItem.Free;
end;

end.
