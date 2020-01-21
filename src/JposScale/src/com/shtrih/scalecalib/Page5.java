package com.shtrih.scalecalib;

import java.awt.Font;
import java.awt.Color;
import java.awt.SystemColor;
import javax.swing.JLabel;
import javax.swing.JTextArea;
import javax.swing.JTextPane;
import javax.swing.ImageIcon;
import java.net.URL;

import com.shtrih.scale.CalibrationStatus;
import javax.swing.JProgressBar;

public class Page5 extends Page {

	private final JTextPane edtStatus;
	private final JLabel lblPointNumber;
	private final JProgressBar progressBar;


	private final SmScale driver = SmScale.instance;

	/**
	 * Create the panel.
	 */
	public Page5() {
		setLayout(null);

		JLabel lblInfo1 = new JLabel();
		lblInfo1.setBounds(10, 11, 349, 47);
		lblInfo1.setText("<html>\u041F\u0440\u043E\u0446\u0435\u0441\u0441 \u0433\u0440\u0430\u0434\u0443\u0438\u0440\u043E\u0432\u043A\u0438 \u043D\u0430\u0447\u0430\u043B\u0441\u044F.<br>\r\n\u0421\u043B\u0435\u0434\u0443\u0439\u0442\u0435 \u0443\u043A\u0430\u0437\u0430\u043D\u0438\u044F\u043C \u0434\u043B\u044F \u043F\u0440\u043E\u0434\u043E\u043B\u0436\u0435\u043D\u0438\u044F.\r\n");
		lblInfo1.setForeground(new Color(0, 0, 128));
		lblInfo1.setFont(new Font("Tahoma", Font.BOLD, 16));
		lblInfo1.setBackground(SystemColor.activeCaptionBorder);
		add(lblInfo1);

		lblPointNumber = new JLabel();
		lblPointNumber.setText("\u0413\u0440\u0430\u0434\u0443\u0438\u0440\u0443\u0435\u0442\u0441\u044F \u0440\u0435\u043F\u0435\u0440\u043D\u0430\u044F \u0442\u043E\u0447\u043A\u0430 \u21161 (\u0432\u0435\u0441 0 \u043A\u0433).");
		lblPointNumber.setForeground(new Color(0, 0, 0));
		lblPointNumber.setFont(new Font("Tahoma", Font.BOLD, 13));
		lblPointNumber.setBackground(SystemColor.activeCaptionBorder);
		lblPointNumber.setBounds(10, 127, 449, 29);
		add(lblPointNumber);

		JLabel lblInfo3 = new JLabel();
		lblInfo3.setText("<html>\u041D\u0435 \u0442\u0440\u043E\u0433\u0430\u0439\u0442\u0435 \u0432\u0435\u0441\u043E\u0432\u043E\u0439 \u043C\u043E\u0434\u0443\u043B\u044C \u0438 \u0433\u0440\u0443\u0437 \u043D\u0430 \u043D\u0435\u043C,<br>\r\n\u043F\u043E\u0441\u0442\u0430\u0440\u0430\u0439\u0442\u0435\u0441\u044C \u043E\u0433\u0440\u0430\u0434\u0438\u0442\u044C \u0443\u0441\u0442\u0440\u043E\u0439\u0441\u0442\u0432\u043E \u043E\u0442 \u043A\u043E\u043B\u0435\u0431\u0430\u043D\u0438\u0439 \u0438 <br>\r\n\u0432\u0438\u0431\u0440\u0430\u0446\u0438\u0439 (\u043D\u0430\u043F\u0440\u0438\u043C\u0435\u0440, \u043D\u0435 \u0441\u0442\u043E\u0438\u0442 \u043E\u043F\u0438\u0440\u0430\u0442\u044C\u0441\u044F \u043D\u0430 \u0441\u0442\u043E\u043B, <br>\r\n\u043D\u0430 \u043A\u043E\u0442\u043E\u0440\u043E\u043C \u0441\u0442\u043E\u0438\u0442 \u0432\u0435\u0441\u043E\u0432\u043E\u0439 \u043C\u043E\u0434\u0443\u043B\u044C)");
		lblInfo3.setForeground(new Color(0, 0, 0));
		lblInfo3.setFont(new Font("Tahoma", Font.PLAIN, 12));
		lblInfo3.setBackground(SystemColor.activeCaptionBorder);
		lblInfo3.setBounds(91, 223, 341, 72);
		add(lblInfo3);

		JLabel lblInfo2 = new JLabel();
		lblInfo2
				.setText("<html>\u041F\u0440\u043E\u0446\u0435\u0441\u0441 \u0433\u0440\u0430\u0434\u0443\u0438\u0440\u043E\u0432\u043A\u0438 \u043C\u043E\u0436\u0435\u0442 \u0437\u0430\u043D\u044F\u0442\u044C \u043D\u0435\u0441\u043A\u043E\u043B\u044C\u043A\u043E \u043C\u0438\u043D\u0443\u0442.<br>\r\n\u0414\u043E\u0436\u0434\u0438\u0442\u0435\u0441\u044C \u043E\u043A\u043E\u043D\u0447\u0430\u043D\u0438\u044F \u043F\u0440\u043E\u0446\u0435\u0441\u0441\u0430.");
		lblInfo2.setForeground(new Color(0, 0, 0));
		lblInfo2.setFont(new Font("Tahoma", Font.PLAIN, 12));
		lblInfo2.setBackground(SystemColor.activeCaptionBorder);
		lblInfo2.setBounds(10, 69, 419, 47);
		add(lblInfo2);

		edtStatus = new JTextPane();
		edtStatus.setFont(new Font("Tahoma", Font.BOLD, 13));
		edtStatus.setToolTipText("");
		edtStatus.setEditable(false);
		edtStatus.setBounds(10, 156, 449, 29);
		edtStatus.setBackground(SystemColor.activeCaptionBorder);
		add(edtStatus);
		
		JLabel label = new JLabel("<html>\u0414\u043B\u044F \u043F\u0440\u043E\u0434\u043E\u043B\u0436\u0435\u043D\u0438\u044F \u043D\u0430\u0436\u043C\u0438\u0442\u0435 \u043A\u043D\u043E\u043F\u043A\u0443 \"\u0414\u0430\u043B\u0435\u0435\",<br>\u0434\u043B\u044F \u0432\u043E\u0437\u0432\u0440\u0430\u0442\u0430 \u043A \u043F\u0440\u0435\u0434\u044B\u0434\u0443\u0449\u0435\u043C\u0443 \u0448\u0430\u0433\u0443 - \"\u041D\u0430\u0437\u0430\u0434\".");
		label.setForeground(Color.BLACK);
		label.setFont(new Font("Tahoma", Font.PLAIN, 11));
		label.setBounds(10, 313, 245, 31);
		add(label);
		
		JLabel label_1 = new JLabel();
		label_1.setText("\u0412\u043D\u0438\u043C\u0430\u043D\u0438\u0435:");
		label_1.setForeground(Color.BLACK);
		label_1.setFont(new Font("Tahoma", Font.BOLD, 13));
		label_1.setBackground(SystemColor.activeCaptionBorder);
		label_1.setBounds(10, 226, 71, 20);
		add(label_1);
		
		progressBar = new JProgressBar();
		progressBar.setValue(0);
		progressBar.setBounds(10, 196, 303, 16);
		add(progressBar);
		
		ImageIcon image = null;
		URL imageURL = getClass().getResource("/res/progress.gif");
		if (imageURL != null) 
		{
			image = new ImageIcon(imageURL);
		}
	}

	public synchronized void updatePage() 
	{
		CalibrationStatus status = driver.getCalibrationStatus();
		
		String text = "Градуируется реперная точка №%d (вес %.3f кг).";
		text = String.format(text, driver.getPointNumber(), status.getWeight());
		lblPointNumber.setText(text);
		edtStatus.setText(status.getStatusText());
		
		progressBar.setValue(driver.getCalibrationProgress());
	}
}
