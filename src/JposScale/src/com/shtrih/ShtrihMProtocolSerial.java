package com.shtrih;

import java.io.IOException;
import com.shtrih.DeviceError;
import com.shtrih.scale.ScaleCommand;
import com.shtrih.scale.ScaleSerial;
import com.shtrih.serialport.SerialPort;
import org.apache.log4j.Logger;

/* 
 * Протокол Штрих-М по которому работают ФРы и Весы 
 * 
 * */
public class ShtrihMProtocolSerial {

    private static final int maxENQCount = 1;
    private int byteTimeout = 100;
    private SerialPort serialPort;
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

    public ScaleCommand execCommand(ScaleCommand cmd) throws Exception {
        serialPort.open();
        // Пересчитаем контрольную сумму
        cmd.crc = cmd.getCRC();

        ScaleCommand reply;
        int enq = requestCommand();
        if (enq == SerialPort.ACK) { // Устройство в режиме формирования ответа
            // Ждем ответ, который готовит устройство
            reply = readReply(cmd.timeout);
            enq = requestCommand();
        }

        if (enq == SerialPort.NAK) { // устройство в режиме ожидания команды
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
        int dataLen = 0; // Контрольная сумма LRC
        if (data != null) {
            dataLen = data.length;
        }

        byte[] buffer = new byte[1
                + // STX
                1
                + // Длина
                1
                + // Байт команды
                dataLen
                + // Байты данных
                1 // Контрольная сумма LRC
                ];
        buffer[0] = SerialPort.STX; // STX
        buffer[1] = (byte) (dataLen + 1);// Длина
        buffer[2] = cmd.cmd;// Команда
        if (dataLen > 0) {
            System.arraycopy(data, 0, buffer, 3, data.length); // Данные
        }
        buffer[buffer.length - 1] = cmd.crc;

        int attempts = 3;
        int confirmation;
        do {
            try {
                serialPort.writeBytes(buffer);
                confirmation = serialPort.readByte(byteTimeout);
                if (confirmation == SerialPort.ACK) {
                    return;
                } else if (confirmation == SerialPort.NAK) { // Команда не принята
                    // устройством
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
        SerialPort.Buffer buffer = this.serialPort.new Buffer();
        ScaleCommand command = new ScaleCommand((byte) 0, 0);

        do {
            // STX
            while (true) {
                stx = this.serialPort.readByte(timeout);
                if (stx == SerialPort.STX) {
                    break;
                }
            }
            // Длина
            len = this.serialPort.readByte(byteTimeout);
            // Код команды
            cmd = this.serialPort.readByte(byteTimeout);

            // Данные
            serialPort.read(buffer, len - 1, byteTimeout);

            // LRC
            lrc = this.serialPort.readByte(byteTimeout);
            command = new ScaleCommand((byte) cmd, 1000);
            command.setData(buffer.data);
            command.crc = (byte) lrc;
            break;
        } while (attempts > 0);
        return command;
    }

    protected int requestCommand() throws Exception {
        int b = 0;
        for (int i = 0; i < maxENQCount; i++) {
            this.serialPort.writeByte(SerialPort.ENQ);
            try {
                b = this.serialPort.readByte(byteTimeout);
                return b;
            } catch (Exception e) {
                logger.error(e);
            }
        }
        return -1;
    }
}
