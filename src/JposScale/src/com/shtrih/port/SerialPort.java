package com.shtrih.port;

/**
 * @author V.Kravtsov
 */
public interface SerialPort 
{
    void open() throws Exception;

    void close();

    boolean isOpened();
    
    int readByte() throws Exception;

    byte[] readBytes(int len) throws Exception;

    void write(byte[] b) throws Exception;

    void write(int b) throws Exception;

    void setTimeout(int timeout) throws Exception;

    public static final byte STX = 0x02;
    public static final byte ETX = 0x03;
    public static final byte EOT = 0x04;
    public static final byte ENQ = 0x05;
    public static final byte ACK = 0x06;
    public static final byte DLE = 0x10;
    public static final byte NAK = 0x15;

}
