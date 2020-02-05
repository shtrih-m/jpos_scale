package com.shtrih.scaletst;

import java.awt.Font;
import java.awt.Color;
import java.awt.Component;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import java.net.URL;
import java.util.Enumeration;
import java.util.Vector;

import javax.swing.JLabel;
import javax.swing.ImageIcon;
import javax.swing.SwingConstants;
import javax.swing.JTextArea;
import javax.swing.JComboBox;
import javax.swing.JTextField;
import javax.swing.JButton;
import javax.swing.JSeparator;
import javax.swing.DefaultComboBoxModel;
import javax.swing.JSpinner;
import javax.swing.SpinnerNumberModel;
import javax.swing.BorderFactory;
import javax.swing.ComboBoxModel;
import javax.swing.border.BevelBorder;
import javax.swing.border.Border;
import javax.swing.JOptionPane;
import javax.swing.text.MaskFormatter;
import javax.swing.ButtonGroup;


import org.eclipse.wb.swing.FocusTraversalOnArray;

import com.shtrih.port.GnuSerialPort;
import com.shtrih.scale.Page;
import com.shtrih.scale.FindDlg;
import com.shtrih.scale.SmScale;
import com.shtrih.scale.DeviceFindMulti;
import com.shtrih.scale.DeviceFindSingle;
import com.shtrih.IDevice;


import javax.swing.JPanel;
import javax.swing.border.EtchedBorder;
import javax.swing.JFormattedTextField;
import javax.swing.JRadioButton;
import javax.swing.border.TitledBorder;
import javax.swing.UIManager;

public class Page1 extends Page {
	private JTextArea txtResult;
	private JSpinner spTimeout;
	private JTextField edtPassword;
	private JButton btnConnect;
	private JButton btnDisconnect;
	private final SmScale driver = SmScale.instance;
	private JTextField textField;
	private JComboBox cbBaudRate;
	private JComboBox cbPortName;
	private JRadioButton rbSocketPort;
	private JRadioButton rbSerialPort;
	/**
	 * Create the panel.
	 */
	public Page1() throws Exception{
		setBorder(null);
		setLayout(null);

		btnConnect = new JButton("\u041F\u043E\u0434\u043A\u043B\u044E\u0447\u0438\u0442\u044C\u0441\u044F");
		btnConnect.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				connect();
			}
		});
		btnConnect.setBounds(284, 11, 137, 23);
		add(btnConnect);

		txtResult = new JTextArea();
		txtResult.setFont(new Font("Courier New", Font.PLAIN, 12));
		txtResult.setEditable(false);
		txtResult.setFocusable(false);
		txtResult.setBounds(10, 262, 411, 88);
		add(txtResult);

		Border border = BorderFactory.createBevelBorder(BevelBorder.LOWERED);
		txtResult.setBorder(BorderFactory.createCompoundBorder(border, BorderFactory.createEmptyBorder(5, 5, 5, 5)));

		JButton btnFind = new JButton("\u041F\u043E\u0438\u0441\u043A...");
		btnFind.setBounds(284, 79, 137, 23);
		btnFind.setVisible(true);
		add(btnFind);

		JPanel panel = new JPanel();
		panel.setToolTipText("");
		panel.setBorder(new TitledBorder(UIManager.getBorder("TitledBorder.border"), "\u041F\u0430\u0440\u0430\u043C\u0435\u0442\u0440\u044B \u043F\u043E\u0434\u043A\u043B\u044E\u0447\u0435\u043D\u0438\u044F", TitledBorder.LEADING, TitledBorder.TOP, null, new Color(0, 0, 0)));
		panel.setBounds(10, 11, 264, 240);
		add(panel);
		panel.setLayout(null);


		JLabel lblTimeout = new JLabel("\u0422\u0430\u0439\u043C\u0430\u0443\u0442:");
		lblTimeout.setBounds(10, 178, 61, 14);
		panel.add(lblTimeout);
		lblTimeout.setFont(new Font("Tahoma", Font.PLAIN, 11));

		spTimeout = new JSpinner();
		spTimeout.setBounds(92, 174, 162, 22);
		panel.add(spTimeout);
		spTimeout.setModel(new SpinnerNumberModel(100, 0, 255, 1));

		edtPassword = new JTextField();
		edtPassword.setBounds(92, 207, 162, 20);
		panel.add(edtPassword);
		edtPassword.setText("30");
		edtPassword.setColumns(10);

		JLabel lblPassword = new JLabel("\u041F\u0430\u0440\u043E\u043B\u044C:");
		lblPassword.setBounds(10, 210, 61, 14);
		panel.add(lblPassword);
		lblPassword.setFont(new Font("Tahoma", Font.PLAIN, 11));
		
		rbSocketPort = new JRadioButton("IP \u0430\u0434\u0440\u0435\u0441:");
		rbSocketPort.setBounds(6, 127, 78, 23);
		panel.add(rbSocketPort);
		
		textField = new JTextField();
		textField.setBounds(92, 128, 162, 20);
		panel.add(textField);
		textField.setText("192.168.0.1:51234");
		textField.setColumns(10);
		
		rbSerialPort = new JRadioButton("RS-232");
		rbSerialPort.setSelected(true);
		rbSerialPort.setBounds(6, 19, 109, 23);
		panel.add(rbSerialPort);
		
		ButtonGroup bgPortType = new ButtonGroup();
		bgPortType.add(rbSerialPort);
		bgPortType.add(rbSocketPort);
		
		cbPortName = new JComboBox();
		cbPortName.setBounds(91, 51, 120, 22);
		panel.add(cbPortName);
		
		cbBaudRate = new JComboBox();
        cbBaudRate.setModel(new DefaultComboBoxModel(new String[]{"2400",
                "4800", "9600", "19200", "38400", "57600", "115200"}));
		cbBaudRate.setBounds(91, 84, 163, 22);
		panel.add(cbBaudRate);
		
		JLabel lblBaudRate = new JLabel("\u0421\u043A\u043E\u0440\u043E\u0441\u0442\u044C:");
		lblBaudRate.setBounds(25, 88, 74, 14);
		panel.add(lblBaudRate);
		lblBaudRate.setFont(new Font("Tahoma", Font.PLAIN, 11));
		
		JLabel lblPortName = new JLabel("\u0421\u041E\u041C- \u043F\u043E\u0440\u0442:");
		lblPortName.setBounds(25, 55, 61, 14);
		panel.add(lblPortName);
		lblPortName.setFont(new Font("Tahoma", Font.PLAIN, 11));
		
		JButton btnRefresh = new JButton("");
		btnRefresh.setBounds(221, 51, 33, 29);
		panel.add(btnRefresh);

		String[] items = { "RS-232", "Ethernet" };
		
		btnDisconnect = new JButton("\u041E\u0442\u043A\u043B\u044E\u0447\u0438\u0442\u044C\u0441\u044F");
		btnDisconnect.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) 
			{
				disconnect();
			}
		});
		btnDisconnect.setBounds(284, 45, 137, 23);
		add(btnDisconnect);
	}

	public void updatePage() {
		updatePortList();
		rbSerialPort.setSelected(driver.getPortType() == IDevice.PARAM_PORTTYPE_SERIAL);
		rbSocketPort.setSelected(driver.getPortType() == IDevice.PARAM_PORTTYPE_SOCKET);
		cbPortName.setSelectedItem(driver.getPortName());
		cbBaudRate.setSelectedItem(String.valueOf(driver.getBaudRate()));
		spTimeout.setValue(driver.getTimeout());
		edtPassword.setText(driver.getPassword());
	}

	public void updatePortList() {
		String portName = (String) cbPortName.getSelectedItem();
		ComboBoxModel model = new DefaultComboBoxModel(GnuSerialPort.getPortList2().toArray());
		cbPortName.setModel(model);
		cbPortName.setSelectedItem(portName);
	}

	public void updateObject() {
		
		if (rbSerialPort.isSelected()) {
			driver.setPortType(IDevice.PARAM_PORTTYPE_SERIAL);
		} else {
			driver.setPortType(IDevice.PARAM_PORTTYPE_SOCKET);
		}
		driver.setPortName((String) cbPortName.getSelectedItem());
		driver.setBaudRate(Integer.parseInt((String) cbBaudRate.getSelectedItem()));
		driver.setTimeout((Integer) spTimeout.getValue());
		driver.setPassword(edtPassword.getText());
		driver.saveParams();
	}

	public void connect() {
		btnConnect.setEnabled(false);
		try {
			txtResult.setText("");
			updateObject();
			driver.connect();
			txtResult.setText(driver.getDeviceText());
		} catch (Exception e) 
		{
			
			JOptionPane.showMessageDialog(this, e.getMessage(), "Œ¯Ë·Í‡", JOptionPane.ERROR_MESSAGE);
		}
		btnConnect.setEnabled(true);
	}
	
	public void disconnect() {
		btnDisconnect.setEnabled(false);
		try {
			txtResult.setText("");
			driver.disconnect();
		} catch (Exception e) {
			JOptionPane.showMessageDialog(this, e.getMessage(), "Œ¯Ë·Í‡", JOptionPane.ERROR_MESSAGE);
		}
		btnDisconnect.setEnabled(true);
	}
}
