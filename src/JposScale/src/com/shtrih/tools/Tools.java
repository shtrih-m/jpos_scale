package com.shtrih.tools;

import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Arrays;

public class Tools {
	
	public static byte[] concat(byte[] first, byte[] second) {
		byte[] result = new byte[first.length + first.length];
		System.arraycopy(first, 0, result, 0, first.length);
		System.arraycopy(second, 0, result, first.length, second.length);
		return result;
	}
	
	public static void sleep(long ms) {
		try { Thread.sleep(ms); } catch (InterruptedException e) { }
	}
	
	public static void sleep(long ms, int ns) {
		try { Thread.sleep(ms, ns); } catch (InterruptedException e) { }
	}
	
	public static String removeUnreadableChars(String s) {
		StringBuilder res = new StringBuilder();
		char c;
		for (int i = 0; i < s.length(); i++) {			
			c = s.charAt(i);
			if ((int)c < 30) {
				res.append('#');
				res.append(String.format("%02X", (int)c));
			} else res.append(s.charAt(i));
		}
		return res.toString();
	}
	
	static final String HEXES = "0123456789ABCDEF";
	public static String getHex(byte[] raw) {
		if (raw == null) { return null; }
	    final StringBuilder hex = new StringBuilder(2 * raw.length);
	    for (final byte b : raw) {
	      hex.append(HEXES.charAt((b & 0xF0) >> 4))
	         .append(HEXES.charAt((b & 0x0F)));
	    }
	    return hex.toString();
	}
	
	public static byte[] longToBytes(long v) { return longToBytes(v, false); }
	public static byte[] longToBytes(long v, boolean inversed) {
	    byte[] writeBuffer = new byte[8];

	    if (!inversed) {
	    	writeBuffer[0] = (byte)(v >>> 56);
	    	writeBuffer[1] = (byte)(v >>> 48);
	    	writeBuffer[2] = (byte)(v >>> 40);
	    	writeBuffer[3] = (byte)(v >>> 32);
	    	writeBuffer[4] = (byte)(v >>> 24);
	    	writeBuffer[5] = (byte)(v >>> 16);
	    	writeBuffer[6] = (byte)(v >>>  8);
	    	writeBuffer[7] = (byte)(v >>>  0);
	    } else {
	    	writeBuffer[7] = (byte)(v >>> 56);
	    	writeBuffer[6] = (byte)(v >>> 48);
	    	writeBuffer[5] = (byte)(v >>> 40);
	    	writeBuffer[4] = (byte)(v >>> 32);
	    	writeBuffer[3] = (byte)(v >>> 24);
	    	writeBuffer[2] = (byte)(v >>> 16);
	    	writeBuffer[1] = (byte)(v >>>  8);
	    	writeBuffer[0] = (byte)(v >>>  0);
	    }

	    return writeBuffer;
	}

	public static long bytesToLong(byte[] a) { return Tools.bytesToLong(a, 0, a.length, false); }
	public static long bytesToLong(byte[] a, boolean inversed) {
		return bytesToLong(a, 0, a.length, inversed);
	}
	public static long bytesToLong(byte[] a, int offset, int len) { return Tools.bytesToLong(a, offset, len, false); }
	public static long bytesToLong(byte[] a, int offset, int len, boolean inversed) {
		long value = 0;
		if (!inversed) {			
			for (int i = offset; i < len; i++) { value = (value << 8) + (a[i] & 0xff); }
		} else {
			for (int i = offset + len - 1; i >= offset; i--) { value = (value << 8) + (a[i] & 0xff); }
		}
		return value;
	}
	
	public static int byteToInt(byte b) { return (0x000000FF & (int)b); };
	
	public static String additionString(String s, char c, int len, boolean left) {
		StringBuilder sb = new StringBuilder(s);
		if (sb.length() > len) sb = sb.delete(len, sb.length() - 1);
		else {
			while (sb.length() < len) {
				if (!left) sb.append(c);
				else sb.insert(0, c);
			}
		}		
		return sb.toString();
	}
	
	public static byte[] getBytes(byte[] a, int pos, int len) {
		byte[] na = new byte[len];
		System.arraycopy(a, pos, na, 0, len);
		return na;
	}
	
	public static short swapBytes(short v) {
		return (short) ((v >> 8 & 0x00FF) | (v << 8 & 0xFF00));
	}
	
	public static ArrayList<String> getLines(InputStream in, String charsetName) {
		ArrayList<String> lines = new ArrayList<String>();
		try {
			int ic, ind;
			String line;
			StringBuilder buffer = new StringBuilder();
			
			while ((ic = in.read()) != -1) {
				if (charsetName.equals("")) buffer.append((char)ic);
				else buffer.append(new String(new byte[]{(byte)ic}, charsetName)); 
			}
			
			while (true) {
				ind = buffer.indexOf("\r\n");
				if (ind != -1) {
					line = buffer.substring(0, ind);
					buffer.delete(0, ind + 2);
					lines.add(line);
				} else {
					lines.add(buffer.toString());
					break;
				}
			}
			
		} catch (IOException e) { }
		return lines;
	}
	
}
