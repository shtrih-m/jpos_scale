package com.shtrih.tools;

import com.shtrih.scale.ScaleSerial;
import com.shtrih.scalecalib.SmScale;
import org.apache.log4j.Logger;

public class StringParams extends ParamsMap<String> {
	
	private final Logger logger = Logger.getLogger(StringParams.class);
        
	public StringParams() {
	}

	@Override
	public String getValue(String key) 
	{
		Value value = get(key);
		if (value == null) return null;	
		return value.getValue();
	}
	
	public int getIntParam(String key)
	throws Exception
	{
		Value value = get(key);
		if (value == null) 
                {
                    logger.error("Value for key " + key + " not found");
                    //throw new Exception("Value for key " + key + " not found");	
                    return 0;
                }
		return Integer.parseInt(value.getValue());
	}
	
	public int getIntParam(String key, int defaultValue)
	{
		Value value = get(key);
		if (value == null) return defaultValue;	
		return Integer.parseInt(value.getValue());
	}
	
}
