package com.shtrih.scale;

import org.apache.log4j.Logger;

import com.shtrih.IDevice;
import com.shtrih.DeviceError;
import com.shtrih.EquipmentTools;
import com.shtrih.tools.StringParams;
import com.shtrih.serialport.SerialPort;

public class ScaleSerial implements IScale, IDevice {

    private final Logger logger = Logger.getLogger(ScaleSerial.class);

    private String portName = "";
    private int baudRate = 4800;
    protected final SerialPort serialPort = new SerialPort();
    protected StringParams params = new StringParams();

    public String getPortName() {
        return portName;
    }

    public void setPortName(String value) {
        portName = value;
    }

    public void setBaudRate(int value) {
        baudRate = value;
    }

    public int getBaudRate() {
        return baudRate;
    }

    public String getErrorText(int error) {
        switch (error) {
            case IDevice.ERROR_OK:
                return IDevice.TEXT_ERROR_OK;
            case IDevice.ERROR_PARAMS:
                return IDevice.TEXT_ERROR_PARAMS;
            case IDevice.ERROR_NOLINK:
                return IDevice.TEXT_ERROR_NOLINK;
            case IDevice.ERROR_UNKNOWN:
                return IDevice.TEXT_ERROR_UNKNOWN;
            case IDevice.ERROR_BUSY:
                return IDevice.TEXT_ERROR_BUSY;
            case IDevice.ERROR_LL:
                return IDevice.TEXT_ERROR_LL;
            case IDevice.ERROR_UNSUPPORT:
                return IDevice.TEXT_ERROR_UNSUPPORT;
            case IDevice.ERROR_PASSWORD:
                return IDevice.TEXT_ERROR_PASSWORD;

            case 17:
                return IScale.ERROR_TEXT_TARA_VALUE;
            case 120:
                return IScale.ERROR_TEXT_UNKNOWN_CMD;
            case 121:
                return IScale.ERROR_TEXT_DATA_LEN;
            case 122:
                return IScale.ERROR_TEXT_PASSWORD;
            case 123:
                return IScale.ERROR_TEXT_MODE;
            case 124:
                return IScale.ERROR_TEXT_PARAM_VALUE;
            case 150:
                return IScale.ERROR_TEXT_SET_ZERO;
            case 151:
                return IScale.ERROR_TEXT_SET_TARA;
            case 152:
                return IScale.ERROR_TEXT_WEIGHT_NOT_FIXED;
            case 166:
                return IScale.ERROR_TEXT_FAILURE_NVRAM;
            case 167:
                return IScale.ERROR_TEXT_CMD_NOT_IMPL_IN_INTERFACE;
            case 170:
                return IScale.ERROR_TEXT_EXHAUSTED_PASSWORD_LIMIT;
            case 180:
                return IScale.ERROR_TEXT_CALIBRATION_MODE_BLOCKED_BY_SWITCH;
            case 181:
                return IScale.ERROR_TEXT_KEYBOARD_BLOCKED;
            case 182:
                return IScale.ERROR_TEXT_CANT_CHANGE_TYPE_CUR_CHANNEL;
            case 183:
                return IScale.ERROR_TEXT_CANT_SWOTCH_OFF_CHANNEL;
            case 184:
                return IScale.ERROR_TEXT_BAD_CHANNEL;
            case 185:
                return IScale.ERROR_TEXT_BAD_CHANNEL_NUMBER;
            case 186:
                return IScale.ERROR_TEXT_NOT_REPLY_FROM_CP;
            default:
                return IScale.ERROR_TEXT_UNKNOWN;
        }
    }

    public void connect() throws Exception {
        openPort();
    }

    public void openPort() throws Exception {
        logger.debug("openPort()");
        prepareParams();
        serialPort.open();
        logger.debug("openPort: OK");
    }

    public void disconnect() {
        closePort();
    }

    public void closePort() {
        serialPort.close();
    }

    public boolean isConnected() {
        return serialPort.isOpened();
    }

    public void setParams(StringParams params) throws Exception {
        this.params = params;
        prepareParams();
    }

    public StringParams getParams() {
        return this.params;
    }

    public void setParam(String name, String value) {
        logger.debug("setParam(" + name + ": " + value + ")");
        this.params.setValue(name, value);
    }

    public String getParam(String name) {
        logger.debug("getParam(" + name + ")");
        return params.getValue(name);
    }

    protected void prepareParams() throws Exception 
    {
        logger.debug("prepareParams()");

        if (this.params == null) {
            throw new DeviceError(IDevice.ERROR_PARAMS, IDevice.TEXT_ERROR_PARAMS);
        }

        StringParams.Value value;
        int dataBits, stopBits, parity;

        value = this.params.get(IDevice.PARAM_DATABITS);
        if (value == null) {
            throw new DeviceError(IDevice.ERROR_PARAMS, IDevice.TEXT_ERROR_PARAMS);
        }
        dataBits = Integer.parseInt(value.getValue());
        logger.debug("dataBits '" + String.valueOf(dataBits) + "'");

        value = this.params.get(IDevice.PARAM_STOPBITS);
        if (value == null) {
            throw new DeviceError(IDevice.ERROR_PARAMS, IDevice.TEXT_ERROR_PARAMS);
        }
        stopBits = Integer.parseInt(value.getValue());
        logger.debug("stopBits '" + String.valueOf(stopBits) + "'");

        value = this.params.get(IDevice.PARAM_PARITY);
        if (value == null) {
            throw new DeviceError(IDevice.ERROR_PARAMS, IDevice.TEXT_ERROR_PARAMS);
        }
        parity = Integer.parseInt(value.getValue());

        String appName = "Unknown Application";
        value = this.params.get(IDevice.PARAM_APPNAME);
        if (value != null) {
            appName = value.getValue();
        }

        int openTimeout = 1000;
        value = this.params.get(IDevice.PARAM_OPEN_TIMEOUT);
        if (value != null) {
            openTimeout = Integer.parseInt(value.getValue());
        }
        logger.debug("parity '" + String.valueOf(parity) + "'");

        serialPort.setSerialParams(appName, portName, baudRate, dataBits,
                stopBits, parity, openTimeout);
        logger.debug("prepareParams: OK");
    }

    public void zero() throws Exception{
    }

    public void tara() throws Exception {
    }

    public void tara(long v) throws Exception{
    }

    public DeviceMetrics getDeviceMetrics() throws Exception{
        return null;
    }

    public ScaleWeight getWeight() throws Exception{
        return null;
    }

    public void test() throws Exception {
    }

    public EScale getType() {
        return null;
    }

}
