package com.shtrih.tools;

/**
 * @author V.Kravtsov
 */
import org.apache.log4j.Logger;

public class Logger2 {

    private Logger2() {
    }

    private static int min(int i1, int i2) {
        if (i1 < i2) {
            return i1;
        } else {
            return i2;
        }
    }

    public static void logTx(Logger logger, byte b) {
        logger.debug("-> " + HexUtils.toHex(b));
    }

    public static void logTx(Logger logger, byte[] data) {
        logData(logger, "->", data);
    }

    public static void logRx(Logger logger, byte b) {
        logger.debug("<- " + HexUtils.toHex(b));
    }

    public static void logRx(Logger logger, byte b1, byte b2) {
        logger.debug("<- " + HexUtils.toHex(b1) + " " + HexUtils.toHex(b2));
    }

    public static void logRx(Logger logger, byte[] data) {
        logData(logger, "<-", data);
    }

    private static void logData(Logger logger, String prefix, byte[] data) {
        final int lineLen = 20;
        int count = (data.length + lineLen - 1) / lineLen;
        for (int i = 0; i < count; i++) {
            StringBuilder sb = new StringBuilder();

            int len = min(lineLen, data.length - lineLen * i);

            sb.append(prefix);

            for (int j = 0; j < len; j++) {
                sb.append(" ");
                sb.append(HexUtils.toHex(data[j + i * lineLen]));
            }

            logger.debug(sb.toString());
        }
    }
}
