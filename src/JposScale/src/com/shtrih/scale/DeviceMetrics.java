package com.shtrih.scale;

public class DeviceMetrics {

    private final int type, subType;
    private final int majorVersion, minorVersion;
    private final int model, lang;
    private final String description;

    public DeviceMetrics(int type, int subType, int majorVersion,
            int minorVersion, int model, int lang, String description) {
        this.type = type;
        this.subType = subType;
        this.majorVersion = majorVersion;
        this.minorVersion = minorVersion;
        this.model = model;
        this.lang = lang;
        this.description = description;
    }

    public String toString() {
        String s;
        s = String.format("%s\r\n", description);
        s += String.format("Тип: %d.%d, версия: %d.%d\r\n", type, subType, majorVersion, minorVersion);
        s += String.format("Модель: %d, язык: %d", model, lang);
        return s;
    }

    /**
     * @return the type
     */
    public int getType() {
        return type;
    }

    /**
     * @return the subType
     */
    public int getSubType() {
        return subType;
    }

    /**
     * @return the majorVersion
     */
    public int getMajorVersion() {
        return majorVersion;
    }

    /**
     * @return the minorVersion
     */
    public int getMinorVersion() {
        return minorVersion;
    }

    /**
     * @return the model
     */
    public int getModel() {
        return model;
    }

    /**
     * @return the lang
     */
    public int getLang() {
        return lang;
    }

    /**
     * @return the description
     */
    public String getDescription() {
        return description;
    }
}
