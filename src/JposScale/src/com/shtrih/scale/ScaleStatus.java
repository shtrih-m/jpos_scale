package com.shtrih.scale;

import com.shtrih.tools.BitUtils;

/////////////////////////////////////////////////////////////////////
// Состояние (2 байта):
//	бит 0 - признак фиксации веса
//	бит 1 - признак работы автонуля
//	бит 2 - "0"- канал выключен, "1"- канал включен.
//	бит 3 - признак тары
//	бит 4 - признак успокоения веса
//	бит 5 - ошибка автонуля при включении
//	бит 6 - перегрузка по весу
//	бит 7 - ошибка при получении измерения
//	бит 8 - весы недогружены
//	бит 9 - нет ответа от АЦП
//	бит 10..бит 15 - Reserved
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
