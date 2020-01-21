package com.shtrih.scale;

public class ScaleWeight {
	public final long weight;
        public final long tare;
	public final ScaleStatus status;
				
	public ScaleWeight(long weight, long tare, ScaleStatus status) { 
		this.weight = weight; 
                this.tare = tare;
                this.status = status;
	}
	
	public String toString() {
		String s;
                float fWeight, fTara;
		fWeight = (float)weight / 1000.0f;
		fTara = (float)tare / 1000.0f;
		s = "��� (" + (status.isFixed() ? "����������":"�� ����������") + "): " + fWeight + " ��. \r\n";
		s += "����: " + fTara + " ��.";
		return s;
	}
	
}
