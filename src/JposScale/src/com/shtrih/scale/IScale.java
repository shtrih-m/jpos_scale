package com.shtrih.scale;

public interface IScale {

    public static final String PARAM_TIMEOUT_DEVICE_METRICS = "�������_�������������";
    public static final String PARAM_TIMEOUT_WEIGHT = "�������_���";

    //������
    public static final int ERROR_TARA_VALUE = 17; // ������ � �������� ����
    public static final int ERROR_UNKNOWN_CMD = 120; //����������� �������
    public static final int ERROR_DATA_LEN = 121; //�������� ����� ������ � �������
    public static final int ERROR_PASSWORD = 122; //�������� ������
    public static final int ERROR_MODE = 123; //������� �� ����������� � ������ ������
    public static final int ERROR_PARAM_VALUE = 124; //�� ������ �������� ���������
    public static final int ERROR_SET_ZERO = 150; //������ ��� ��������� ����
    public static final int ERROR_SET_TARA = 151; //������ ��� ��������� ����
    public static final int ERROR_WEIGHT_NOT_FIXED = 152; //��� �� ������������
    public static final int ERROR_FAILURE_NVRAM = 166; //���� ����������������� ������
    public static final int ERROR_CMD_NOT_IMPL_IN_INTERFACE = 167; //������� �� ����������� �����������
    public static final int ERROR_EXHAUSTED_PASSWORD_LIMIT = 170; //�������� ����� ������� ��������� � �������� �������
    public static final int ERROR_CALIBRATION_MODE_BLOCKED_BY_SWITCH = 180; //����� ����������� ���������� �������������� ��������������
    public static final int ERROR_KEYBOARD_BLOCKED = 181; //���������� ������������� 
    public static final int ERROR_CANT_CHANGE_TYPE_CUR_CHANNEL = 182; //������ �������� ��� �������� ������ 
    public static final int ERROR_CANT_SWOTCH_OFF_CHANNEL = 183; //������ ��������� ������� ����� 
    public static final int ERROR_BAD_CHANNEL = 184; //� ������ ������� ������ ������ ������ 
    public static final int ERROR_BAD_CHANNEL_NUMBER = 185; //�������� ����� ������ 
    public static final int ERROR_NOT_REPLY_FROM_CP = 186; //��� ������ �� ��� 

    public static final String ERROR_TEXT_TARA_VALUE = "������ � �������� ����";
    public static final String ERROR_TEXT_UNKNOWN_CMD = "����������� �������";
    public static final String ERROR_TEXT_DATA_LEN = "�������� ����� ������ � �������";
    public static final String ERROR_TEXT_PASSWORD = "�������� ������";
    public static final String ERROR_TEXT_MODE = "������� �� ����������� � ������ ������";
    public static final String ERROR_TEXT_PARAM_VALUE = "�� ������ �������� ���������";
    public static final String ERROR_TEXT_SET_ZERO = "������ ��� ��������� ����";
    public static final String ERROR_TEXT_SET_TARA = "������ ��� ��������� ����";
    public static final String ERROR_TEXT_WEIGHT_NOT_FIXED = "��� �� ������������";
    public static final String ERROR_TEXT_FAILURE_NVRAM = "���� ����������������� ������";
    public static final String ERROR_TEXT_CMD_NOT_IMPL_IN_INTERFACE = "������� �� ����������� �����������";
    public static final String ERROR_TEXT_EXHAUSTED_PASSWORD_LIMIT = "�������� ����� ������� ��������� � �������� �������";
    public static final String ERROR_TEXT_CALIBRATION_MODE_BLOCKED_BY_SWITCH = "����� ����������� ���������� �������������� ��������������";
    public static final String ERROR_TEXT_KEYBOARD_BLOCKED = "���������� �������������";
    public static final String ERROR_TEXT_CANT_CHANGE_TYPE_CUR_CHANNEL = "������ �������� ��� �������� ������";
    public static final String ERROR_TEXT_CANT_SWOTCH_OFF_CHANNEL = "������ ��������� ������� �����";
    public static final String ERROR_TEXT_BAD_CHANNEL = "� ������ ������� ������ ������ ������";
    public static final String ERROR_TEXT_BAD_CHANNEL_NUMBER = "�������� ����� ������";
    public static final String ERROR_TEXT_NOT_REPLY_FROM_CP = "��� ������ �� ���";
    public static final String ERROR_TEXT_UNKNOWN = "����������� ��� ������";

    public EScale getType();

    public void zero() throws Exception;

    public ScaleWeight getWeight() throws Exception;

    public void tara() throws Exception;

    public void tara(long v) throws Exception;

    public DeviceMetrics getDeviceMetrics() throws Exception;
}
