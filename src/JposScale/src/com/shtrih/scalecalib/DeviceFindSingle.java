package com.shtrih.scalecalib;

import java.util.Vector;

import com.shtrih.IDevice;
import com.shtrih.tools.StringParams;
import com.shtrih.scale.Pos2Serial;
import com.shtrih.port.GnuSerialPort;
import org.apache.log4j.Logger;

// Single thread device find
public class DeviceFindSingle implements Runnable {

    private Thread thread;
    private int timeout = 100;
    private boolean started = false;
    private Vector items = new Vector();
    private final SmScale driver = SmScale.instance;
    private final Logger logger = Logger.getLogger(DeviceFindSingle.class);

    public DeviceFindSingle() {
    }

    public void setTimeout(int value) {
        timeout = value;
    }

    public int getItemCount() {
        return items.size();
    }

    public DeviceItem getItem(int index) {
        return (DeviceItem) items.get(index);
    }

    public class DeviceItem {

        private String text;
        private int baudRate;
        private boolean found;
        private final String portName;

        public DeviceItem(String portName) {
            this.portName = portName;
        }

        public String getPortName() {
            return portName;
        }

        public String getText() {
            return text;
        }

        public String getBaudRate() {
            if (baudRate == 0) {
                return "";
            } else {
                return String.valueOf(baudRate);
            }
        }

        public boolean isFound() {
            return found;
        }

        public void reset() {
            text = "";
            baudRate = 0;
            found = false;
        }

        public void searchDevice() {
            text = "идет поиск...";
            int[] baudRates = {2400, 4800, 9600, 19200, 38400, 57600, 115200};
            for (int i = 0; i < baudRates.length; i++) {
                if (thread == null) {
                    break;
                }
                baudRate = baudRates[i];
                int resultCode = findDevice();
                if (resultCode != IDevice.ERROR_NOLINK) {
                    break;
                }
            }
        }

        public int findDevice() {
            found = false;
            int resultCode = 0;
            Pos2Serial device = new Pos2Serial();
            try {
                StringParams params = new StringParams();
                params.set(IDevice.PARAM_PORTNAME, portName);
                params.set(IDevice.PARAM_BAUDRATE, String.valueOf(baudRate));
                params.set(IDevice.PARAM_DATABITS, "8");
                params.set(IDevice.PARAM_STOPBITS, "1");
                params.set(IDevice.PARAM_PARITY, "0");
                params.set(IDevice.PARAM_APPNAME, "Программа градуировки");
                params.set(IDevice.PARAM_OPEN_TIMEOUT, String.valueOf(timeout));
                device.setParams(params);

                device.connect();
                device.readDeviceMetrics();
            } catch (Exception e) {
                text = String.format("Ошибка: %s", e.getMessage());
                //resultCode = device.getResultCode(); !!!
            } finally {
                device.disconnect();
            }
            return resultCode;
        }
    }

    public void start() throws Exception{
        if (thread == null) {
            driver.disconnect();

            for (int i = 0; i < items.size(); i++) {
                DeviceItem item = (DeviceItem) items.get(i);
                item.reset();
            }

            started = true;
            thread = new Thread(this);
            thread.start();
        }
    }

    public void stop() {
        thread = null;
    }

    public boolean isStarted() {
        return started;
    }

    public void updateItems() {
        stop();
        Vector ports = GnuSerialPort.getPortList();
        items.clear();
        for (int i = 0; i < ports.size(); i++) {
            DeviceItem item = new DeviceItem((String) ports.get(i));
            items.add(item);
        }
    }

    public void run() {
        logger.debug("run");
        try {
            for (int i = 0; i < items.size(); i++) {
                if (thread == null) {
                    break;
                }
                DeviceItem item = (DeviceItem) items.get(i);
                item.searchDevice();
            }
        } catch (Exception e) {
            logger.error("Search failed: " + e);

        }
        thread = null;
        started = false;
    }

}
