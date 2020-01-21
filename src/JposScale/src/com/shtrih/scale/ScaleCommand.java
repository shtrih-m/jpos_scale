package com.shtrih.scale;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.util.Arrays;

import com.shtrih.EquipmentTools;

public class ScaleCommand {

    public ScaleCommand(byte cmd, int timeout) {
        this.cmd = cmd;
        this.timeout = timeout;
    }

    public final byte cmd;
    public final int timeout;

    public byte crc;
    private byte[] data = new byte[0];

    private ByteArrayInputStream in = new ByteArrayInputStream(data);
    private ByteArrayOutputStream out = new ByteArrayOutputStream();

    public String toString() {
        String s = String.format("Команда - %02X, ", this.cmd);
        s += String.format("длина - %d, данные - [", (this.data.length + 1));
        for (int i = 0; i < this.data.length; i++) {
            s += String.format(" %02X", this.data[i]);
        }
        s += String.format(" ], LRC - %02X, ", this.crc);
        s += String.format("timeout - %d, ", this.timeout);
        return s;
    }

    public byte getCRC() {
        int crc = 0;
        crc = crc ^ (data.length + 1);
        crc = crc ^ EquipmentTools.getCRC(data, 0, data.length);
        crc = crc ^ cmd;
        return (byte) crc;
    }

    public void write(long v, int len) throws Exception {
        byte buffer[] = new byte[len];
        for (int i = 0; i < len; i++) {
            buffer[i] = (byte) (v >>> 8 * i);
        }
        out.write(buffer, 0, len);
        this.data = out.toByteArray();
    }

    public void writeBytes(byte[] data, int length) throws Exception {
        byte[] b = new byte[length];
        Arrays.fill(b, (byte) 0);
        System.arraycopy(data, 0, b, 0, Math.min(data.length, length));
        out.write(b);
        this.data = out.toByteArray();
    }

    public void writeBoolean(boolean v) throws Exception {
        if (v) {
            writeByte(1);
        } else {
            writeByte(0);
        }
    }

    public void write(String line, String charsetName) throws Exception {
        byte[] data = line.getBytes(charsetName);
        writeBytes(data, data.length);
    }

    public void writeByte(int v) throws Exception {
        if ((v < 0) || (v > 255)) {
            throw new Exception("Invalid byte value, " + String.valueOf(v));
        }
        out.write(v);
        this.data = out.toByteArray();
    }

    public int readByte() {
        int B = (byte) in.read();
        if (B < 0) {
            B = (int) (256 + B);
        }
        return B;
    }

    public int readShort() throws Exception {
        int ch2 = readByte();
        int ch1 = readByte();
        return ((ch1 << 8) + (ch2 << 0));
    }

    public int readInt() throws Exception {
        int ch4 = readByte();
        int ch3 = readByte();
        int ch2 = readByte();
        int ch1 = readByte();
        return ((ch1 << 24) + (ch2 << 16) + (ch3 << 8) + (ch4 << 0));
    }

    public long readLong(int len) throws Exception {
        if ((len < 1) || (len > 8)) {
            throw new IllegalArgumentException("Invalid answer length");
        }

        long B;
        long result = 0;
        for (int i = 0; i < len; i++) {
            B = readByte();
            result += (B << (8 * i));
        }
        return result;
    }

    public byte[] getData() {
        return data;
    }

    public void setData(byte[] data) {
        this.data = data;
        in = new ByteArrayInputStream(data);
    }

    public byte[] readBytes(int len) {
        byte[] b = new byte[len];
        in.read(b, 0, len);
        return b;
    }

    public String readString(String charsetName) throws Exception {
        byte[] data = trimRight(readBytes(in.available()));
        return new String(data, charsetName);
    }

    public byte[] trimRight(byte[] data) {
        byte[] result = new byte[0];

        int i = 0;
        while (i < data.length) {
            if (data[i] == 0) {
                break;
            }
            i++;
        }
        if (i > 0) {
            result = new byte[i];
            System.arraycopy(data, 0, result, 0, i);
        }
        return result;
    }

}
