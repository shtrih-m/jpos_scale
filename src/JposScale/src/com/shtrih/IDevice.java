package com.shtrih;

import com.shtrih.tools.StringParams;

public interface IDevice {

    public static final String S_UNKNOWN_DEVICE = "Неизвестное устройство";

    //Параметры
    public static final String PARAM_PORTTYPE = "PortType"; 
    public static final String PARAM_PORTNAME = "PortName"; 
    public static final String PARAM_BAUDRATE = "BaudRate"; 
    public static final String PARAM_DATABITS = "DataBits";
    public static final String PARAM_STOPBITS = "StopBits";
    public static final String PARAM_PARITY = "Parity";
    public static final String PARAM_IPADDRESS = "IPAddress";
    public static final String PARAM_PASSWORD = "Password";
    public static final String PARAM_PREFIX = "Prefix";
    public static final String PARAM_SUFFIX = "Suffix";
    public static final String PARAM_APPNAME = "AppName";
    public static final String PARAM_OPEN_TIMEOUT = "OpenTimeout";
    public static final String PARAM_READ_TIMEOUT = "ReadTimeout";

    // PortType constants
    public static final int PARAM_PORTTYPE_SERIAL = 0;
    public static final int PARAM_PORTTYPE_SOCKET = 1;
            
    //ОБЩИЕ ОШИБКИ в диапазоне [0 - 999]
    public static final int ERROR_OK = 0; //Нет ошибок
    public static final int ERROR_PARAMS = -4; //Ошибка во входных параметрах (не во входных параметрах команд, если реализован некий протокол)
    public static final int ERROR_NOLINK = -1; //Нет связи
    public static final int ERROR_UNKNOWN = -2;  //Неизвестная ошибка
    public static final int ERROR_BUSY = -3; //Занят
    public static final int ERROR_LL = -5; //Низкоуровневая-системная ошибка 
    public static final int ERROR_UNSUPPORT = -6; //Не поддерживается вызов
    public static final int ERROR_PASSWORD = -7; //Параметр-пароль не установлен (ошибка говорит, что пароль обязательный параметр и он не установлен)

    public static final String TEXT_ERROR_OK = "Нет ошибок";
    public static final String TEXT_ERROR_PARAMS = "Ошибка во входных параметрах";
    public static final String TEXT_ERROR_NOLINK = "Нет связи";
    public static final String TEXT_ERROR_UNKNOWN = "Неизвестная ошибка";
    public static final String TEXT_ERROR_BUSY = "Занят";
    public static final String TEXT_ERROR_LL = "Низкоуровневая-системная ошибка";
    public static final String TEXT_ERROR_UNSUPPORT = "Не поддерживается вызов";
    public static final String TEXT_ERROR_PASSWORD = "Параметр-пароль не установлен";

    //ОШИБКИ СКАНЕРА в диапазоне [1000 - 1990]
    //ОШИБКИ РИДЕРА в диапазоне [2000 - 2990]
    //ОШИБКИ ВЕСОВ в диапазоне [3000 - 3990]
    //ОШИБКИ ДИСПЛЕЯ ПОКУПАТЕЛЯ в диапазоне [4000 - 4999]
    public abstract void connect() throws Exception;

    public abstract void disconnect() throws Exception;

    public abstract boolean isConnected() throws Exception;

    public abstract void setParams(StringParams params) throws Exception;

    public abstract StringParams getParams();

    public abstract void setParam(String name, String value);

    public abstract String getParam(String name);

    public abstract void test() throws Exception;
}
