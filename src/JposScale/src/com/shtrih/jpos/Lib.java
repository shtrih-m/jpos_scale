package com.shtrih.jpos;

public abstract class Lib {

	public static final String NAME = "equipment_jpos";
	public static final int VERSION_MAJOR = 1;
	public static final int VERSION_MINOR = 0;
	public static final int VERSION_BUILD = 4;
	
	public static boolean isSupported(String prop) {
		return false;
	}
	
	public static String getTextVersion() {
		return "" + VERSION_MAJOR + "." + VERSION_MINOR + "." + VERSION_BUILD;
	}
}
