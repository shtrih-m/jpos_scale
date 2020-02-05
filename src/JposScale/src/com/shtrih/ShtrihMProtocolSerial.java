package com.shtrih;

import java.io.IOException;
import com.shtrih.DeviceError;
import com.shtrih.scale.ScaleCommand;
import com.shtrih.scale.ScaleSerial;
import com.shtrih.port.SerialPort;
import com.shtrih.tools.Logger2;
import org.apache.log4j.Logger;

/* 
 * �������� �����-� �� �������� �������� ��� � ���� 
 * 
 * */
public class ShtrihMProtocolSerial {

    private static final int maxENQCount = 1;
    private int byteTimeout = 100;
    private final SerialPort serialPort;
    private final Logger logger = Logger.getLogger(ShtrihMProtocolSerial.class);

    public ShtrihMProtocolSerial(SerialPort serialPort) {
        this.serialPort = serialPort;
    }

    public int getByteTimeout() {
        return byteTimeout;
    }

    public void setByteTimeout(int value) {
        byteTimeout = value;
    }

	public ScaleCommand execCommand(ScaleCommand cmd) throws Exception 
    {
        serialPort.open();
        // ����������� ����������� �����
        cmd.crc = cmd.getCRC();

        ScaleCommand reply;
        int enq = requestCommand();
        if (enq == SerialPort.ACK) { // ���������� � ������ ������������ ������
            // ���� �����, ������� ������� ����������
            reply = readReply(cmd.timeout);
            enq = requestCommand();
        }

        if (enq == SerialPort.NAK) { // ���������� � ������ �������� �������
            writeCommand(cmd);
            reply = readReply(cmd.timeout);
            return reply;
        } else {
            throw new DeviceError(IDevice.ERROR_NOLINK, IDevice.TEXT_ERROR_NOLINK);
        }
    }

    public ScaleCommand createCommand(byte c, int timeout) {
        return new ScaleCommand(c, timeout);
    }

    protected void writeCommand(ScaleCommand cmd) throws Exception{

        byte[] data = cmd.getData();
        int dataLen = 0; // ����������� ����� LRC
        if (data != null) {
            dataLen = data.length;
        }

        byte[] buffer = new byte[1
                + // STX
                1
                + // �����
                1
                + // ���� �������
                dataLen
                + // ����� ������
                1 // ����������� ����� LRC
                ];
        buffer[0] = SerialPort.STX; // STX
        buffer[1] = (byte) (dataLen + 1);// �����
        buffer[2] = cmd.cmd;// �������
        if (dataLen > 0) {
            System.arraycopy(data, 0, buffer, 3, data.length); // ������
        }
        buffer[buffer.length - 1] = cmd.crc;

        int attempts = 3;
        int confirmation;
        do {
            try {
                serialPort.write(buffer);
                serialPort.setTimeout(byteTimeout);
                confirmation = serialPort.readByte();
                if (confirmation == SerialPort.ACK) {
                    return;
                } else if (confirmation == SerialPort.NAK) { // ������� �� �������
                    // �����������
                    attempts--;
                    continue;
                }

            } catch (Exception e) {
                logger.error(e);
                attempts--;
            }
        } while (attempts > 0);
        throw new DeviceError(IDevice.ERROR_NOLINK, IDevice.TEXT_ERROR_NOLINK);
    }

    protected ScaleCommand readReply(int timeout) throws Exception {
        int stx, cmd, len, lrc;
        int attempts = 3;
        ScaleCommand command = new ScaleCommand((byte) 0, 0);

        do {
            // STX
            while (true) {
                serialPort.setTimeout(timeout);
                stx = serialPort.readByte();
                if (stx == SerialPort.STX) {
                    break;
                }
            }
            serialPort.setTimeout(byteTimeout);
            // �����
            len = serialPort.readByte();
            // ������
            byte data[] = serialPort.readBytes(len + 1);
            // ��� �������
            cmd = data[0];
            // LRC
            lrc = data[len];
            
            command = new ScaleCommand((byte) cmd, 1000);
            System.arraycopy(data, 1, data, 0, len);
            
            command.setData(data);
            command.crc = (byte) lrc;
            break;
        } while (attempts > 0);
        return command;
    }

    protected int requestCommand() throws Exception {
        int b = 0;
        for (int i = 0; i < maxENQCount; i++) {
            serialPort.write(SerialPort.ENQ);
            try {
                serialPort.setTimeout(byteTimeout);
                b = serialPort.readByte();
                return b;
            } catch (Exception e) {
                logger.error(e);
            }
        }
        return -1;
    }
}
