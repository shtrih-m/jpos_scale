package com.shtrih.port;

import java.io.*;
import java.net.*;
import java.util.*;
import org.apache.log4j.Logger;

import com.shtrih.util.*;

/**
 * @author V.Kravtsov
 */
public class TcpSocketPort implements SerialPort {
    private static Logger logger = Logger.getLogger(TcpSocketPort.class);

    public String portName;
    public int readTimeout = 1000;
    public int openTimeout = 1000;
    private Socket socket = null;

    public TcpSocketPort() {
    }

    public boolean isOpened() {
        return socket != null && socket.isConnected();
    }

    public void open() throws Exception 
    {
        if (isOpened()) {
            return;
        }

        logger.debug("open(" + portName + ")");
        socket = new Socket();
        socket.setReuseAddress(true);
        socket.setSoTimeout(readTimeout);
        socket.setTcpNoDelay(true);

        StringTokenizer tokenizer = new StringTokenizer(portName, ":");
        String host = tokenizer.nextToken();
        int port = Integer.parseInt(tokenizer.nextToken());
        socket.connect(new InetSocketAddress(host, port), openTimeout);
        logger.debug("OK");
    }

    public void close() {
        if (!isOpened()) {
            return;
        }
        try {
            socket.close();
            Thread.sleep(100);
        } catch (Exception e) {
        }
        socket = null;
    }

    public int readByte() throws Exception {
        open();

        int b = socket.getInputStream().read();
        if (b == -1) {
            noConnectionError();
        }

        return b;
    }

    private void noConnectionError() throws Exception {
        throw new IOException("No connection)");
    }

    public byte[] readBytes(int len) throws Exception {
        open();

        byte[] data = new byte[len];
        int offset = 0;
        while (len > 0) {
            int count = socket.getInputStream().read(data, offset, len);
            if (count == -1) {
                noConnectionError();
            }
            len -= count;
            offset += count;
        }
        return data;
    }

    public void write(byte[] b) throws Exception 
    {
        OutputStream os = socket.getOutputStream();
        for (int i = 0; i < 2; i++) {
            try {
                open();
                os.write(b);
                os.flush();
                return;
            } catch (Exception e) {
                close();
                if (i == 1) {
                    throw e;
                }
            }
        }
    }

    public void write(int b) throws Exception {
        open();
        byte[] data = new byte[1];
        data[0] = (byte) b;
        write(data);
    }

    public void setBaudRate(int baudRate) throws Exception {
    }

    public void setTimeout(int timeout) throws Exception {

        this.readTimeout = timeout;

        if (isOpened())
            socket.setSoTimeout(readTimeout);
    }

    public String getPortName() {
        return portName;
    }

    public void setPortName(String portName) throws Exception {

    }

    public Object getSyncObject() throws Exception {
        return this;
    }

    public boolean isSearchByBaudRateEnabled() {
        return false;
    }

    public String[] getPortNames() {
        return new String[] { portName };
    }
}
