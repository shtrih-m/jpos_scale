package com.shtrih.scale;

import com.shtrih.tools.BitUtils;

/////////////////////////////////////////////////////////////////////
// ��������� (2 �����):
//	��� 0 - ������� �������� ����
//	��� 1 - ������� ������ ��������
//	��� 2 - "0"- ����� ��������, "1"- ����� �������.
//	��� 3 - ������� ����
//	��� 4 - ������� ���������� ����
//	��� 5 - ������ �������� ��� ���������
//	��� 6 - ���������� �� ����
//	��� 7 - ������ ��� ��������� ���������
//	��� 8 - ���� �����������
//	��� 9 - ��� ������ �� ���
//	��� 10..��� 15 - Reserved
//
/////////////////////////////////////////////////////////////////////
public class ScaleStatus {

    private final int value;

    public ScaleStatus(int value) {
        this.value = value;
    }

    public int getValue() {
        return value;
    }

    public boolean testBit(int data, int bit) {
        return BitUtils.testBit(data, bit);
    }

    public boolean isFixed() {
        return BitUtils.testBit(value, 0);
    }

    public boolean isAutoZero() {
        return BitUtils.testBit(value, 1);
    }

    public boolean isChannelEnabled() {
        return BitUtils.testBit(value, 2);
    }

    public boolean isTareSet() {
        return BitUtils.testBit(value, 3);
    }

    public boolean isWeightStable() {
        return BitUtils.testBit(value, 4);
    }

    public boolean isAutoZeroError() {
        return BitUtils.testBit(value, 5);
    }

    public boolean isOverweight() {
        return BitUtils.testBit(value, 6);
    }

    public boolean isReadWeightError() {
        return BitUtils.testBit(value, 7);
    }

    public boolean isLowWeight() {
        return BitUtils.testBit(value, 8);
    }

    public boolean isADCNotResponding() {
        return BitUtils.testBit(value, 9);
    }
}
