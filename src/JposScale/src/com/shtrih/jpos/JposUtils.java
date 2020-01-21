/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.shtrih.jpos;

import jpos.JposConst;

/**
 *
 * @author V.Kravtsov
 */
public class JposUtils {

    public static String getCapPowerReportingText(int value) {
        switch (value) {
            case JposConst.JPOS_PR_NONE:
                return "JPOS_PR_NONE";
            case JposConst.JPOS_PR_STANDARD:
                return "JPOS_PR_STANDARD";
            case JposConst.JPOS_PR_ADVANCED:
                return "JPOS_PR_ADVANCED";
            default:
                return String.valueOf(value);
        }
    }

    public static String getStateText(int value) {
        switch (value) {
            case JposConst.JPOS_S_CLOSED:
                return "JPOS_S_CLOSED";
            case JposConst.JPOS_S_IDLE:
                return "JPOS_S_IDLE";
            case JposConst.JPOS_S_BUSY:
                return "JPOS_S_BUSY";
            case JposConst.JPOS_S_ERROR:
                return "JPOS_S_ERROR";
            default:
                return String.valueOf(value);
        }
    }

}
