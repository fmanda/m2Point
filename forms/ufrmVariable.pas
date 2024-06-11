unit ufrmVariable;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ufrmDefaultInput, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  Vcl.Menus, cxStyles, cxDataControllerConditionalFormattingRulesManagerDialog,
  cxVGrid, cxInplaceContainer, Vcl.StdCtrls, Vcl.ExtCtrls, cxButtons, cxGroupBox,
  cxTextEdit, cxDBExtLookupComboBox, cxButtonEdit, uVariable, cxClasses,
  cxCurrencyEdit, cxRadioGroup;

type
  TfrmVariable = class(TfrmDefaultInput)
    cxVertGrid: TcxVerticalGrid;
    cxVertGridCategoryRow1: TcxCategoryRow;
    colKodePusat: TcxEditorRow;
    colKodeCabang: TcxEditorRow;
    colAlamat1: TcxEditorRow;
    colAlamat2: TcxEditorRow;
    colTelpCabang: TcxEditorRow;
    cxVertGridCategoryRow2: TcxCategoryRow;
    colDefCustBengkel: TcxEditorRow;
    colDefCustUmum: TcxEditorRow;
    colDefRekening: TcxEditorRow;
    colCOAPengeluaran: TcxEditorRow;
    colCOAPendapatan: TcxEditorRow;
    colNamaCabang: TcxEditorRow;
    colToleransiPiutang: TcxEditorRow;
    colCheckStock: TcxEditorRow;
    colCheckCreditLimit: TcxEditorRow;
    colCOAInventory: TcxEditorRow;
    colCOACOGS: TcxEditorRow;
    colCOAAR: TcxEditorRow;
    colCOAAP: TcxEditorRow;
    colCOADP: TcxEditorRow;
    colCOATempAP: TcxEditorRow;
    colCOAStockAdjustment: TcxEditorRow;
    cxVertGridCategoryRow3: TcxCategoryRow;
    procedure FormCreate(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure colDefCustUmumEditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure colDefCustBengkelEditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure colDefRekeningEditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure colKodePusatEditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure colKodeCabangEditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure colCOAPengeluaranEditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure colCOAPendapatanEditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure colCOAInventoryEditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure colCOACOGSEditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure colCOAAREditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure colCOATempAPEditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure colCOAAPEditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure colCOADPEditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure colCOAStockAdjustmentEditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
  private
    procedure LoadVariable;
    procedure LookupCustomer(AEditor: TcxEditorRow);
    procedure LookupRekening(AEditor: TcxEditorRow);
    procedure LookupCabang(AEditor: TcxEditorRow);
    procedure LookupAccount(AEditor: TcxEditorRow);
    { Private declarations }
  public
    function GetGroupName: string; override;
    { Public declarations }
  end;

var
  frmVariable: TfrmVariable;

implementation

uses
  uAppUtils, uDXUtils, ufrmCXServerLookup;

{$R *.dfm}

procedure TfrmVariable.colCOAAPEditPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  inherited;
  LookupAccount(colCOATempAP);
end;

procedure TfrmVariable.colCOAAREditPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  inherited;
  LookupAccount(colCOAAR);
end;

procedure TfrmVariable.colCOACOGSEditPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  inherited;
  LookupAccount(colCOACOGS);
end;

procedure TfrmVariable.colCOADPEditPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  inherited;
  LookupAccount(colCOADP);
end;

procedure TfrmVariable.colCOAInventoryEditPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  inherited;
  LookupAccount(colCOAInventory);
end;

procedure TfrmVariable.colCOAPendapatanEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  LookupAccount(colCOAPendapatan);
end;

procedure TfrmVariable.colCOAPengeluaranEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  LookupAccount(colCOAPengeluaran);
end;

procedure TfrmVariable.colCOAStockAdjustmentEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  LookupAccount(colCOAStockAdjustment);
end;

procedure TfrmVariable.colCOATempAPEditPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  inherited;
  LookupAccount(colCOAAP);
end;

procedure TfrmVariable.colDefCustBengkelEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  LookupCustomer(colDefCustBengkel);
end;

procedure TfrmVariable.colDefCustUmumEditPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  inherited;
  LookupCustomer(colDefCustUmum);
end;

procedure TfrmVariable.colDefRekeningEditPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  inherited;
  LookupRekening(colDefRekening);
end;

procedure TfrmVariable.colKodeCabangEditPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  inherited;
  LookupCabang(colKodeCabang);
end;

procedure TfrmVariable.colKodePusatEditPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  inherited;
  LookupCabang(colKodePusat);
end;

procedure TfrmVariable.FormCreate(Sender: TObject);
begin
  inherited;
//  TcxExtLookup(colDefRekening.Properties.EditProperties).LoadFromSQL(Self,
//    'select kode, nama from trekening','nama','kode');
  LoadVariable;
end;

procedure TfrmVariable.btnSaveClick(Sender: TObject);
begin
  inherited;
  AppVariable.Kode_Pusat := colKodePusat.Properties.Value;
  AppVariable.Kode_Cabang := colKodeCabang.Properties.Value;
  AppVariable.Alamat_1 := colAlamat1.Properties.Value;
  AppVariable.Alamat_2 := colAlamat2.Properties.Value;
  AppVariable.Telp := colTelpCabang.Properties.Value;
  AppVariable.Def_Cust_Umum := colDefCustUmum.Properties.Value;
  AppVariable.Def_Cust_Bengkel := colDefCustBengkel.Properties.Value;
  AppVariable.Def_Rekening := colDefRekening.Properties.Value;
  AppVariable.Account_Expense := colCOAPengeluaran.Properties.Value;
  AppVariable.Account_OtherIncome := colCOAPendapatan.Properties.Value;
  AppVariable.Nama_Cabang := colNamaCabang.Properties.Value;
  AppVariable.Toleransi_Piutang := colToleransiPiutang.Properties.Value;
  AppVariable.Check_Stock := colCheckStock.Properties.Value;
  AppVariable.Check_CreditLimit := colCheckCreditLimit.Properties.Value;
  AppVariable.Account_Inventory := colCOAInventory.Properties.Value;
  AppVariable.Account_COGS := colCOACOGS.Properties.Value;
  AppVariable.Account_AR := colCOAAR.Properties.Value;
  AppVariable.Account_AP := colCOAAP.Properties.Value;
  AppVariable.Account_DP := colCOADP.Properties.Value;
  AppVariable.Account_TempAP := colCOATempAP.Properties.Value;
  AppVariable.Account_StockAdjustment := colCOAStockAdjustment.Properties.Value;



  if AppVariable.UpdateVariable then
    TAppUtils.Information('Variable Berhasil Diupdate');
end;

function TfrmVariable.GetGroupName: string;
begin
  Result := 'Aplikasi';
end;

procedure TfrmVariable.LoadVariable;
begin
  colNamaCabang.Properties.Value := AppVariable.Nama_Cabang;
  colKodePusat.Properties.Value := AppVariable.Kode_Pusat;
  colKodeCabang.Properties.Value := AppVariable.Kode_Cabang;
  colAlamat1.Properties.Value := AppVariable.Alamat_1;
  colAlamat2.Properties.Value := AppVariable.Alamat_2;
  colTelpCabang.Properties.Value := AppVariable.Telp;
  colDefCustUmum.Properties.Value := AppVariable.Def_Cust_Umum;
  colDefCustBengkel.Properties.Value := AppVariable.Def_Cust_Bengkel;
  colDefRekening.Properties.Value := AppVariable.Def_Rekening;
  colCOAPengeluaran.Properties.Value := AppVariable.Account_Expense;
  colCOAPendapatan.Properties.Value := AppVariable.Account_OtherIncome;
  colToleransiPiutang.Properties.Value := AppVariable.Toleransi_Piutang;

  colCOAInventory.Properties.Value := AppVariable.Account_Inventory;
  colCOACOGS.Properties.Value := AppVariable.Account_COGS;
  colCOAAR.Properties.Value := AppVariable.Account_AR;
  colCOAAP.Properties.Value := AppVariable.Account_AP;
  colCOADP.Properties.Value := AppVariable.Account_DP;
  colCOATempAP.Properties.Value := AppVariable.Account_TempAP;
  colCOAStockAdjustment.Properties.Value := AppVariable.Account_StockAdjustment;

  colCheckStock.Properties.Value := AppVariable.Check_Stock;
  colCheckCreditLimit.Properties.Value := AppVariable.Check_CreditLimit;
end;

procedure TfrmVariable.LookupCustomer(AEditor: TcxEditorRow);
var
  cxLookup: TfrmCXServerLookup;
  S: string;
begin
  S := 'select * from TCustomer';
  cxLookup := TfrmCXServerLookup.Execute(S, 'ID');
  Try
    cxLookup.PreFilter('Nama', '');
    if cxLookup.ShowModal = mrOK then
    begin

      AEditor.Properties.Value := cxLookup.FieldValue('Kode');
      Keybd_event(VK_RETURN, 0, 0, 0);
//      Self.Refresh;
    end;
  Finally
    cxLookup.Free;
  End;
end;

procedure TfrmVariable.LookupRekening(AEditor: TcxEditorRow);
var
  cxLookup: TfrmCXServerLookup;
  S: string;
begin
  S := 'select * from TRekening';
  cxLookup := TfrmCXServerLookup.Execute(S, 'ID');
  Try
    cxLookup.PreFilter('Nama', '');
    if cxLookup.ShowModal = mrOK then
    begin
      AEditor.Properties.Value := cxLookup.FieldValue('Kode');
      Keybd_event(VK_RETURN, 0, 0, 0);
    end;
  Finally
    cxLookup.Free;
  End;
end;

procedure TfrmVariable.LookupCabang(AEditor: TcxEditorRow);
var
  cxLookup: TfrmCXServerLookup;
  S: string;
begin
  S := 'select Project_Code as ID,  Project_Code, Project_Name from TProject';
  cxLookup := TfrmCXServerLookup.Execute(S, 'ID');
  Try
//    cxLookup.PreFilter('Nama', '');
    if cxLookup.ShowModal = mrOK then
    begin
      AEditor.Properties.Value := cxLookup.FieldValue('Project_Code');
      Keybd_event(VK_RETURN, 0, 0, 0);
    end;
  Finally
    cxLookup.Free;
  End;
end;

procedure TfrmVariable.LookupAccount(AEditor: TcxEditorRow);
var
  cxLookup: TfrmCXServerLookup;
  S: string;
begin
  S := 'select * from taccount';
  cxLookup := TfrmCXServerLookup.Execute(S, 'ID');
  Try
    cxLookup.PreFilter('Nama', '');
    if cxLookup.ShowModal = mrOK then
    begin
      AEditor.Properties.Value := cxLookup.FieldValue('Kode');
      Keybd_event(VK_RETURN, 0, 0, 0);
    end;
  Finally
    cxLookup.Free;
  End;
end;

end.
