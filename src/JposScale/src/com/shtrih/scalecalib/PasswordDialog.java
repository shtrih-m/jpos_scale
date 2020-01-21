package com.shtrih.scalecalib;

import java.awt.Font;
import java.awt.Color;
import java.awt.SystemColor;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.JButton;
import javax.swing.JDialog;
import javax.swing.JLabel;
import javax.swing.border.BevelBorder;
import javax.swing.BorderFactory;
import javax.swing.border.Border;
import org.eclipse.wb.swing.FocusTraversalOnArray;
import java.awt.Component;
import javax.swing.JTextField;
import javax.swing.JSeparator;


public class PasswordDialog extends JDialog {

	private boolean okPressed = false;
	private String password = "";
	private JTextField edtPassword;
	
	/**
	 * Create the dialog.
	 */
	public PasswordDialog() 
	{
		setTitle("\u0412\u0445\u043E\u0434 \u0432 \u0440\u0435\u0436\u0438\u043C \u0433\u0440\u0430\u0434\u0443\u0438\u0440\u043E\u0432\u043A\u0438");
		setResizable(false);
		setModal(true);
		setDefaultCloseOperation(JDialog.DISPOSE_ON_CLOSE);
		
		setBounds(100, 100, 450, 228);
		getContentPane().setLayout(null);
		
		JLabel lblInfo = new JLabel();
		lblInfo.setBounds(10, 11, 429, 81);
		lblInfo.setText("<html>\r\n\u0414\u043B\u044F \u0432\u0445\u043E\u0434\u0430 \u0432 \u0440\u0435\u0436\u0438\u043C \u0433\u0440\u0430\u0434\u0443\u0438\u0440\u043E\u0432\u043A\u0438  \u043D\u0435\u043E\u0431\u0445\u043E\u0434\u0438\u043C\u043E  \u043F\u0435\u0440\u0435\u0432\u0435\u0441\u0442\u0438 <br>\r\n\u0433\u0440\u0430\u0434\u0443\u0438\u0440\u043E\u0432\u043E\u0447\u043D\u044B\u0439 \u043F\u0435\u0440\u0435\u043A\u043B\u044E\u0447\u0430\u0442\u0435\u043B\u044C \u0432\u0435\u0441\u043E\u0432 \u0432 \u043F\u043E\u043B\u043E\u0436\u0435\u043D\u0438\u0435 \"\u0413\u0420\u0410\u0414\u0423\u0418\u0420\u041E\u0412\u041A\u0410\".<br>\r\n\u041D\u0430\u0436\u043C\u0438\u0442\u0435 \"\u041E\u041A\"  \u0434\u043B\u044F \u043F\u0440\u043E\u0434\u043E\u043B\u0436\u0435\u043D\u0438\u044F \u0438\u043B\u0438 \"\u041E\u0442\u043C\u0435\u043D\u0430\" <br>\r\n\u0434\u043B\u044F \u043F\u0440\u0435\u043A\u0440\u0430\u0449\u0435\u043D\u0438\u044F \u0433\u0440\u0430\u0434\u0443\u0438\u0440\u043E\u0432\u043A\u0438.");
		lblInfo.setForeground(Color.BLACK);
		lblInfo.setFont(new Font("Tahoma", Font.PLAIN, 13));
		lblInfo.setBackground(SystemColor.activeCaptionBorder);
		getContentPane().add(lblInfo);
		
		JButton btnOK = new JButton("OK");
		btnOK.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) 
			{
				password = edtPassword.getText();
				okPressed = true;
				setVisible(false);
			}
		});
		btnOK.setBounds(261, 167, 75, 23);
		btnOK.setActionCommand("OK");
		getContentPane().add(btnOK);
		
		JButton btnCancel = new JButton("\u041E\u0442\u043C\u0435\u043D\u0430");
		btnCancel.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) 
			{
				okPressed = false;
				setVisible(false);
			}
		});
		btnCancel.setBounds(346, 167, 86, 23);
		btnCancel.setActionCommand("Cancel");
		getContentPane().add(btnCancel);
		
		JLabel label = new JLabel("\u041F\u0430\u0440\u043E\u043B\u044C:");
		label.setBounds(10, 112, 120, 14);
		getContentPane().add(label);
		Border border = BorderFactory.createBevelBorder(BevelBorder.LOWERED);
		
		getRootPane().setDefaultButton(btnOK);
		
		edtPassword = new JTextField();
		edtPassword.setBounds(140, 109, 178, 20);
		getContentPane().add(edtPassword);
		edtPassword.setColumns(10);
		
		JSeparator separator = new JSeparator();
		separator.setBounds(10, 152, 424, 14);
		getContentPane().add(separator);
		
		getContentPane().setFocusTraversalPolicy(new FocusTraversalOnArray(new Component[]{edtPassword, btnOK, btnCancel}));
		getContentPane().setFocusCycleRoot(true); 
	}
	
	public boolean getOKPressed(){
		return okPressed;
	}
	
	public String getPassword(){
		return password;
	}
	
}
