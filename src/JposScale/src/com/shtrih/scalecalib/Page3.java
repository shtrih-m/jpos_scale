package com.shtrih.scalecalib;

import java.awt.Font;
import java.awt.Color;
import javax.swing.JLabel;
import javax.swing.BorderFactory;
import javax.swing.border.Border;

import com.shtrih.scale.Page;
import com.shtrih.scale.SmScale;

import javax.swing.SwingConstants;

public class Page3 extends Page 
{
	private JLabel lblADC;
	private final SmScale driver = SmScale.instance;
	
	/**
	 * Create the panel.
	 */
	public Page3() {
		setLayout(null);
		
		JLabel lblADCValue = new JLabel("\u0417\u043D\u0430\u0447\u0435\u043D\u0438\u0435 \u0410\u0426\u041F:\r\n");
		lblADCValue.setForeground(Color.BLACK);
		lblADCValue.setFont(new Font("Tahoma", Font.PLAIN, 13));
		lblADCValue.setBounds(32, 112, 110, 31);
		add(lblADCValue);
		
		JLabel lblInfo2 = new JLabel("\u0412\u044B\u0441\u0442\u0430\u0432\u044C\u0442\u0435 \u0437\u043D\u0430\u0447\u0435\u043D\u0438\u0435 \u0410\u0426\u041F \u0441\u043E\u0433\u043B\u0430\u0441\u043D\u043E \u0434\u043E\u043A\u0443\u043C\u0435\u043D\u0442\u0430\u0446\u0438\u0438 \u043D\u0430 \u0432\u0435\u0441\u043E\u0432\u043E\u0439 \u043C\u043E\u0434\u0443\u043B\u044C");
		lblInfo2.setForeground(Color.BLACK);
		lblInfo2.setFont(new Font("Tahoma", Font.PLAIN, 13));
		lblInfo2.setBounds(20, 36, 470, 31);
		add(lblInfo2);
		
		JLabel label = new JLabel(" \u0423\u0441\u0442\u0430\u043D\u043E\u0432\u043A\u0430 \u043D\u0430\u0447\u0430\u043B\u044C\u043D\u043E\u0433\u043E \u0437\u043D\u0430\u0447\u0435\u043D\u0438\u044F \u0410\u0426\u041F");
		label.setForeground(new Color(0, 0, 128));
		label.setFont(new Font("Tahoma", Font.BOLD, 16));
		label.setBounds(10, 11, 470, 31);
		add(label);
		
		lblADC = new JLabel("12345");
		lblADC.setHorizontalAlignment(SwingConstants.CENTER);
		lblADC.setForeground(new Color(0, 0, 128));
		lblADC.setFont(new Font("Tahoma", Font.PLAIN, 50));
		lblADC.setBounds(152, 92, 272, 76);
		add(lblADC);
		Border border = BorderFactory.createLineBorder(Color.BLACK, 1);
		lblADC.setBorder(BorderFactory.createCompoundBorder(border, 
				BorderFactory.createEmptyBorder(5, 5, 5, 5)));
		
		JLabel label_1 = new JLabel("<html>\u0414\u043B\u044F \u043F\u0440\u043E\u0434\u043E\u043B\u0436\u0435\u043D\u0438\u044F \u043D\u0430\u0436\u043C\u0438\u0442\u0435 \u043A\u043D\u043E\u043F\u043A\u0443 \"\u0414\u0430\u043B\u0435\u0435\",<br>\u0434\u043B\u044F \u0432\u043E\u0437\u0432\u0440\u0430\u0442\u0430 \u043A \u043F\u0440\u0435\u0434\u044B\u0434\u0443\u0449\u0435\u043C\u0443 \u0448\u0430\u0433\u0443 - \"\u041D\u0430\u0437\u0430\u0434\".");
		label_1.setForeground(Color.BLACK);
		label_1.setFont(new Font("Tahoma", Font.PLAIN, 11));
		label_1.setBounds(10, 313, 245, 31);
		add(label_1);
	}

	public void updatePage()
	{
		lblADC.setText(String.valueOf(driver.getADCValue()));
	}
}
