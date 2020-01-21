unit Scale;

interface

uses
  // VCL
  SysUtils;

const
  /////////////////////////////////////////////////////////////////////////////
  // Command code constants

	CMD_WRITE_MODE            = $07;
	CMD_KEYBOARD              = $08;
	CMD_LOCK_KEYBOARD         = $09;
	CMD_READ_SCALE_MODE       = $12;
	CMD_WRITE_PARAM           = $14;
	CMD_READ_PARAM            = $15;
	CMD_WRITE_ADMIN_PASSWORD  = $16;
	CMD_ZERO                  = $30;
	CMD_TARA                  = $31;
	CMD_SET_TARA              = $32;
	CMD_READ_WEIGHT           = $3A;
	CMD_WRITE_CALIB_POINT     = $70;
	CMD_READ_CALIB_POINT      = $71;
	CMD_START_CALIBRATION     = $72;
	CMD_READ_CALIB_STATUS     = $73;
	CMD_STOP_CALIBRATION      = $74;
	CMD_READ_WEIGHT_ADC       = $75;
	CMD_READ_KBD_STATUS       = $90;
	CMD_READ_CHANNEL_COUNT    = $E5;
	CMD_SELECT_CHANNEL        = $E6;
	CMD_ENABLE_CHANNEL        = $E7;
	CMD_READ_CHANNEL_PARAMS   = $E8;
	CMD_WRITE_CHANNEL_PARAMS  = $E9;
	CMD_READ_CHANNEL_NUMBER   = $EA;
	CMD_RESET_CHANNEL         = $EF;
	CMD_RESET_DEVICE          = $F0;
	CMD_READ_DEVICE_METRICS   = $FC;

  /////////////////////////////////////////////////////////////////////////////
  // Mode constants

  SCALE_MODE_NORMAL       = 0;
  SCALE_MODE_CALIBRATION  = 1;


type
  { TSerialParams }

  TSerialParams = record
    PortNumebr: Integer;
    BaudRate: Integer;
    Timeout: Integer;
  end;

  { ISerialPort }

  ISerialPort = interface
    procedure Open(const Data: TSerialParams);
    procedure Close;
  end;

  { TScaleCommand }

  TScaleCommand = record
    Code: Integer;
    Data: string;
  end;

  { TScale }

  TScale = class
  private
    FMode: Integer;
    FStatus: string;
    procedure Execute(const Command: TScaleCommand);
  public
    procedure Open(const Params: TSerialParams);
    procedure Close;
    property Status: string read FStatus;
  end;

implementation

procedure CheckDataLength(const Data: string; MinLen: Integer);
begin
  if Length(Data) < MinLen then
    raise Exception.Create('�������� ����� ������');
end;

function GetCommandText(Code: Integer): string;
begin
  case Code of
    $07: Result := '������� � �����';
    $08: Result := '�������� ����������';
    $09: Result := '����������/������������� ����������';
    $12: Result := '������ �������� ������ �������� ������';
    $14: Result := '��������� ���������� ������';
    $15: Result := '������ ���������� ������';
    $16: Result := '��������� ������ ��������������';
    $30: Result := '���������� ����';
    $31: Result := '���������� ����';
    $32: Result := '������ ����';
    $3A: Result := '������ ��������� �������� ������';
    $70: Result := '�������� �������������� �����';
    $71: Result := '��������� �������������� �����';
    $72: Result := '������ �����������';
    $73: Result := '������ ��������� �������� �����������';
    $74: Result := '�������� ������� �����������';
    $75: Result := '�������� ��������� ��� ��� �������� ������';
    $90: Result := '������ ��������� ����������';
    $E5: Result := '��������� ���������� ������� �������';
    $E6: Result := '������� ������� �����';
    $E7: Result := '�������� / ��������� ������� ������� �����';
    $E8: Result := '��������� �������������� �������� ������';
    $E9: Result := '�������� �������������� �������� ������';
    $EA: Result := '�������� ����� �������� �������� ������';
    $EF: Result := '���������� �������� �������� ������';
    $F0: Result := '�����';
    $FC: Result := '�������� ��� ����������';
  else
    Result := '����������� �������';
  end;
end;

{ TScale }

procedure TScale.Close;
begin
  Port.Close;
end;

procedure TScale.Open(const Params: TSerialParams);
begin
  Port.PortNumber := Params.PortNumber;
  Port.BaudRate := Params.BaudRate;
  Port.Timeout := Params.Timeout;
  Port.Open;
end;

procedure TScale.SetModeCommand(const Data: string);
begin
  CheckDataLength(Data, 5);
  CheckPassword(Copy(Data, 1, 4));
  FMode := Ord(Data[5]);
end;

procedure TScale.Execute(const Command: TScaleCommand);
begin
  case Command.Code of
	  $07: SetModeCommand(Command.Data);
	  $08;
	CMD_LOCK_KEYBOARD         = $09;
	CMD_READ_SCALE_MODE       = $12;
	CMD_WRITE_PARAM           = $14;
	CMD_READ_PARAM            = $15;
	CMD_WRITE_ADMIN_PASSWORD  = $16;
	CMD_ZERO                  = $30;
	CMD_TARA                  = $31;
	CMD_SET_TARA              = $32;
	CMD_READ_WEIGHT           = $3A;
	CMD_WRITE_CALIB_POINT     = $70;
	CMD_READ_CALIB_POINT      = $71;
	CMD_START_CALIBRATION     = $72;
	CMD_READ_CALIB_STATUS     = $73;
	CMD_STOP_CALIBRATION      = $74;
	CMD_READ_WEIGHT_ADC       = $75;
	CMD_READ_KBD_STATUS       = $90;
	CMD_READ_CHANNEL_COUNT    = $E5;
	CMD_SELECT_CHANNEL        = $E6;
	CMD_ENABLE_CHANNEL        = $E7;
	CMD_READ_CHANNEL_PARAMS   = $E8;
	CMD_WRITE_CHANNEL_PARAMS  = $E9;
	CMD_READ_CHANNEL_NUMBER   = $EA;
	CMD_RESET_CHANNEL         = $EF;
	CMD_RESET_DEVICE          = $F0;
	CMD_READ_DEVICE_METRICS   = $FC;

end;

end.
