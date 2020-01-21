unit SMType;

interface

uses Windows, SMConsts;

const
  BaudRates:array[0..6] of integer=(CBR_2400,CBR_4800,CBR_9600,
                              CBR_19200,CBR_38400,CBR_57600,
                              CBR_115200);
  strBaudRates:array[0..6] of string=('2400','4800','9600',
                              '19200','38400','57600',
                              '115200');

type
  PDeviceType=^TDeviceType;
  TDeviceType=packed record
    UMajorType:byte;
    UMinorType:byte;
    UMajorProtocol:byte;
    UMinorProtocol:byte;
    UModel:byte;
    UCodePage:byte;
    UDescription:array[1..40]of char;
  end;

  PLDRec = ^TLDRec;
  TLDRec =record
    Name:string;
    ComNumber:byte;
    BaudRate:byte;
    UNumber: Cardinal;
    Timeout: byte;
  end;

  PChannel=^TChannel;
  TChannel=packed record
    Flags: word;
    PointPosition: byte;
    Stepen: shortint;
    MaxWeight: word;
    MinWeight: word;
    MaxTare: word;
    Range1: word;
    Range2: word;
    Range3: word;
    Discreteness1: byte;
    Discreteness2: byte;
    Discreteness3: byte;
    Discreteness4: byte;
    PointsCount: byte;
    CalibrationsCount: byte;
  end;



implementation

end.

