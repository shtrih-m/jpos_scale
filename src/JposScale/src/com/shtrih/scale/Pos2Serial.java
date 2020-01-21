package com.shtrih.scale;

import com.shtrih.IDevice;
import com.shtrih.DeviceError;
import com.shtrih.ShtrihMProtocolSerial;
import org.apache.log4j.Logger;

public class Pos2Serial extends ScaleSerial {

    private final ShtrihMProtocolSerial protocol = new ShtrihMProtocolSerial(
            this.serialPort);

    private final Logger logger = Logger.getLogger(Pos2Serial.class);

    // //////////////////////////////////////////////////////////////////////////
    // Scale command code constants
    public static final byte CMD_ZERO = (byte) 0x30;
    public static final byte CMD_TARA = (byte) 0x31;
    public static final byte CMD_SET_TARA = (byte) 0x32;
    public static final byte CMD_READ_WEIGHT = (byte) 0x3A;
    public static final byte CMD_READ_DEVICE_METRICS = (byte) 0xFC;
    public static final byte CMD_WRITE_MODE = (byte) 0x07;
    public static final byte CMD_SEND_KEY = (byte) 0x08;
    public static final byte CMD_LOCK_KEYBOARD = (byte) 0x09;
    public static final byte CMD_READ_SCALE_MODE = (byte) 0x12;
    public static final byte CMD_WRITE_PARAM = (byte) 0x14;
    public static final byte CMD_READ_PARAM = (byte) 0x15;
    public static final byte CMD_WRITE_ADMIN_PASSWORD = (byte) 0x16;
    public static final byte CMD_WRITE_CALIB_POINT = (byte) 0x70;
    public static final byte CMD_READ_CALIB_POINT = (byte) 0x71;
    public static final byte CMD_START_CALIBRATION = (byte) 0x72;
    public static final byte CMD_READ_CALIB_STATUS = (byte) 0x73;
    public static final byte CMD_STOP_CALIBRATION = (byte) 0x74;
    public static final byte CMD_READ_WEIGHT_ADC = (byte) 0x75;
    public static final byte CMD_READ_KBD_STATUS = (byte) 0x90;
    public static final byte CMD_READ_CHANNEL_COUNT = (byte) 0xE5;
    public static final byte CMD_SELECT_CHANNEL = (byte) 0xE6;
    public static final byte CMD_ENABLE_CHANNEL = (byte) 0xE7;
    public static final byte CMD_READ_CHANNEL_PARAMS = (byte) 0xE8;
    public static final byte CMD_WRITE_CHANNEL_PARAMS = (byte) 0xE9;
    public static final byte CMD_READ_CHANNEL_NUMBER = (byte) 0xEA;
    public static final byte CMD_RESET_CHANNEL = (byte) 0xEF;
    public static final byte CMD_RESET_DEVICE = (byte) 0xF0;

    // //////////////////////////////////////////////////////////////////////////
    // Scale mode constants
    public static final byte MODE_NORMAL = (byte) 0x00;
    public static final byte MODE_CALIBRATION = (byte) 0x01;

    private int channelCount = 0;
    private int channelNumber = 0;
    private int scaleMode = 0;
    private long adcValue = 0;
    private int keyboardStatus = 0;
    private int weightValue = 0;
    private String charsetName = "Cp1251";
    private ScaleCommand reply;
    private ScaleWeight weight = new ScaleWeight(0, 0, new ScaleStatus(0));
    private ChannelParams channelParams = new ChannelParams();
    private CalibrationStatus calibrationStatus = new CalibrationStatus(0, 0, 0);
    private DeviceMetrics deviceMetrics = new DeviceMetrics(0, 0, 0, 0, 0, 0, "");

    public EScale getType() {
        return EScale.Pos2;
    }

    public void connect() throws Exception {
        int byteTimeout = params.getIntParam(IDevice.PARAM_OPEN_TIMEOUT);
        protocol.setByteTimeout(byteTimeout);
        openPort();
    }

    public void sendKey(int key) throws Exception {
        ScaleCommand command = new ScaleCommand(CMD_SEND_KEY, 1000);
        command.write(getPassword(), charsetName);
        command.write(key, 1);
        execute(command);
    }

    public void lockKeyboard() throws Exception {
        ScaleCommand command = new ScaleCommand(CMD_LOCK_KEYBOARD, 1000);
        command.write(getPassword(), charsetName);
        command.write(1, 1);
        execute(command);
    }

    public void unlockKeyboard() throws Exception {
        ScaleCommand command = new ScaleCommand(CMD_LOCK_KEYBOARD, 1000);
        command.write(getPassword(), charsetName);
        command.write(0, 1);
        execute(command);
    }

    public void writeMode(int mode) throws Exception {
        ScaleCommand command = new ScaleCommand(CMD_WRITE_MODE, 1000);
        command.write(getPassword(), charsetName);
        command.write(mode, 1);
        execute(command);
    }

    public int getScaleMode() {
        return scaleMode;
    }

    public void readScaleMode() throws Exception {
        execute(CMD_READ_SCALE_MODE);
        scaleMode = reply.readByte();
    }

    public void tara() throws Exception {
        executePsw(CMD_TARA);
    }

    public void tara(long v) throws Exception {
        ScaleCommand command = createCommand(CMD_SET_TARA);
        command.write(getPassword(), charsetName);
        command.write(v, 2);
        execute(command);
    }

    public void zero() throws Exception {
        executePsw(CMD_ZERO);
    }

    public String getPassword() throws Exception {
        long password = params.getIntParam(IDevice.PARAM_PASSWORD);
        String result = String.valueOf(password);
        int len = 4 - result.length();
        for (int i = 0; i < len; i++) {
            result = '0' + result;
        }
        return result;
    }

    public int getCommandTimeout(int cmd) {
        return 1000;
    }

    public ScaleWeight getWeight2() {
        return weight;
    }

    public ScaleWeight getWeight() throws Exception {
        readWeight();
        return weight;
    }

    public void readWeight() throws Exception {
        logger.debug("readWeight");
        this.weight = null;
        int timeout = getCommandTimeout(CMD_READ_WEIGHT);
        ScaleCommand command = new ScaleCommand(CMD_READ_WEIGHT, timeout);
        command.write(getPassword(), charsetName);
        execute(command);
        int status = reply.readShort();
        int weight = reply.readInt();
        int tare = reply.readShort();
        this.weight = new ScaleWeight(weight, tare, new ScaleStatus(status));
        logger.debug("weight = " + weight + ", tare = " + tare + ", flags = " + status);
    }

    public void writeCalibrationPoint(int number, int weight) throws Exception {
        byte cmd = CMD_WRITE_CALIB_POINT;
        int timeout = getCommandTimeout(cmd);
        ScaleCommand command = new ScaleCommand(cmd, timeout);
        command.write(getPassword(), charsetName);
        command.write(number, 1);
        command.write(weight, 2);
        execute(command);
    }

    public int getWeightValue() {
        return weightValue;
    }

    public void readCalibrationPoint(int number) throws Exception {
        byte cmd = CMD_READ_CALIB_POINT;
        int timeout = getCommandTimeout(CMD_READ_CALIB_POINT);
        ScaleCommand command = new ScaleCommand(cmd, timeout);
        command.write(getPassword(), charsetName);
        command.write(number, 1);
        execute(command);
        weightValue = reply.readShort();
    }

    public CalibrationStatus getCalibrationStatus() {
        return calibrationStatus;
    }

    public void readCalibrationStatus() throws Exception {
        executePsw(CMD_READ_CALIB_STATUS);
        int number = reply.readByte();
        double weight = getWeightValue(reply.readShort());
        int status = reply.readByte();
        calibrationStatus = new CalibrationStatus(number, weight,
                status);
    }

    public long getADCValue() {
        return adcValue;
    }

    public void readADCValue() throws Exception {
        executePsw(CMD_READ_WEIGHT_ADC);
        adcValue = reply.readLong(4);
    }

    public int getKeyboardStatus() {
        return keyboardStatus;
    }

    public void readKeyboardStatus() throws Exception {
        executePsw(CMD_READ_KBD_STATUS);
        keyboardStatus = reply.readByte();
    }

    public void reset() throws Exception {
        executePsw(CMD_RESET_DEVICE);
    }

    public void resetChannel() throws Exception {
        executePsw(CMD_RESET_CHANNEL);
    }

    public void startCalibration() throws Exception {
        executePsw(CMD_START_CALIBRATION);
    }

    public void stopCalibration() throws Exception {
        executePsw(CMD_STOP_CALIBRATION);
    }

    public int getChannelCount() {
        return channelCount;
    }

    public void readChannelCount() throws Exception {
        byte cmd = CMD_READ_CHANNEL_COUNT;
        int timeout = getCommandTimeout(CMD_READ_CALIB_POINT);
        ScaleCommand command = new ScaleCommand(cmd, timeout);
        execute(command);
        channelCount = reply.readByte();
    }

    public int getChannelNumber() {
        return channelNumber;
    }

    public void readChannelNumber() throws Exception {
        execute(CMD_READ_CHANNEL_NUMBER);
        channelNumber = reply.readByte();
    }

    public ChannelParams getChannelParams() {
        return channelParams;
    }

    public void readChannelParams(int index) throws Exception {
        ScaleCommand command = createCommand(CMD_READ_CHANNEL_PARAMS);
        command.write(index, 1);
        execute(command);
        channelParams.flags = reply.readShort();
        channelParams.decimalPoint = (byte) reply.readByte();
        channelParams.power = (byte) reply.readByte();
        channelParams.maxWeigth = reply.readShort();
        channelParams.minWeigth = reply.readShort();
        channelParams.maxTare = reply.readShort();
        channelParams.range[0] = 0;
        channelParams.range[1] = reply.readShort();
        channelParams.range[2] = reply.readShort();
        channelParams.range[3] = reply.readShort();
        channelParams.resolution[0] = reply.readByte();
        channelParams.resolution[1] = reply.readByte();
        channelParams.resolution[2] = reply.readByte();
        channelParams.resolution[3] = reply.readByte();
        channelParams.pointCount = reply.readByte();
        channelParams.calibCount = reply.readByte();
    }

    public DeviceMetrics getDeviceMetrics() {
        return deviceMetrics;
    }

    public void readDeviceMetrics() throws Exception {
        ScaleCommand command = createCommand(CMD_READ_DEVICE_METRICS);
        execute(command);
        int type = reply.readByte();
        int subType = reply.readByte();
        int majorVersion = reply.readByte();
        int minorVersion = reply.readByte();
        int model = reply.readByte();
        int lang = reply.readByte();
        String description = reply.readString(charsetName);
        deviceMetrics = new DeviceMetrics(type, subType, majorVersion,
                minorVersion, model, lang, description);
    }

    public static final String getCommandText(int cmd) {
        switch (cmd) {
            case 0x07:
                return "Перейти в режим";
            case 0x08:
                return "Эмуляция клавиатуры";
            case 0x09:
                return "Блокировка/разблокировка клавиатуры";
            case 0x12:
                return "Запрос текущего режима весового модуля";
            case 0x14:
                return "Установка параметров обмена";
            case 0x15:
                return "Чтение параметров обмена";
            case 0x16:
                return "Изменение пароля администратора";
            case 0x30:
                return "Установить ноль";
            case 0x31:
                return "Установить тару";
            case 0x32:
                return "Задать тару";
            case 0x3A:
                return "Запрос состояния весового канала";
            case 0x70:
                return "Записать градуировочную точку";
            case 0x71:
                return "Прочитать градуировочную точку";
            case 0x72:
                return "Начать градуировку";
            case 0x73:
                return "Запрос состояния процесса градуировки";
            case 0x74:
                return "Прервать процесс градуировки";
            case 0x75:
                return "Получить показания АЦП для текущего канала";
            case 0x90:
                return "Запрос состояния клавиатуры";
            case 0xE5:
                return "Прочитать количество весовых каналов";
            case 0xE6:
                return "Выбрать весовой канал";
            case 0xE7:
                return "Включить / выключить текущий весовой канал";
            case 0xE8:
                return "Прочитать характеристики весового канала";
            case 0xE9:
                return "Записать характеристики весового канала";
            case 0xEA:
                return "Получить номер текущего весового канала";
            case 0xEF:
                return "Перезапуск текущего весового канала";
            case 0xF0:
                return "Сброс";
            case 0xFC:
                return "Получить тип устройства";
            default:
                return String.valueOf(cmd);
        }
    }

    protected synchronized void execute(ScaleCommand command) throws Exception {
        String CommandSeparator = "------------------------------------------------------";
        logger.debug(CommandSeparator);
        logger.debug(getCommandText(command.cmd));

        reply = protocol.execCommand(command);
        int rc = reply.readByte();
        logger.debug(CommandSeparator);
        if (rc != 0) {
            throw new DeviceError(rc, getErrorText(rc));
        }
    }

    protected ScaleCommand createCommand(byte cmd) {
        int timeout = getCommandTimeout(cmd);
        ScaleCommand command = new ScaleCommand(cmd, timeout);
        return command;
    }

    protected void execute(byte cmd) throws Exception {
        execute(createCommand(cmd));
    }

    protected void executePsw(byte cmd) throws Exception {
        ScaleCommand command = createCommand(cmd);
        command.write(getPassword(), charsetName);
        execute(command);
    }

    public double getWeightValue(int value) {
        return channelParams.getWeigthValue(value);
    }

}
