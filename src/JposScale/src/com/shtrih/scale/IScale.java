package com.shtrih.scale;

public interface IScale {

    public static final String PARAM_TIMEOUT_DEVICE_METRICS = "Таймаут_ТипУстройства";
    public static final String PARAM_TIMEOUT_WEIGHT = "Таймаут_Вес";

    //Ошибки
    public static final int ERROR_TARA_VALUE = 17; // Ошибка в значении тары
    public static final int ERROR_UNKNOWN_CMD = 120; //Неизвестная команда
    public static final int ERROR_DATA_LEN = 121; //Неверная длина данных в команде
    public static final int ERROR_PASSWORD = 122; //Неверный пароль
    public static final int ERROR_MODE = 123; //Команда не реализуется в данном режиме
    public static final int ERROR_PARAM_VALUE = 124; //Не верное значение параметра
    public static final int ERROR_SET_ZERO = 150; //Ошибка при установки нуля
    public static final int ERROR_SET_TARA = 151; //Ошибка при установки тары
    public static final int ERROR_WEIGHT_NOT_FIXED = 152; //Вес не зафиксирован
    public static final int ERROR_FAILURE_NVRAM = 166; //Сбой энергонезависимой памяти
    public static final int ERROR_CMD_NOT_IMPL_IN_INTERFACE = 167; //Команда не реализуется интерфейсом
    public static final int ERROR_EXHAUSTED_PASSWORD_LIMIT = 170; //Исчерпан лимит попыток обращения с неверным паролем
    public static final int ERROR_CALIBRATION_MODE_BLOCKED_BY_SWITCH = 180; //Режим градуировки блокирован градуировочным переключателем
    public static final int ERROR_KEYBOARD_BLOCKED = 181; //Клавиатура заблокирована 
    public static final int ERROR_CANT_CHANGE_TYPE_CUR_CHANNEL = 182; //Нельзя поменять тип текущего канала 
    public static final int ERROR_CANT_SWOTCH_OFF_CHANNEL = 183; //Нельзя выключить текущий канал 
    public static final int ERROR_BAD_CHANNEL = 184; //С данным каналом ничего нельзя делать 
    public static final int ERROR_BAD_CHANNEL_NUMBER = 185; //Неверный номер канала 
    public static final int ERROR_NOT_REPLY_FROM_CP = 186; //Нет ответа от АЦП 

    public static final String ERROR_TEXT_TARA_VALUE = "Ошибка в значении тары";
    public static final String ERROR_TEXT_UNKNOWN_CMD = "Неизвестная команда";
    public static final String ERROR_TEXT_DATA_LEN = "Неверная длина данных в команде";
    public static final String ERROR_TEXT_PASSWORD = "Неверный пароль";
    public static final String ERROR_TEXT_MODE = "Команда не реализуется в данном режиме";
    public static final String ERROR_TEXT_PARAM_VALUE = "Не верное значение параметра";
    public static final String ERROR_TEXT_SET_ZERO = "Ошибка при установки нуля";
    public static final String ERROR_TEXT_SET_TARA = "Ошибка при установки тары";
    public static final String ERROR_TEXT_WEIGHT_NOT_FIXED = "Вес не зафиксирован";
    public static final String ERROR_TEXT_FAILURE_NVRAM = "Сбой энергонезависимой памяти";
    public static final String ERROR_TEXT_CMD_NOT_IMPL_IN_INTERFACE = "Команда не реализуется интерфейсом";
    public static final String ERROR_TEXT_EXHAUSTED_PASSWORD_LIMIT = "Исчерпан лимит попыток обращения с неверным паролем";
    public static final String ERROR_TEXT_CALIBRATION_MODE_BLOCKED_BY_SWITCH = "Режим градуировки блокирован градуировочным переключателем";
    public static final String ERROR_TEXT_KEYBOARD_BLOCKED = "Клавиатура заблокирована";
    public static final String ERROR_TEXT_CANT_CHANGE_TYPE_CUR_CHANNEL = "Нельзя поменять тип текущего канала";
    public static final String ERROR_TEXT_CANT_SWOTCH_OFF_CHANNEL = "Нельзя выключить текущий канал";
    public static final String ERROR_TEXT_BAD_CHANNEL = "С данным каналом ничего нельзя делать";
    public static final String ERROR_TEXT_BAD_CHANNEL_NUMBER = "Неверный номер канала";
    public static final String ERROR_TEXT_NOT_REPLY_FROM_CP = "Нет ответа от АЦП";
    public static final String ERROR_TEXT_UNKNOWN = "Неизвестный код ошибки";

    public EScale getType();

    public void zero() throws Exception;

    public ScaleWeight getWeight() throws Exception;

    public void tara() throws Exception;

    public void tara(long v) throws Exception;

    public DeviceMetrics getDeviceMetrics() throws Exception;
}
