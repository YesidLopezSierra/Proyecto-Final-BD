package Mundo;

import java.awt.Color;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.sql.Date;

public class BaseDatos {

	private Conexion conexion;
	private Proyecto actual;
	private ArrayList<Color> colores;
	private int consecutivoProyecto = 0;
	private ArrayList<String[]> datosInicialesProyecto;

	public BaseDatos() {
		super();

		colores = new ArrayList<>();
		colores.add(new Color(103, 188, 200));// Azul Claro
		colores.add(new Color(153, 50, 204));// Morado
		colores.add(new Color(50, 205, 50));// Verde
		colores.add(new Color(237, 188, 99));// dorado
		colores.add(new Color(250, 128, 114));// salmon
		colores.add(new Color(37, 81, 173));// Azul Oscuro
		colores.add(new Color(250, 38, 32));// Rojo
		colores.add(new Color(175, 238, 238));// Lima
		colores.add(new Color(176, 196, 222));// Gris
		colores.add(new Color(250, 86, 23));// Naranja

		conexion = new Conexion("P09551_1_10", "1144204109");

	}

	public Proyecto seleccionarProyecto(int id) {

		try {
			return conexion.fConsultarProyecto(id);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return null;
	}

	public Actividad darActividadMayorPrioridad(int IDProyecto) throws Exception {

		return conexion.fActividadMayorPrioridad(IDProyecto);
	}

	public ArrayList<Actividad> darActividades(int IDProyecto) {
		try {
			return conexion.fDarActividades(IDProyecto);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return null;

	}

	public void crearNuevoProyecto(String nombre, String fechaInicio, String fechaFin, int IDGerente, Color col)
			throws Exception {

		SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
		java.util.Date parsed = format.parse(fechaInicio);
		java.sql.Date fI = new java.sql.Date(parsed.getTime());

		java.util.Date parsed2 = format.parse(fechaFin);
		java.sql.Date fF = new java.sql.Date(parsed2.getTime());

		conexion.pCrearNuevoProyecto(nombre, IDGerente, fI, fF);

	}

	public ArrayList<Proyecto> darInformacionProyectos() throws Exception {

		ArrayList<Proyecto> proyectos = conexion.fDarProyectos();
		for (Proyecto pr : proyectos) {
			ArrayList<Actividad> total = conexion.fDarActividades(pr.getID());
			int cantidad = total.size();
			int cantidadCompletadas = 0;
			for (Actividad ac : total) {
				if (conexion.fConsultarEstado(ac.getEstado()).getNombre().equalsIgnoreCase("COMPLETADA"))
					cantidadCompletadas++;
			}
			pr.setActividadesTotales(cantidad);
			pr.setActividadesCompletadas(cantidadCompletadas);
		}

		// ArrayList<Proyecto> proyectos = new ArrayList<>();
		// Proyecto p1 = new Proyecto(1, "Proyecto1", new Date(10, 8, 2017), new
		// Date(11, 8, 2017), 1);
		// p1.setActividadesTotales(10);
		// p1.setActividadesCompletadas(5);
		// proyectos.add(p1);
		return proyectos;
	}

	public ArrayList<String> darGerentes() throws Exception {
		ArrayList<String> gerentes = new ArrayList<>();

		ArrayList<Gerente> g = conexion.fDarGerentes();

		for (int i = 0; i < g.size(); i++) {

			gerentes.add(g.get(i).getNombre() + "," + g.get(i).getID());

		}

		return gerentes;
	}

	public ArrayList<Color> getColores() {
		return colores;
	}

	public int getConsecutivoProyecto() {
		return consecutivoProyecto;
	}

	public ArrayList<String[]> getDatosInicialesProyecto() {
		return datosInicialesProyecto;
	}

	public Gerente consultarGerente(int idGerente) {
		// TODO Auto-generated method stub
		try {
			return conexion.fConsultarGerente(idGerente);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return null;
	}

	public Calendar toCalendar(Date date) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		return cal;
	}

	public ArrayList<Categoria> darCategorias() {

		try {
			return conexion.fDarCategorias();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	public ArrayList<Estado> darEstados() {
		try {
			return conexion.fDarEstados();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	public ArrayList<Actividad> darActividades() {
		ArrayList<Actividad> actividades = new ArrayList<>();
		ArrayList<Proyecto> proyectos;
		try {
			proyectos = conexion.fDarProyectos();
			for (int i = 0; i < proyectos.size(); i++) {

				ArrayList<Actividad> a = conexion.fDarActividades(proyectos.get(i).getID());
				if (a != null) {

					actividades.addAll(a);

				}

			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return actividades;
	}

	public Actividad darActividad(int idProyecto, int idActividad) {

		try {
			return conexion.fConsultarActividad(idActividad, idProyecto);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	public Estado darEstado(int idEstado) {

		try {
			return conexion.fConsultarEstado(idEstado);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	public Categoria darCategoria(int idCategoria) {
		try {
			return conexion.fConsultarCategoria(idCategoria);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	public void crearNuevaActividad(int proyectoId, int pId, String pNombre, int pPrioridad, String pTemporalidad,
			int pRepeticiones, String pFechaInicial, String pFechaFinal, int pCategoria, int pEstado,
			String pDescripcion, ArrayList<Integer> prerequisitos) throws ParseException {

		SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
		java.util.Date parsed = format.parse(pFechaInicial);
		java.sql.Date fInicio = new java.sql.Date(parsed.getTime());

		java.util.Date parsed2 = format.parse(pFechaFinal);
		java.sql.Date fFin = new java.sql.Date(parsed2.getTime());

		try {
			conexion.pCrearNuevaActividad(pPrioridad, fInicio, fFin, pDescripcion, pNombre, pTemporalidad,
					pRepeticiones, pEstado, pCategoria, proyectoId);

			if (prerequisitos.size() > 0) {

				for (int i = 0; i < prerequisitos.size(); i++) {

					conexion.pCrearDependencias(prerequisitos.get(i), pId);
				}
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public void modificarActividad(int idProyecto, int idActividad, String pNombre, int pPrioridad,
			String pTemporalidad, int pRepeticiones, String pFechaInicial, String pFechaFinal, int pCategoria,
			int pEstado, String descripcion, ArrayList<Integer> prerequisitos) throws Exception {

		SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
		java.util.Date parsed = format.parse(pFechaInicial);
		java.sql.Date fInicio = new java.sql.Date(parsed.getTime());

		java.util.Date parsed2 = format.parse(pFechaFinal);
		java.sql.Date fFin = new java.sql.Date(parsed2.getTime());

		conexion.pModificarActividad(idActividad, pPrioridad, fInicio, fFin, descripcion, pNombre, pTemporalidad,
				pRepeticiones, idProyecto, pEstado, pCategoria);

	}

	public Actividad skip(int idProyecto, int idActividad) throws Exception {

		conexion.pRecalcularPrioridadActividad(idActividad, 0);
		return darActividadMayorPrioridad(idProyecto);

	}

	public ArrayList<Actividad> filtrarActividades(String pFechaFinal, String pDescripcion, int pPrioridad,
			int idActividad) throws Exception {
		java.sql.Date fInicio;
		if (!pFechaFinal.equals("")) {
			SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
			java.util.Date parsed = format.parse(pFechaFinal);
			fInicio = new java.sql.Date(parsed.getTime());
		} else {
			fInicio = null;
		}
		return conexion.fFiltrarActividadesPorProyecto(fInicio, pDescripcion, pPrioridad, idActividad);
	}

	public void crearNuevaCategoria(String nombre, int prioridad, int padreID, String descripcion) throws Exception {
		conexion.pCrearCategoria(nombre, descripcion, padreID, prioridad);

	}

}
