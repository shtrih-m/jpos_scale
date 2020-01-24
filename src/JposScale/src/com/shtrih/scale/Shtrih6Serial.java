package com.shtrih.scale;

import com.shtrih.EquipmentTools;
import com.shtrih.IDevice;
import com.shtrih.port.GnuSerialPort;

public class Shtrih6Serial extends ScaleSerial {

    public EScale getType() {
        return EScale.Shtrih6;
    }

    public void tara() throws Exception {
        byte[] data = new byte[]{0, 0, 1};
        getSerialPort().write(data);
    }

    public ScaleWeight getWeight() throws Exception {
        byte[] data = new byte[]{0, 0, 3, 0, 0, 0, 0, 0, 0};
        getSerialPort().write(data);
        data = getSerialPort().readBytes(18);
        long weight = EquipmentTools.convertLongBSDToDec(data, 0, 6);
        long price = EquipmentTools.convertLongBSDToDec(data, 6, 6);
        long summ = EquipmentTools.convertLongBSDToDec(data, 12, 6);
        return new ScaleWeight(weight, 0, new ScaleStatus(1));
    }
}
