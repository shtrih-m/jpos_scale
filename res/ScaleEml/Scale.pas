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
    raise Exception.Create('Неверная длина данных');
end;

function GetCommandText(Code: Integer): string;
begin
  case Code of
    $07: Result := 'Перейти в режим';
    $08: Result := 'Эмуляция клавиатуры';
    $09: Result := 'Блокировка/разблокировка клавиатуры';
    $12: Result := 'Запрос текущего режима весового модуля';
    $14: Result := 'Установка параметров обмена';
    $15: Result := 'Чтение параметров обмена';
    $16: Result := 'Изменение пароля администратора';
    $30: Result := 'Установить ноль';
    $31: Result := 'Установить тару';
    $32: Result := 'Задать тару';
    $3A: Result := 'Запрос состояния весового канала';
    $70: Result := 'Записать градуировочную точку';
    $71: Result := 'Прочитать градуировочную точку';
    $72: Result := 'Начать градуировку';
    $73: Result := 'Запрос состояния процесса градуировки';
    $74: Result := 'Прервать процесс градуировки';
    $75: Result := 'Получить показания АЦП для текущего канала';
    $90: Result := 'Запрос состояния клавиатуры';
    $E5: Result := 'Прочитать количество весовых каналов';
    $E6: Result := 'Выбрать весовой канал';
    $E7: Result := 'Включить / выключить текущий весовой канал';
    $E8: Result := 'Прочитать характеристики весового канала';
    $E9: Result := 'Записать характеристики весового канала';
    $EA: Result := 'Получить номер текущего весового канала';
    $EF: Result := 'Перезапуск текущего весового канала';
    $F0: Result := 'Сброс';
    $FC: Result := 'Получить тип устройства';
  else
    Result := 'Неизвестная команда';
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
