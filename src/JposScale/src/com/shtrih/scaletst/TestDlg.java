package com.shtrih.scaletst;

import java.util.Vector;
import java.awt.Toolkit;
import java.awt.Rectangle;
import java.awt.Component;
import java.awt.Dimension;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;

import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JButton;
import javax.swing.JDialog;
import javax.swing.UIManager;
import javax.swing.border.EmptyBorder;
import javax.swing.JSeparator;
import javax.swing.JOptionPane;
import javax.swing.ImageIcon;

import org.eclipse.wb.swing.FocusTraversalOnArray;

import com.shtrih.DeviceError;
import com.shtrih.scale.IScale;
import com.shtrih.scale.Pos2Serial;
import com.shtrih.scale.CalibrationStatus;
import com.shtrih.scale.Page;
import com.shtrih.scale.FindDlg;
import com.shtrih.scale.SmScale;
import com.shtrih.scale.DeviceFindMulti;
import com.shtrih.scale.DeviceFindSingle;
import javax.swing.JTabbedPane;

public class TestDlg extends JDialog {

	private final JButton btnAbout;
	private final JButton btnCancel;
	private final JTabbedPane tabbedPane;
	private final Vector<Page> pages = new Vector();
	private final SmScale driver = SmScale.instance;

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		try {
			// Set System L&F
			UIManager.setLookAndFeel(UIManager.getCrossPlatformLookAndFeelClassName());

			TestDlg dialog = new TestDlg();
			dialog.setDefaultCloseOperation(JDialog.DISPOSE_ON_CLOSE);
			dialog.setVisible(true);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * Create the dialog.
	 */
	public TestDlg() throws Exception {
		addWindowListener(new WindowAdapter() {
			@Override
			public void windowClosed(WindowEvent arg0) {
				driver.disconnect();
			}

			@Override
			public void windowClosing(WindowEvent arg0) {
				if (confirmClose()) {
					setDefaultCloseOperation(DISPOSE_ON_CLOSE);
				} else {
					setDefaultCloseOperation(DO_NOTHING_ON_CLOSE);
				}
			}
		});
		setResizable(false);
		setModal(true);
		setDefaultCloseOperation(JDialog.DISPOSE_ON_CLOSE);
		setTitle(
				"\u0428\u0442\u0440\u0438\u0445-\u041C: \u0422\u0435\u0441\u0442 \u0432\u0435\u0441\u043E\u0432\u043E\u0433\u043E \u043C\u043E\u0434\u0443\u043B\u044F \u0412\u041C-100");

		setBounds(100, 100, 509, 464);
		getContentPane().setLayout(null);
		{

			JPanel buttonPane = new JPanel();
			buttonPane.setBounds(4, 392, 501, 46);
			getContentPane().add(buttonPane);
			buttonPane.setLayout(null);
			{
				btnAbout = new JButton("\u041E \u043F\u0440\u043E\u0433\u0440\u0430\u043C\u043C\u0435...");
				btnAbout.addActionListener(new ActionListener() {
					public void actionPerformed(ActionEvent arg0) {
						// !!!
					}
				});
				btnAbout.setBounds(266, 8, 132, 26);
				btnAbout.setActionCommand("Next");
				buttonPane.add(btnAbout);
				getRootPane().setDefaultButton(btnAbout);
			}
			{
				btnCancel = new JButton("\u0412\u044B\u0445\u043E\u0434");
				btnCancel.addActionListener(new ActionListener() {
					public void actionPerformed(ActionEvent arg0) {
						driver.disconnect();
						setVisible(false);
					}
				});
				btnCancel.setBounds(405, 8, 90, 26);
				btnCancel.setActionCommand("Cancel");
				buttonPane.add(btnCancel);
			}
		}

		tabbedPane = new JTabbedPane(JTabbedPane.TOP);
		tabbedPane.setBounds(0, 0, 501, 387);
		getContentPane().add(tabbedPane);
		addPage("Подключение", new Page1());

		Dimension screenSize = Toolkit.getDefaultToolkit().getScreenSize();
		int x = (screenSize.width / 2) - (getWidth() / 2);
		int y = (screenSize.height / 2) - (getHeight() / 2);
		setLocation(x, y);
		updatePages();
	}

	public boolean confirmClose() {
		return true;
	}

	public void addPage(String name, Page page) {
		pages.add(page);
		tabbedPane.add(name, page);
	}

	public void updatePages() {
		for (int i = 0; i < pages.size(); i++) {
			pages.get(i).updatePage();
		}
	}

	public void updateObject() {
	}

	public void showError(Exception e) {
		JOptionPane.showMessageDialog(this, e.getMessage(), "Ошибка", JOptionPane.ERROR_MESSAGE);
	}
}
