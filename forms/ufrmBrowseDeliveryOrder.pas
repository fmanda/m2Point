unit ufrmBrowseDeliveryOrder;

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
  cxGridServerModeTableView, cxGrid, ufrmAuthUser;

type
  TfrmBrowseDeliveryOrder = class(TfrmDefaultServerBrowse)
    procedure btnBaruClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnHapusClick(Sender: TObject);
    procedure btnLihatClick(Sender: TObject);
    procedure cxGrdMainStylesGetContentStyle(Sender: TcxCustomGridTableView;
        ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle:
        TcxStyle);
    procedure FormCreate(Sender: TObject);
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
  frmBrowseDeliveryOrder: TfrmBrowseDeliveryOrder;

implementation

uses
  uDXUtils, uDBUtils, uAppUtils, ufrmDeliveryOrder, System.DateUtils,
  uTransDetail, uPrintStruk;

{$R *.dfm}

procedure TfrmBrowseDeliveryOrder.btnBaruClick(Sender: TObject);
begin
  inherited;
  with TfrmDeliveryOrder.Create(Application) do
  begin
    Try
      if ShowModalDlg = mrOK then
        RefreshData;
    Finally
      Free;
    End;
  end;
end;

procedure TfrmBrowseDeliveryOrder.btnEditClick(Sender: TObject);
begin
  inherited;
  with TfrmDeliveryOrder.Create(Application) do
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

procedure TfrmBrowseDeliveryOrder.btnHapusClick(Sender: TObject);
begin
  inherited;
  if not TAppUtils.Confirm('Anda yakin menghapus data ini?') then exit;

  with TDeliveryOrder.Create do
  begin
    if LoadByID(Self.cxGrdMain.GetID) then
    begin
      if not IsValidTransDate(TransDate) then exit;

//      if not TfrmAuthUser.Authorize('Autorisasi Hapus Faktur', InvoiceNo, TransDate ) then
//      begin
//        TAppUtils.Warning('User tidak mendapatkan autorisasi hapus faktur');
//        exit;
//      end;

      if not ValidateUpdate then
      begin
        TAppUtils.Warning('DO ini sudah dibuatkan invoice, tidak bisa dilakukan edit/hapus. Silahkan hapus DO dari invoice terlebih dahulu');
        exit;
      end;

      if DeleteFromDB then
      begin
        TAppUtils.Information('Berhasil menghapus data');
        RefreshData;
      end;
    end;
    Free;
  end;
end;

procedure TfrmBrowseDeliveryOrder.btnLihatClick(Sender: TObject);
begin
  inherited;
  with TfrmDeliveryOrder.Create(Application) do
  begin
    LoadByID(Self.cxGrdMain.GetID,  True);
    Try
      ShowModalDlg;
    Finally
      Free;
    End;
  end;
end;

procedure TfrmBrowseDeliveryOrder.btnPrintClick(Sender: TObject);
var
  lInv: TDeliveryOrder;
begin
  inherited;
  lInv := TDeliveryOrder.Create;
  Try
    if lInv.LoadByID(Self.cxGrdMain.GetID) then
    begin
      TDeliveryOrder.PrintData(lInv.ID);
    end;
  finally
    lInv.Free;
  end;
end;

procedure TfrmBrowseDeliveryOrder.cxGrdMainStylesGetContentStyle(Sender:
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

procedure TfrmBrowseDeliveryOrder.FormCreate(Sender: TObject);
begin
//  StartDate.Date := StartOfTheMonth(Now());
//  EndDate.Date := EndOfTheMonth(Now());
  inherited;
end;

function TfrmBrowseDeliveryOrder.GetGroupName: string;
begin
  Result := 'Penjualan & Kas';
end;

function TfrmBrowseDeliveryOrder.GetKeyField: string;
begin
  Result := 'id';
end;

function TfrmBrowseDeliveryOrder.GetSQL: string;
begin
  Result := 'SELECT A.ID, A.DONO, A.TRANSDATE, B.NAMA AS CUSTOMER, A.NOTES,  C.NAMA AS GUDANG, '
           +' A.STATUS, A.CLOSED, A.MODIFIEDBY, A.MODIFIEDDATE '
           +' FROM TDELIVERYORDER A '
           +' LEFT JOIN TCUSTOMER B ON A.CUSTOMER_ID = B.ID '
           +' LEFT JOIN TWAREHOUSE C ON A.WAREHOUSE_ID = C.ID  '
           +' WHERE A.TRANSDATE BETWEEN ' + TAppUtils.QuotD(StartDate.Date)
           +' AND ' + TAppUtils.QuotD(EndDate.Date);

end;

end.
