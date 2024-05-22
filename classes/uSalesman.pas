unit uSalesman;

interface

uses CRUDObject;

type
  TSalesman = class(TCRUDObject)
  private
    FAlamat: String;
    FKode: String;
    FNama: String;
    FIsActive: Integer;
    FTelp: string;
  public
    constructor Create;
  published
    property Alamat: String read FAlamat write FAlamat;
    [AttributeOfCode]
    property Kode: String read FKode write FKode;
    property Nama: String read FNama write FNama;
    property IsActive: Integer read FIsActive write FIsActive;
    property Telp: string read FTelp write FTelp;
  end;

implementation

constructor TSalesman.Create;
begin
  inherited;
  IsActive := 1;
end;

end.
