package Interfaz;

import javax.swing.*;

import Mundo.BaseDatos;
import Mundo.Proyecto;

import java.awt.*;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.util.ArrayList;
import java.util.Calendar;

public class InterfazPrueba extends JFrame implements MouseListener {

	private Dibujo contenedora;

	private BaseDatos principal;

	private JLabel fechaActual;
	private JLabel btnOpciones;
	private JLabel lineaProyecto1;
	private JLabel lineaProyecto2;
	private JLabel lineaProyecto3;
	private JLabel cantidadActividades1;
	private JLabel cantidadActividades2;
	private JLabel cantidadActividades3;
	private JLabel cantidadActividadesSinCompletar1;
	private JLabel cantidadActividadesSinCompletar2;
	private JLabel cantidadActividadesSinCompletar3;
	private JLabel circulo1;
	private JLabel circulo2;
	private JLabel circulo3;

	private JLabel btnCrearProyecto;
	private JLabel btnSubirProyecto;
	private JLabel btnBajarProyecto;

	private JLabel nombreProyecto1;
	private JLabel nombreProyecto2;
	private JLabel nombreProyecto3;
	private int max = 0;
	private ArrayList<Proyecto> proyectos;

	public InterfazPrueba(String dia, String mes, String annio) {

		this.setUndecorated(true);
		this.setLayout(null);
		this.setBounds(490,15,394,700);
		contenedora = new Dibujo("Imagenes/Fondo1.png", 394, 700);
		principal = new BaseDatos();

		Color col1 = new Color(200, 205, 211);
		Font fuente1 = new Font("Arial", Font.BOLD, 12);
		Font fuente4 = new Font("Arial", Font.BOLD, 20);
		Font fuente2 = new Font("Arial", Font.BOLD, 30);
		Font fuente3 = new Font("Arial", Font.BOLD, 25);

		fechaActual = new JLabel(mes + " " + dia + ", " + annio);

		fechaActual.setBounds(132, 60, 130, 15);
		fechaActual.setForeground(col1);
		fechaActual.setFont(fuente1);

		fechaActual.setVerticalAlignment(SwingConstants.CENTER);
		fechaActual.setHorizontalAlignment(SwingConstants.CENTER);

		btnOpciones = new JLabel();
		btnOpciones.setBounds(339, 32, 46, 40);
		btnOpciones.setIcon(convertirTamanho("Imagenes/BtnOpciones.png", 46, 40));

		lineaProyecto1 = new JLabel();
		lineaProyecto1.setBounds(24, 80, 346, 3);
		lineaProyecto1.setBackground(new Color(103, 188, 200));
		lineaProyecto1.setOpaque(true);
		lineaProyecto1.setVisible(false);

		lineaProyecto2 = new JLabel();
		lineaProyecto2.setBounds(24, 286, 346, 3);
		lineaProyecto2.setBackground(new Color(175, 238, 238));
		lineaProyecto2.setOpaque(true);
		lineaProyecto2.setVisible(false);

		lineaProyecto3 = new JLabel();
		lineaProyecto3.setBounds(24, 492, 346, 3);
		lineaProyecto3.setBackground(new Color(250, 86, 23));
		lineaProyecto3.setOpaque(true);
		lineaProyecto3.setVisible(false);

		cantidadActividades1 = new JLabel("5,201");
		cantidadActividades1.setBounds(149, 164, 96, 41);
		cantidadActividades1.setFont(fuente2);
		cantidadActividades1.setForeground(col1);
		cantidadActividades1.setVerticalAlignment(SwingConstants.CENTER);
		cantidadActividades1.setHorizontalAlignment(SwingConstants.CENTER);
		cantidadActividades1.addMouseListener(this);
		cantidadActividades1.setVisible(false);
		cantidadActividades1.setCursor(new Cursor(Cursor.HAND_CURSOR));

		cantidadActividades2 = new JLabel("5,201");
		cantidadActividades2.setBounds(149, 370, 96, 41);
		cantidadActividades2.setFont(fuente2);
		cantidadActividades2.setForeground(col1);
		cantidadActividades2.setVerticalAlignment(SwingConstants.CENTER);
		cantidadActividades2.setHorizontalAlignment(SwingConstants.CENTER);
		cantidadActividades2.addMouseListener(this);
		cantidadActividades2.setVisible(false);
		cantidadActividades2.setCursor(new Cursor(Cursor.HAND_CURSOR));

		cantidadActividades3 = new JLabel("5,201");
		cantidadActividades3.setBounds(149, 576, 96, 41);
		cantidadActividades3.setFont(fuente2);
		cantidadActividades3.setForeground(col1);
		cantidadActividades3.setVerticalAlignment(SwingConstants.CENTER);
		cantidadActividades3.setHorizontalAlignment(SwingConstants.CENTER);
		cantidadActividades3.addMouseListener(this);
		cantidadActividades3.setVisible(false);
		cantidadActividades3.setCursor(new Cursor(Cursor.HAND_CURSOR));

		cantidadActividadesSinCompletar1 = new JLabel("2,799");
		cantidadActividadesSinCompletar1.setBounds(282, 158, 69, 30);
		cantidadActividadesSinCompletar1.setFont(fuente3);
		cantidadActividadesSinCompletar1.setForeground(col1);
		cantidadActividadesSinCompletar1.setVerticalAlignment(SwingConstants.CENTER);
		cantidadActividadesSinCompletar1.setHorizontalAlignment(SwingConstants.CENTER);
		cantidadActividadesSinCompletar1.setVisible(false);
		cantidadActividadesSinCompletar1.setCursor(new Cursor(Cursor.HAND_CURSOR));

		cantidadActividadesSinCompletar2 = new JLabel("2,799");
		cantidadActividadesSinCompletar2.setBounds(282, 364, 69, 30);
		cantidadActividadesSinCompletar2.setFont(fuente3);
		cantidadActividadesSinCompletar2.setForeground(col1);
		cantidadActividadesSinCompletar2.setVerticalAlignment(SwingConstants.CENTER);
		cantidadActividadesSinCompletar2.setHorizontalAlignment(SwingConstants.CENTER);
		cantidadActividadesSinCompletar2.setVisible(false);

		cantidadActividadesSinCompletar3 = new JLabel("2,799");
		cantidadActividadesSinCompletar3.setBounds(282, 570, 69, 30);
		cantidadActividadesSinCompletar3.setFont(fuente3);
		cantidadActividadesSinCompletar3.setForeground(col1);
		cantidadActividadesSinCompletar3.setVerticalAlignment(SwingConstants.CENTER);
		cantidadActividadesSinCompletar3.setHorizontalAlignment(SwingConstants.CENTER);
		cantidadActividadesSinCompletar3.setVisible(false);

		circulo1 = new JLabel();
		circulo1.setBounds(125, 110, 145, 145);
		circulo1.setIcon(convertirTamanho("Imagenes/Circulos/1/92.png", 145, 145));
		circulo1.setVisible(false);
		circulo1.setCursor(new Cursor(Cursor.HAND_CURSOR));

		circulo2 = new JLabel();
		circulo2.setBounds(125, 316, 145, 145);
		circulo2.setIcon(convertirTamanho("Imagenes/Circulos/2/8.png", 145, 145));
		circulo2.setVisible(false);
		circulo2.setCursor(new Cursor(Cursor.HAND_CURSOR));

		circulo3 = new JLabel();
		circulo3.setBounds(125, 522, 145, 145);
		circulo3.setIcon(convertirTamanho("Imagenes/Circulos/3/50.png", 145, 145));
		circulo3.setVisible(false);
		circulo3.setCursor(new Cursor(Cursor.HAND_CURSOR));

		btnCrearProyecto = new JLabel();
		btnCrearProyecto.setBounds(29, 31, 42, 42);
		btnCrearProyecto.setIcon(convertirTamanho("Imagenes/Botones/a.png", 42, 42));
		btnCrearProyecto.addMouseListener(this);
		btnCrearProyecto.setCursor(new Cursor(Cursor.HAND_CURSOR));
		btnCrearProyecto.setCursor(new Cursor(Cursor.HAND_CURSOR));

		btnSubirProyecto = new JLabel();
		btnSubirProyecto.setBounds(20, 641, 42, 42);
		btnSubirProyecto.setIcon(convertirTamanho("Imagenes/Botones/SubirProyecto.png", 42, 42));
		btnSubirProyecto.addMouseListener(this);
		btnSubirProyecto.setVisible(false);
		btnSubirProyecto.setCursor(new Cursor(Cursor.HAND_CURSOR));
		btnSubirProyecto.setCursor(new Cursor(Cursor.HAND_CURSOR));

		btnBajarProyecto = new JLabel();
		btnBajarProyecto.setBounds(337, 641, 42, 42);
		btnBajarProyecto.setIcon(convertirTamanho("Imagenes/Botones/BajarProyecto.png", 42, 42));
		btnBajarProyecto.addMouseListener(this);
		btnBajarProyecto.setCursor(new Cursor(Cursor.HAND_CURSOR));
		btnBajarProyecto.setCursor(new Cursor(Cursor.HAND_CURSOR));

		nombreProyecto1 = new JLabel("Proyecto 1");
		nombreProyecto1.setBounds(22, 255, 350, 30);
		nombreProyecto1.setForeground(new Color(103, 188, 200));
		nombreProyecto1.setFont(fuente4);
		nombreProyecto1.setVerticalAlignment(SwingConstants.CENTER);
		nombreProyecto1.setHorizontalAlignment(SwingConstants.CENTER);
		nombreProyecto1.setVisible(false);

		nombreProyecto2 = new JLabel("Proyecto 2");
		nombreProyecto2.setBounds(22, 461, 350, 30);
		nombreProyecto2.setForeground(new Color(175, 238, 238));
		nombreProyecto2.setFont(fuente4);
		nombreProyecto2.setVerticalAlignment(SwingConstants.CENTER);
		nombreProyecto2.setHorizontalAlignment(SwingConstants.CENTER);
		nombreProyecto2.setVisible(false);

		nombreProyecto3 = new JLabel("Proyecto 3");
		nombreProyecto3.setBounds(22, 667, 350, 30);
		nombreProyecto3.setForeground(new Color(250, 86, 23));
		nombreProyecto3.setFont(fuente4);
		nombreProyecto3.setVerticalAlignment(SwingConstants.CENTER);
		nombreProyecto3.setHorizontalAlignment(SwingConstants.CENTER);
		nombreProyecto3.setVisible(false);

		try {
			proyectos = principal.darInformacionProyectos();

			max = proyectos.size() - 1;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		if (max != -1)
			cambiarSiguientesProyecto();

		contenedora.add(fechaActual);
		contenedora.add(btnOpciones);
		contenedora.add(lineaProyecto1);
		contenedora.add(lineaProyecto2);
		contenedora.add(lineaProyecto3);
		contenedora.add(cantidadActividades1);
		contenedora.add(cantidadActividades2);
		contenedora.add(cantidadActividades3);
		contenedora.add(cantidadActividadesSinCompletar1);
		contenedora.add(cantidadActividadesSinCompletar2);
		contenedora.add(cantidadActividadesSinCompletar3);
		contenedora.add(circulo1);
		contenedora.add(circulo2);
		contenedora.add(circulo3);
		contenedora.add(btnCrearProyecto);
		contenedora.add(btnSubirProyecto);
		contenedora.add(btnBajarProyecto);
		contenedora.add(nombreProyecto1);
		contenedora.add(nombreProyecto2);
		contenedora.add(nombreProyecto3);
		setSize(394, 700);
		this.setDefaultCloseOperation(EXIT_ON_CLOSE);
		
		contenedora.setBounds(0, 0, 394, 700);
		add(contenedora);

	}

	public static void main(String[] args) {

		String[] meses = { "ENERO", "FEBRERO", "MARZO", "ABRIL", "MAYO", "JUNIO", "JULIO", "AGOSTO", "SEPTIEMBRE",
				"OCTUBRE", "NOVIEMBRE", "DICIEMBRE" };
		Calendar c1 = Calendar.getInstance();
		String dia = Integer.toString(c1.get(Calendar.DATE));
		String mes = meses[c1.get(Calendar.MONTH)];
		String annio = Integer.toString(c1.get(Calendar.YEAR));

		InterfazPrueba b = new InterfazPrueba(dia, mes, annio);
		b.setVisible(true);

	}

	public ImageIcon convertirTamanho(String image, int x, int y) {

		ImageIcon imagen = new ImageIcon(image);
		Image conversion = imagen.getImage();

		Image tamanho = conversion.getScaledInstance(x, y, Image.SCALE_DEFAULT);
		// TODO Auto-generated method stub
		return new ImageIcon(tamanho);
	}

	@Override
	public void mouseClicked(MouseEvent e) {
		if (e.getSource() == btnCrearProyecto) {

			InterfazCrearProyecto i = new InterfazCrearProyecto(this, principal, proyectos.size());
			i.setVisible(true);
			i.setBounds(80, 100, 400, 400);

		} else if (e.getSource() == cantidadActividades1) {

			InterfazProyecto i;
			try {
				i = new InterfazProyecto(this, principal, proyectos.get(max));

				i.setVisible(true);
			} catch (Exception e1) {
				JOptionPane.showMessageDialog(null, e1.getMessage(), "ERROR ", JOptionPane.ERROR_MESSAGE);
			}
		} else if (e.getSource() == cantidadActividades2) {

			InterfazProyecto i;
			try {
				i = new InterfazProyecto(this, principal, proyectos.get(max - 1));

				i.setVisible(true);
			} catch (Exception e1) {
				JOptionPane.showMessageDialog(null, e1.getMessage(), "ERROR ", JOptionPane.ERROR_MESSAGE);
			}
		} else if (e.getSource() == cantidadActividades3) {

			InterfazProyecto i;
			try {
				i = new InterfazProyecto(this, principal, proyectos.get(max - 2));

				i.setVisible(true);
			} catch (Exception e1) {
				JOptionPane.showMessageDialog(null, e1.getMessage(), "ERROR ", JOptionPane.ERROR_MESSAGE);
			}
		} else if (e.getSource() == btnSubirProyecto) {

			max++;
			if (max == proyectos.size() - 1) {
				btnSubirProyecto.setVisible(false);

			}
			btnBajarProyecto.setVisible(true);
			cambiarSiguientesProyecto();
		} else if (e.getSource() == btnBajarProyecto) {

			max--;
			if (max - 2 == 0) {
				btnBajarProyecto.setVisible(false);

			}
			btnSubirProyecto.setVisible(true);
			cambiarSiguientesProyecto();
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

	public void agregarProyecto(String nombre, String fechaInicio, String fechaFin, int idGerente, Color col)
			throws Exception {

		principal.crearNuevoProyecto(nombre, fechaInicio, fechaFin, idGerente, col);
		actualizarProyectos();
	}

	public void actualizarProyectos() {
		try {
			proyectos = principal.darInformacionProyectos();

			max = proyectos.size() - 1;
			cambiarSiguientesProyecto();

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	private void cambiarSiguientesProyecto() {

		Proyecto proyecto1 = proyectos.get(max);
		lineaProyecto1.setVisible(true);
		cantidadActividades1.setVisible(true);
		cantidadActividadesSinCompletar1.setVisible(true);
		circulo1.setVisible(true);
		nombreProyecto1.setVisible(true);
		Proyecto proyecto2 = null;
		Proyecto proyecto3 = null;
		if (max > 0) {
			lineaProyecto2.setVisible(true);
			cantidadActividades2.setVisible(true);
			cantidadActividadesSinCompletar2.setVisible(true);
			circulo2.setVisible(true);
			nombreProyecto2.setVisible(true);

			proyecto2 = proyectos.get(max - 1);
			if (max > 1) {
				lineaProyecto3.setVisible(true);
				cantidadActividades3.setVisible(true);
				cantidadActividadesSinCompletar3.setVisible(true);
				circulo3.setVisible(true);
				nombreProyecto3.setVisible(true);
				proyecto3 = proyectos.get(max - 2);
			}
		}

		nombreProyecto1.setText(proyecto1.getNombre());
		cantidadActividades1.setText(Integer.toString(proyecto1.getActividadesTotales()));
		cantidadActividadesSinCompletar1
				.setText(Integer.toString(proyecto1.getActividadesTotales() - proyecto1.getActividadesCompletadas()));
		cambiarPorcentajeProyecto(1, proyecto1.getActividadesTotales(), proyecto1.getActividadesCompletadas());

		if (proyecto2 != null) {

			nombreProyecto2.setText(proyecto2.getNombre());
			cantidadActividades2.setText(Integer.toString(proyecto2.getActividadesTotales()));
			cantidadActividadesSinCompletar2.setText(
					Integer.toString(proyecto2.getActividadesTotales() - proyecto2.getActividadesCompletadas()));
			cambiarPorcentajeProyecto(2, proyecto2.getActividadesTotales(), proyecto2.getActividadesCompletadas());

		}

		if (proyecto3 != null) {

			nombreProyecto3.setText(proyecto3.getNombre());
			cantidadActividades3.setText(Integer.toString(proyecto3.getActividadesTotales()));
			cantidadActividadesSinCompletar3.setText(
					Integer.toString(proyecto3.getActividadesTotales() - proyecto3.getActividadesCompletadas()));
			cambiarPorcentajeProyecto(3, proyecto3.getActividadesTotales(), proyecto3.getActividadesCompletadas());

		}
		this.repaint();

	}

	private void cambiarPorcentajeProyecto(int i, int actividadesTotales, int actividadesCompletadas) {

		int total = 0;
		int diferencia = 100;

		if (actividadesTotales > 0) {
			double valorPorActividad = 100 / actividadesTotales;

			double valorTotal = valorPorActividad * actividadesCompletadas;

			int[] posibles = { 0, 8, 17, 25, 33, 42, 50, 58, 67, 75, 83, 92, 100 };

			for (int j = 0; j < posibles.length; j++) {

				int d = Math.abs((int) valorTotal - posibles[j]);

				if (d < diferencia) {

					total = posibles[j];
					diferencia = d;
				}

			}

		}

		if (i == 1) {

			circulo1.setIcon(convertirTamanho("Imagenes/Circulos/" + "1" + "/" + total + ".png", 145, 145));

		} else if (i == 2) {

			circulo2.setIcon(convertirTamanho("Imagenes/Circulos/" + "2" + "/" + total + ".png", 145, 145));

		} else if (i == 3) {

			circulo3.setIcon(convertirTamanho("Imagenes/Circulos/" + "3" + "/" + total + ".png", 145, 145));

		}

	}
}
