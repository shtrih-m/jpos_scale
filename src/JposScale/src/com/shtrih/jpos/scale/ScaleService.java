package com.shtrih.jpos.scale;

import java.util.ArrayList;

import org.apache.log4j.Logger;
import com.shtrih.jpos.JposPropertyReader;

import com.shtrih.IDevice;
import com.shtrih.DeviceError;
import com.shtrih.scale.DeviceMetrics;
import com.shtrih.port.GnuSerialPort;
import com.shtrih.scale.EScale;
import com.shtrih.scale.IScale;
import com.shtrih.scale.Pos2Serial;
import com.shtrih.scale.ScaleSerial;
import com.shtrih.scale.ScaleWeight;
import com.shtrih.scale.Shtrih5Serial;
import com.shtrih.scale.Shtrih6Serial;
import com.shtrih.tools.Tools;
import com.shtrih.tools.StringParams;
import com.shtrih.jpos.JposUtils;
import com.shtrih.util.ServiceVersionUtil;

import jpos.JposConst;
import static jpos.JposConst.JPOS_EL_INPUT;
import static jpos.JposConst.JPOS_ER_RETRY;
import static jpos.JposConst.JPOS_E_FAILURE;
import static jpos.JposConst.JPOS_E_TIMEOUT;
import jpos.JposException;
import jpos.ScaleConst;
import jpos.config.JposEntryConst;
import jpos.config.RS232Const;
import jpos.events.DataEvent;
import jpos.events.ErrorEvent;
import jpos.services.EventCallbacks;
import jpos.services.ScaleService113;

public class ScaleService extends Scale implements ScaleService113, ScaleConst, JposConst, JposEntryConst {

    /**
     *
     */
    private static final long serialVersionUID = 6309237509625068100L;
    private final Logger logger = Logger.getLogger(ScaleService.class);
    private final int S_CLOSED = 0;
    private final int S_OPENED = 1;
    private final int S_CLAIMED = 2;
    private final int S_ENABLED = 3;

    private ScaleSerial m_protocol = null;
    private DeviceMetrics m_deviceMetrics;
    private int m_state = S_CLOSED;
    private boolean m_asyncMode = false;
    private EventCallbacks m_eventsCallback = null;
    private String m_logicalName = null;
    private boolean m_dataEventEnabled = false;
    private boolean m_freezeEvents = false;
    private final ReadWeightThread m_reader = new ReadWeightThread();
    private boolean m_autoDisable = false;
    private int m_tareWeight = 0;
    private boolean m_needReadWeight = true;
    private final ArrayList<DataEvent> m_events = new ArrayList<DataEvent>();

    public boolean getCapCompareFirmwareVersion() throws JposException {
        logger.debug("getCapCompareFirmwareVersion()");
        boolean result = false;
        checkOpened();
        logger.debug("getCapCompareFirmwareVersion = " + String.valueOf(result));
        return result;
    }

    public boolean getCapStatusUpdate() throws JposException {
        logger.debug("getCapStatusUpdate()");
        boolean result = false;
        checkOpened();
        logger.debug("getCapStatusUpdate = " + String.valueOf(result));
        return result;
    }

    public boolean getCapUpdateFirmware() throws JposException {
        logger.debug("getCapUpdateFirmware()");
        boolean result = false;
        checkOpened();
        logger.debug("getCapUpdateFirmware = " + String.valueOf(result));
        return result;
    }

    public boolean getCapDisplay() throws JposException {
        logger.debug("getCapDisplay()");
        boolean result = false;
        checkOpened();
        logger.debug("getCapDisplay = " + String.valueOf(result));
        return result;
    }

    public boolean getCapStatisticsReporting() throws JposException {
        logger.debug("getCapStatisticsReporting()");
        boolean result = false;
        checkOpened();
        logger.debug("getCapStatisticsReporting = " + String.valueOf(result));
        return result;
    }

    public boolean getCapUpdateStatistics() throws JposException {
        logger.debug("getCapUpdateStatistics()");
        boolean result = false;
        checkOpened();
        logger.debug("getCapUpdateStatistics = " + String.valueOf(result));
        return result;
    }

    public boolean getCapDisplayText() throws JposException {
        logger.debug("getCapDisplayText()");
        boolean result = false;
        checkOpened();
        logger.debug("getCapDisplayText = " + String.valueOf(result));
        return result;
    }

    public int getCapPowerReporting() throws JposException {
        logger.debug("getCapPowerReporting()");
        int result = JPOS_PR_NONE;
        checkOpened();
        logger.debug("getCapPowerReporting = " + JposUtils.getCapPowerReportingText(result));
        return result;
    }

    public boolean getCapPriceCalculating() throws JposException {
        logger.debug("getCapPriceCalculating()");
        boolean result = false;
        checkOpened();
        logger.debug("getCapPriceCalculating = " + String.valueOf(result));
        return result;
    }

    public boolean getCapTareWeight() throws JposException {
        logger.debug("getCapTareWeight()");
        boolean result = true;
        checkOpened();
        logger.debug("getCapTareWeight = " + String.valueOf(result));
        return result;
    }

    public boolean getCapZeroScale() throws JposException {
        logger.debug("getCapZeroScale()");

        checkOpened();
        boolean result = false;
        if (m_protocol.getType() == EScale.Pos2) {
            result = true;
        }
        logger.debug("getCapZeroScale = " + String.valueOf(result));
        return result;
    }

    public void open(String logicalName, EventCallbacks eventsCallback) throws JposException {
        logger.debug("open(" + logicalName + ", " + eventsCallback + ")");
        if (m_state > S_OPENED) {
            logger.warn("state > S_OPENED");
            // throw new JposException(JPOS_E_CLAIMED);
            return;
        }

        m_state = S_CLOSED;
        m_eventsCallback = eventsCallback;
        m_logicalName = logicalName;
        m_asyncMode = false;
        m_needReadWeight = false;

        JposPropertyReader reader = new JposPropertyReader(m_jposEntry);
        try {
            String protocol = reader.readString("protocol").toLowerCase();
            m_protocol = createProtocol(protocol);

            StringParams params = new StringParams();
            params.set(IDevice.PARAM_DATABITS, "8");
            params.set(IDevice.PARAM_STOPBITS, "1");
            params.set(IDevice.PARAM_PARITY, "0");

            String value = reader.readString(RS232Const.RS232_PORT_NAME_PROP_NAME, "");
            params.set(IDevice.PARAM_PORTNAME, value);

            value = reader.readString(RS232Const.RS232_BAUD_RATE_PROP_NAME, "9600");
            params.set(IDevice.PARAM_BAUDRATE, value);

            value = reader.readString("password", "30");
            params.set(IDevice.PARAM_PASSWORD, value);

            value = reader.readString("timeout", "100");
            params.set(IDevice.PARAM_OPEN_TIMEOUT, value);

            value = reader.readString("portType", "0");
            params.set(IDevice.PARAM_PORTTYPE, value);
            
            m_protocol.setParams(params);
            m_state = S_OPENED;
            logger.debug("open: OK");
        } catch (Exception e) {
            throw getJposException(e);
        }
    }

    private ScaleSerial createProtocol(String protocol) throws Exception {
        if (protocol.equalsIgnoreCase("pos2")) {
            return new Pos2Serial();
        }
        if (protocol.equalsIgnoreCase("shtrih5")) {
            return new Shtrih5Serial();
        }
        if (protocol.equalsIgnoreCase(
                "shtrih6")) {
            return new Shtrih6Serial();
        }
        throw new JposException(JPOS_E_FAILURE, "Неизвестный протокол весов '" + protocol + "'");
    }

    public void release() throws JposException {
        logger.debug("release()");
        checkClaimed();
        try{
            m_protocol.disconnect();
            m_state = S_OPENED;
            synchronized (m_events) {
                m_events.clear();
            }
            logger.debug("release: OK");
        } catch(Exception e){
            throw getJposException(e);
        }
    }

    public void claim(int timeout) throws JposException {
        logger.debug("claim(" + String.valueOf(timeout) + ")");
        if (m_state >= S_CLAIMED) {
            logger.warn("state >= S_CLAIMED");
            // throw new JposException(JPOS_E_CLAIMED);
            return;
        }

        m_protocol.setParam(IScale.PARAM_TIMEOUT_DEVICE_METRICS,
                /* String.valueOf(timeout) */ "1000");

        try {
            m_protocol.connect();
            m_deviceMetrics = m_protocol.getDeviceMetrics();
        } catch (Exception e) {
            throw getJposException(e);
        }
        m_state = S_CLAIMED;
        logger.debug("claim: OK");
    }

    public void close() throws JposException {
        logger.debug("close()");
        if (m_state >= S_CLAIMED) {
            release();
        }
        m_asyncMode = false;
        m_needReadWeight = false;
        m_state = S_CLOSED;
        m_protocol = null;
        synchronized (m_events) {
            m_events.clear();
        }
        logger.debug("close: OK");
    }

    public void compareFirmwareVersion(String arg0, int[] arg1) throws JposException {
        logger.debug("compareFirmwareVersion("
                + String.valueOf(arg0) + ", "
                + String.valueOf(arg1) + ")");

        logger.debug("compareFirmwareVersion: OK");
    }

    public int getScaleLiveWeight() throws JposException {
        logger.debug("getScaleLiveWeight()");
        logger.debug("getScaleLiveWeight = 0");
        return 0;
    }

    public int getStatusNotify() throws JposException {
        logger.debug("getStatusNotify()");
        throw new JposException(JPOS_E_ILLEGAL, "Неподдерживается");
    }

    public void setStatusNotify(int arg0) throws JposException {
        logger.debug("setStatusNotify(" + String.valueOf(arg0) + ")");
        throw new JposException(JPOS_E_ILLEGAL, "Неподдерживается");
    }

    public void updateFirmware(String arg0) throws JposException {
        logger.debug("updateFirmware(" + String.valueOf(arg0) + ")");
        logger.debug("updateFirmware: OK");
    }

    public void resetStatistics(String arg0) throws JposException {
        logger.debug("resetStatistics(" + String.valueOf(arg0) + ")");
        logger.debug("resetStatistics: OK");
    }

    public void retrieveStatistics(String[] arg0) throws JposException {
        logger.debug("retrieveStatistics(" + String.valueOf(arg0) + ")");
        logger.debug("retrieveStatistics: OK");
    }

    public void updateStatistics(String arg0) throws JposException {
        logger.debug("updateStatistics(" + String.valueOf(arg0) + ")");
        logger.debug("updateStatistics: OK");
    }

    public void clearInput() throws JposException {
        logger.debug("clearInput()");
        synchronized (m_events) {
            m_events.clear();
        }
        logger.debug("clearInput: OK");
    }

    public void displayText(String arg0) throws JposException {
        logger.debug("displayText(" + arg0 + ")");
        logger.debug("displayText: OK");
    }

    public void setAsyncMode(boolean async) throws JposException {
        logger.debug("setAsyncMode(" + String.valueOf(async) + ")");

        checkOpened();
        if (async == m_asyncMode) {
            return;
        }

        m_asyncMode = async;
        if (m_asyncMode) {
            m_reader.start();
        } else {
            try {
                m_reader.join();
            } catch (InterruptedException e) {
                logger.error(e.getMessage());
            }
        }
        logger.debug("setAsyncMode: OK");
    }

    public boolean getAsyncMode() throws JposException {
        logger.debug("getAsyncMode()");
        logger.debug("getAsyncMode = " + String.valueOf(m_asyncMode));
        return m_asyncMode;
    }

    public int getDataCount() throws JposException {
        logger.debug("getDataCount()");
        logger.debug("getDataCount = 0");
        return 0;
    }

    public int getMaxDisplayTextChars() throws JposException {
        logger.debug("getMaxDisplayTextChars()");
        checkOpened();
        logger.debug("getMaxDisplayTextChars = 0");
        return 0;
    }

    public int getPowerNotify() throws JposException {
        logger.debug("getPowerNotify()");
        checkOpened();
        logger.debug("getPowerNotify = JPOS_PN_DISABLED");
        return JPOS_PN_DISABLED;
    }

    public int getPowerState() throws JposException {
        logger.debug("getPowerState()");
        checkOpened();
        logger.debug("getPowerState = JPOS_PS_UNKNOWN");
        return JPOS_PS_UNKNOWN;
    }

    public long getSalesPrice() throws JposException {
        logger.debug("getSalesPrice()");
        checkOpened();
        logger.debug("getSalesPrice = 0");
        return 0;
    }

    public int getTareWeight() throws JposException {
        logger.debug("getTareWeight()");
        checkOpened();
        logger.debug("getTareWeight = " + String.valueOf(m_tareWeight));
        return m_tareWeight;
    }

    public long getUnitPrice() throws JposException {
        logger.debug("getUnitPrice()");
        checkOpened();
        logger.debug("getUnitPrice = 0");
        return 0;
    }

    public boolean getAutoDisable() throws JposException {
        logger.debug("getAutoDisable()");
        logger.debug("getAutoDisable = " + String.valueOf(m_autoDisable));
        return m_autoDisable;
    }

    public void setAutoDisable(boolean autoDisable) throws JposException {
        logger.debug("setAutoDisable(" + String.valueOf(autoDisable) + ")");
        m_autoDisable = autoDisable;
        logger.debug("setAutoDisable: OK");
    }

    public void setDataEventEnabled(boolean enabled) throws JposException {
        logger.debug("setDataEventEnabled(" + String.valueOf(enabled) + ")");
        m_dataEventEnabled = enabled;
        if (m_dataEventEnabled) {
            synchronized (m_events) {
                for (DataEvent e : m_events) {
                    m_eventsCallback.fireDataEvent(e);
                }
                m_events.clear();
            }
        }
        logger.debug("setDataEventEnabled: OK");
    }

    public boolean getDataEventEnabled() throws JposException {
        logger.debug("getDataEventEnabled()");
        logger.debug("getDataEventEnabled = " + m_dataEventEnabled);
        return m_dataEventEnabled;
    }

    public void setPowerNotify(int arg0) throws JposException {
        logger.debug("setPowerNotify(" + arg0 + ")");
        logger.debug("setPowerNotify: OK");
    }

    public void setTareWeight(int tareWeight) throws JposException {
        logger.debug("setTareWeight(" + tareWeight + ")");
        checkOpened();

        try {
            m_tareWeight = tareWeight;
            m_protocol.tara((long) tareWeight);
        } catch (Exception e) {
            throw getJposException(e);
        }

        logger.debug("setTareWeight: OK");
    }

    public void setUnitPrice(long arg0) throws JposException {
        logger.debug("setUnitPrice(" + arg0 + ")");
        logger.debug("setUnitPrice: JPOS_E_ILLEGAL");
        throw new JposException(JPOS_E_ILLEGAL, "Неподдерживается");
    }

    public void zeroScale() throws JposException {
        logger.debug("zeroScale()");
        checkEnabled();
        try {
            m_protocol.zero();
        } catch (Exception e) {
            throw getJposException(e);
        }
        logger.debug("zeroScale: OK");
    }

    public int getMaximumWeight() throws JposException {
        logger.debug("getWeightUnit()");
        logger.debug("getWeightUnit = 2147483647");
        return 2147483647;
    }

    public int getWeightUnit() throws JposException {
        logger.debug("getWeightUnit()");
        checkOpened();
        logger.debug("getWeightUnit() = SCAL_WU_GRAM");
        return SCAL_WU_GRAM;
    }

    public void readWeight(int[] data, int timeout) throws JposException {
        logger.debug("readWeight(" + data + ", " + timeout + ")");

        checkEnabled();
        try {
            if (!m_asyncMode) {
                long beginReadTime = System.currentTimeMillis(), currentTime;

                int w = 0;
                while (true) {
                    ScaleWeight weight = m_protocol.getWeight();
                    if (weight != null) {
                        w = (int) weight.weight;

                        // Test for overweight
                        if (weight.status.isOverweight()) {
                            throw new JposException(JPOS_E_EXTENDED, ScaleConst.JPOS_ESCAL_OVERWEIGHT,
                                    "Вес превышает максимальный");
                        }
                        // Test for 
                        if ((weight.status.isFixed()) || (timeout == 0)) {
                            break;
                        }

                        Tools.sleep(5, 0);
                        currentTime = System.currentTimeMillis();
                        if (currentTime - beginReadTime >= timeout) {
                            throw new JposException(JPOS_E_TIMEOUT, "Истекло время ожидания фиксированного веса");
                        }
                    } else {
                        throw new JposException(JPOS_E_TIMEOUT, "Истекло время ожидания фиксированного веса");
                    }
                }

                logger.debug("weight = " + w + ", tareWeight = " + m_tareWeight);
                data[0] = w;
            } else if (m_needReadWeight) {
                throw new JposException(JPOS_E_BUSY, "Осуществляется операция получения веса");
            } else {
                m_needReadWeight = true;
            }
        } catch (Exception e) {
            throw getJposException(e);
        }
        logger.debug("readWeight: OK");
    }

    public void checkHealth(int arg0) throws JposException {
        logger.debug("checkHealth(" + arg0 + ")");
        logger.debug("checkHealth = JPOS_E_ILLEGAL");
        throw new JposException(JPOS_E_ILLEGAL, "Неподдерживается");
    }

    public void directIO(int arg0, int[] arg1, Object arg2) throws JposException {
        logger.debug("directIO(" + arg0 + ", " + arg1 + ", " + arg2 + ")");
        logger.debug("directIO = JPOS_E_ILLEGAL");
        throw new JposException(JPOS_E_ILLEGAL, "Неизвестная команда");
    }

    public String getCheckHealthText() throws JposException {
        logger.debug("getCheckHealthText()");
        logger.debug("getCheckHealthText = ");
        return "";
    }

    public boolean getClaimed() throws JposException {
        logger.debug("getClaimed()");
        logger.debug("getClaimed = " + (m_state >= S_CLAIMED));
        return (m_state >= S_CLAIMED);
    }

    public String getDeviceServiceDescription() throws JposException {
        logger.debug("getDeviceServiceDescription()");
        logger.debug("getDeviceServiceDescription = ScalePos2Service");
        return "ScalePos2Service";
    }

    public int getDeviceServiceVersion() throws JposException {
        // 001 | 000 | 000
        int version = 1013000 + ServiceVersionUtil.getVersionInt();
        logger.debug("getDeviceServiceVersion()");
        logger.debug("getDeviceServiceVersion = " + version);
        return version;
    }

    public boolean getFreezeEvents() throws JposException {
        logger.debug("getFreezeEvents()");
        logger.debug("getFreezeEvents = " + m_freezeEvents);
        return m_freezeEvents;
    }

    public void setFreezeEvents(boolean arg0) throws JposException {
        logger.debug("setFreezeEvents(" + arg0 + ")");
        m_freezeEvents = arg0;
        logger.debug("setFreezeEvents: OK");
    }

    public String getPhysicalDeviceDescription() throws JposException {
        logger.debug("getPhysicalDeviceDescription()");
        checkOpened();
        switch (m_protocol.getType()) {
            case Pos2:
                /*
			 * logger.debug(
			 * "<--getPhysicalDeviceDescription() Весы ШТРИХ-М POS2");
                 */ return "Весы ШТРИХ-М POS2";
            case Shtrih5:
                /*
			 * logger.debug(
			 * "<--getPhysicalDeviceDescription() Весы ШТРИХ-М ШТРИХ5");
                 */ return "Весы ШТРИХ-М ШТРИХ5";
            case Shtrih6:
                /*
			 * logger.debug(
			 * "<--getPhysicalDeviceDescription() Весы ШТРИХ-М ШТРИХ6");
                 */ return "Весы ШТРИХ-М ШТРИХ6";
        }
        logger.debug("getPhysicalDeviceDescription = Весы ШТРИХ-М");
        return "Весы ШТРИХ-М";
    }

    public String getPhysicalDeviceName() throws JposException {
        logger.debug("getPhysicalDeviceName()");
        checkOpened();
        String s = getPhysicalDeviceDescription();
        logger.debug("getPhysicalDeviceName = " + s);
        return s;
    }

    public int getState() throws JposException {
        logger.debug("getState()");

        int result = JPOS_S_ERROR;

        if (m_asyncMode && m_reader.isAlive()) {
            result = JPOS_S_BUSY;
        }

        switch (m_state) {
            case S_CLOSED:
                result = JPOS_S_CLOSED;
            case S_OPENED:
            case S_CLAIMED:
            case S_ENABLED:
                result = JPOS_S_IDLE;
            default:
                result = JPOS_S_ERROR;
        }
        logger.debug("getState = " + JposUtils.getStateText(result));
        return result;
    }

    public boolean getDeviceEnabled() throws JposException {
        logger.debug("getDeviceEnabled()");
        logger.debug("getDeviceEnabled = " + (m_state >= S_ENABLED));
        return (m_state >= S_ENABLED);
    }

    public void setDeviceEnabled(boolean enabled) throws JposException {
        logger.debug("setDeviceEnabled(" + enabled + ")");
        checkClaimed();
        m_state = enabled ? S_ENABLED : S_CLAIMED;
        logger.debug("setDeviceEnabled: OK");
    }

    public void deleteInstance() throws JposException {
        logger.debug("deleteInstance()");
    }

    public boolean getZeroValid() throws JposException {
        logger.debug("getZeroValid()");
        logger.debug("getZeroValid = false");
        return false;
    }

    public void setZeroValid(boolean arg0) throws JposException {
        logger.debug("setZeroValid(" + arg0 + ")");
        logger.debug("setZeroValid: OK");
    }

    private void handleErrorEvent(ErrorEvent event) {
        logger.debug("handleErrorEvent(" + event + ")");
        m_eventsCallback.fireErrorEvent(event);
        logger.debug("handleErrorEvent: OK");
    }

    private void handleDataEvent(DataEvent event) throws JposException {
        logger.debug("handleDataEvent(" + event + ")");
        if (m_dataEventEnabled) {
            m_eventsCallback.fireDataEvent(event);
        } else {
            synchronized (m_events) {
                m_events.add(event);
            }
        }
        if (m_autoDisable) {
            setDeviceEnabled(false);
        }
        logger.debug("handleDataEvent: OK");
    }

    private void checkClaimed() throws JposException {
        if (m_state < S_CLAIMED) {
            logger.debug("checkOpened = JPOS_E_NOTCLAIMED");
            throw new JposException(JPOS_E_NOTCLAIMED);
        }
    }

    private void checkEnabled() throws JposException {
        if (m_state < S_ENABLED) {
            logger.debug("checkOpened() JPOS_E_DISABLED");
            throw new JposException(JPOS_E_DISABLED);
        }
    }

    private void checkOpened() throws JposException {
        if (m_state < S_OPENED) {
            logger.debug("checkOpened() JPOS_E_CLOSED");
            throw new JposException(JPOS_E_CLOSED);

        }
    }

    private class ReadWeightThread extends Thread {

        @Override
        public void run() {
            logger.debug("ReadWeightThread start");

            while (m_asyncMode) {

                if (m_needReadWeight) {
                    int timeout = Integer.parseInt(m_protocol.getParam(IScale.PARAM_TIMEOUT_WEIGHT));
                    long beginReadTime = System.currentTimeMillis(), currentTime;

                    int w = 0;
                    while (true) {
                        try {
                            ScaleWeight weight = m_protocol.getWeight();
                            if (weight != null) {
                                if (weight.status.isFixed()) {
                                    DataEvent event = new DataEvent(this, (int) weight.weight);
                                    try {
                                        handleDataEvent(event);
                                    } catch (JposException e) {
                                        handleErrorEvent(new ErrorEvent(this, e.getErrorCode(), e.getErrorCodeExtended(),
                                                JPOS_EL_INPUT, JPOS_ER_RETRY));
                                    }
                                    break;
                                }

                                Tools.sleep(5, 0);
                                currentTime = System.currentTimeMillis();
                                if (currentTime - beginReadTime >= timeout) {
                                    ErrorEvent event = new ErrorEvent(this, JPOS_E_TIMEOUT, 0, JPOS_EL_INPUT,
                                            JPOS_ER_RETRY);
                                    handleErrorEvent(event);
                                }
                            } else {
                                ErrorEvent event = new ErrorEvent(this,
                                        JPOS_E_TIMEOUT, 0, JPOS_EL_INPUT, JPOS_ER_RETRY);
                                handleErrorEvent(event);
                            }
                        } catch (Exception e) {
                            JposException jposException = getJposException(e);

                            ErrorEvent event = new ErrorEvent(this,
                                    jposException.getErrorCode(),
                                    jposException.getErrorCodeExtended(),
                                    JPOS_EL_INPUT, JPOS_ER_RETRY);
                            handleErrorEvent(event);
                        }
                    }

                    m_needReadWeight = false;
                }

                try {
                    Thread.sleep(50);
                } catch (InterruptedException e) {
                    logger.error(e.getMessage());
                }
            }
            logger.debug("ReadWeightThread stop");
        }
    }

    private JposException getJposException(Exception e) {
        logger.error(e);
        if (e instanceof DeviceError) {
            return new JposException(JposConst.JPOS_E_FAILURE, e.getMessage());
        }
        return new JposException(JposConst.JPOS_E_FAILURE, e.getMessage());
    }

}
