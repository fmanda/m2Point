unit ufrmBrowseCashReceiptDP;

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
  TfrmBrowseCashReceiptDP = class(TfrmDefaultServerBrowse)
    procedure btnBaruClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnHapusClick(Sender: TObject);
    procedure btnLihatClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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
  frmBrowseCashReceiptDP: TfrmBrowseCashReceiptDP;

implementation

uses
  uAppUtils, ufrmCashReceiptDP, uDXUtils, System.DateUtils,
  uFinancialTransaction, uDBUtils;

{$R *.dfm}

procedure TfrmBrowseCashReceiptDP.btnBaruClick(Sender: TObject);
begin
  inherited;
  with TfrmCashReceiptDP.Create(Application) do
  begin
    Try
      if ShowModalDlg = mrOK then
        RefreshData;
    Finally
      Free;
    End;
  end;
end;

procedure TfrmBrowseCashReceiptDP.btnEditClick(Sender: TObject);
begin
  inherited;
  with TfrmCashReceiptDP.Create(Application) do
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

procedure TfrmBrowseCashReceiptDP.btnHapusClick(Sender: TObject);
begin
  inherited;
  if not TAppUtils.Confirm('Anda yakin menghapus data ini?') then exit;

  with TCashReceipt.Create do
  begin
    if LoadByID(Self.cxGrdMain.GetID) then
    begin
      if not IsValidTransDate(TransDate) then exit;

      if not ValidateUpdate then
      begin
        TAppUtils.Warning('CR sudah dilakukan settlement');
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

procedure TfrmBrowseCashReceiptDP.btnLihatClick(Sender: TObject);
begin
  inherited;
  with TfrmCashReceiptDP.Create(Application) do
  begin
    LoadByID(Self.cxGrdMain.GetID, True);
    Try
      ShowModalDlg;
    Finally
      Free;
    End;
  end;
end;

procedure TfrmBrowseCashReceiptDP.FormCreate(Sender: TObject);
begin
  StartDate.Date := StartOfTheMonth(Now());
  EndDate.Date := EndOfTheMonth(Now());
  inherited;
end;

function TfrmBrowseCashReceiptDP.GetGroupName: string;
begin
  Result := 'Penjualan & Kas';
end;

function TfrmBrowseCashReceiptDP.GetKeyField: string;
begin
  Result := 'id';
end;

function TfrmBrowseCashReceiptDP.GetSQL: string;
begin
  Result := 'SELECT A.ID, A.REFNO, A.TRANSDATE, B.NAMA AS REKENING_ASAL, A.AMOUNT, A.NOTES, A.MODIFIEDDATE, A.MODIFIEDBY'
           +' FROM TCASHRECEIPT A'
           +' LEFT JOIN TREKENING B ON A.REKENING_ID = B.ID'
           +' WHERE A.IS_DOWNPAYMENT=1 AND A.TRANSDATE BETWEEN ' + TAppUtils.QuotD(StartDate.Date)
           +' AND ' + TAppUtils.QuotD(EndDate.Date);

end;

end.
