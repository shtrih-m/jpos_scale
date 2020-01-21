package com.shtrih.serialport;

import org.apache.log4j.Logger;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.ByteBuffer;
import java.util.Enumeration;
import java.util.LinkedList;
import java.util.Vector;
import gnu.io.UnsupportedCommOperationException;

import com.shtrih.DeviceError;
import com.shtrih.IDevice;
import com.shtrih.tools.Logger2;
import com.shtrih.tools.Tools;

public class SerialPort {

    private final Logger logger = Logger.getLogger(SerialPort.class);

    protected gnu.io.SerialPort port;

    protected String appName = SerialPort.class.getName();
    protected String portName = "COM1";
    protected int baudrate = 115200;
    protected int dataBits = gnu.io.SerialPort.DATABITS_8;
    protected int stopBits = gnu.io.SerialPort.STOPBITS_1;
    protected int parity = gnu.io.SerialPort.PARITY_NONE;
    protected int openTimeout = 1000;

    private long idleTimeoutMS = 0;
    private int idleTimeoutNS = 1;

    public static final int ERROR_NONE = 0;
    public static final int ERROR_UNKNOWN = -1;
    public static final int ERROR_PORTINUSE = -2;
    public static final int ERROR_NOSUCHPORT = -3;
    public static final int ERROR_IO = -4;
    public static final int ERROR_UNSUPPORT = -5;
    public static final int ERROR_TIMEOUT = -7;

    public static final String TEXT_ERROR_NONE = "Ошибок нет";
    public static final String TEXT_ERROR_UNKNOWN = "Неизвестная ошибка";
    //public static final String TEXT_ERROR_INUSE = "Порт открыт приложением, ";
    public static final String TEXT_ERROR_INUSE = "Port is opened by another application";
    //public static final String TEXT_ERROR_NOTSUCHPORT = "Порт не существует";
    public static final String TEXT_ERROR_NOTSUCHPORT = "Port is not exists";
    public static final String TEXT_ERROR_IO = "Ошибка ввода/вывода";
    public static final String TEXT_ERROR_UNSUPPORT = "Не поддерживается";
    public static final String TEXT_ERROR_TIMEOUT = "Нет связи";
    public static final String TEXT_ERROR_PORTINUSE = "Невозможно открыть порт.";

    public static final byte STX = 0x02;
    public static final byte ETX = 0x03;
    public static final byte EOT = 0x04;
    public static final byte ENQ = 0x05;
    public static final byte ACK = 0x06;
    public static final byte DLE = 0x10;
    public static final byte NAK = 0x15;

    final int bufferSize = 2048;

    public SerialPort() {
    }

    public void setSerialParams(String appName, String portName, int baudrate,
            int dataBits, int stopBits, int parity, int openTimeout) {
        this.appName = appName;
        this.portName = portName;
        this.baudrate = baudrate;
        this.dataBits = dataBits;
        this.stopBits = stopBits;
        this.parity = parity;
        this.openTimeout = openTimeout;
    }

    private void listPortNames() {
        logger.debug("listPortNames");
        Enumeration ports = gnu.io.CommPortIdentifier.getPortIdentifiers();
        while (ports.hasMoreElements()) {
            gnu.io.CommPortIdentifier port = (gnu.io.CommPortIdentifier) ports.nextElement();
            if (port.getPortType() == gnu.io.CommPortIdentifier.PORT_SERIAL) {
                logger.debug("PORT: " + port.getName());
            }
        }
    }

    public void open() throws Exception {
        if (isOpened()) {
            return;
        }
        logger.debug("open(" + portName + ")");
        gnu.io.CommPortIdentifier portIdentifier;
        portIdentifier = gnu.io.CommPortIdentifier.getPortIdentifier(portName);
        if (portIdentifier == null) {
            throw new gnu.io.NoSuchPortException();
        }
        port = (gnu.io.SerialPort) portIdentifier.open(appName,
                openTimeout);
        if (port == null) {
            throw new gnu.io.NoSuchPortException();
        }
        port.setSerialPortParams(this.baudrate, this.dataBits,
                this.stopBits, this.parity);
        port.setInputBufferSize(1024);
        port.setOutputBufferSize(1024);
        port.setFlowControlMode(gnu.io.SerialPort.FLOWCONTROL_NONE);
        port.enableReceiveTimeout(openTimeout);
    }

    public void setTimeout(int timeout) throws Exception {
        port.enableReceiveTimeout(timeout);
    }

    public void close() {
        logger.debug("close()");
        if (isOpened()) {
            port.close();
            port = null;
            try {
                Thread.sleep(1000);
            } catch (InterruptedException e) {
            }
        }
        logger.debug("close: OK");
    }

    protected void setReceiveTimeout(int timeout) throws Exception {
        if (!isOpened()) {
            return;
        }

        if (timeout <= 0) {
            port.disableReceiveTimeout();
        } else {
            port.enableReceiveTimeout(timeout);
        }
    }

    public int readByte(int timeout) throws Exception {
        open();

        int result;
        InputStream is;
        try {
            is = port.getInputStream();
            if (is == null) {
                return -1;
            }

            long startTime = System.currentTimeMillis();
            for (;;) {
                long currentTime = System.currentTimeMillis();
                if (is.available() > 0) {
                    result = is.read();
                    if (result >= 0) {
                        return result;
                    }
                }
                if ((currentTime - startTime) > timeout) {
                    throw new DeviceError(IDevice.ERROR_NOLINK, IDevice.TEXT_ERROR_NOLINK);
                }
            }
        } catch (Exception e) {
            close();
            throw e;
        }
    }

    public void read(SerialPort.Buffer out, int expectedBytes, int timeout) throws Exception {
        if (timeout < 100) {
            timeout = 100;
        }
        if (expectedBytes <= 0) {
            return;
        }

        out.data = new byte[expectedBytes];
        for (int i = 0; i < expectedBytes; i++) {
            int b = readByte(timeout);
            out.data[i] = (byte) b;
            Tools.sleep(idleTimeoutMS, idleTimeoutNS);
        }

        Logger2.logRx(logger, out.data);
    }

    public void read(SerialPort.Buffer out, int timeout) throws Exception {
        read(out, -1, timeout);
    }

    public void write(ByteBuffer in) throws Exception {
        writeBytes(in.array());
    }

    public void write(SerialPort.Buffer in) throws Exception {
        write(in, false);
    }

    public void write(SerialPort.Buffer in, boolean flush) throws Exception {
        Logger2.logTx(logger, in.data);

        open();
        try {
            OutputStream out = port.getOutputStream();
            out.write(in.data);
            if (flush) {
                out.flush();
            }
        } catch (Exception e) {
            close();
            throw e;
        }
    }

    public void writeBytes(byte[] a, boolean flush) throws Exception {
        write(new SerialPort.Buffer(a), flush);
    }

    public void writeBytes(byte[] a) throws Exception {
        writeBytes(a, false);
    }

    public void writeByte(byte b, boolean flush) throws Exception {
        write(new SerialPort.Buffer(new byte[]{b}), flush);
    }

    public void writeByte(byte b) throws Exception {
        writeByte(b, false);
    }

    public boolean isOpened() {
        return port != null;
    }

    public long getIdleTimeoutMS() {
        return idleTimeoutMS;
    }

    public void setIdleTimeoutMS(long timeout) {
        idleTimeoutMS = timeout;
    }

    public int getIdleTimeoutNS() {
        return idleTimeoutNS;
    }

    public void setIdleTimeoutNS(int timeout) {
        idleTimeoutNS = timeout;
    }

    public void setIdleTimeout(long ms, int ns) {
        idleTimeoutMS = ms;
        idleTimeoutNS = ns;
    }

    public class Buffer {

        public byte[] data;

        public Buffer() {
        }

        public Buffer(byte[] bytes) {
            this.data = bytes;
        }
    }

    public class ReceivedData {

        public byte[] rawData;
        public int rawDataLen;
        public String strData;

        public ReceivedData(byte[] rawData, int rawDataLen, String strData) {
            this.rawData = rawData;
            this.rawDataLen = rawDataLen;
            this.strData = strData;
        }
    }

    public static Vector<String> getPortList() {
        Vector<String> names = new Vector<String>();
        String osname = System.getProperty("os.name");
        String prefix = "/dev/ttyS";
        if (osname.startsWith("Windows")) {
            prefix = "COM";
        }
        for (int i = 1; i < 33; i++) {
            names.add(prefix + String.valueOf(i));
        }
        return names;
    }

}
