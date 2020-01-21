package com.shtrih.scale;

public class CalibrationStatus {
	// ///////////////////////////////////////////////////////////////////////////////
	// Point status constants

	public static final int POINT_STATUS_READY = 0;
	public static final int POINT_STATUS_NO_DAMPING = 1;
	public static final int POINT_STATUS_DAMPING = 2;
	public static final int POINT_STATUS_SUCCEDED = 3;
	public static final int POINT_STATUS_FAILED = 4;

	private final int number;
	private final double weight;
	private final int status;

	public CalibrationStatus(int number, double weight, int status) {
		this.number = number;
		this.weight = weight;
		this.status = status;
	}

	public boolean isPointReady() {
		return status == POINT_STATUS_READY;
	}

	public boolean isCalibrationStopped() {
		return (status == POINT_STATUS_SUCCEDED)
				|| (status == POINT_STATUS_FAILED);
	}

	public int getNumber() {
		return number + 1;
	}

	public double getWeight() {
		return weight;
	}

	public int getStatus() {
		return status;
	}

	public String getStatusText() {
		switch (status) {
		case 0:
			return "����� ������ ��� ���������";
		case 1:
			return "����� ����������, ���������� ���";
		case 2:
			return "����� ����������, ���������� ����";
		case 3:
			return "����������� ��������� �������";
		case 4:
			return "����������� ��������� � �������, �������� ����� �� ��������";
		default:
			return "����������� ���������";
		}
	}

}
