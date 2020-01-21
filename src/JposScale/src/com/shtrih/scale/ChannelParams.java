package com.shtrih.scale;

import com.shtrih.tools.BitUtils;

public class ChannelParams 
{
	public int flags;
	public byte decimalPoint; // Положение десятичной точки (1 байт) : Диапазон 0..6.
	public byte power; 		  // Степень (1 байт), диапазон: -127..128.
	public int maxWeigth;
	public int minWeigth;
	public int maxTare;
	public int[] range = new int[4];
	public int[] resolution = new int[4];
	public int pointCount;
	public int calibCount;

	public double getRange(int index){
		return getRate() * range[index];
	}
	
	public double getResolution(int index){
		return getRate() * resolution[index];
	}
	
	public double getRate(){
		return Math.pow(10, power);
	}
	
	public double getWeigthValue(int value){
		return value * getRate();
	}
	
	public double getMaxWeigth(){
		return getWeigthValue(maxWeigth);
	}
	
	public double getMinWeigth(){
		return getWeigthValue(minWeigth);
	}
	
	public double getMaxTare(){
		return getWeigthValue(maxTare);
	}
	
	public ScaleChannelFlags getFlags(){
		return new ScaleChannelFlags(flags);
	}

	public String flagToStr(boolean flag){
		if (flag) {
			return "есть";
		} else {
			return "нет";
		}
	}

	/*
	public static String weightToString(long weight) {
        DecimalFormatSymbols symbols = new DecimalFormatSymbols(Locale.getDefault());
        symbols.setDecimalSeparator('.');
        DecimalFormat formatter = new DecimalFormat("0.000", symbols);
        return formatter.format(weight / 1000.0);
    }
	*/
	
	public String toText()
	{
	  String text = "";
	  text += String.format("Тип канала         : < %s >\r\n", getFlags().getTypeText());					  
	  text += String.format("Выборка массы тары : < %s >\r\n", flagToStr(getFlags().isTare()));
	  text += String.format("Максимальный вес   : %.3f кг\r\n", getMaxWeigth());
	  text += String.format("Минимальный вес    : %.3f кг\r\n", getMinWeigth());
	  text += String.format("Максимальная тара  : %.3f кг\r\n", getMaxTare());
	  for (int i=0;i<3;i++)
	  {
		  if (range[i+1] == 0) break;
		  text += String.format("Диапазон №%d        : %.3f-%.3f кг\r\n", 
				  i+1, getRange(i), getRange(i+1));
	  }
	  for (int i=0;i<4;i++)
	  {
		  if (resolution[i] == 0) break;
		  text += String.format("Дискретность на диапазоне №%d: %.3f кг\r\n", 
				  i+1, getResolution(i));
	  }
	  text += String.format("Количество градуировочных точек: %d", pointCount);
	  return text;
	}
	
	public class ScaleChannelFlags
	{
		////////////////////////////////////////////////////////////////////
		// Channel type constants
		
		public static final int CHANNEL_TYPE_TENSO    = 0;
		public static final int CHANNEL_TYPE_VIBRO 	  = 1;
		public static final int CHANNEL_TYPE_ABSTRACT = 2;
		public static final int CHANNEL_TYPE_RESERVED = 3;

		private final int flags;
		
		public ScaleChannelFlags(int flags){
			this.flags = flags;
		}
		
		public int getValue(){
			return flags;
		}
		
		public int getType(){
			return flags & 0x03;
		}
		
		public String getTypeText(){
			switch (getType())
			{
			case CHANNEL_TYPE_TENSO: return "тензоканал";
			case CHANNEL_TYPE_VIBRO: return "виброчастотный";
			default: return "неизвестный";
			}
		}
		
		// бит2 - Выборка массы тары из диапазона взвешивания. 
		public boolean isTare(){
			return BitUtils.testBit(flags, 2);
		}
	} 
}