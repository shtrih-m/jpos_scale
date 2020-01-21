package com.shtrih.jpos;

import jpos.config.JposEntry;

public abstract class Device {
	protected JposEntry m_jposEntry = null;
	protected DeviceType m_type = DeviceType.None; 
	
	public Device() { }

	void setJposEntry(JposEntry entry) { m_jposEntry = entry; }
	JposEntry getJposEntry() { return m_jposEntry; }  
	
	DeviceType getType() { return m_type; }
}
