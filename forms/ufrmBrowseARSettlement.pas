unit ufrmBrowseARSettlement;

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
  cxGridServerModeTableView, cxGrid, cxCheckBox;

type
  TfrmBrowseARSettlement = class(TfrmDefaultServerBrowse)
    procedure btnBaruClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnHapusClick(Sender: TObject);
    procedure btnLihatClick(Sender: TObject);
    procedure cxGrdMainStylesGetContentStyle(Sender: TcxCustomGridTableView;
        ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle:
        TcxStyle);
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
  frmBrowseARSettlement: TfrmBrowseARSettlement;

implementation

uses
  ufrmARSettlement, uAppUtils, uDXUtils, uFinancialTransaction,
  System.DateUtils, uDBUtils;

{$R *.dfm}

procedure TfrmBrowseARSettlement.btnBaruClick(Sender: TObject);
begin
  inherited;
  with TfrmARSettlement.Create(Application) do
  begin
    Try
      if ShowModalDlg = mrOK then
        RefreshData;
    Finally
      Free;
    End;
  end;
end;

procedure TfrmBrowseARSettlement.btnEditClick(Sender: TObject);
begin
  inherited;
  with TfrmARSettlement.Create(Application) do
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

procedure TfrmBrowseARSettlement.btnHapusClick(Sender: TObject);
begin
  inherited;
  if not TAppUtils.Confirm('Anda yakin menghapus data ini?') then exit;

  with TARSettlement.Create do
  begin
    if LoadByID(Self.cxGrdMain.GetID) then
    begin
      if not IsValidTransDate(TransDate) then exit;
      if DeleteFromDB then
      begin
        TAppUtils.Information('Berhasil menghapus data');
        RefreshData;
      end;
    end;
    Free;
  end;
end;

procedure TfrmBrowseARSettlement.btnLihatClick(Sender: TObject);
begin
  inherited;
  with TfrmARSettlement.Create(Application) do
  begin
    LoadByID(Self.cxGrdMain.GetID, True);
    Try
      ShowModalDlg;
    Finally
      Free;
    End;
  end;
end;

procedure TfrmBrowseARSettlement.cxGrdMainStylesGetContentStyle(Sender:
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

procedure TfrmBrowseARSettlement.FormCreate(Sender: TObject);
begin
//  StartDate.Date := StartOfTheMonth(Now());
//  EndDate.Date := EndOfTheMonth(Now());
  inherited;
end;

function TfrmBrowseARSettlement.GetGroupName: string;
begin
  Result := 'Hutang & Piutang';
end;

function TfrmBrowseARSettlement.GetKeyField: string;
begin
  Result := 'id';
end;

function TfrmBrowseARSettlement.GetSQL: string;
begin
  Result := 'SELECT A.ID, A.REFNO, A.TRANSDATE, A.NOTES,'
           +' B.NAMA AS CUSTOMER, A.AMOUNT, A.RETURAMOUNT'
           +' FROM TARSettlement A'
           +' LEFT JOIN TCUSTOMER B ON A.CUSTOMER_ID = B.ID'
           +' WHERE A.TRANSDATE BETWEEN ' + TAppUtils.QuotD(StartDate.Date)
           +' AND ' + TAppUtils.QuotD(EndDate.Date);

 

end;

end.
