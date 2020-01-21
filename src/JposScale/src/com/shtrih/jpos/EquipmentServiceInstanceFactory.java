package com.shtrih.jpos;

import java.lang.reflect.Constructor;

import com.shtrih.jpos.scale.Scale;

import jpos.JposConst;
import jpos.JposException;
import jpos.config.JposEntry;
import jpos.loader.JposServiceInstance;
import jpos.loader.JposServiceInstanceFactory;

public final class EquipmentServiceInstanceFactory extends Object 
    implements JposServiceInstanceFactory, JposConst {
	
	//private static Logger logger = Logger.getLogger(ShtrihJposServiceInstanceFactory.class);

	public JposServiceInstance createInstance(String logicalName, JposEntry entry)
			throws JposException {
		if( !entry.hasPropertyWithName( JposEntry.SERVICE_CLASS_PROP_NAME ) )
            throw new JposException( JPOS_E_NOSERVICE, 
                "The JposEntry does not contain the 'serviceClass' property" );

        JposServiceInstance serviceInstance = null;

        try
        {
            String serviceClassName = (String)entry.getPropertyValue( JposEntry.SERVICE_CLASS_PROP_NAME );
            
            Class serviceClass = Class.forName(serviceClassName);
            Class[] params = new Class[0];
            Constructor ctor = serviceClass.getConstructor(params);
            serviceInstance = (JposServiceInstance)ctor.newInstance(params);

			Device device = (Device)serviceInstance;
			device.setJposEntry(entry);
			
			if (device.getType() == DeviceType.Scale) {
				Scale scale = (Scale)device;
				
			}
        }
        catch(Exception e)
        {
            //logger.fatal("Could not create the service instance!", e);
            throw new JposException(JPOS_E_NOSERVICE, "Could not create the service instance. ", e); 
        }
        return serviceInstance;
	}

}
