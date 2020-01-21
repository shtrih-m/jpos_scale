package com.shtrih.scalecalib;

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

public class MainDialog extends JDialog {

    private int pageIndex = -1;
    private JButton lastButton;
    private final JButton btnPrev;
    private final JButton btnNext;
    private final JButton btnCancel;
    private final JPanel contentPanel = new JPanel();
    private final Vector<Page> pages = new Vector();
    private final SmScale driver = SmScale.instance;
    private Thread thread = null;

    private static final String StartCalibrationErrorText = "Невозможно перейти в режим градуировки.\r\n"
            + "Возможно, надо установить градуировочный переключатель\r\n"
            + "в положение ВКЛ (ON).";

    /**
     * Launch the application.
     */
    public static void main(String[] args) {
        try {
            // Set System L&F		
            UIManager.setLookAndFeel(UIManager.getCrossPlatformLookAndFeelClassName());

            MainDialog dialog = new MainDialog();
            dialog.setDefaultCloseOperation(JDialog.DISPOSE_ON_CLOSE);
            dialog.setVisible(true);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Create the dialog.
     */
    public MainDialog() {
        addWindowListener(new WindowAdapter() {
            @Override
            public void windowClosed(WindowEvent arg0) 
            {
                stopThread();
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
        setTitle("\u0428\u0442\u0440\u0438\u0445-\u041C: \u041F\u0440\u043E\u0433\u0440\u0430\u043C\u043C\u0430 \u0433\u0440\u0430\u0434\u0443\u0438\u0440\u043E\u0432\u043A\u0438 \u0432\u0435\u0441\u043E\u0432\u043E\u0439 \u044F\u0447\u0435\u0439\u043A\u0438 \u0412\u041C-100");

        setBounds(100, 100, 509, 420);
        getContentPane().setLayout(null);
        contentPanel.setBounds(0, 0, 501, 347);
        contentPanel.setBorder(new EmptyBorder(5, 5, 5, 5));
        getContentPane().add(contentPanel);
        contentPanel.setLayout(null);
        {

            JPanel buttonPane = new JPanel();
            buttonPane.setBounds(0, 347, 501, 46);
            getContentPane().add(buttonPane);
            buttonPane.setLayout(null);
            {
                btnPrev = new JButton("<< \u041D\u0430\u0437\u0430\u0434");
                btnPrev.setEnabled(false);
                btnPrev.addActionListener(new ActionListener() {
                    public void actionPerformed(ActionEvent e) {
                        prevPage();
                    }
                });
                btnPrev.setBounds(190, 8, 100, 26);
                btnPrev.setActionCommand("Prev");
                buttonPane.add(btnPrev);
            }
            {
                btnNext = new JButton("\u0414\u0430\u043B\u0435\u0435 >>");
                btnNext.addActionListener(new ActionListener() {
                    public void actionPerformed(ActionEvent arg0) {
                        nextPage();
                    }
                });
                btnNext.setBounds(298, 8, 100, 26);
                btnNext.setActionCommand("Next");
                buttonPane.add(btnNext);
                getRootPane().setDefaultButton(btnNext);
            }
            {
                btnCancel = new JButton("\u0412\u044B\u0439\u0442\u0438");
                btnCancel.addActionListener(new ActionListener() {
                    public void actionPerformed(ActionEvent arg0) {
                        lastButton = btnCancel;
                        if (confirmClose()) {
                            stopThread();
                            driver.disconnect();
                            setVisible(false);
                        }
                    }
                });
                btnCancel.setBounds(405, 8, 90, 26);
                btnCancel.setActionCommand("Cancel");
                buttonPane.add(btnCancel);
            }

            JSeparator separator = new JSeparator();
            separator.setBounds(10, 0, 485, 26);
            buttonPane.add(separator);
        }

        Dimension screenSize = Toolkit.getDefaultToolkit().getScreenSize();
        int x = (screenSize.width / 2) - (getWidth() / 2);
        int y = (screenSize.height / 2) - (getHeight() / 2);
        setLocation(x, y);

        addPage(new Page1());
        addPage(new Page2());
        addPage(new Page3());
        addPage(new Page4());
        addPage(new Page5());
        addPage(new Page6());

        /*
		getContentPane().setFocusCycleRoot(true);
		setFocusTraversalPolicy(new FocusTraversalOnArray(new Component[] {
				page, btnPrev, btnNext, btnCancel }));
         */
        showPage(0);
    }

    public boolean confirmClose() {
        boolean result = true;
        if (isCalibrationStarted()) {
            String text = "Вы уверены, что хотите прервать процесс градуировки?";
            result = JOptionPane.showInternalConfirmDialog(getContentPane(),
                    (Object) text, "Подтверждение", JOptionPane.YES_NO_OPTION,
                    JOptionPane.QUESTION_MESSAGE) == JOptionPane.YES_OPTION;
        }
        return result;
    }

    public void addPage(Page page) {
        pages.add(page);
        contentPanel.add(page);
        page.setBounds(new Rectangle(0, 0, 501, 355));
        page.setVisible(false);
    }

    public boolean validPage(int index) {
        return (index >= 0) && (index < pages.size());
    }

    public void showPage(int index) {
        if (!validPage(index)) {
            index = 0;
        }

        if (index != pageIndex) {
            if (validPage(pageIndex)) {
                pages.get(pageIndex).setVisible(false);
            }
            if (validPage(index)) {
                Page page = pages.get(index);
                page.updatePage();
                page.setVisible(true);
                pageIndex = index;
            }
        }
        boolean prevEnabled = (index > 0) && (index != 4);
        btnPrev.setEnabled(prevEnabled);
        if (prevEnabled && (lastButton == btnPrev)) {
            btnPrev.requestFocus();
        }

        boolean nextEnabled = (index != 4);
        btnNext.setEnabled(nextEnabled);
        if (nextEnabled && (lastButton == btnNext)) {
            btnNext.requestFocus();
        }
    }

    public boolean isCalibrationStarted() {
        return (pageIndex == 3) || (pageIndex == 4);
    }

    public void updatePage() {
        if (validPage(pageIndex)) {
            Page page = pages.get(pageIndex);
            page.updatePage();
        }
        if (isCalibrationStarted()) {
            btnCancel.setText("Прервать");
        } else {
            btnCancel.setText("Выход");
        }
    }

    public void updateObject() {
        if (validPage(pageIndex)) {
            Page page = pages.get(pageIndex);
            page.updateObject();
        }
    }

    public class ReadADCRunner implements Runnable {

        private final MainDialog dlg;

        public ReadADCRunner(MainDialog dlg) {
            this.dlg = dlg;
        }

        public void run() {
            try {
                dlg.updateADCValue();
            } catch (Exception e) {
                Thread.currentThread().interrupt();
            }

        }
    }

    public class ReadCalibrationRunner implements Runnable {

        private final MainDialog dlg;

        public ReadCalibrationRunner(MainDialog dlg) {
            this.dlg = dlg;
        }

        public void run() {
            try {
                dlg.updateCalibrationStatus();
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
            }
        }
    }

    public void showError(Exception e) {
        JOptionPane.showMessageDialog(this, e.getMessage(), "Ошибка", JOptionPane.ERROR_MESSAGE);
    }

    public void updateCalibrationStatus() throws InterruptedException {
        try {
            driver.startCalibration();

            while (thread != null) {
                driver.readCalibrationStatus();

                CalibrationStatus calibrationStatus = driver.getCalibrationStatus();
                pages.get(4).updatePage();
                if (calibrationStatus.isPointReady()) {
                    driver.incPointNumber();
                    showPage(3);
                    thread = null;
                    return;
                }
                if (calibrationStatus.isCalibrationStopped()) {
                    driver.stopCalibration();
                    driver.exitCalibrationMode();
                    showPage(5);
                    thread = null;
                    return;
                }
                driver.stepCalibrationProgress();
                Thread.sleep(100);
            }
        } catch (Exception e) {
            showError(e);
        }
    }

    public void updateADCValue() throws Exception {
        while (thread != null) {
            driver.readADCValue();
            pages.get(2).updatePage();
            Thread.sleep(200);
        }
    }

    public void stopThread() {
        thread = null;
    }

    public void nextPage() {
        lastButton = btnNext;
        setPageIndex(pageIndex + 1);
    }

    public void prevPage() {
        lastButton = btnPrev;
        setPageIndex(pageIndex - 1);
    }

    public void setPageIndex(int index) {
        if (index == pageIndex) {
            return;
        }

        try {
            stopThread();
            updateObject();
            setPageIndex2(index);
        } catch (Exception e) {
            JOptionPane.showMessageDialog(this, e.getMessage(), "Ошибка",
                    JOptionPane.ERROR_MESSAGE);
            try {
                setPageIndex2(pageIndex);
            } catch (Exception e1) {
            }
        }
    }

    public void setPageIndex2(int index) throws Exception {
        stopThread();

        switch (index) {
            case 1: {
                driver.connect();
                break;
            }
            case 2: {
                thread = new Thread(new ReadADCRunner(this));
                thread.start();
                break;
            }
            case 3: {
                driver.resetPointNumber();
                driver.readScaleMode();
                int scaleMode = driver.getScaleMode();
                if (scaleMode == Pos2Serial.MODE_NORMAL) {
                    int rc = 0;
                    try {
                        driver.enterCalibrationMode();
                    } catch (DeviceError e) {
                        rc = e.getCode();
                    }
                    if (rc > 0) {
                        PasswordDialog dlg = new PasswordDialog();
                        dlg.setLocationRelativeTo(this);
                        dlg.setVisible(true);
                        if (dlg.getOKPressed()) {
                            if (dlg.getPassword().equals("316071")) {
                                driver.sendCalibrationPassword();
                            } else {
                                driver.enterCalibrationMode();
                            }
                            Thread.sleep(500);
                            driver.readScaleMode();
                            if (driver.getScaleMode() == Pos2Serial.MODE_NORMAL) {
                                throw new Exception(StartCalibrationErrorText);
                            }
                            driver.readCalibrationStatus();

                        } else {
                            throw new Exception(StartCalibrationErrorText);
                        }
                    }
                }
                break;
            }
            case 4: {
                thread = new Thread(new ReadCalibrationRunner(this));
                thread.start();
                break;
            }
        }
        showPage(index);
    }
}
