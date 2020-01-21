package com.shtrih;

import com.shtrih.tools.StringParams;

public interface IDevice {

    public static final String S_UNKNOWN_DEVICE = "����������� ����������";

    //���������
    //public static final String PARAM_PORT = "����"; 
    //public static final String PARAM_BAUDRATE = "��������"; 
    public static final String PARAM_DATABITS = "���������";
    public static final String PARAM_STOPBITS = "�������";
    public static final String PARAM_PARITY = "��������";
    public static final String PARAM_IP = "�����";
    public static final String PARAM_PASSWORD = "������";
    public static final String PARAM_PREFIX = "�������";
    public static final String PARAM_SUFFIX = "�������";
    public static final String PARAM_APPNAME = "ApplicationName";
    public static final String PARAM_OPEN_TIMEOUT = "OpenTimeout";

    //����� ������ � ��������� [0 - 999]
    public static final int ERROR_OK = 0; //��� ������
    public static final int ERROR_PARAMS = -4; //������ �� ������� ���������� (�� �� ������� ���������� ������, ���� ���������� ����� ��������)
    public static final int ERROR_NOLINK = -1; //��� �����
    public static final int ERROR_UNKNOWN = -2;  //����������� ������
    public static final int ERROR_BUSY = -3; //�����
    public static final int ERROR_LL = -5; //��������������-��������� ������ 
    public static final int ERROR_UNSUPPORT = -6; //�� �������������� �����
    public static final int ERROR_PASSWORD = -7; //��������-������ �� ���������� (������ �������, ��� ������ ������������ �������� � �� �� ����������)

    public static final String TEXT_ERROR_OK = "��� ������";
    public static final String TEXT_ERROR_PARAMS = "������ �� ������� ����������";
    public static final String TEXT_ERROR_NOLINK = "��� �����";
    public static final String TEXT_ERROR_UNKNOWN = "����������� ������";
    public static final String TEXT_ERROR_BUSY = "�����";
    public static final String TEXT_ERROR_LL = "��������������-��������� ������";
    public static final String TEXT_ERROR_UNSUPPORT = "�� �������������� �����";
    public static final String TEXT_ERROR_PASSWORD = "��������-������ �� ����������";

    //������ ������� � ��������� [1000 - 1990]
    //������ ������ � ��������� [2000 - 2990]
    //������ ����� � ��������� [3000 - 3990]
    //������ ������� ���������� � ��������� [4000 - 4999]
    public abstract void connect() throws Exception;

    public abstract void disconnect();

    public abstract boolean isConnected();

    public abstract void setParams(StringParams params) throws Exception;

    public abstract StringParams getParams();

    public abstract void setParam(String name, String value);

    public abstract String getParam(String name);

    public abstract void test() throws Exception;
}
