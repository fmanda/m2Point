unit ufrmCashReceiptReport;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ufrmDefaultReport, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  Vcl.Menus, cxStyles, cxClasses, Vcl.StdCtrls, cxButtons, cxLabel, cxGroupBox,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, Datasnap.DBClient, Vcl.ComCtrls, dxCore,
  cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, uDBUtils,
  DateUtils;

type
  TfrmCashReceiptReport = class(TfrmDefaultReport)
    cxGrid1: TcxGrid;
    cxGrdMain: TcxGridDBTableView;
    cxGrdDetail: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1Level2: TcxGridLevel;
    cxGroupBox3: TcxGroupBox;
    cxLabel3: TcxLabel;
    StartDate: TcxDateEdit;
    cxLabel1: TcxLabel;
    EndDate: TcxDateEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
  private
    FCDSDetail: TClientDataset;
    FCDSMain: TClientDataset;
    function GetCDSMain: TClientDataset;
    procedure RefreshData;
    property CDSDetail: TClientDataset read FCDSDetail write FCDSDetail;
    property CDSMain: TClientDataset read GetCDSMain write FCDSMain;
    { Private declarations }
  public
    function GetGroupName: string; override;
    { Public declarations }
  end;

var
  frmCashReceiptReport: TfrmCashReceiptReport;

implementation

uses
  uDXUtils, uAppUtils;

{$R *.dfm}

procedure TfrmCashReceiptReport.btnRefreshClick(Sender: TObject);
begin
  inherited;
  RefreshData;
end;

procedure TfrmCashReceiptReport.FormCreate(Sender: TObject);
begin
  inherited;
  StartDate.Date := StartOfTheMonth(Now());
  EndDate.Date := EndOfTheMonth(Now());
end;

function TfrmCashReceiptReport.GetCDSMain: TClientDataset;
begin
  if FCDSMain = nil then
  begin
    FCDSMain := TClientDataSet.Create(Self);
    FCDSMain.AddField('Salesman', ftString);
    FCDSMain.AddField('Customer', ftString);
    FCDSMain.AddField('Current', ftFloat);
    FCDSMain.AddField('Range1', ftFloat);
    FCDSMain.AddField('Range2', ftFloat);
    FCDSMain.AddField('Range3', ftFloat);
    FCDSMain.AddField('Range4', ftFloat);
    FCDSMain.AddField('Total', ftFloat);
    FCDSMain.CreateDataSet;
  end;
  Result := FCDSMain;
end;

function TfrmCashReceiptReport.GetGroupName: string;
begin
  Result := 'Penjualan & Kas';
end;

procedure TfrmCashReceiptReport.RefreshData;
var
  lParent: string;
  S: string;

begin
  lParent := 'REFNO';

  if CDSMain <> nil then
    FreeAndNil(FCDSMain);

  S := 'select a.REFNO, a.TRANSDATE, d.NAMA as REKENING, A.NOTES,'
      +' C.NAMA AS CUSTOMER, A.AMOUNT, SUM(ISNULL(B.AMOUNT,0)) AS PAIDAMT,'
      +' A.AMOUNT - SUM(ISNULL(B.AMOUNT,0)) AS REMAIN, A.MODIFIEDDATE, A.MODIFIEDBY'
      +' from TCASHRECEIPT a'
      +' left join TARSETTLEMENT b on a.id = b.CASHRECEIPT_ID'
      +' inner join TCUSTOMER c on a.CUSTOMER_ID = c.ID'
      +' left join TREKENING d on a.REKENING_ID = d.ID'
      +' where cast(a.transdate as date) between ' + TAppUtils.QuotD(StartDate.Date)
      +' and  ' + TAppUtils.QuotD(EndDate.Date)
      +' GROUP BY a.REFNO, a.TRANSDATE, d.NAMA , A.NOTES,'
      +' C.NAMA , A.AMOUNT, A.MODIFIEDDATE, A.MODIFIEDBY ';
  FCDSMain := TDBUtils.OpenDataset(S, Self);

  if CDSDetail <> nil then
    FreeAndNil(FCDSDetail);

  S := 'select A.REFNO,  b.REFNO AS SETTLEMENT, b.TRANSDATE, b.NOTES, b.AMOUNT '
      +' from TCASHRECEIPT a '
      +' inner join TARSETTLEMENT b on a.id = b.CASHRECEIPT_ID '
      +' where cast(a.transdate as date) between ' + TAppUtils.QuotD(StartDate.Date)
      +' and  ' + TAppUtils.QuotD(EndDate.Date);

  FCDSDetail := TDBUtils.OpenDataset(S, Self);

  cxGrdMain.LoadFromCDS(CDSMain);
  cxGrdDetail.LoadFromCDS(CDSDetail);


  cxGrdDetail.SetMasterKeyField(lParent);
  cxGrdDetail.SetDetailKeyField(lParent);
  cxGrdMain.EnableFiltering();

  cxGrdMain.SetSummaryByColumns(['amount','paidamt','REMAIN']);
  cxGrdDetail.SetSummaryByColumns(['amount']);

  cxGrdDetail.SetColumnsWidth(['REFNO','SETTLEMENT','TRANSDATE','NOTES', 'AMOUNT'],[94,94,94,150,94]);
end;

end.
