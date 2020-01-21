package com.shtrih.scalecalib;

import java.awt.Font;
import java.awt.Color;
import java.awt.SystemColor;
import java.net.URL;

import javax.swing.JLabel;
import javax.swing.ImageIcon;

import com.shtrih.scale.CalibrationStatus;

public class Page6 extends Page {

	private final String stCalibSuccess = "<html>Градуировка успешно завершена.<br>Уберите груз с платформы.";
	private final String stCalibFailed = "<html>Градуировка завершена с ошибкой.<br>Реперные точки не изменены.";
	private final String stErrorReasons = "<html>Возможные причины ошибки:<br><br>1. Установленный груз не соответствовал требуемому.<br>2. Неисправен АЦП.";
	
	private final JLabel lblInfo1;
	private final JLabel lblInfo2;
	private JLabel lblOKImage = null;
	private JLabel lblFailImage = null;
	
	private final SmScale driver = SmScale.instance;
	
	/**
	 * Create the panel.
	 */
	public Page6() {
		setLayout(null);
		
		lblInfo1 = new JLabel();
		lblInfo1.setBounds(92, 62, 398, 72);
		lblInfo1.setText("<html>\u0413\u0440\u0430\u0434\u0443\u0438\u0440\u043E\u0432\u043A\u0430 \u0443\u0441\u043F\u0435\u0448\u043D\u043E \u0437\u0430\u0432\u0435\u0440\u0448\u0435\u043D\u0430.<br>\r\n\u0423\u0431\u0435\u0440\u0438\u0442\u0435 \u0433\u0440\u0443\u0437 \u0441 \u043F\u043B\u0430\u0442\u0444\u043E\u0440\u043C\u044B.");
		lblInfo1.setForeground(new Color(0, 0, 128));
		lblInfo1.setFont(new Font("Tahoma", Font.BOLD, 16));
		lblInfo1.setBackground(SystemColor.activeCaptionBorder);
		add(lblInfo1);
		
		lblInfo2 = new JLabel();
		lblInfo2.setText("<html>\u0412\u043E\u0437\u043C\u043E\u0436\u043D\u044B\u0435 \u043F\u0440\u0438\u0447\u0438\u043D\u044B \u043E\u0448\u0438\u0431\u043A\u0438:<br><br>\r\n1. \u0423\u0441\u0442\u0430\u043D\u043E\u0432\u043B\u0435\u043D\u043D\u044B\u0439 \u0433\u0440\u0443\u0437 \u043D\u0435 \u0441\u043E\u043E\u0442\u0432\u0435\u0442\u0441\u0442\u0432\u043E\u0432\u0430\u043B \u0442\u0440\u0435\u0431\u0443\u0435\u043C\u043E\u043C\u0443.<br>\r\n2. \u041D\u0435\u0438\u0441\u043F\u0440\u0430\u0432\u0435\u043D \u0410\u0426\u041F.");
		lblInfo2.setForeground(new Color(0, 0, 0));
		lblInfo2.setFont(new Font("Tahoma", Font.PLAIN, 13));
		lblInfo2.setBackground(SystemColor.activeCaptionBorder);
		lblInfo2.setBounds(92, 130, 398, 86);
		add(lblInfo2);
		
		URL imageURL = null;
		ImageIcon image = null;
		imageURL = getClass().getResource("/res/ok.png");
		if (imageURL != null) 
		{
			image = new ImageIcon(imageURL);
		}
		lblOKImage = new JLabel(image);
		lblOKImage.setText("lblOKImage");
		lblOKImage.setBounds(20, 75, 50, 50);
		lblOKImage.setVisible(false);
		lblOKImage.setText("");
		add(lblOKImage);
		
		image = null;
		imageURL = getClass().getResource("/res/fail.png");
		if (imageURL != null) 
		{
			image = new ImageIcon(imageURL);
		}
		lblFailImage = new JLabel(image);
		lblFailImage.setText("lblFailImage");
		lblFailImage.setBounds(20, 75, 50, 50);
		lblFailImage.setVisible(false);
		lblFailImage.setText("");
		add(lblFailImage);
		
	}
	
	public void updatePage()
	{
		CalibrationStatus status = driver.getCalibrationStatus();
		if (status.getStatus() == CalibrationStatus.POINT_STATUS_SUCCEDED)
		{
			lblOKImage.setVisible(true);
			lblFailImage.setVisible(false);
			lblInfo1.setText(stCalibSuccess);
			lblInfo2.setVisible(false);
		} else{
			lblOKImage.setVisible(false);
			lblFailImage.setVisible(true);
			lblInfo1.setText(stCalibFailed);
			lblInfo2.setVisible(true);
		}
	}
}
