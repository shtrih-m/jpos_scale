package com.shtrih;

import com.shtrih.tools.Tools;
import com.shtrih.port.GnuSerialPort;

public class EquipmentTools {
	public static int convertDecToBCD(int dec) {
		int tmp = 0;
		int ost = 0;
		int mul = 1;
		do {
			ost = dec % 100;
			tmp += mul * (ost % 10 + ost / 10 * 16);
			mul *= 256;
			dec = dec / 100;
		} while (dec != 0);
		return tmp;
	}

	public static int convertBCDToDec(int bindec)	{
		int tmp = 0;
		int ost = 0;
		int mul = 1;
		do {
			ost = bindec % 256;
			tmp += mul * (ost % 16 + ost / 16 * 10);
			mul *= 100;
			bindec = bindec / 256;
		} while (bindec != 0);
		return tmp;
	}
	
	public static int convertDecToBin(int dec)
	{
		int tmp = 0;
		int ost = 0;
		int mul = 1;
		do {
			ost = dec % 100;
			tmp += mul * (ost % 10 + ost / 10 * 16);
			mul *= 256;
			dec = dec / 100;
		} while(dec != 0);
		return tmp;
	}

	public static int converBinDecToDec(int bindec)
	{
		int tmp = 0;
		int ost = 0;
		int mul = 1;
		do {
			ost = bindec % 256;
			tmp += mul * (ost % 16 + ost / 16 * 10);
			mul *= 100;
			bindec = bindec / 256;
		} while(bindec != 0);
		return tmp;
	}
	
	public static int convertLongBSDToDec(byte[] a) {
		return convertLongBSDToDec(a, 0, a.length);
	}
	
	public static int convertLongBSDToDec(byte[] a, int offset, int len) {
		return convertLongBSDToDec(Tools.bytesToLong(a, offset, len, true));
	}
	
	public static int convertLongBSDToDec(long a) {
		int tmp = 0;
		long ost = 0;
		int mul = 1;
		long bcd = a;
		do {
			ost = bcd % 256;
			tmp += mul * ost;
			mul *= 10;
			bcd = bcd / 256;
		} while(bcd != 0);
		return tmp;
	}
	
	public static byte getCRC(byte[] a, int s, int len) {
		int crc = 0;
		for (int i = s; i < s + len; i++) {
			crc = crc ^ (int)a[i];
		}
		return (byte)crc;
	}
}
