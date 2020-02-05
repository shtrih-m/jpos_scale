package com.shtrih.scale;

import java.util.Vector;

import javax.swing.JList;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTable;
import javax.swing.JButton;
import javax.swing.JDialog;
import javax.swing.JScrollPane;
import javax.swing.table.TableColumn;
import javax.swing.border.EmptyBorder;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.TableColumnModel;
import javax.swing.table.DefaultTableCellRenderer;
import java.awt.Component;
import java.awt.Dimension;
import java.awt.FlowLayout;
import java.awt.BorderLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import org.eclipse.wb.swing.FocusTraversalOnArray;

import com.shtrih.scale.DeviceFindSingle.DeviceItem;

import javax.swing.JOptionPane;

public class FindDlg extends JDialog implements Runnable {

    private JTable table;
    private JButton btnStop;
    private JButton btnStart;
    private Thread thread;
    private DeviceFindSingle find = new DeviceFindSingle();
    private String[] columns = {"Порт", "Скорость", "Название"};
    String[][] data = new String[1][3];

    /**
     * Create the dialog.
     */
    public FindDlg() {
        setModal(true);
        setTitle("\u041F\u043E\u0438\u0441\u043A \u0443\u0441\u0442\u0440\u043E\u0439\u0441\u0442\u0432");
        setDefaultCloseOperation(JDialog.DISPOSE_ON_CLOSE);
        setBounds(100, 100, 450, 328);
        getContentPane().setLayout(null);

        JButton btnClose = new JButton(
                "\u0417\u0430\u043A\u0440\u044B\u0442\u044C");
        btnClose.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                setVisible(false);
            }
        });
        btnClose.setActionCommand("Cancel");
        btnClose.setBounds(326, 267, 106, 26);
        getContentPane().add(btnClose);

        btnStart = new JButton("\u041D\u0430\u0447\u0430\u0442\u044C");
        btnStart.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                startFind();
            }
        });
        btnStart.setBounds(84, 267, 112, 26);
        getContentPane().add(btnStart);

        btnStop = new JButton(
                "\u041E\u0441\u0442\u0430\u043D\u043E\u0432\u0438\u0442\u044C");
        btnStop.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                stopFind();
            }
        });
        btnStop.setEnabled(false);
        btnStop.setBounds(204, 267, 112, 26);
        getContentPane().add(btnStop);

        table = new JTable(data, columns);
        table.setBounds(10, 11, 422, 217);
        table.setAutoResizeMode(table.AUTO_RESIZE_LAST_COLUMN);
        table.setAutoCreateColumnsFromModel(false);
        table.setPreferredScrollableViewportSize(new Dimension(
                table.getWidth(), table.getHeight()));
        table.setRowHeight(20);
        table.getTableHeader().setReorderingAllowed(false);
        table.getTableHeader().setResizingAllowed(false);
        DefaultTableCellRenderer cellRenderer = new DefaultTableCellRenderer();
        cellRenderer.setHorizontalAlignment(JLabel.CENTER);
        table.setDefaultRenderer(String.class, cellRenderer);

        TableColumn column;
        column = table.getColumn(columns[0]);
        column.setPreferredWidth(60);
        column.setResizable(false);
        column.setCellRenderer(cellRenderer);

        column = table.getColumn(columns[1]);
        column.setPreferredWidth(80);
        column.setResizable(false);
        column.setCellRenderer(cellRenderer);

        column = table.getColumn(columns[2]);
        column.setPreferredWidth(table.getWidth());
        column.setResizable(false);
        column.setCellRenderer(cellRenderer);

        JScrollPane scrollPane = new JScrollPane(table);
        scrollPane.setBounds(10, 11, 422, 245);
        getContentPane().add(scrollPane);

        getContentPane().setFocusTraversalPolicy(
                new FocusTraversalOnArray(new Component[]{btnStart, btnStop,
            btnClose}));

        find.updateItems();
        updatePage();
    }

    public void run() {
        try {
            while (thread != null) {
                updatePage();
                Thread.sleep(100);
            }
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }
    }

    private void startFind() {
        try {
            btnStart.setEnabled(false);
            find.start();
            updatePage();
            thread = new Thread(this);
            thread.start();

            btnStop.setEnabled(true);
            btnStop.requestFocus();
        } catch (Exception e) {
            JOptionPane.showMessageDialog(this, e.getMessage(), "Ошибка", JOptionPane.ERROR_MESSAGE);
        }
    }

    private void stopFind() {
        btnStop.setEnabled(false);
        find.stop();
        updatePage();
        btnStart.setEnabled(true);
        btnStart.requestFocus();
    }

    private void updatePage() {
        int rowCount = find.getItemCount();
        String[][] data = new String[rowCount][3];
        for (int row = 0; row < rowCount; row++) {
            DeviceItem item = (DeviceItem) find.getItem(row);
            data[row][0] = item.getPortName();
            data[row][1] = item.getBaudRate();
            data[row][2] = item.getText();
        }

        DefaultTableModel tableModel = new DefaultTableModel(data, columns) {
            @Override
            public boolean isCellEditable(int row, int column) {
                return false;
            }
        };

        table.setModel(tableModel);
        if (!find.isStarted()) {
            thread = null;
            btnStop.setEnabled(false);
            btnStart.setEnabled(true);
            btnStart.requestFocus();
        }
    }
}
