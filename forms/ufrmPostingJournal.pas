unit ufrmPostingJournal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ufrmDefaultInput, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  Vcl.Menus, cxStyles, cxClasses, Vcl.StdCtrls, Vcl.ExtCtrls, cxButtons,
  cxGroupBox, Vcl.ComCtrls, dxCore, cxDateUtils, cxDropDownEdit, cxCalendar,
  cxLabel, cxSpinEdit, cxTextEdit, cxMaskEdit, DateUtils, uDBUtils,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxGridLevel,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridServerModeTableView, cxGrid, uDXUtils, Data.DB, cxDBData,
  cxGridDBTableView, cxPropertiesStore;

type
  TfrmPostingJournal = class(TfrmDefaultInput)
    cxGroupBox1: TcxGroupBox;
    cbMonth: TcxComboBox;
    cbBulan: TCheckBox;
    spYear: TcxSpinEdit;
    cxLabel3: TcxLabel;
    dtStart: TcxDateEdit;
    cxLabel1: TcxLabel;
    dtEnd: TcxDateEdit;
    cxGrid: TcxGrid;
    cxGridLevel1: TcxGridLevel;
    cxPropertiesStore1: TcxPropertiesStore;
    cxGrdMain: TcxGridDBTableView;
    procedure FormCreate(Sender: TObject);
    procedure cbBulanClick(Sender: TObject);
    procedure cbMonthPropertiesChange(Sender: TObject);
    procedure spYearPropertiesChange(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
  private
    procedure PostingJournal;
    procedure PreviewData;
    procedure SetDefaultPeriod;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPostingJournal: TfrmPostingJournal;

implementation

uses
  uAppUtils;

{$R *.dfm}

procedure TfrmPostingJournal.cbMonthPropertiesChange(Sender: TObject);
begin
  inherited;
  SetDefaultPeriod;
end;

procedure TfrmPostingJournal.FormCreate(Sender: TObject);
begin
  inherited;
  cbBulan.Enabled := True;
  cbBulanClick(Self);

  cbMonth.ItemIndex := MonthOf(Now())-1;
  spYear.Value      := YearOf(Now());

  SetDefaultPeriod;
end;

procedure TfrmPostingJournal.btnPrintClick(Sender: TObject);
begin
  inherited;
  PreviewData;
end;

procedure TfrmPostingJournal.btnSaveClick(Sender: TObject);
begin
  inherited;
  if TAppUtils.Confirm('Anda yakin melakukan posting periode terpilih?') then
    PostingJournal;

end;

procedure TfrmPostingJournal.cbBulanClick(Sender: TObject);
begin
  inherited;
  dtStart.Enabled := not cbBulan.Enabled;
  dtEnd.Enabled := not cbBulan.Enabled;

end;

procedure TfrmPostingJournal.PostingJournal;
var
  S: string;
begin
  S := 'exec SP_PostingJournal ' + TAppUtils.QuotD(dtStart.Date)
      + ',' + TAppUtils.QuotD(dtEnd.Date);
  if TDBUtils.ExecuteSQL(S) then
    TAppUtils.Information('Berhasil Posting Journal');
end;

procedure TfrmPostingJournal.PreviewData;
var
  S: string;
begin
  S := 'SELECT A.TRANSDATE, A.REFNO, A.DESCRIPTION, '
      +' A.ACCOUNTCODE, B.NAMA AS ACCOUNTNAME, A.DEBET, A.CREDIT, '
      +' A.COSTCENTER, A.TRANSTYPE, A.MODIFIEDDATE, A.MODIFIEDBY, A.FLAGNO '
      +' FROM [FN_JOURNAL_ALL](' + TAppUtils.QuotD(dtStart.Date)
      + ', ' + TAppUtils.QuotD(dtEnd.Date) +') A  '
      +' INNER JOIN TACCOUNT B ON A.ACCOUNTCODE = B.KODE  '
      +' ORDER BY A.TRANSDATE,  A.REFNO,  A.FLAGNO ' ;

  cxGrdMain.LoadFromSQL(S);
  cxGrdMain.SetSummaryByColumns(['debet','credit']);
end;

procedure TfrmPostingJournal.SetDefaultPeriod;
var
  lDate: TDateTime;
begin
  lDate := EncodeDate(spYear.Value, cbMonth.ItemIndex+1, 1);

  dtStart.Date  := StartOfTheMonth(lDate);
  dtEnd.Date    := EndOfTheMonth(lDate);

end;

procedure TfrmPostingJournal.spYearPropertiesChange(Sender: TObject);
begin
  inherited;
  SetDefaultPeriod;
end;

end.
