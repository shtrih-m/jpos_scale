package com.shtrih.scale;

import java.util.Vector;

import com.shtrih.IDevice;
import com.shtrih.DeviceError;
import com.shtrih.port.GnuSerialPort;
import org.apache.log4j.Logger;

// Multithread device find 
// Not working, because RXTX 2.1.7r2 is not thread safe
public class DeviceFindMulti {

	private int timeout = 100;
	private boolean started = false;
	private Vector items = new Vector();
	private final SmScale driver = SmScale.instance;
	private final Logger logger = Logger.getLogger(DeviceFindMulti.class);
	private int startedCount = 0;

	public DeviceFindMulti() {
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

	public class DeviceItem implements Runnable {

		private String text;
		private int baudRate;
		private boolean found;
		private Thread thread;
		private boolean started;
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

		public boolean isStarted() {
			return started;
		}

		public void start() {
			if (thread == null) {
				reset();
				started = true;
				thread = new Thread(this);
				thread.start();
			}
		}

		public void stop() {
			thread = null;
		}

		public void run() {
			text = "идет поиск...";
			int[] baudRates = { 2400, 4800, 9600, 19200, 38400, 57600, 115200 };
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
			started = false;
		}

		public int findDevice() {
			found = false;
			int resultCode = 0;
			Pos2Serial device = new Pos2Serial();
			try {
				device.setParam(IDevice.PARAM_PORTNAME, portName);
				device.setParam(IDevice.PARAM_BAUDRATE, String.valueOf(baudRate));
				device.setParam(IDevice.PARAM_DATABITS, "8");
				device.setParam(IDevice.PARAM_STOPBITS, "1");
				device.setParam(IDevice.PARAM_PARITY, "0");
				device.setParam(IDevice.PARAM_APPNAME, "Программа градуировки");
				device.setParam(IDevice.PARAM_OPEN_TIMEOUT, String.valueOf(timeout));

				try {
					device.connect();
					device.readDeviceMetrics();
					text = device.getDeviceMetrics().getDescription();
					return IDevice.ERROR_NONE;
				} catch (Exception e) {
					text = String.format("Ошибка: %s", e.getMessage());
					if (e instanceof DeviceError) {
						DeviceError deviceError = (DeviceError) e;
						resultCode = deviceError.getCode();
					} else {
						resultCode = IDevice.ERROR_UNKNOWN;
					}
				}
			} finally {
				device.disconnect();
			}
			return resultCode;
		}
	}

	public void start() throws Exception {
		if (!isStarted()) {
			driver.disconnect();
			for (int i = 0; i < items.size(); i++) {
				DeviceItem item = (DeviceItem) items.get(i);
				item.start();
			}
		}
	}

	public void stop() throws Exception {
		if (!isStarted()) {
			driver.disconnect();
			for (int i = 0; i < items.size(); i++) {
				DeviceItem item = (DeviceItem) items.get(i);
				item.stop();
			}
		}
	}

	public boolean isStarted() {
		boolean started = false;
		for (int i = 0; i < items.size(); i++) {
			DeviceItem item = (DeviceItem) items.get(i);
			started = item.isStarted();
			if (started) {
				break;
			}
		}
		return started;
	}

	public void updateItems() throws Exception {
		stop();
		Vector ports = GnuSerialPort.getPortList();
		items.clear();
		for (int i = 0; i < ports.size(); i++) {
			DeviceItem item = new DeviceItem((String) ports.get(i));
			items.add(item);
		}
	}

}
