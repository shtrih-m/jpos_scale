package com.shtrih.tools;

import java.util.HashMap;

public class StringParams 
{
    private HashMap<String, String> map = new HashMap<String, String>();

    public StringParams() {
    }

    public void clear() {
        map.clear();
    }

    public void remove(String key) {
        map.remove(key);
    }

    public String set(String key, String value) {
        return map.put(key, value);
    }

    public String get(String key) {
        return map.get(key);
    }

    public String get(String key, String defValue) {
        String value = map.get(key);
        if (value == null) {
            return defValue;
        }
        return value;
    }

    public int getInt(String key) throws Exception {
        try {
            return Integer.parseInt(map.get(key));
        } catch (Exception e) {
            throw new Exception("Ошибка получения параметра " + key);
        }
    }

    public int getInt(String key, int defValue) throws Exception {
        try {
            String value = map.get(key);
            if (value == null) {
                return defValue;
            }
            return Integer.parseInt(value);
        } catch (Exception e) {
            throw new Exception("Ошибка получения параметра " + key);
        }
    }
}
