package Interfaz;

import javax.swing.*;
import javax.swing.event.ChangeEvent;
import javax.swing.event.ChangeListener;

import Mundo.Actividad;
import Mundo.BaseDatos;
import Mundo.Categoria;
import Mundo.Estado;
import Mundo.Proyecto;

import java.awt.*;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.sql.Date;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Calendar;
import Auxiliar.LimitadorCaracteres;

public class InterfazProyecto extends JFrame implements MouseListener, ChangeListener {

	private Dibujo contenedora;
	private Dibujo contenedora2;
	private JLabel tituloProyecto;
	private JLabel marco;
	private JLabel btnSkip;
	private JLabel btnAceptar;
	private JLabel nombreActividad;
	private JLabel prioridad;
	private JComboBox<String> actividades;
	private JLabel btnBuscar;
	private JLabel btnSeleccionar;
	private JLabel btnNuevo;
	private JLabel imgGerente;
	private JLabel txtGerente;
	private JLabel imgFechaInicio;
	private JLabel txtFechaInicio;
	private JLabel imgFechaFin;
	private JLabel txtFechaFin;
	private BaseDatos principal;

	static final int FPS_MIN = 0;
	static final int FPS_MAX = 99;
	static final int FPS_INIT = 50; // initial frames per second

	private JTextField txtNombre;
	private JSlider slPrioridad = new JSlider(JSlider.HORIZONTAL, FPS_MIN, FPS_MAX, FPS_INIT);
	private JComboBox<String> temporalidad;
	private JComboBox<String> repeticiones;
	private JComboBox<Integer> diaInicial;
	private JComboBox<Integer> mesInicial;
	private JTextField anhoInicial;
	private JComboBox<Integer> diaFinal;
	private JComboBox<Integer> mesFinal;
	private JTextField anhoFinal;
	private JLabel btnCrearCategoria;
	private JComboBox<String> categorias;
	private JComboBox<String> estados;
	private JLabel btnDependencias;
	private JLabel btnDescripcion;
	private JLabel btnAceptar2;
	private JLabel btnCancelar2;

	private ArrayList<Integer> prerequisitos;
	private String descripcion = "";
	private int idProyecto = -1;
	private boolean esCreacion = true;
	private InterfazPrueba p;
	private Proyecto proyecto;
	private int idActividad;

	public InterfazProyecto(InterfazPrueba p, BaseDatos principal, Proyecto proyecto) throws Exception {

		contenedora = new Dibujo("Imagenes/FondoProyecto.png", 400, 400);
		contenedora.setBounds(0, 0, 400, 400);
		contenedora2 = new Dibujo("Imagenes/FondoNuevaActividad.png", 400, 400);
		contenedora2.setBounds(0, 0, 400, 400);
		contenedora2.setVisible(false);
		this.setLayout(null);
		this.setBounds(890, 14, 400, 400);
		this.setUndecorated(true);
		this.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
		this.principal = principal;
		prerequisitos = new ArrayList<>();
		this.p = p;
		this.proyecto = proyecto;

		idProyecto = proyecto.getID();
		Font fuente1 = new Font("Arial", Font.BOLD, 20);
		Font fuente2 = new Font("Arial", Font.BOLD, 25);
		Font fuente3 = new Font("Arial", Font.BOLD, 30);
		Font fuente4 = new Font("Arial", Font.BOLD, 18);

		tituloProyecto = new JLabel(proyecto.getNombre());
		tituloProyecto.setFont(fuente1);
		tituloProyecto.setForeground(Color.white);
		tituloProyecto.setVerticalAlignment(SwingConstants.CENTER);
		tituloProyecto.setHorizontalAlignment(SwingConstants.CENTER);
		tituloProyecto.setBounds(20, 5, 360, 40);
		tituloProyecto.setText(proyecto.getNombre());

		marco = new JLabel();
		marco.setBounds(18, 280, 366, 106);
		marco.setIcon(convertirTamanho("Imagenes/MarcoProyecto.png", 366, 106));

		btnSkip = new JLabel();
		btnSkip.setBounds(260, 338, 100, 35);
		btnSkip.setIcon(convertirTamanho("Imagenes/Botones/SkipProyecto.png", 100, 35));
		btnSkip.setCursor(new Cursor(Cursor.HAND_CURSOR));
		btnSkip.addMouseListener(this);

		btnAceptar = new JLabel();
		btnAceptar.setBounds(154, 338, 100, 35);
		btnAceptar.setIcon(convertirTamanho("Imagenes/Botones/AceptarProyecto.png", 100, 35));
		btnAceptar.setCursor(new Cursor(Cursor.HAND_CURSOR));
		btnAceptar.addMouseListener(this);

		btnBuscar = new JLabel();
		btnBuscar.setBounds(297, 230, 25, 25);
		btnBuscar.setIcon(convertirTamanho("Imagenes/Botones/BuscarActividad.png", 25, 25));
		btnBuscar.addMouseListener(this);
		btnBuscar.setCursor(new Cursor(Cursor.HAND_CURSOR));

		btnSeleccionar = new JLabel();
		btnSeleccionar.setBounds(325, 230, 25, 25);
		btnSeleccionar.addMouseListener(this);
		btnSeleccionar.setIcon(convertirTamanho("Imagenes/Botones/SeleccionarActividad.png", 25, 25));

		btnSeleccionar.setCursor(new Cursor(Cursor.HAND_CURSOR));
		btnNuevo = new JLabel();
		btnNuevo.setBounds(353, 230, 25, 25);
		btnNuevo.setIcon(convertirTamanho("Imagenes/Botones/NuevaActividad.png", 25, 25));
		btnNuevo.addMouseListener(this);
		btnNuevo.setCursor(new Cursor(Cursor.HAND_CURSOR));

		nombreActividad = new JLabel("Actividad 1");
		nombreActividad.setFont(fuente2);
		nombreActividad.setForeground(Color.white);
		nombreActividad.setVerticalAlignment(SwingConstants.CENTER);
		nombreActividad.setHorizontalAlignment(SwingConstants.CENTER);
		nombreActividad.setBounds(20, 290, 360, 40);

		prioridad = new JLabel("99");
		prioridad.setFont(fuente3);
		prioridad.setForeground(Color.white);
		prioridad.setVerticalAlignment(SwingConstants.CENTER);
		prioridad.setHorizontalAlignment(SwingConstants.CENTER);
		prioridad.setBounds(80, 332, 50, 50);

		actividades = new JComboBox<>();
		actividades.setBounds(20, 230, 270, 25);

		imgGerente = new JLabel();
		imgGerente.setBounds(26, 57, 40, 40);
		imgGerente.setIcon(convertirTamanho("Imagenes/Iconos/Gerente1.png", 40, 40));

		imgFechaInicio = new JLabel();
		imgFechaInicio.setBounds(26, 127, 40, 40);
		imgFechaInicio.setIcon(convertirTamanho("Imagenes/Iconos/FechaInicio1.png", 40, 40));

		imgFechaFin = new JLabel();
		imgFechaFin.setBounds(198, 127, 40, 40);
		imgFechaFin.setIcon(convertirTamanho("Imagenes/Iconos/FechaFin1.png", 40, 40));

		txtGerente = new JLabel(principal.consultarGerente(proyecto.getGerente()).getNombre());

		txtGerente.setBounds(90, 65, 250, 32);
		txtGerente.setForeground(Color.WHITE);
		txtGerente.setFont(fuente4);
		txtGerente.setVerticalAlignment(SwingConstants.CENTER);
		txtGerente.setHorizontalAlignment(SwingConstants.CENTER);

		Calendar c = principal.toCalendar((Date) proyecto.getFechaInicio());
		String dia = Integer.toString(c.get(Calendar.DATE));
		String mes = Integer.toString(c.get(Calendar.MONTH) + 1);
		String anho = Integer.toString(c.get(Calendar.YEAR));

		txtFechaInicio = new JLabel(dia + "/" + mes + "/" + anho);
		txtFechaInicio.setBounds(78, 135, 100, 30);
		txtFechaInicio.setForeground(Color.WHITE);
		txtFechaInicio.setFont(fuente4);

		c = principal.toCalendar((Date) proyecto.getFechaFin());
		dia = Integer.toString(c.get(Calendar.DATE));
		mes = Integer.toString(c.get(Calendar.MONTH) + 1);
		anho = Integer.toString(c.get(Calendar.YEAR));

		txtFechaFin = new JLabel(dia + "/" + mes + "/" + anho);
		txtFechaFin.setBounds(250, 135, 100, 30);
		txtFechaFin.setForeground(Color.WHITE);
		txtFechaFin.setFont(fuente4);

		actualizarActividades();
		contenedora.add(tituloProyecto);

		contenedora.add(actividades);
		contenedora.add(btnBuscar);
		contenedora.add(btnNuevo);
		contenedora.add(btnSeleccionar);
		contenedora.add(imgGerente);
		contenedora.add(imgFechaInicio);
		contenedora.add(imgFechaFin);
		contenedora.add(txtGerente);
		contenedora.add(txtFechaInicio);
		contenedora.add(txtFechaFin);

		add(contenedora);

		Font f1 = new Font("Arial", Font.BOLD, 12);
		Calendar c1 = Calendar.getInstance();
		int d = c1.get(Calendar.DATE);
		int m = c1.get(Calendar.MONTH);
		int a = c1.get(Calendar.YEAR);

		txtNombre = new JTextField(20);
		txtNombre.setText("Actividad " + (principal.darActividades(0).size() + 1));
		txtNombre.setFont(new Font("Arial", Font.BOLD, 12));
		txtNombre.setBounds(70, 72, 120, 20);
		txtNombre.setToolTipText("Nombre Actividad");

		slPrioridad.addChangeListener(this);
		slPrioridad.setMajorTickSpacing(10);
		slPrioridad.setMinorTickSpacing(1);
		slPrioridad.setPaintTicks(true);
		slPrioridad.setPaintLabels(true);
		slPrioridad.setBounds(70, 120, 300, 50);
		slPrioridad.setBackground(new Color(33, 44, 50));
		slPrioridad.setForeground(Color.WHITE);
		slPrioridad.setToolTipText("Prioridad");
		slPrioridad.setCursor(new Cursor(Cursor.HAND_CURSOR));

		temporalidad = new JComboBox<>();
		temporalidad.addItem("Diario");
		temporalidad.addItem("Semanal");
		temporalidad.addItem("Mensual");
		temporalidad.addItem("Anual");
		temporalidad.setBounds(245, 72, 80, 20);
		temporalidad.setToolTipText("Temporalidad");

		repeticiones = new JComboBox<>();
		repeticiones.setBounds(335, 72, 45, 20);
		repeticiones.setToolTipText("Número de repeticiones");

		diaInicial = new JComboBox<>();
		diaInicial.setBounds(70, 185, 40, 25);
		diaInicial.setFont(f1);
		diaInicial.setToolTipText("Dia fecha inicial");

		mesInicial = new JComboBox<>();
		mesInicial.setBounds(112, 185, 40, 25);
		mesInicial.setFont(f1);
		mesInicial.setToolTipText("Mes fecha inicial");

		anhoInicial = new JTextField(4);
		anhoInicial.setBounds(154, 185, 44, 25);
		anhoInicial.setFont(f1);
		anhoInicial.setToolTipText("Año fecha inicial");

		diaFinal = new JComboBox<>();
		diaFinal.setBounds(250, 185, 40, 25);
		diaFinal.setFont(f1);
		diaFinal.setToolTipText("Dia fecha Final");

		mesFinal = new JComboBox<>();
		mesFinal.setBounds(292, 185, 40, 25);
		mesFinal.setFont(f1);
		mesFinal.setToolTipText("Mes fecha Final");

		anhoFinal = new JTextField(4);
		anhoFinal.setBounds(334, 185, 44, 25);
		anhoFinal.setFont(f1);
		anhoFinal.setToolTipText("Año fecha Final");

		btnCrearCategoria = new JLabel();
		btnCrearCategoria.setBounds(250, 243, 20, 21);
		btnCrearCategoria.setToolTipText("Nueva Categoria");
		btnCrearCategoria.addMouseListener(this);
		btnCrearCategoria.setIcon(convertirTamanho("Imagenes/Botones/NuevaCategoria.png", 20, 21));

		btnCrearCategoria.setCursor(new Cursor(Cursor.HAND_CURSOR));
		categorias = new JComboBox<>();
		categorias.setBounds(70, 243, 180, 20);
		categorias.setToolTipText("Categorias");
		cargarCategorias();

		estados = new JComboBox<>();
		estados.setBounds(70, 296, 200, 20);
		estados.setToolTipText("Estados");
		cargarEstados();

		btnDependencias = new JLabel();
		btnDependencias.setBounds(324, 242, 62, 27);
		btnDependencias.setToolTipText("Asignar prerequisitos");
		btnDependencias.setIcon(convertirTamanho("Imagenes/Botones/Establecer.png", 62, 27));
		btnDependencias.addMouseListener(this);
		btnDependencias.setCursor(new Cursor(Cursor.HAND_CURSOR));

		btnDescripcion = new JLabel();
		btnDescripcion.setBounds(324, 295, 62, 27);
		btnDescripcion.setToolTipText("Escribir descripción");
		btnDescripcion.setIcon(convertirTamanho("Imagenes/Botones/Establecer.png", 62, 27));
		btnDescripcion.addMouseListener(this);
		btnDescripcion.setCursor(new Cursor(Cursor.HAND_CURSOR));

		btnAceptar2 = new JLabel();
		btnAceptar2.setBounds(29, 354, 142, 40);
		btnAceptar2.setIcon(convertirTamanho("Imagenes/Botones/AceptarNuevaActividad.png", 142, 40));
		btnAceptar2.addMouseListener(this);
		btnAceptar2.setCursor(new Cursor(Cursor.HAND_CURSOR));

		btnCancelar2 = new JLabel();
		btnCancelar2.setBounds(225, 354, 142, 40);
		btnCancelar2.setIcon(convertirTamanho("Imagenes/Botones/CancelarNuevaActividad.png", 142, 40));
		btnCancelar2.addMouseListener(this);
		btnCancelar2.setCursor(new Cursor(Cursor.HAND_CURSOR));

		for (int i = 1; i <= 31; i++) {

			repeticiones.addItem(Integer.toString(i));
			diaInicial.addItem(i);
			diaFinal.addItem(i);
			if (i < 13) {
				mesInicial.addItem(i);
				mesFinal.addItem(i);
			}

		}

		diaInicial.setSelectedIndex(d - 1);
		diaFinal.setSelectedIndex(d - 1);
		mesInicial.setSelectedIndex(m);
		mesFinal.setSelectedIndex(m);
		anhoInicial.setText(Integer.toString(a));
		anhoFinal.setText(Integer.toString(a));
		contenedora2.add(diaInicial);
		contenedora2.add(mesInicial);
		contenedora2.add(anhoInicial);
		contenedora2.add(diaFinal);
		contenedora2.add(mesFinal);
		contenedora2.add(anhoFinal);
		contenedora2.add(txtNombre);
		contenedora2.add(slPrioridad);
		contenedora2.add(temporalidad);
		contenedora2.add(repeticiones);
		contenedora2.add(categorias);
		contenedora2.add(estados);
		contenedora2.add(btnCrearCategoria);
		contenedora2.add(btnDependencias);
		contenedora2.add(btnDescripcion);
		contenedora2.add(btnAceptar2);
		contenedora2.add(btnCancelar2);
		add(contenedora2);
		this.repaint();

	}

	private void cargarCategorias() {

		ArrayList<Categoria> cat = principal.darCategorias();

		for (int i = 0; i < cat.size(); i++) {

			categorias.addItem(Integer.toString(cat.get(i).getID()) + "-" + cat.get(i).getNombre());

		}

	}

	private void cargarEstados() {

		ArrayList<Estado> est = principal.darEstados();

		for (int i = 0; i < est.size(); i++) {

			estados.addItem(Integer.toString(est.get(i).getID()) + "-" + est.get(i).getNombre());

		}

	}

	public ImageIcon convertirTamanho(String image, int x, int y) {

		ImageIcon imagen = new ImageIcon(image);
		Image conversion = imagen.getImage();

		Image tamanho = conversion.getScaledInstance(x, y, Image.SCALE_DEFAULT);
		// TODO Auto-generated method stub
		return new ImageIcon(tamanho);
	}

	public void cargarActividades(ArrayList<Actividad> act) {

		actividades.removeAllItems();
		for (int i = 0; i < act.size(); i++) {

			actividades.addItem(act.get(i).getID() + "-" + act.get(i).getNombre());
		}

	}

	@Override
	public void mouseClicked(MouseEvent e) {

		if (e.getSource() == btnNuevo) {

			contenedora.setVisible(false);
			contenedora2.setVisible(true);
			esCreacion = true;
			Calendar c1 = Calendar.getInstance();
			int d = c1.get(Calendar.DATE);
			int m = c1.get(Calendar.MONTH);
			int a = c1.get(Calendar.YEAR);
			txtNombre.setText("Actividad " + (principal.darActividades(0).size() + 1));
			diaInicial.setSelectedIndex(d - 1);
			diaFinal.setSelectedIndex(d - 1);
			mesInicial.setSelectedIndex(m);
			mesFinal.setSelectedIndex(m);
			anhoInicial.setText(Integer.toString(a));
			anhoFinal.setText(Integer.toString(a));
			estados.setSelectedIndex(0);
			categorias.setSelectedIndex(0);
			temporalidad.setSelectedIndex(0);
			repeticiones.setSelectedIndex(0);

		} else if (e.getSource() == btnSeleccionar) {
			contenedora.setVisible(false);
			contenedora2.setVisible(true);
			esCreacion = false;
			int idActividad = Integer.parseInt(((String) actividades.getSelectedItem()).split("-")[0]);
			Actividad actividad = principal.darActividad(idProyecto, idActividad);
			Categoria categoria = principal.darCategoria(actividad.getCategoria());
			System.out.println(actividad.getEstado());
			Estado estado = principal.darEstado(actividad.getEstado());

			Calendar c = principal.toCalendar((Date) actividad.getFechaInicio());
			int dia = c.get(Calendar.DATE);
			int mes = c.get(Calendar.MONTH);
			String anho = Integer.toString(c.get(Calendar.YEAR));

			diaInicial.setSelectedIndex(dia - 1);
			mesInicial.setSelectedIndex(mes);
			anhoInicial.setText(anho);

			c = principal.toCalendar((Date) actividad.getFechaFin());
			dia = c.get(Calendar.DATE);
			mes = c.get(Calendar.MONTH);
			anho = Integer.toString(c.get(Calendar.YEAR));

			diaFinal.setSelectedIndex(dia - 1);
			mesFinal.setSelectedIndex(mes);
			anhoFinal.setText(anho);

			txtNombre.setText(actividad.getNombre());
			slPrioridad.setValue(actividad.getPrioridad());
			temporalidad.setSelectedItem(actividad.getTemporalidad());
			repeticiones.setSelectedItem(actividad.getCantidadRepeticiones());
			categorias.setSelectedItem(categoria.getID() + "-" + categoria.getNombre());
			estados.setSelectedItem(estado.getID() + "-" + estado.getNombre());
			descripcion = actividad.getDescripcion();

		} else if (e.getSource() == btnDependencias) {

			InterfazDependencias i = new InterfazDependencias(this, principal, prerequisitos);
			i.setVisible(true);
		} else if (e.getSource() == btnDescripcion) {

			InterfazDescripcion i = new InterfazDescripcion(this);
			i.setVisible(true);
		} else if (e.getSource() == btnAceptar2) {

			String pNombre = txtNombre.getText();
			int pPrioridad = slPrioridad.getValue();
			String pTemporalidad = (String) temporalidad.getSelectedItem();
			int pRepeticiones = Integer.parseInt((String) repeticiones.getSelectedItem());
			String pFechaInicial = diaInicial.getSelectedItem() + "/" + mesInicial.getSelectedItem() + "/"
					+ anhoInicial.getText();
			String pFechaFinal = diaFinal.getSelectedItem() + "/" + mesFinal.getSelectedItem() + "/"
					+ anhoFinal.getText();
			int pCategoria = Integer.parseInt(((String) categorias.getSelectedItem()).split("-")[0]);
			int pEstado = Integer.parseInt(((String) estados.getSelectedItem()).split("-")[0]);

			try {
				if (esCreacion) {
					principal.crearNuevaActividad(idProyecto, principal.darActividades(0).size() + 61, pNombre,
							pPrioridad, pTemporalidad, pRepeticiones, pFechaInicial, pFechaFinal, pCategoria, pEstado,
							descripcion, prerequisitos);

					p.actualizarProyectos();
					contenedora2.setVisible(false);
					contenedora.setVisible(true);
					actualizarActividades();
					try {
						cambiarActividadMasprioridad(principal.darActividadMayorPrioridad(idProyecto));
					} catch (Exception e1) {
						JOptionPane.showMessageDialog(null, e1.getMessage(), "ERROR ", JOptionPane.ERROR_MESSAGE);
					}
					JOptionPane.showMessageDialog(null, "Atividad creada satisfactoriamente");
				} else {

					int idActividad = Integer.parseInt(((String) actividades.getSelectedItem()).split("-")[0]);
					try {
						principal.modificarActividad(idProyecto, idActividad, pNombre, pPrioridad, pTemporalidad,
								pRepeticiones, pFechaInicial, pFechaFinal, pCategoria, pEstado, descripcion,
								prerequisitos);
					} catch (Exception e1) {
						JOptionPane.showMessageDialog(null, e1.getMessage(), "ERROR ", JOptionPane.ERROR_MESSAGE);
					}

					p.actualizarProyectos();
					try {
						cambiarActividadMasprioridad(principal.darActividadMayorPrioridad(idProyecto));
					} catch (Exception e1) {
						JOptionPane.showMessageDialog(null, e1.getMessage(), "ERROR ", JOptionPane.ERROR_MESSAGE);
					}
					contenedora2.setVisible(false);
					contenedora.setVisible(true);
					JOptionPane.showMessageDialog(null, "Atividad modificada satisfactoriamente");
				}

			} catch (Exception e1) {
				JOptionPane.showMessageDialog(null, e1.getMessage(), "ERROR ", JOptionPane.ERROR_MESSAGE);
			}

		} else if (e.getSource() == btnCancelar2) {
			descripcion = "";
			prerequisitos = new ArrayList<>();
			contenedora2.setVisible(false);
			contenedora.setVisible(true);

		} else if (e.getSource() == btnAceptar) {
			contenedora.setVisible(false);
			contenedora2.setVisible(true);
			esCreacion = false;
			
			Actividad actividad = principal.darActividad(idProyecto, idActividad);
			Categoria categoria = principal.darCategoria(actividad.getCategoria());
			System.out.println(actividad.getEstado());
			Estado estado = principal.darEstado(actividad.getEstado());

			Calendar c = principal.toCalendar((Date) actividad.getFechaInicio());
			int dia = c.get(Calendar.DATE);
			int mes = c.get(Calendar.MONTH);
			String anho = Integer.toString(c.get(Calendar.YEAR));

			diaInicial.setSelectedIndex(dia - 1);
			mesInicial.setSelectedIndex(mes);
			anhoInicial.setText(anho);

			c = principal.toCalendar((Date) actividad.getFechaFin());
			dia = c.get(Calendar.DATE);
			mes = c.get(Calendar.MONTH);
			anho = Integer.toString(c.get(Calendar.YEAR));

			diaFinal.setSelectedIndex(dia - 1);
			mesFinal.setSelectedIndex(mes);
			anhoFinal.setText(anho);

			txtNombre.setText(actividad.getNombre());
			slPrioridad.setValue(actividad.getPrioridad());
			temporalidad.setSelectedItem(actividad.getTemporalidad());
			repeticiones.setSelectedItem(actividad.getCantidadRepeticiones());
			categorias.setSelectedItem(categoria.getID() + "-" + categoria.getNombre());
			estados.setSelectedItem(estado.getID() + "-" + estado.getNombre());
			descripcion = actividad.getDescripcion();
			
			
			
		} else if (e.getSource() == btnBuscar) {

			InterfazFiltrar i = new InterfazFiltrar(this, principal);
			i.setVisible(true);
		} else if (e.getSource() == btnSkip) {
			if (actividades.getItemCount() > 1) {
				try {
					Actividad a = principal.skip(idProyecto, idActividad);
					cambiarActividadMasprioridad(a);
				} catch (Exception e1) {
					JOptionPane.showMessageDialog(null, e1.getMessage(), "ERROR ", JOptionPane.ERROR_MESSAGE);
				}
			}
		} else if (e.getSource() == btnCrearCategoria) {
			InterfazCrearCategoria i = new InterfazCrearCategoria(this, principal);
			i.setVisible(true);
		}

	}

	private void cambiarActividadMasprioridad(Actividad act) {

		idActividad = act.getID();
		nombreActividad.setText(act.getNombre());
		prioridad.setText(Integer.toString(act.getPrioridad()));

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

	@Override
	public void stateChanged(ChangeEvent e) {
		JSlider source = (JSlider) e.getSource();
		if (!source.getValueIsAdjusting()) {
			int fps = (int) source.getValue();
			System.out.println(fps);

		}

	}

	public void cambiarPrerequisitos(ArrayList<Integer> pre) {
		prerequisitos = pre;

	}

	public void cambiarDescripcion(String text) {

		descripcion = text;
	}

	public void actualizarActividades() {
		Actividad act;
		try {
			act = principal.darActividadMayorPrioridad(proyecto.getID());
			if (act != null) {

				idActividad = act.getID();
				nombreActividad.setText(act.getNombre());
				prioridad.setText(Integer.toString(act.getPrioridad()));

				cargarActividades(principal.darActividades(proyecto.getID()));
				contenedora.add(btnAceptar);
				contenedora.add(btnSkip);
				contenedora.add(marco);
				contenedora.add(prioridad);
				contenedora.add(nombreActividad);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public void cambiarActividades(ArrayList<Actividad> actividades2) {

		actividades.removeAllItems();
		for (int i = 0; i < actividades2.size(); i++) {

			actividades.addItem(actividades2.get(i).getID() + "-" + actividades2.get(i).getNombre());
		}
		// TODO Auto-generated method stub

	}

	public void crearNuevaCategoria(String text, int value, int selectedItem, String text2) {

		try {
			principal.crearNuevaCategoria(text, value, selectedItem, text2);
			actualizarCategorias();
			JOptionPane.showMessageDialog(null, "Categoria creada Satisfactoriamente");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	private void actualizarCategorias() {
		categorias.removeAllItems();
		ArrayList<Categoria> c = principal.darCategorias();

		for (int i = 0; i < c.size(); i++) {
			categorias.addItem(c.get(i).getID() + "-" + c.get(i).getNombre());
		}
		// TODO Auto-generated method stub

	}

}
