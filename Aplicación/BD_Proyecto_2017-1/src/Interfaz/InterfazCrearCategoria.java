package Interfaz;

import javax.swing.*;
import javax.swing.event.ChangeEvent;
import javax.swing.event.ChangeListener;

import Mundo.Actividad;
import Mundo.BaseDatos;
import Mundo.Categoria;

import java.awt.*;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.util.ArrayList;
import java.util.Calendar;

public class InterfazCrearCategoria extends JFrame implements MouseListener, ChangeListener {

	private BaseDatos principal;
	private Dibujo contenedora;

	private JLabel btnAceptar;
	private JLabel btnCancelar;
	private InterfazProyecto interfaz;
	private JTextField campo;
	private JTextField nombre;
	private JComboBox<Integer> diaFinal;
	private JComboBox<Integer> mesFinal;
	private JTextField anhoFinal;
	private JTextField intPrioridad;
	private JComboBox<String> categorias;

	static final int FPS_MIN = 0;
	static final int FPS_MAX = 99;
	static final int FPS_INIT = 50; // initial frames per second

	private JSlider slPrioridad = new JSlider(JSlider.HORIZONTAL, FPS_MIN, FPS_MAX, FPS_INIT);

	public InterfazCrearCategoria(InterfazProyecto interfaz, BaseDatos principal) {

		this.setLayout(null);
		this.setBounds(890, 420, 400, 290);
		this.setUndecorated(true);
		this.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);

		this.principal = principal;
		this.interfaz = interfaz;
		contenedora = new Dibujo("Imagenes/FondoCategoria.png", 400, 290);
		contenedora.setBounds(0, 0, 400, 290);

		slPrioridad.addChangeListener(this);
		slPrioridad.setMajorTickSpacing(10);
		slPrioridad.setMinorTickSpacing(1);
		slPrioridad.setPaintTicks(true);
		slPrioridad.setPaintLabels(true);
		slPrioridad.setBounds(75, 163, 240, 50);
		slPrioridad.setBackground(new Color(33, 44, 50));
		slPrioridad.setForeground(Color.WHITE);
		slPrioridad.setToolTipText("Prioridad");
		slPrioridad.setCursor(new Cursor(Cursor.HAND_CURSOR));

		campo = new JTextField();
		campo.setBounds(75, 211, 300, 30);

		nombre = new JTextField();
		nombre.setBounds(75, 64, 300, 30);

		categorias = new JComboBox<>();
		categorias.setBounds(75, 113, 300, 30);

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

		intPrioridad = new JTextField("50");
		intPrioridad.setBounds(325, 163, 30, 25);
		intPrioridad.setEnabled(false);
		cargarCategorias();

		contenedora.add(campo);
		contenedora.add(nombre);
		contenedora.add(btnAceptar);
		contenedora.add(intPrioridad);
		contenedora.add(slPrioridad);
		contenedora.add(btnCancelar);
		contenedora.add(categorias);

		add(contenedora);

	}

	public void cargarCategorias() {

		ArrayList<Categoria> c = principal.darCategorias();

		categorias.addItem("0-Sin padre");

		for (int i = 0; i < c.size(); i++) {
			categorias.addItem(c.get(i).getID() + "-" + c.get(i).getNombre());
		}
		categorias.setSelectedIndex(0);

	}

	@Override
	public void mouseClicked(MouseEvent e) {
		if (e.getSource() == btnAceptar) {

			int idCategoria = Integer.parseInt(((String) categorias.getSelectedItem()).split("-")[0]);

			
			interfaz.crearNuevaCategoria(nombre.getText(), slPrioridad.getValue(), idCategoria, campo.getText());
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
			intPrioridad.setText(fps + "");
			System.out.println(fps);

		}

	}
}
