package com.shtrih.jpos;

//import org.apache.log4j.Logger;

import jpos.JposConst;
import jpos.JposException;
import jpos.config.JposEntry;

public class JposPropertyReader implements JposConst {
	
	private JposEntry jposEntry;
    //static Logger logger = Logger.getLogger(JposPropertyReader.class);
    
    /** Creates a new instance of JposPropertyReader */
    public JposPropertyReader(JposEntry jposEntry) 
    {
        this.jposEntry = jposEntry;
    }
    
    public boolean propertyExists(String propertyName)
    {
        return jposEntry.hasPropertyWithName(propertyName);
    }
        
    public String readString(String propertyName)
        throws Exception 
    {
        if (!propertyExists(propertyName)) 
        {
            throw new JposException(JPOS_E_FAILURE, "Property not found " + propertyName);
        }
        return (String)jposEntry.getPropertyValue(propertyName);
    }
    
    public String readString(String propertyName, String defaultValue)
        throws Exception 
    {
        String result;
        if (propertyExists(propertyName)) 
        {
            result = (String)jposEntry.getPropertyValue(propertyName);
        } else
        {
            result = defaultValue;
        }
        //logger.debug(propertyName + ": \"" + result + "\"");
        return result;
    }
    
    public int readInteger(String propertyName, int defaultValue)
        throws Exception 
    {
        int result = defaultValue;
        if (propertyExists(propertyName)) 
        {
            try
            {
                result = Integer.parseInt((String)jposEntry.getPropertyValue(propertyName));
            }
            catch(Exception e) 
            {
                //logger.error(e);
                throw new JposException(JPOS_E_FAILURE, e.getMessage(), e);
            }
        }
        //logger.debug(propertyName + ": \"" + String.valueOf(result) + "\"");
        return result;
    }
    
    public double readDouble(String propertyName, double defaultValue)
        throws Exception 
    {
        double result = defaultValue;
        if (propertyExists(propertyName))
        {
            try
            {
                result = Double.parseDouble((String)jposEntry.getPropertyValue(propertyName));
            }
            catch(Exception e) 
            {
                //logger.error(e);
                throw new JposException(JPOS_E_FAILURE, e.getMessage());
            }
        }
        //logger.debug(propertyName + ": \"" + String.valueOf(result) + "\"");
        return result;
    }
    
    public boolean readBoolean(String propertyName, boolean defaultValue)
        throws Exception 
    {
        boolean result = defaultValue;
        if (propertyExists(propertyName))
        {
            try
            {
                result = ((String)jposEntry.getPropertyValue(propertyName)).equalsIgnoreCase("1");
            }
            catch(Exception e) 
            {
                //logger.error(e);
                throw new JposException(JPOS_E_FAILURE, e.getMessage());
            }
        }
        //logger.debug(propertyName + ": \"" + String.valueOf(result) + "\"");
        return result;
    }

}
