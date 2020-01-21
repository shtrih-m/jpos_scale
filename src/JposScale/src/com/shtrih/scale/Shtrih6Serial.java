package com.shtrih.scale;

import com.shtrih.EquipmentTools;
import com.shtrih.IDevice;
import com.shtrih.serialport.SerialPort;

public class Shtrih6Serial extends ScaleSerial {

    public EScale getType() {
        return EScale.Shtrih6;
    }

    public void tara() throws Exception {
        SerialPort.Buffer buffer = serialPort.new Buffer();
        buffer.data = new byte[]{0, 0, 1};
        serialPort.write(buffer);
    }

    public ScaleWeight getWeight() throws Exception {
        SerialPort.Buffer buffer = serialPort.new Buffer();
        buffer.data = new byte[]{0, 0, 3, 0, 0, 0, 0, 0, 0};
        serialPort.write(buffer);
        serialPort.read(buffer, 18, 1000);
        long weight = EquipmentTools.convertLongBSDToDec(buffer.data, 0, 6);
        long price = EquipmentTools.convertLongBSDToDec(buffer.data, 6, 6);
        long summ = EquipmentTools.convertLongBSDToDec(buffer.data, 12, 6);
        return new ScaleWeight(weight, 0, new ScaleStatus(1));
    }
}
