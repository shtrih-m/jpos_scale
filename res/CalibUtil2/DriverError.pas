unit DriverError;

interface

uses
  // VCL
  SysUtils;

type
  { EDriverError }

  EDriverError = class(Exception)
  private
   FErrorCode: Integer;
  public
    constructor Create2(Code: Integer; const Msg: string);

    property ErrorCode: Integer read FErrorCode write FErrorCode;
  end;

const
  E_ECR_FMOVERFLOW    = $14;
  E_ECR_PASSWORD      = $4F;

  E_NOERROR           =  0;
  E_NOHARDWARE        = -1;
  E_NOPORT            = -2;
  E_PORTBUSY          = -3;
  E_ANSWERLENGTH      = -7;
  E_UNKNOWN           = -8;
  E_INVALIDPARAM      = -9;
  E_NOTSUPPORTED      = -12;
  E_NOTLOADED         = -16;
  E_PORTLOCKED        = -18;
  E_REMOTECONNECTION  = -19;
  E_USERBREAK	        = -30;
  E_MP_SALEERROR      = -31;
  E_MP_CHECKOPENED    = -32;
  E_MP_PAYERROR       = -33;
  E_NOPAPER           = -34;
  E_RESET             = -35;
  E_MODELNOTFOUND     = -36;
  E_MODELSFILEERROR   = -37;

function DRV_SUCCESS(Value: Integer): Boolean;
procedure RaiseError(Code: Integer; const Message: string);

implementation

function DRV_SUCCESS(Value: Integer): Boolean;
begin
  Result := Value = E_NOERROR;
end;

{ EDriverError }

constructor EDriverError.Create2(Code: Integer; const Msg: string);
begin
  inherited Create(Msg);
  FErrorCode := Code;
end;

procedure RaiseError(Code: Integer; const Message: string);
begin
  raise EDriverError.Create2(Code, Message);
end;

end.
