package com.shtrih.scale;

import org.apache.log4j.Logger;

import com.shtrih.IDevice;
import com.shtrih.DeviceError;
import com.shtrih.EquipmentTools;
import com.shtrih.port.SerialPort;
import com.shtrih.tools.StringParams;
import com.shtrih.port.GnuSerialPort;
import com.shtrih.port.TcpSocketPort;

public class ScaleSerial implements IScale, IDevice {

    private SerialPort serialPort = null;
    protected StringParams params = new StringParams();
    private final Logger logger = Logger.getLogger(ScaleSerial.class);

    public String getErrorText(int error) {
        switch (error) {
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
        getSerialPort().open();
        logger.debug("openPort: OK");
    }

    public void disconnect() {
        closePort();
    }

    public void closePort() {
        try {
            getSerialPort().close();
        } catch (Exception e) {
        }
    }

    public boolean isConnected() throws Exception {
        return getSerialPort().isOpened();
    }

    public void setParams(StringParams params) throws Exception {
        this.params = params;
    }

    public StringParams getParams() {
        return params;
    }

    public void setParam(String name, String value) {
        logger.debug("setParam(" + name + ": " + value + ")");
        params.set(name, value);
    }

    public String getParam(String name) {
        logger.debug("getParam(" + name + ")");
        return params.get(name);
    }

    public SerialPort getSerialPort() throws Exception {
        if (serialPort == null) {
            serialPort = createSerialPort();
        }
        return serialPort;
    }

    private SerialPort createSerialPort() throws Exception {
        logger.debug("createSerialPort()");

        int portType = params.getInt(IDevice.PARAM_PORTTYPE);
        if (portType == IDevice.PARAM_PORTTYPE_SERIAL) {
            GnuSerialPort port = new GnuSerialPort();
            port.portName = params.get(IDevice.PARAM_PORTNAME);
            port.baudRate = params.getInt(IDevice.PARAM_BAUDRATE, 9600);
            port.dataBits = params.getInt(IDevice.PARAM_DATABITS, gnu.io.SerialPort.DATABITS_8);
            port.stopBits = params.getInt(IDevice.PARAM_STOPBITS, gnu.io.SerialPort.STOPBITS_1);
            port.parity = params.getInt(IDevice.PARAM_PARITY, gnu.io.SerialPort.PARITY_NONE);
            port.appName = params.get(IDevice.PARAM_APPNAME, "");
            port.openTimeout = params.getInt(IDevice.PARAM_OPEN_TIMEOUT, 1000);
            return port;
        } else {
            TcpSocketPort port = new TcpSocketPort();
            port.portName = params.get(IDevice.PARAM_PORTNAME);
            port.openTimeout = params.getInt(IDevice.PARAM_OPEN_TIMEOUT, 1000);
            port.readTimeout = params.getInt(IDevice.PARAM_READ_TIMEOUT, 1000);
            return port;
        }
    }

    public void zero() throws Exception {
    }

    public void tara() throws Exception {
    }

    public void tara(long v) throws Exception {
    }

    public DeviceMetrics getDeviceMetrics() throws Exception {
        return null;
    }

    public ScaleWeight getWeight() throws Exception {
        return null;
    }

    public void test() throws Exception {
    }

    public EScale getType() {
        return null;
    }

}
