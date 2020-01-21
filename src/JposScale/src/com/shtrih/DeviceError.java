package com.shtrih;

public class DeviceError extends Exception {

    private final int code;

    public DeviceError(int code, String text) {
        super(text);
        this.code = code;
    }

    public int getCode() {
        return code;
    }
}
