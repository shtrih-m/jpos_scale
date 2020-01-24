package com.shtrih.scalecalib;

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

import org.eclipse.wb.swing.FocusTraversalOnArray;

import com.shtrih.port.GnuSerialPort;
import javax.swing.JOptionPane;

public class Page1 extends Page {

    private JComboBox cbBaudRate;
    private JComboBox cbPortName;
    private JTextField edtPassword;
    private JTextArea txtResult;
    private JButton btnTestConnection;
    private JSpinner spTimeout;
    private final SmScale driver = SmScale.instance;

    /**
     * Create the panel.
     */
    public Page1() {
        setLayout(null);

        cbPortName = new JComboBox();
        cbPortName.setBounds(87, 152, 126, 22);
        cbPortName.setSelectedItem("COM1");
        add(cbPortName);
        updatePortList();

        cbBaudRate = new JComboBox();
        cbBaudRate.setModel(new DefaultComboBoxModel(new String[]{"2400",
            "4800", "9600", "19200", "38400", "57600", "115200"}));
        cbBaudRate.setBounds(87, 185, 126, 22);
        cbBaudRate.setSelectedItem("9600");
        add(cbBaudRate);

        spTimeout = new JSpinner();
        spTimeout.setModel(new SpinnerNumberModel(100, 0, 255, 1));
        spTimeout.setBounds(87, 218, 126, 22);
        add(spTimeout);

        edtPassword = new JTextField();
        edtPassword.setText("30");
        edtPassword.setBounds(87, 251, 126, 20);
        add(edtPassword);
        edtPassword.setColumns(10);

        btnTestConnection = new JButton(
                "\u041F\u043E\u0434\u043A\u043B\u044E\u0447\u0438\u0442\u044C\u0441\u044F");
        btnTestConnection.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent arg0) {
                testConnection();
            }
        });
        btnTestConnection.setBounds(353, 282, 137, 23);
        add(btnTestConnection);

        txtResult = new JTextArea();
        txtResult.setFont(new Font("Courier New", Font.PLAIN, 12));
        txtResult.setEditable(false);
        txtResult.setFocusable(false);
        txtResult.setBounds(221, 185, 267, 86);
        add(txtResult);

        JLabel lblInfo1 = new JLabel();
        lblInfo1.setFont(new Font("Tahoma", Font.BOLD, 16));
        lblInfo1.setText("<html>\u0414\u043B\u044F \u043D\u0430\u0447\u0430\u043B\u0430 \u043F\u0440\u043E\u0446\u0435\u0441\u0441\u0430 \u0433\u0440\u0430\u0434\u0443\u0438\u0440\u043E\u0432\u043A\u0438 \u043D\u0435\u043E\u0431\u0445\u043E\u0434\u0438\u043C\u043E<br>\u0443\u0441\u0442\u0430\u043D\u043E\u0432\u0438\u0442\u044C \u0441\u0432\u044F\u0437\u044C \u0441 \u0432\u0435\u0441\u043E\u0432\u043E\u0439 \u044F\u0447\u0435\u0439\u043A\u043E\u0439.");
        lblInfo1.setBounds(10, 11, 480, 47);
        lblInfo1.setForeground(new Color(0, 0, 128));
        add(lblInfo1);

        JLabel lblInfo2 = new JLabel();
        lblInfo2.setText("<html>\u0412\u044B\u0431\u0435\u0440\u0438\u0442\u0435 \u043D\u043E\u043C\u0435\u0440 \u0421\u041E\u041C-\u043F\u043E\u0440\u0442\u0430, \u0441\u043A\u043E\u0440\u043E\u0441\u0442\u044C \u0438 \u043F\u0430\u0440\u043E\u043B\u044C.<br>\r\n\u0415\u0441\u043B\u0438 \u043F\u0430\u0440\u0430\u043C\u0435\u0442\u0440\u044B \u0441\u0432\u044F\u0437\u0438 \u043D\u0435\u0438\u0437\u0432\u0435\u0441\u0442\u043D\u044B \u043D\u0430\u0436\u043C\u0438\u0442\u0435 \u043A\u043D\u043E\u043F\u043A\u0443 \"\u041D\u0430\u0441\u0442\u0440\u043E\u0439\u043A\u0430 \u0441\u0432\u044F\u0437\u0438\"<br>\r\n\u0434\u043B\u044F \u043F\u043E\u0438\u0441\u043A\u0430 \u0443\u0441\u0442\u0440\u043E\u0439\u0441\u0442\u0432\u0430 \u0438 \u0443\u0441\u0442\u0430\u043D\u043E\u0432\u043B\u0435\u043D\u0438\u044F \u0441\u043E\u0435\u0434\u0438\u043D\u0435\u043D\u0438\u044F.");
        lblInfo2.setForeground(Color.BLACK);
        lblInfo2.setFont(new Font("Tahoma", Font.PLAIN, 13));
        lblInfo2.setBounds(10, 64, 480, 60);
        add(lblInfo2);

        JLabel lblPortNumber = new JLabel(
                "\u0421\u041E\u041C- \u043F\u043E\u0440\u0442:");
        lblPortNumber.setFont(new Font("Tahoma", Font.PLAIN, 11));
        lblPortNumber.setBounds(20, 152, 74, 14);
        add(lblPortNumber);

        JLabel lblBaudRate = new JLabel(
                "\u0421\u043A\u043E\u0440\u043E\u0441\u0442\u044C:");
        lblBaudRate.setFont(new Font("Tahoma", Font.PLAIN, 11));
        lblBaudRate.setBounds(20, 189, 74, 14);
        add(lblBaudRate);

        JLabel lblTimeout = new JLabel(
                "\u0422\u0430\u0439\u043C\u0430\u0443\u0442:");
        lblTimeout.setFont(new Font("Tahoma", Font.PLAIN, 11));
        lblTimeout.setBounds(20, 219, 74, 14);
        add(lblTimeout);

        JLabel lblPassword = new JLabel("\u041F\u0430\u0440\u043E\u043B\u044C:");
        lblPassword.setFont(new Font("Tahoma", Font.PLAIN, 11));
        lblPassword.setBounds(20, 254, 74, 14);
        add(lblPassword);

        JLabel lblPressNext = new JLabel(
                "\u0414\u043B\u044F \u043F\u0440\u043E\u0434\u043E\u043B\u0436\u0435\u043D\u0438\u044F \u043D\u0430\u0436\u043C\u0438\u0442\u0435 \u043A\u043D\u043E\u043F\u043A\u0443 \"\u0414\u0430\u043B\u0435\u0435\".");
        lblPressNext.setForeground(Color.BLACK);
        lblPressNext.setFont(new Font("Tahoma", Font.PLAIN, 11));
        lblPressNext.setBounds(10, 329, 343, 14);
        add(lblPressNext);

        Border border = BorderFactory.createBevelBorder(BevelBorder.LOWERED);
        txtResult.setBorder(BorderFactory.createCompoundBorder(border,
                BorderFactory.createEmptyBorder(5, 5, 5, 5)));

        JButton btnUpdatePorts = new JButton(
                "\u041E\u0431\u043D\u043E\u0432\u0438\u0442\u044C \u043F\u043E\u0440\u0442\u044B");
        btnUpdatePorts.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent arg0) {
                updatePortList();
            }
        });
        btnUpdatePorts.setBounds(223, 152, 267, 23);
        add(btnUpdatePorts);

        JButton btnFind = new JButton("\u041F\u043E\u0438\u0441\u043A...");
        btnFind.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                updateObject();
                FindDlg dlg = new FindDlg();
                dlg.setLocationRelativeTo(getTopLevelAncestor());
                dlg.setVisible(true);

            }
        });
        btnFind.setBounds(221, 282, 122, 23);
        btnFind.setVisible(true);
        add(btnFind);
    }

    public void updatePortList() {
        String portName = (String) cbPortName.getSelectedItem();
        ComboBoxModel model = new DefaultComboBoxModel(GnuSerialPort.getPortList()
                .toArray());
        cbPortName.setModel(model);
        cbPortName.setSelectedItem(portName);
    }

    public void updatePage() {
        cbPortName.setSelectedItem(driver.getPortName());
        cbBaudRate.setSelectedItem(String.valueOf(driver.getBaudRate()));
        spTimeout.setValue(driver.getTimeout());
        edtPassword.setText(driver.getPassword());
    }

    public void updateObject() {
        driver.setPortName((String) cbPortName.getSelectedItem());
        driver.setBaudRate(Integer.parseInt((String) cbBaudRate
                .getSelectedItem()));
        driver.setTimeout((Integer) spTimeout.getValue());
        driver.setPassword(edtPassword.getText());
        driver.saveParams();
    }

    public void testConnection() {
        btnTestConnection.setEnabled(false);
        try {
            txtResult.setText("");
            updateObject();
            driver.connect();
            txtResult.setText(driver.getDeviceText());
        } catch (Exception e) {
            JOptionPane.showMessageDialog(this, e.getMessage(), "Œ¯Ë·Í‡", JOptionPane.ERROR_MESSAGE);
        }
        btnTestConnection.setEnabled(true);
    }
}
