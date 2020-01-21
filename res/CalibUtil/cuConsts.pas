unit cuConsts;

interface

resourcestring
  // main
  stExit = 'Выйти';
  stBreak = 'Прервать';
  stNoCalibMode = 'Невозможно перейти в режим градуировки.'#13#10'Возможно, надо установить градуировочный переключатель'#13#10'в положение ВКЛ (ON).';
  stError  = 'Ошибка';
  stConfirmation = 'Вы уверены, что хотите прервать процесс градуировки?';
  stconfirmationTitle = 'Подтверждение';
  // page2
  stFlagYes = '<есть>';
  stFlagNo = '<нет>';
  stChannelNum = 'Канал №%d';
  stWCParams = 'Характеристики весового канала: %d';
  stFlags = 'Флаги:';
  stFlagChannelType = 'тип канала: %s';
  stChannelType1 = '<тензоканал>';
  stChannelType4 = '<неизвестный>';
  stFlagTareDevice = 'выборка массы тары: %s';
  stMax = 'НПВ: %8.3f кг';
  stMin = 'НмПВ: %8.3f кг';
  stMaxTare = 'Тара: %8.3f кг';
  stInterval = 'Диапазон №%d: %8.3f-%8.3f кг';
  stDiscreteness = 'Дискретность на диапазоне №%d: %8.3f кг';
  stPointsCount = 'Кол-во градуировочных точек: %d';
  // page3
  stCalibPoint = '  Градуируется реперная точка №%d (вес %8.3f кг).';
  stNeedLoad = '  Положите на платформу вес %8.3f кг.';
  stEmptyReceptor = ' Убедитесь, что платформа пуста.';
  // page4
  stCalibStatus1 = 'точка готова для измерения';
  stCalibStatus2 = 'успокоения нет';
  stCalibStatus3 = 'точка измеряется, успокоение есть';
  stCalibStatus4 = 'градуировка закончена успешно';
  stCalibStatus5 = 'градуировка закончена с ошибкой, реперные точки не изменены';
  stCalibPoint2 = '  Градуируется реперная точка №%d (вес %8.3f кг).';
  // page5
  stCalibSuccess = '  Градуировка успешно завершена. Уберите груз с платформы.';
  stCalibFailed = '  Градуировка завершена с ошибкой. Реперные точки не изменены.';
  stErrorReasons = 'Возможные причины ошибки:'#13#10'1. Установленный груз не соответствовал требуемому.'#13#10'2. Неисправен АЦП.';

implementation

end.
 