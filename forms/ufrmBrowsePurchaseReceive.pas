unit ufrmBrowsePurchaseReceive;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ufrmDefaultServerBrowse, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxContainer,
  Vcl.Menus, Vcl.ComCtrls, dxCore, cxDateUtils, cxClasses, cxLabel, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCalendar, Vcl.StdCtrls, cxButtons, cxGroupBox,
  cxGridLevel, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridServerModeTableView, cxGrid;

type
  TfrmBrowsePurchaseReceive = class(TfrmDefaultServerBrowse)
    procedure FormCreate(Sender: TObject);
    procedure btnBaruClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnHapusClick(Sender: TObject);
    procedure btnLihatClick(Sender: TObject);
    procedure cxGrdMainStylesGetContentStyle(Sender: TcxCustomGridTableView;
        ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle:
        TcxStyle);
    procedure btnPrintClick(Sender: TObject);
  private
    { Private declarations }
  protected
    function GetKeyField: string; override;
    function GetSQL: string; override;
  public
    function GetGroupName: string; override;
    { Public declarations }
  end;

var
  frmBrowsePurchaseReceive: TfrmBrowsePurchaseReceive;

implementation

uses
  uAppUtils, uDBUtils, uTransDetail, uDXUtils, System.DateUtils,
  ufrmPurchaseReceive;

{$R *.dfm}

procedure TfrmBrowsePurchaseReceive.FormCreate(Sender: TObject);
begin
  StartDate.Date := StartOfTheMonth(Now());
  EndDate.Date := EndOfTheMonth(Now());
  inherited;
end;

procedure TfrmBrowsePurchaseReceive.btnBaruClick(Sender: TObject);
begin
  inherited;
  with TfrmPurchaseReceive.Create(Application) do
  begin
    Try
      if ShowModalDlg = mrOK then
        RefreshData;
    Finally
      Free;
    End;
  end;
end;

procedure TfrmBrowsePurchaseReceive.btnEditClick(Sender: TObject);
begin
  inherited;
  with TfrmPurchaseReceive.Create(Application) do
  begin
    LoadByID(Self.cxGrdMain.GetID, False);
    Try
      if ShowModalDlg = mrOK then
        RefreshData;
    Finally
      Free;
    End;
  end;
end;

procedure TfrmBrowsePurchaseReceive.btnHapusClick(Sender: TObject);
begin
  inherited;
  if not TAppUtils.Confirm('Anda yakin menghapus data ini?') then exit;

  with TPurchaseReceive.Create do
  begin
    if LoadByID(Self.cxGrdMain.GetID) then
    begin
//      if not IsValidTransDate(TransDate) then exit;

      if DeleteFromDB then
      begin
        TAppUtils.Information('Berhasil menghapus data');
        RefreshData;
      end;
    end;
    Free;
  end;
end;

procedure TfrmBrowsePurchaseReceive.btnLihatClick(Sender: TObject);
begin
  inherited;
  with TfrmPurchaseReceive.Create(Application) do
  begin
    LoadByID(Self.cxGrdMain.GetID, True);
    Try
      ShowModalDlg;
    Finally
      Free;
    End;
  end;
end;

procedure TfrmBrowsePurchaseReceive.btnPrintClick(Sender: TObject);
var
  lInv: TPurchaseReceive;
begin
  inherited;
  lInv := TPurchaseReceive.Create;
  Try
    if lInv.LoadByID(Self.cxGrdMain.GetID) then
    begin
      TPurchaseReceive.PrintData(lInv.ID);
    end;
  finally
    lInv.Free;
  end;
end;

procedure TfrmBrowsePurchaseReceive.cxGrdMainStylesGetContentStyle(Sender:
    TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem:
    TcxCustomGridTableItem; var AStyle: TcxStyle);
//var
//  iCol: Integer;
begin
  inherited;
//  if cxGrdMain.GetColumnByFieldName('IsActive') = nil then exit;
//  if ARecord = nil then exit;
//
//  iCol := cxGrdMain.GetColumnByFieldName('IsActive').Index;
//  if VarToInt(ARecord.Values[iCol]) = 0 then
//    AStyle := styleNonActive;

end;

function TfrmBrowsePurchaseReceive.GetGroupName: string;
begin
  Result := 'Inventory';
end;

function TfrmBrowsePurchaseReceive.GetKeyField: string;
begin
  Result := 'id';
end;

function TfrmBrowsePurchaseReceive.GetSQL: string;
begin
  Result := 'SELECT A.ID, A.RECNO, A.TRANSDATE, B.NAMA AS SUPPLIER, '
           +' A.REFERENSI, C.NAMA AS GUDANG,'
           +' A.STATUS, A.CLOSED, A.MODIFIEDBY, A.MODIFIEDDATE'
           +' FROM TPURCHASERECEIVE A'
           +' INNER JOIN TSUPPLIER B ON A.SUPPLIER_ID = B.ID'
           +' LEFT JOIN TWAREHOUSE C ON A.WAREHOUSE_ID = C.ID'
           +' WHERE TRANSDATE BETWEEN ' + TAppUtils.QuotD(StartDate.Date)
           +' AND ' + TAppUtils.QuotD(EndDate.Date);

end;

end.
