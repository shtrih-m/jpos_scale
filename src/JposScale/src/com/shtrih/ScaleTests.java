package com.shtrih;

import jpos.JposException;
import jpos.events.DataEvent;
import jpos.events.DataListener;

public class ScaleTests implements DataListener {

    private String[] m_args = null;

    public ScaleTests(String[] args) {
        m_args = args;
    }

    public void reportCapablities(jpos.Scale scale) throws Exception {
        System.out.println("Capablities");
        System.out.println("-----------------------------------------------");
        System.out.println("CapCompareFirmwareVersion : " + scale.getCapCompareFirmwareVersion());
        System.out.println("CapDisplay                : " + scale.getCapDisplay());
        System.out.println("CapDisplayText            : " + scale.getCapDisplayText());
        System.out.println("CapPowerReporting         : " + scale.getCapPowerReporting());
        System.out.println("CapPriceCalculating       : " + scale.getCapPriceCalculating());
        System.out.println("CapStatisticsReporting    : " + scale.getCapStatisticsReporting());
        System.out.println("CapStatusUpdate           : " + scale.getCapStatusUpdate());
        System.out.println("CapTareWeight             : " + scale.getCapTareWeight());
        System.out.println("CapUpdateFirmware         : " + scale.getCapUpdateFirmware());
        System.out.println("CapUpdateStatistics       : " + scale.getCapUpdateStatistics());
        System.out.println("CapZeroScale              : " + scale.getCapZeroScale());
        System.out.println("-----------------------------------------------");
    }

    public void readWeight() {

        try {
            jpos.Scale scale = new jpos.Scale();
            scale.open("Scale");
            reportCapablities(scale);
            scale.claim(1000);
            scale.setDeviceEnabled(true);
            scale.setAsyncMode(false);

            int[] weight = new int[1];

            System.out.println("scale.readWeight(1000)");
            while (true) {
                try {
                    scale.readWeight(weight, 1000);
                    System.out.println("Weight (sync): " + (float) weight[0] / 1000.0f + " kg.");
                } catch (Exception e) {
                    System.out.println("ERROR: " + e.getMessage());
                }
                Thread.sleep(100);
            }
            //scale.setDeviceEnabled(false);
            //scale.release();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    @Override
    public void dataOccurred(DataEvent event) {
        System.out.println("Weight (async): " + (float) event.getStatus() / 1000.0f + " kg.");

    }

    //static
    /**
     * @param args
     */
    public static void main(String[] args) {
        // TODO Auto-generated method stub
        ScaleTests tests = new ScaleTests(args);
        tests.readWeight();
    }

}
