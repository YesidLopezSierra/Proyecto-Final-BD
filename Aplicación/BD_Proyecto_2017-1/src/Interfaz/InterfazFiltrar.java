package Interfaz;

import javax.swing.*;
import javax.swing.event.ChangeEvent;
import javax.swing.event.ChangeListener;

import Mundo.Actividad;
import Mundo.BaseDatos;

import java.awt.*;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.util.ArrayList;
import java.util.Calendar;

public class InterfazFiltrar extends JFrame implements MouseListener, ChangeListener {

	private BaseDatos principal;
	private Dibujo contenedora;

	private JLabel btnAceptar;
	private JLabel btnCancelar;
	private InterfazProyecto interfaz;
	private JTextField campo;
	private JComboBox<Integer> diaFinal;
	private JComboBox<Integer> mesFinal;
	private JTextField anhoFinal;
	private JTextField intPrioridad;

	static final int FPS_MIN = -1;
	static final int FPS_MAX = 99;
	static final int FPS_INIT = -1; // initial frames per second

	private JSlider slPrioridad = new JSlider(JSlider.HORIZONTAL, FPS_MIN, FPS_MAX, FPS_INIT);

	public InterfazFiltrar(InterfazProyecto interfaz, BaseDatos principal) {

		this.setLayout(null);
		this.setBounds(890, 420, 400, 290);
		this.setUndecorated(true);
		this.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);

		this.principal = principal;
		this.interfaz = interfaz;
		contenedora = new Dibujo("Imagenes/FondoFiltrar.png", 400, 290);
		contenedora.setBounds(0, 0, 400, 290);

		slPrioridad.addChangeListener(this);
		slPrioridad.setMajorTickSpacing(10);
		slPrioridad.setMinorTickSpacing(1);
		slPrioridad.setPaintTicks(true);
		slPrioridad.setPaintLabels(true);
		slPrioridad.setBounds(75, 63, 240, 50);
		slPrioridad.setBackground(new Color(33, 44, 50));
		slPrioridad.setForeground(Color.WHITE);
		slPrioridad.setToolTipText("Prioridad");
		slPrioridad.setCursor(new Cursor(Cursor.HAND_CURSOR));

		campo = new JTextField();
		campo.setBounds(75, 199, 300, 30);

		diaFinal = new JComboBox<>();
		diaFinal.setBounds(75, 134, 60, 25);

		diaFinal.setToolTipText("Dia fecha Final");

		mesFinal = new JComboBox<>();
		mesFinal.setBounds(145, 134, 60, 25);

		mesFinal.setToolTipText("Mes fecha Final");

		anhoFinal = new JTextField(4);
		anhoFinal.setBounds(215, 134, 100, 25);

		anhoFinal.setToolTipText("Año fecha Final");

		Calendar c1 = Calendar.getInstance();
		int d = c1.get(Calendar.DATE);
		int m = c1.get(Calendar.MONTH);
		int a = c1.get(Calendar.YEAR);

		diaFinal.addItem(-1);
		mesFinal.addItem(-1);

		for (int i = 1; i <= 31; i++) {

			diaFinal.addItem(i);
			if (i < 13) {

				mesFinal.addItem(i);
			}

		}

		anhoFinal.setText(Integer.toString(a));

		btnAceptar = new JLabel();
		btnAceptar.setBounds(89, 263, 94, 22);
		btnAceptar.addMouseListener(this);
		btnAceptar.setIcon(convertirTamanho("Imagenes/Botones/AceptarDependencias.png", 94, 22));

		btnAceptar.setCursor(new Cursor(Cursor.HAND_CURSOR));
		btnCancelar = new JLabel();
		btnCancelar.setBounds(287, 263, 94, 22);
		btnCancelar.addMouseListener(this);
		btnCancelar.setIcon(convertirTamanho("Imagenes/Botones/CancelarDependencias.png", 94, 22));

		btnCancelar.setCursor(new Cursor(Cursor.HAND_CURSOR));
		intPrioridad=new JTextField("-1");
		intPrioridad.setBounds(325,68,30,25);
		intPrioridad.setEnabled(false);
		
		
		contenedora.add(slPrioridad);
		contenedora.add(campo);
		contenedora.add(anhoFinal);
		contenedora.add(mesFinal);
		contenedora.add(diaFinal);
		contenedora.add(btnAceptar);
		contenedora.add(btnCancelar);
		contenedora.add(intPrioridad);
		add(contenedora);

	}

	@Override
	public void mouseClicked(MouseEvent e) {
		if (e.getSource() == btnAceptar) {

			String fechaFinal = "";
			String pDescripcion = campo.getText();
			int pPrioridad = 0;
			int idActividad = 0;

			if (slPrioridad.getValue() != -1) {

				pPrioridad = slPrioridad.getValue();

			}
			if((int)diaFinal.getSelectedItem()!=-1){
				
				fechaFinal=diaFinal.getSelectedIndex()+"/"+mesFinal.getSelectedItem()+"/"+anhoFinal.getText();
				
			}

			try {
				ArrayList<Actividad> actividades=principal.filtrarActividades(fechaFinal, pDescripcion, pPrioridad, idActividad);
			
				interfaz.cambiarActividades(actividades);
			
			} catch (Exception e1) {
				JOptionPane.showMessageDialog(null, e1.getMessage(), "ERROR ", JOptionPane.ERROR_MESSAGE);
			}
			dispose();
		} else if (e.getSource() == btnCancelar) {

			dispose();
		}

	}

	@Override
	public void mouseEntered(MouseEvent e) {
		// TODO Auto-generated method stub

	}

	@Override
	public void mouseExited(MouseEvent e) {
		// TODO Auto-generated method stub

	}

	@Override
	public void mousePressed(MouseEvent e) {
		// TODO Auto-generated method stub

	}

	@Override
	public void mouseReleased(MouseEvent e) {
		// TODO Auto-generated method stub

	}

	public ImageIcon convertirTamanho(String image, int x, int y) {

		ImageIcon imagen = new ImageIcon(image);
		Image conversion = imagen.getImage();

		Image tamanho = conversion.getScaledInstance(x, y, Image.SCALE_DEFAULT);
		// TODO Auto-generated method stub
		return new ImageIcon(tamanho);
	}

	@Override
	public void stateChanged(ChangeEvent e) {
		JSlider source = (JSlider) e.getSource();
		if (!source.getValueIsAdjusting()) {
			int fps = (int) source.getValue();
			intPrioridad.setText(fps+"");
			System.out.println(fps);

		}

	}

}
