package com.shtrih.scalecalib;

import java.awt.Font;
import java.awt.Color;
import javax.swing.JLabel;
import java.awt.SystemColor;

import com.shtrih.scale.CalibrationStatus;
import com.shtrih.scale.Page;
import com.shtrih.scale.SmScale;

public class Page4 extends Page {

	private final JLabel lblPointNumber;
	private final JLabel lblCalibGuidance;
	private final SmScale driver = SmScale.instance;
	
	/**
	 * Create the panel.
	 */
	public Page4() {
		setLayout(null);
		
		JLabel lblInfo1 = new JLabel();
		lblInfo1.setBounds(10, 11, 480, 47);
		lblInfo1.setText("<html>\u041F\u0440\u043E\u0446\u0435\u0441\u0441 \u0433\u0440\u0430\u0434\u0443\u0438\u0440\u043E\u0432\u043A\u0438 \u043D\u0430\u0447\u0430\u043B\u0441\u044F.<br>\r\n\u0421\u043B\u0435\u0434\u0443\u0439\u0442\u0435 \u0443\u043A\u0430\u0437\u0430\u043D\u0438\u044F\u043C \u0434\u043B\u044F \u043F\u0440\u043E\u0434\u043E\u043B\u0436\u0435\u043D\u0438\u044F.");
		lblInfo1.setForeground(new Color(0, 0, 128));
		lblInfo1.setFont(new Font("Tahoma", Font.BOLD, 16));
		lblInfo1.setBackground(SystemColor.activeCaptionBorder);
		add(lblInfo1);
		
		lblPointNumber = new JLabel();
		lblPointNumber.setText("\u0413\u0440\u0430\u0434\u0443\u0438\u0440\u0443\u0435\u0442\u0441\u044F \u0440\u0435\u043F\u0435\u0440\u043D\u0430\u044F \u0442\u043E\u0447\u043A\u0430 \u21161 (\u0432\u0435\u0441 0 \u043A\u0433).");
		lblPointNumber.setForeground(SystemColor.desktop);
		lblPointNumber.setFont(new Font("Tahoma", Font.BOLD, 13));
		lblPointNumber.setBackground(SystemColor.activeCaptionBorder);
		lblPointNumber.setBounds(10, 127, 449, 29);
		add(lblPointNumber);
		
		JLabel lblInfo2 = new JLabel();
		lblInfo2.setText("<html>\u0423\u0431\u0435\u0434\u0438\u0442\u0435\u0441\u044C, \u0447\u0442\u043E \u0432\u0435\u0441\u043E\u0432\u043E\u0439 \u043C\u043E\u0434\u0443\u043B\u044C \u043D\u0430\u0445\u043E\u0434\u0438\u0442\u0441\u044F \u043D\u0430 <br> \r\n\u0433\u043E\u0440\u0438\u0437\u043E\u043D\u0442\u0430\u043B\u044C\u043D\u043E\u0439 \u0438 \u0443\u0441\u0442\u043E\u0439\u0447\u0438\u0432\u043E\u0439 \u043F\u043E\u0432\u0435\u0440\u0445\u043D\u043E\u0441\u0442\u0438.");
		lblInfo2.setForeground(new Color(0, 0, 0));
		lblInfo2.setFont(new Font("Tahoma", Font.PLAIN, 13));
		lblInfo2.setBackground(SystemColor.activeCaptionBorder);
		lblInfo2.setBounds(10, 69, 419, 47);
		add(lblInfo2);
		
		lblCalibGuidance = new JLabel();
		lblCalibGuidance.setText("\u041F\u043E\u043B\u043E\u0436\u0438\u0442\u0435 \u043D\u0430 \u043F\u043B\u0430\u0442\u0444\u043E\u0440\u043C\u0443 \u0432\u0435\u0441 0 \u043A\u0433.");
		lblCalibGuidance.setForeground(Color.BLACK);
		lblCalibGuidance.setFont(new Font("Tahoma", Font.BOLD, 13));
		lblCalibGuidance.setBackground(SystemColor.activeCaptionBorder);
		lblCalibGuidance.setBounds(10, 155, 449, 29);
		add(lblCalibGuidance);
		
		JLabel label = new JLabel("<html>\u0414\u043B\u044F \u043F\u0440\u043E\u0434\u043E\u043B\u0436\u0435\u043D\u0438\u044F \u043D\u0430\u0436\u043C\u0438\u0442\u0435 \u043A\u043D\u043E\u043F\u043A\u0443 \"\u0414\u0430\u043B\u0435\u0435\",<br>\u0434\u043B\u044F \u0432\u043E\u0437\u0432\u0440\u0430\u0442\u0430 \u043A \u043F\u0440\u0435\u0434\u044B\u0434\u0443\u0449\u0435\u043C\u0443 \u0448\u0430\u0433\u0443 - \"\u041D\u0430\u0437\u0430\u0434\".");
		label.setForeground(Color.BLACK);
		label.setFont(new Font("Tahoma", Font.PLAIN, 11));
		label.setBounds(10, 313, 245, 31);
		add(label);
	}
	
	public void updatePage()
	{
		CalibrationStatus status = driver.getCalibrationStatus();
		String text = String.format("Градуируется реперная точка №%d (вес %.3f кг).", 
				driver.getPointNumber(), status.getWeight());
		lblPointNumber.setText(text);
		if (status.getWeight() == 0){
			text = "Убедитесь, что платформа пуста.";
			lblCalibGuidance.setText(text);
		} else
		{
			text = String.format("Положите на платформу вес %.3f кг.", 
					status.getWeight());
			lblCalibGuidance.setText(text);
		}
	}
}
