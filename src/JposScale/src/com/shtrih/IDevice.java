package com.shtrih;

import com.shtrih.tools.StringParams;

public interface IDevice {

	public static final String S_UNKNOWN_DEVICE = "����������� ����������";

	// ���������
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

	// ����� ������ � ��������� [0 - 999]
	public static final int ERROR_NONE = 0; // ��� ������
	public static final int ERROR_NOLINK = -1; // ��� �����
	public static final int ERROR_PORTINUSE = -2; // ���� ������ �����������
	public static final int ERROR_NOSUCHPORT = -3; // ���� �� ����������
	public static final int ERROR_PARAMS = -4; // ������ �� ������� ����������
	public static final int ERROR_UNKNOWN = -5; // ����������� ������
	public static final int ERROR_UNSUPPORT = -6; // �� �������������� �����
	public static final int ERROR_PASSWORD = -7; // ��������-������ �� ����������

	public static final String TEXT_ERROR_NONE = "��� ������";
	public static final String TEXT_ERROR_NOLINK = "��� �����";
	public static final String TEXT_ERROR_PORTINUSE = "���� ������ �����������, ";
	public static final String TEXT_ERROR_NOTSUCHPORT = "���� �� ����������";
	public static final String TEXT_ERROR_PARAMS = "������ �� ������� ����������";
	public static final String TEXT_ERROR_UNKNOWN = "����������� ������";
	public static final String TEXT_ERROR_UNSUPPORT = "�� �������������� �����";
	public static final String TEXT_ERROR_PASSWORD = "��������-������ �� ����������";

	// ������ ������� � ��������� [1000 - 1990]
	// ������ ������ � ��������� [2000 - 2990]
	// ������ ����� � ��������� [3000 - 3990]
	// ������ ������� ���������� � ��������� [4000 - 4999]
	public abstract void connect() throws Exception;

	public abstract void disconnect() throws Exception;

	public abstract boolean isConnected() throws Exception;

	public abstract void setParams(StringParams params) throws Exception;

	public abstract StringParams getParams();

	public abstract void setParam(String name, String value);

	public abstract String getParam(String name);

	public abstract void test() throws Exception;
}
