package com.shtrih.scalecalib;

import java.util.prefs.*;
import java.awt.Component;
import javax.swing.JOptionPane;
import java.util.Enumeration;
import java.util.Vector;
import com.shtrih.IDevice;
import com.shtrih.DeviceError;
import com.shtrih.scale.IScale;
import com.shtrih.scale.Pos2Serial;
import com.shtrih.scale.ChannelParams;
import com.shtrih.scale.DeviceMetrics;
import com.shtrih.scale.CalibrationStatus;
import com.shtrih.serialport.SerialPort;
import org.apache.log4j.Logger;

public class SmScale {

    private final Logger logger = Logger.getLogger(SmScale.class);

    private int pointNumber = 1;
    private String portName = "COM1";
    private int baudRate = 9600;
    private int timeout = 100;
    private String password = "30";

    private DeviceMetrics deviceMetrics;
    private int channelCount = 0;
    private int channelNumber = 0;
    private ChannelParams scaleChannel = new ChannelParams();
    private boolean connected = false;
    private double calibrationProgress = 0;

    private final Pos2Serial protocol = new Pos2Serial();

    public static final SmScale instance = new SmScale();

    private SmScale() {
        loadParams();
    }

    public String getDefaultPortName() {
        String result = "COM1";
        Vector<String> portNames = SerialPort.getPortList();
        if (portNames.size() > 0) {
            result = portNames.get(0);
        }
        return result;
    }

    public void setDefaults() {
        logger.error("setDefaults");

        portName = getDefaultPortName();
        baudRate = 9600;
        timeout = 100;
        password = "30";

        protocol.setParam(IDevice.PARAM_DATABITS, "8");
        protocol.setParam(IDevice.PARAM_STOPBITS, "1");
        protocol.setParam(IDevice.PARAM_PARITY, "0");
        protocol.setParam(IDevice.PARAM_PASSWORD, password);
        protocol.setParam(IDevice.PARAM_APPNAME, "Программа градуировки");
        protocol.setParam(IDevice.PARAM_OPEN_TIMEOUT, String.valueOf(timeout));
    }

    public void loadParams() {
        logger.debug("loadParams()");
        try {
            Preferences prefs = Preferences.userNodeForPackage(SmScale.class);
            portName = prefs.get("portName", getDefaultPortName());
            baudRate = prefs.getInt("baudRate", 9600);
            timeout = prefs.getInt("timeout", 100);
            password = prefs.get("password", "30");

            protocol.setParam(IDevice.PARAM_DATABITS, "8");
            protocol.setParam(IDevice.PARAM_STOPBITS, "1");
            protocol.setParam(IDevice.PARAM_PARITY, "0");
            protocol.setParam(IDevice.PARAM_PASSWORD, password);
            protocol.setParam(IDevice.PARAM_APPNAME, "Программа градуировки");
            protocol.setParam(IDevice.PARAM_OPEN_TIMEOUT, String.valueOf(timeout));

            logger.debug("loadParams(): OK");
        } catch (Exception e) {
            logger.error(e.getMessage());
            setDefaults();
        }
    }

    public void saveParams() {
        Preferences prefs = Preferences.userNodeForPackage(SmScale.class);
        prefs.put("portName", portName);
        prefs.putInt("baudRate", baudRate);
        prefs.putInt("timeout", timeout);
        prefs.put("password", password);

        protocol.setPortName(portName);
        protocol.setBaudRate(baudRate);

        protocol.setParam(IDevice.PARAM_DATABITS, "8");
        protocol.setParam(IDevice.PARAM_STOPBITS, "1");
        protocol.setParam(IDevice.PARAM_PARITY, "0");
        protocol.setParam(IDevice.PARAM_PASSWORD, password);
        protocol.setParam(IDevice.PARAM_APPNAME, "Программа градуировки");
        protocol.setParam(IDevice.PARAM_OPEN_TIMEOUT, String.valueOf(timeout));
    }

    public String getPortName() {
        return portName;
    }

    public int getBaudRate() {
        return baudRate;
    }

    public String getPassword() {
        return password;
    }

    public String getDeviceName() {
        String result = "";
        if (deviceMetrics != null) {
            result = deviceMetrics.getDescription();
        }
        return result;
    }

    public String getDeviceText() {
        String result = "";
        if (deviceMetrics != null) {
            result = deviceMetrics.toString();
        }
        return result;
    }

    public int getChannelCount() {
        return channelCount;
    }

    public int getTimeout() {
        return timeout;
    }

    public void setPortName(String portName) {
        this.portName = portName;
    }

    public void setBaudRate(int baudRate) {
        this.baudRate = baudRate;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setTimeout(int timeout) {
        this.timeout = timeout;
    }

    public boolean isConnected() {
        return connected;
    }

    public DeviceMetrics getDeviceMetrics() {
        return deviceMetrics;
    }

    public void connect() throws Exception {
        if (connected) {
            return;
        }
        protocol.connect();
        protocol.readDeviceMetrics();
        deviceMetrics = protocol.getDeviceMetrics();
        protocol.readChannelCount();
        channelCount = protocol.getChannelCount();
        protocol.readChannelNumber();
        channelNumber = protocol.getChannelNumber();
        connected = true;
        protocol.readScaleMode();
        if (protocol.getScaleMode() == protocol.MODE_CALIBRATION) {
            stopCalibration();
            exitCalibrationMode();
        }
    }

    public void disconnect() {
        try {
            if (connected) {
                stopCalibration();
                exitCalibrationMode();
                protocol.disconnect();
            }
        } catch (Exception e) {
            // !!!
        }
    }

    public int readPortParams() {
        return 0;
    }

    public ChannelParams getChannelParams() {
        return protocol.getChannelParams();
    }

    public void readChannelParams(int index) throws Exception {
        protocol.readChannelParams(index);
    }

    public ChannelParams getScaleChannel() {
        return scaleChannel;
    }

    public long getADCValue() {
        long adcValue = protocol.getADCValue();
        return adcValue;
    }

    public void readADCValue() throws Exception {
        protocol.readADCValue();
    }

    public int getPointNumber() {
        return pointNumber;
    }

    public void incPointNumber() {
        pointNumber++;
    }

    public void startCalibration() throws Exception {
        calibrationProgress = 0;
        protocol.startCalibration();
    }

    public void stopCalibration() throws Exception {
        protocol.stopCalibration();
    }

    public void resetPointNumber() {
        pointNumber = 1;
    }

    public void enterCalibrationMode() throws Exception {
        int rc = 0;
        try {
            protocol.lockKeyboard();
        } catch (DeviceError e) {
            rc = e.getCode();
        }
        if ((rc == 0) || (rc == IScale.ERROR_CMD_NOT_IMPL_IN_INTERFACE)) {
            protocol.writeMode(protocol.MODE_CALIBRATION);
        }
    }

    public void exitCalibrationMode() throws Exception {
        protocol.writeMode(protocol.MODE_NORMAL);
        protocol.unlockKeyboard();
    }

    public void sendCalibrationPassword() throws Exception {
        boolean result = true;
        int[] password = {60, 60, 188, 61, 189, 61, 61, 189, 60, 188};
        for (int i = 0; i < password.length; i++) {
            protocol.sendKey(password[i]);
        }
    }

    public void readScaleMode() throws Exception {
        protocol.readScaleMode();
    }

    public int getScaleMode() {
        return protocol.getScaleMode();
    }

    public CalibrationStatus getCalibrationStatus() {
        return protocol.getCalibrationStatus();
    }

    public void readCalibrationStatus() throws Exception {
        protocol.readCalibrationStatus();
    }

    public void check(boolean result) throws Exception {
        /*
        if (!result) {
            throw new Exception(getResultText());
        }
         */
    }

    public void checkResult() throws Exception {
        /*
        if (getResultCode() != 0) {
            throw new Exception(getResultText());
        }
         */
    }

    public double getWeightValue(int value) {
        return protocol.getWeightValue(value);
    }

    public void stepCalibrationProgress() {
        calibrationProgress += 2.4;
    }

    public int getCalibrationProgress() {
        return (int) calibrationProgress;
    }
}
