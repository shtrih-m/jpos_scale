package com.shtrih.port;

import org.apache.log4j.Logger;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.ByteBuffer;
import java.util.Enumeration;
import java.util.LinkedList;
import java.util.Vector;
import gnu.io.UnsupportedCommOperationException;

import com.shtrih.IDevice;
import com.shtrih.DeviceError;
import com.shtrih.tools.Tools;
import com.shtrih.tools.Logger2;
import com.shtrih.port.SerialPort;

public class GnuSerialPort implements SerialPort {

    private final Logger logger = Logger.getLogger(GnuSerialPort.class);

    private final int bufferSize = 2048;
    private gnu.io.SerialPort port;
    public String appName = GnuSerialPort.class.getName();
    public String portName = "COM1";
    public int baudRate = 115200;
    public int dataBits = gnu.io.SerialPort.DATABITS_8;
    public int stopBits = gnu.io.SerialPort.STOPBITS_1;
    public int parity = gnu.io.SerialPort.PARITY_NONE;
    public int openTimeout = 1000;
    public long idleTimeoutMS = 0;
    public int idleTimeoutNS = 1;
    private int readTimeout = 1000;

    public GnuSerialPort() {
    }

    public void setSerialParams(String appName, String portName, int baudrate,
            int dataBits, int stopBits, int parity, int openTimeout) {
        this.appName = appName;
        this.portName = portName;
        this.baudRate = baudrate;
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
        port.setSerialPortParams(this.baudRate, this.dataBits,
                this.stopBits, this.parity);
        port.setInputBufferSize(1024);
        port.setOutputBufferSize(1024);
        port.setFlowControlMode(gnu.io.SerialPort.FLOWCONTROL_NONE);
        port.enableReceiveTimeout(openTimeout);
    }

    public void setTimeout(int timeout) throws Exception {
        port.enableReceiveTimeout(timeout);
        readTimeout = timeout;
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

    public int doReadByte() throws Exception {
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
                if ((currentTime - startTime) > readTimeout) {
                    throw new DeviceError(IDevice.ERROR_NOLINK, IDevice.TEXT_ERROR_NOLINK);
                }
            }
        } catch (Exception e) {
            close();
            throw e;
        }
    }

    public int readByte() throws Exception {
        byte[] data = new byte[1];
        data[0] = (byte) doReadByte();
        Logger2.logRx(logger, data);
        return data[0];
    }

    public void read(GnuSerialPort.Buffer out, int len, int timeout) throws Exception {
        if (timeout < 100) {
            timeout = 100;
        }
        setTimeout(timeout);
        out.data = readBytes(len);
    }

    public void read(GnuSerialPort.Buffer out, int timeout) throws Exception {
        read(out, -1, timeout);
    }

    public byte[] readBytes(int len) throws Exception {
        byte[] result = new byte[len];
        for (int i = 0; i < len; i++) {
            int b = doReadByte();
            result[i] = (byte) b;
        }
        Logger2.logRx(logger, result);
        return result;
    }

    public void write(ByteBuffer in) throws Exception {
        write(in.array());
    }

    public void write(GnuSerialPort.Buffer in) throws Exception {
        write(in, false);
    }

    public void write(GnuSerialPort.Buffer in, boolean flush) throws Exception {
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
        write(new GnuSerialPort.Buffer(a), flush);
    }

    public void writeByte(int b, boolean flush) throws Exception {
        write(new GnuSerialPort.Buffer(new byte[]{(byte) b}), flush);
    }

    public void write(int b) throws Exception {
        writeByte(b, false);
    }

    public void write(byte[] a) throws Exception {
        writeBytes(a, false);
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

    public static Vector<String> getPortList2() {
        Vector<String> names = new Vector<String>();
        Enumeration e = gnu.io.CommPortIdentifier.getPortIdentifiers();
        while (e.hasMoreElements()) {
            gnu.io.CommPortIdentifier port = (gnu.io.CommPortIdentifier) e.nextElement();
            if (port.getPortType() == gnu.io.CommPortIdentifier.PORT_SERIAL) {
                names.add(port.getName());
            }
        }
        return names;
    }
}
