package Interfaz;

import javax.swing.*;

import Mundo.BaseDatos;

import java.awt.*;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.util.ArrayList;
import java.util.Calendar;

public class InterfazCrearProyecto extends JFrame implements MouseListener {

	private Dibujo contenedora;
	private BaseDatos principal;
	private JTextField txtNombre;
	private JTextField txtFechaInicial;
	private JTextField txtFechaFinal;
	private JLabel color;
	private JLabel btnColor;
	private JLabel btnAceptar;
	private JLabel btnCancelar;
	private JComboBox<String> diaInicial;
	private JComboBox<String> diaFinal;
	private JComboBox<String> mesInicial;
	private JComboBox<String> mesFinal;

	private JComboBox<String> gerente;

	private InterfazPrueba interfaz;

	public class PanelColor extends JDialog implements MouseListener {
		private JLabel[] colores;
		private Dibujo contenedora;
		InterfazCrearProyecto crear;

		public PanelColor(InterfazCrearProyecto crear, BaseDatos principal) {

			this.setBounds(390, 377, 102, 42);
			this.setLayout(null);
			this.setUndecorated(true);
			contenedora = new Dibujo("Imagenes/FondoBase.png", 102, 42);
			contenedora.setBounds(0, 0, 102, 42);
			this.add(contenedora);
			colores = new JLabel[10];
			this.crear = crear;

			int x = 1;
			int y = 1;
			for (int i = 0; i < colores.length; i++) {

				colores[i] = new JLabel();
				colores[i].setBounds(x, y, 20, 20);
				colores[i].setOpaque(true);
				colores[i].setBackground(principal.getColores().get(i));
				colores[i].addMouseListener(this);

				contenedora.add(colores[i]);
				x += 20;

				if (i == 4) {
					x = 1;
					y = 21;
				}

			}

		}

		@Override
		public void mouseClicked(MouseEvent e) {

			for (int i = 0; i < colores.length; i++) {
				if (e.getSource() == colores[i]) {
					crear.cambiarColor(colores[i].getBackground());
					dispose();

				}

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

	}

	public InterfazCrearProyecto(InterfazPrueba interfaz, BaseDatos principal,int consecutivo) {

		this.setUndecorated(true);
		this.setLayout(null);
		contenedora = new Dibujo("Imagenes/FondoCrearProyecto.png", 400, 400);
		this.principal = principal;
		this.interfaz = interfaz;

		Font fuente = new Font("Arial", Font.BOLD, 13);

		txtNombre = new JTextField(20);
		txtNombre.setBounds(120, 73, 220, 20);
		txtNombre.setText("Proyecto "+consecutivo);
		txtNombre.setFont(fuente);

		Calendar c1 = Calendar.getInstance();
		int dia = c1.get(Calendar.DATE);
		int mes = c1.get(Calendar.MONTH);
		int annio = c1.get(Calendar.YEAR);

		diaInicial = new JComboBox<>();
		diaInicial.setBounds(120, 129, 60, 20);

		diaFinal = new JComboBox<>();
		diaFinal.setBounds(120, 185, 60, 20);

		mesInicial = new JComboBox<>();
		mesInicial.setBounds(200, 129, 60, 20);

		mesFinal = new JComboBox<>();
		mesFinal.setBounds(200, 185, 60, 20);

		llenarDias();
		llenarMeses();

		diaInicial.setSelectedIndex(dia - 1);
		diaFinal.setSelectedIndex(dia - 1);
		mesInicial.setSelectedIndex(mes);
		mesFinal.setSelectedIndex(mes);

		txtFechaInicial = new JTextField(10);
		txtFechaInicial.setBounds(280, 129, 60, 20);
		txtFechaInicial.setText("2017");
		txtFechaInicial.setFont(fuente);

		txtFechaFinal = new JTextField(20);
		txtFechaFinal.setBounds(280, 185, 60, 20);
		txtFechaFinal.setText("2017");
		txtFechaFinal.setFont(fuente);

		gerente = new JComboBox<>();
		gerente.setBounds(120, 239, 220, 20);
		agregarGerentes();

		color = new JLabel();
		color.setBounds(120, 297, 220, 20);
		color.setOpaque(true);
		color.setBackground(new Color(103, 188, 200));

		btnColor = new JLabel();
		btnColor.setBounds(320, 297, 20, 20);
		btnColor.setIcon(convertirTamanho("Imagenes/Botones/EditarColor.png", 20, 20));
		btnColor.addMouseListener(this);

		btnAceptar = new JLabel();
		btnAceptar.setBounds(48, 347, 145, 45);
		btnAceptar.setIcon(convertirTamanho("Imagenes/Botones/AceptarNuevoProyecto.png", 145, 45));
		btnAceptar.addMouseListener(this);
		btnAceptar.setCursor(new Cursor(Cursor.HAND_CURSOR));

		btnCancelar = new JLabel();
		btnCancelar.setBounds(208, 347, 145, 45);
		btnCancelar.setIcon(convertirTamanho("Imagenes/Botones/CancelarNuevoProyecto.png", 145, 45));
		btnCancelar.addMouseListener(this);
		btnCancelar.setCursor(new Cursor(Cursor.HAND_CURSOR));

		contenedora.add(txtNombre);
		contenedora.add(txtFechaInicial);
		contenedora.add(txtFechaFinal);
		contenedora.add(gerente);
		contenedora.add(btnColor);
		contenedora.add(color);
		contenedora.add(diaInicial);
		contenedora.add(diaFinal);
		contenedora.add(mesInicial);
		contenedora.add(mesFinal);
		contenedora.add(btnAceptar);
		contenedora.add(btnCancelar);

		setSize(400, 400);
		this.setDefaultCloseOperation(EXIT_ON_CLOSE);
		this.setLocationRelativeTo(null);
		contenedora.setBounds(0, 0, 400, 400);
		add(contenedora);
	}

	public void cambiarColor(Color background) {

		color.setBackground(background);
		this.setEnabled(true);

	}

	private void llenarMeses() {

		for (int i = 0; i < 12; i++) {

			mesInicial.addItem(Integer.toString(i + 1));
			mesFinal.addItem(Integer.toString(i + 1));
		}

	}

	private void llenarDias() {
		for (int i = 0; i < 31; i++) {

			diaInicial.addItem(Integer.toString(i + 1));
			diaFinal.addItem(Integer.toString(i + 1));
		}

	}

	private void agregarGerentes() {
		ArrayList<String> gerentes;
		try {
			gerentes = principal.darGerentes();
			for (int i = 0; i < gerentes.size(); i++) {

				gerente.addItem(gerentes.get(i));

			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	@Override
	public void mouseClicked(MouseEvent e) {

		if (e.getSource() == btnColor) {

			PanelColor p = new PanelColor(this, principal);
			p.setVisible(true);
			this.setEnabled(false);
		} else if (e.getSource() == btnAceptar) {

			String nombre = txtNombre.getText();
			String fechaInicio = diaInicial.getSelectedItem() + "/" + mesInicial.getSelectedItem() + "/"
					+ txtFechaInicial.getText();
			String fechaFin = diaFinal.getSelectedItem() + "/" + mesFinal.getSelectedItem() + "/"
					+ txtFechaFinal.getText();
			System.out.println(fechaInicio);
			System.out.println(fechaFin);
			Color col = color.getBackground();
			String g = (String) gerente.getSelectedItem();
			
			String[] compGerente = g.split(",");

			int idGerente = Integer.parseInt(compGerente[1]);

			try {
				interfaz.agregarProyecto(nombre, fechaInicio, fechaFin, idGerente, col);
				JOptionPane.showMessageDialog(null, "Proyecto creado satisfactoriamente");
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

}
