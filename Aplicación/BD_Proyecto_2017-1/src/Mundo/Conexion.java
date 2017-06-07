package Mundo;

import java.awt.image.renderable.ContextualRenderedImageFactory;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.Date;

import oracle.jdbc.driver.OracleTypes;

public class Conexion {
	public static void main(String[] args) {
		Conexion c = new Conexion("P09551_1_10", "1144204109");
		try {
			// Actividad ac = c.fConsultarActividad(11, 667890);
			// System.out.println(ac.getDescripcion() + " " + ac.getNombre());

			// ArrayList<String> x = c.fConsultarDependencias(0, 0);
			// for (String v : x) {
			// System.out.println(v);
			// }
			Estado x = c.fConsultarEstado(1088);
			System.out.println(x.getNombre());

			// Estado x=c.consultarEstado(1053);
			// System.out.println(x.getNombre()+"--"+x.getDescripcion());
			//
			// ArrayList<Proyecto> pts= c.darProyectos();
			//
			// for (Proyecto v : pts) {
			// System.out.println(
			// v.getNombre() + " " + v.getFechaFin() + " " + v.getFechaInicio()+
			// " ID: " + v.getID());
			// }

		} catch (Exception e) {
			System.out.println(e.getMessage());
			;
		}

	}

	public static String PKCONSULTA = "pkConsultaNivel3";
	public static String PKCLASIFICACION = "pkClasificacionNivel3";
	public static String PKMODIFICACION = "pkmodificacionnivel3";
	public static String PKREGISTRO = "pkRegistroNivel3";

	private Connection conection;
	private String user;
	private String password;

	public Conexion(String usuario, String contraseña) {
		user = usuario;
		password = contraseña;
	}

	public void conectarBD() throws SQLException {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conection = DriverManager.getConnection("jdbc:oracle:thin:@172.16.0.103:1522:ESTUD", user, password);
			System.out.println("¡conexión establecida!");
		} catch (ClassNotFoundException e) {
			System.out.println("¡Oracle JDBC Driver no encontrado!");
			e.printStackTrace();
		}
	}

	public Proyecto fConsultarProyecto(int idProyecto) throws Exception {
		Proyecto proyecto = null;
		conectarBD();
		String consulta = SqlTools.buildFunctionCall(PKCONSULTA, "fConsultarProyecto", 3);
		CallableStatement stm = conection.prepareCall(consulta);
		stm.registerOutParameter(1, OracleTypes.CURSOR);
		stm.setInt(2, idProyecto);
		stm.registerOutParameter(3, Types.NUMERIC);
		stm.registerOutParameter(4, Types.VARCHAR);
		stm.execute();
		ResultSet proyectors = (ResultSet) stm.getObject(1);
		if (proyectors.next()) {
			int cod = stm.getInt(3);
			String msj = stm.getString(4);
			if (cod != 0) {
				throw new Exception("Error(" + cod + "): " + msj);
			}
			int id = proyectors.getInt("id");
			String nombre = proyectors.getString("nombre");
			Date fechaInicio = proyectors.getDate("fecha_inicio");
			Date fechaFin = proyectors.getDate("fecha_fin");
			int gerente = proyectors.getInt("gerentes_id");
			proyecto = new Proyecto(id, nombre, fechaInicio, fechaFin, gerente);
		}
		SqlTools.close(proyectors, stm, conection);

		return proyecto;
	}

	public Gerente fConsultarGerente(int idGerente) throws Exception {
		Gerente gerente = null;

		conectarBD();
		String consulta = SqlTools.buildFunctionCall(PKCONSULTA, "fConsultarGerente", 3);
		CallableStatement stm = conection.prepareCall(consulta);
		stm.registerOutParameter(1, OracleTypes.CURSOR);
		stm.setInt(2, idGerente);
		stm.registerOutParameter(3, Types.NUMERIC);
		stm.registerOutParameter(4, Types.VARCHAR);
		stm.execute();
		ResultSet gerentes = (ResultSet) stm.getObject(1);
		if (gerentes.next()) {
			int cod = stm.getInt(3);
			String msj = stm.getString(4);
			if (cod != 0) {
				throw new Exception("Error(" + cod + "): " + msj);
			}
			int id = gerentes.getInt("id");
			String nombre = gerentes.getString("nombre");
			String telefono = gerentes.getString("telefono");
			gerente = new Gerente(id, nombre, telefono);
		}
		SqlTools.close(gerentes, stm, conection);

		return gerente;
	}

	public Estado fConsultarEstado(int idEstado) throws Exception {
		Estado estado = null;

		conectarBD();
		String consulta = SqlTools.buildFunctionCall(PKCONSULTA, "fConsultarEstados", 3);
		CallableStatement stm = conection.prepareCall(consulta);
		stm.registerOutParameter(1, OracleTypes.CURSOR);
		stm.setInt(2, idEstado);
		stm.registerOutParameter(3, Types.NUMERIC);
		stm.registerOutParameter(4, Types.VARCHAR);
		stm.execute();
		ResultSet Estados = (ResultSet) stm.getObject(1);
		if (Estados.next()) {
			int cod = stm.getInt(3);
			String msj = stm.getString(4);
			if (cod != 0) {
				throw new Exception("Error(" + cod + "): " + msj);
			}
			int id = Estados.getInt("Consecutivo");
			String nombre = Estados.getString("nombre");
			String descripcion = Estados.getString("Descripcion");

			estado = new Estado(id, nombre, descripcion);
		}
		SqlTools.close(Estados, stm, conection);
		return estado;
	}

	public Actividad fConsultarActividad(int iDActividad, int idProyecto) throws Exception {

		Actividad act = null;
		conectarBD();

		String consulta = SqlTools.buildFunctionCall(PKCONSULTA, "fConsultarActividad", 4);
		CallableStatement stm = conection.prepareCall(consulta);

		stm.registerOutParameter(1, OracleTypes.CURSOR);
		stm.setInt(2, idProyecto);
		stm.setInt(3, iDActividad);
		stm.registerOutParameter(4, Types.NUMERIC);
		stm.registerOutParameter(5, Types.VARCHAR);
		stm.execute();

		ResultSet actividad = (ResultSet) stm.getObject(1);
		if (actividad.next()) {
			int cod = stm.getInt(4);
			String msj = stm.getString(5);
			if (cod != 0) {
				throw new Exception("Error(" + cod + "): " + msj);
			}
			act = new Actividad(actividad.getInt(1), actividad.getInt(2), actividad.getDate(3), actividad.getDate(4),
					actividad.getString(5), actividad.getString(6), actividad.getString(7), actividad.getInt(8),
					actividad.getInt(9), actividad.getInt(10), actividad.getInt(11));
		}
		SqlTools.close(actividad, stm, conection);
		return act;
	}

	public ArrayList<String> fConsultarDependencias(int Prerequisito, int Dependiente) throws Exception {
		ArrayList<String> Dependencias = new ArrayList<String>();
		conectarBD();

		String consulta = SqlTools.buildFunctionCall(PKCONSULTA, "fConsultarDependencias", 4);
		CallableStatement stm = conection.prepareCall(consulta);
		stm.registerOutParameter(1, OracleTypes.CURSOR);
		stm.setInt(2, Prerequisito);
		stm.setInt(3, Dependiente);
		stm.registerOutParameter(4, Types.NUMERIC);
		stm.registerOutParameter(5, Types.VARCHAR);
		stm.execute();

		ResultSet cursorDependencias = (ResultSet) stm.getObject(1);
		int cod = stm.getInt(4);
		String msj = stm.getString(5);
		if (cod == 1)
			throw new Exception("Error(" + cod + "): " + msj);
		while (cursorDependencias.next()) {
			Dependencias.add(cursorDependencias.getInt(1) + "," + cursorDependencias.getInt(2));
		}
		SqlTools.close(cursorDependencias, stm, conection);

		return Dependencias;
	}

	public Categoria fConsultarCategoria(int idCategoria) throws Exception {
		Categoria categoria = null;
		conectarBD();

		String consulta = SqlTools.buildFunctionCall(PKCONSULTA, "fConsultarCategoria", 3);
		CallableStatement stm = conection.prepareCall(consulta);
		stm.registerOutParameter(1, OracleTypes.CURSOR);
		stm.setInt(2, idCategoria);
		stm.registerOutParameter(3, Types.NUMERIC);
		stm.registerOutParameter(4, Types.VARCHAR);
		stm.execute();

		ResultSet respCategoria = (ResultSet) stm.getObject(1);
		int cod = stm.getInt(3);
		String msj = stm.getString(4);
		if (cod == 1)
			throw new Exception("Error(" + cod + "): " + msj);
		if (respCategoria.next()) {
			int id = respCategoria.getInt("Id");
			String nombre = respCategoria.getString("Nombre");
			String descripcion = respCategoria.getString("Descripcion");
			int peso = respCategoria.getInt("peso");
			int idCategoriaPadre = respCategoria.getInt("categorias_id");
			categoria = new Categoria(id, nombre, descripcion, peso, idCategoriaPadre);
		}
		SqlTools.close(respCategoria, stm, conection);

		return categoria;
	}

	@SuppressWarnings("deprecation")
	public ArrayList<Actividad> fFiltrarActividadesPorProyecto(Date fechaVencimiento, String descripcion, int prioridad,
			int IDActividad) throws Exception {

		ArrayList<Actividad> retornoActividades = new ArrayList<Actividad>();
		conectarBD();

		String consulta = SqlTools.buildFunctionCall(PKMODIFICACION, "fbuscaractividades", 6);
		CallableStatement stm = conection.prepareCall(consulta);

		stm.registerOutParameter(1, OracleTypes.CURSOR);
		if (fechaVencimiento != null)
			stm.setDate(2, new java.sql.Date(fechaVencimiento.getYear(), fechaVencimiento.getMonth(),
					fechaVencimiento.getDay()));
		else
			stm.setDate(2, null);
		stm.setString(3, descripcion);
		stm.setInt(4, prioridad);
		stm.setInt(5, IDActividad);
		stm.registerOutParameter(6, Types.NUMERIC);
		stm.registerOutParameter(7, Types.VARCHAR);

		stm.execute();

		ResultSet cursorActividades = (ResultSet) stm.getObject(1);
		int cod = stm.getInt(6);
		String msj = stm.getString(7);
		if (cod != 0)
			throw new Exception("Error(" + cod + "): " + msj);
		while (cursorActividades.next()) {
			retornoActividades.add(new Actividad(cursorActividades.getInt("ID"),
					Integer.parseInt(cursorActividades.getString("PRIORIDAD")),
					cursorActividades.getDate("FECHA_INICIO"), cursorActividades.getDate("Fecha_fin"),
					cursorActividades.getString("Descripcion"), cursorActividades.getString("Nombre"),
					cursorActividades.getString("Temporalidad"), cursorActividades.getInt("Cantidadrepeticiones"),
					cursorActividades.getInt("Proyectos_id"), cursorActividades.getInt("Estados_consecutivo"),
					cursorActividades.getInt("Categorias_Id")));
		}
		SqlTools.close(cursorActividades, stm, conection);

		return retornoActividades;

	}

	public ArrayList<Actividad> fDarActividades(int idProyecto) throws Exception {
		ArrayList<Actividad> total = new ArrayList<Actividad>();

		conectarBD();

		String consulta = SqlTools.buildFunctionCall(PKCONSULTA, "fDarActividades", 3);
		CallableStatement stm = conection.prepareCall(consulta);

		stm.registerOutParameter(1, OracleTypes.CURSOR);
		stm.setInt(2, idProyecto);
		stm.registerOutParameter(3, Types.NUMERIC);
		stm.registerOutParameter(4, Types.VARCHAR);
		stm.execute();

		ResultSet cursorActividades = (ResultSet) stm.getObject(1);
		int cod = stm.getInt(3);
		String msj = stm.getString(4);
		if (cod != 0)
			throw new Exception("Error(" + cod + "): " + msj);
		while (cursorActividades.next()) {
			total.add(new Actividad(cursorActividades.getInt("ID"),
					Integer.parseInt(cursorActividades.getString("PRIORIDAD")),
					cursorActividades.getDate("FECHA_INICIO"), cursorActividades.getDate("Fecha_fin"),
					cursorActividades.getString("Descripcion"), cursorActividades.getString("Nombre"),
					cursorActividades.getString("Temporalidad"), cursorActividades.getInt("Cantidadrepeticiones"),
					cursorActividades.getInt("Proyectos_id"), cursorActividades.getInt("Estados_consecutivo"),
					cursorActividades.getInt("Categorias_Id")));
		}
		SqlTools.close(cursorActividades, stm, conection);

		return total;
	}

	public ArrayList<Proyecto> fDarProyectos() throws Exception {
		ArrayList<Proyecto> total = new ArrayList<Proyecto>();

		conectarBD();

		String consulta = SqlTools.buildFunctionCall(PKCONSULTA, "fDarProyectos", 2);
		CallableStatement stm = conection.prepareCall(consulta);

		stm.registerOutParameter(1, OracleTypes.CURSOR);
		stm.registerOutParameter(2, Types.NUMERIC);
		stm.registerOutParameter(3, Types.VARCHAR);
		stm.execute();

		ResultSet cursorProyecto = (ResultSet) stm.getObject(1);
		int cod = stm.getInt(2);
		String msj = stm.getString(3);
		if (cod != 0)
			throw new Exception("Error(" + cod + "): " + msj);
		while (cursorProyecto.next()) {
			int id = cursorProyecto.getInt("id");
			String nombre = cursorProyecto.getString("nombre");
			Date fechaInicio = cursorProyecto.getDate("fecha_inicio");
			Date fechaFin = cursorProyecto.getDate("fecha_fin");
			int gerente = cursorProyecto.getInt("gerentes_id");
			total.add(new Proyecto(id, nombre, fechaInicio, fechaFin, gerente));
		}
		SqlTools.close(cursorProyecto, stm, conection);

		return total;
	}

	public ArrayList<Gerente> fDarGerentes() throws Exception {
		ArrayList<Gerente> retornoGerentes = new ArrayList<Gerente>();
		conectarBD();

		String consulta = SqlTools.buildFunctionCall(PKCONSULTA, "fDarGerentes", 2);
		CallableStatement stm = conection.prepareCall(consulta);

		stm.registerOutParameter(1, OracleTypes.CURSOR);
		stm.registerOutParameter(2, Types.NUMERIC);
		stm.registerOutParameter(3, Types.VARCHAR);
		stm.execute();

		ResultSet cursorGerente = (ResultSet) stm.getObject(1);
		int cod = stm.getInt(2);
		String msj = stm.getString(3);
		if (cod != 0)
			throw new Exception("Error(" + cod + "): " + msj);
		while (cursorGerente.next()) {
			retornoGerentes.add(new Gerente(cursorGerente.getInt("Id"), cursorGerente.getString("Nombre"),
					cursorGerente.getString("Telefono")));
		}
		SqlTools.close(cursorGerente, stm, conection);

		return retornoGerentes;
	}

	public ArrayList<Estado> fDarEstados() throws Exception {
		ArrayList<Estado> retornoEstados = new ArrayList<Estado>();
		conectarBD();

		String consulta = SqlTools.buildFunctionCall(PKCONSULTA, "fDarEstados", 2);
		CallableStatement stm = conection.prepareCall(consulta);

		stm.registerOutParameter(1, OracleTypes.CURSOR);
		stm.registerOutParameter(2, Types.NUMERIC);
		stm.registerOutParameter(3, Types.VARCHAR);
		stm.execute();

		ResultSet cursorEstados = (ResultSet) stm.getObject(1);
		int cod = stm.getInt(2);
		String msj = stm.getString(3);
		if (cod != 0)
			throw new Exception("Error(" + cod + "): " + msj);
		while (cursorEstados.next()) {
			retornoEstados.add(new Estado(cursorEstados.getInt("Consecutivo"), cursorEstados.getString("Nombre"),
					cursorEstados.getString("Descripcion")));
		}
		SqlTools.close(cursorEstados, stm, conection);

		return retornoEstados;
	}

	public ArrayList<Categoria> fDarCategorias() throws Exception {
		ArrayList<Categoria> retoroCategoria = new ArrayList<Categoria>();
		conectarBD();

		String consulta = SqlTools.buildFunctionCall(PKCONSULTA, "fDarCategorias", 2);
		CallableStatement stm = conection.prepareCall(consulta);

		stm.registerOutParameter(1, OracleTypes.CURSOR);
		stm.registerOutParameter(2, Types.NUMERIC);
		stm.registerOutParameter(3, Types.VARCHAR);
		stm.execute();

		ResultSet cursorCate = (ResultSet) stm.getObject(1);
		int cod = stm.getInt(2);
		String msj = stm.getString(3);
		if (cod != 0)
			throw new Exception("Error(" + cod + "): " + msj);
		while (cursorCate.next()) {
			int iD = cursorCate.getInt("ID");
			String nombre = cursorCate.getString("Nombre");
			String descripcion = cursorCate.getString("Descripcion");
			int peso = cursorCate.getInt("peso");
			int idCategoriaPadre = cursorCate.getInt("Categorias_id");
			retoroCategoria.add(new Categoria(iD, nombre, descripcion, peso, idCategoriaPadre));
		}
		SqlTools.close(cursorCate, stm, conection);

		return retoroCategoria;
	}

	public ArrayList<String> fDarDependenciasActs() throws Exception {
		ArrayList<String> retornoDependencias = new ArrayList<String>();
		conectarBD();

		String consulta = SqlTools.buildFunctionCall(PKCONSULTA, "fDarDependenciasActs", 2);
		CallableStatement stm = conection.prepareCall(consulta);

		stm.registerOutParameter(1, OracleTypes.CURSOR);
		stm.registerOutParameter(2, Types.NUMERIC);
		stm.registerOutParameter(3, Types.VARCHAR);
		stm.execute();

		ResultSet cursorDepen = (ResultSet) stm.getObject(1);
		int cod = stm.getInt(2);
		String msj = stm.getString(3);
		if (cod != 0)
			throw new Exception("Error(" + cod + "): " + msj);
		while (cursorDepen.next()) {
			retornoDependencias.add(
					cursorDepen.getInt("actividadRequisitoId") + "," + cursorDepen.getInt("actividaddependienteid"));
		}
		SqlTools.close(cursorDepen, stm, conection);

		return retornoDependencias;
	}

	public ArrayList<Categoria> fConsultarCategoriasHijas(int idCategoria) throws Exception {
		ArrayList<Categoria> retornoHijas = new ArrayList<Categoria>();
		conectarBD();

		String consulta = SqlTools.buildFunctionCall(PKCONSULTA, "fConsultarCategoriasHijas", 3);
		CallableStatement stm = conection.prepareCall(consulta);

		stm.registerOutParameter(1, OracleTypes.CURSOR);
		stm.setInt(2, idCategoria);
		stm.registerOutParameter(3, Types.NUMERIC);
		stm.registerOutParameter(4, Types.VARCHAR);
		stm.execute();

		ResultSet cursorHijas = (ResultSet) stm.getObject(1);
		int cod = stm.getInt(3);
		String msj = stm.getString(4);
		if (cod != 0)
			throw new Exception("Error(" + cod + "): " + msj);
		while (cursorHijas.next()) {
			int iD = cursorHijas.getInt("ID");
			String nombre = cursorHijas.getString("Nombre");
			String descripcion = cursorHijas.getString("Descripcion");
			int peso = cursorHijas.getInt("peso");
			int idCategoriaPadre = cursorHijas.getInt("Categorias_id");
			retornoHijas.add(new Categoria(iD, nombre, descripcion, peso, idCategoriaPadre));
		}
		SqlTools.close(cursorHijas, stm, conection);
		return retornoHijas;
	}

	public void pCrearEstado(String nombre, String descripcion) throws Exception {

		conectarBD();

		String consulta = SqlTools.buildProcedureCall(PKREGISTRO, "pInsertarEstados", 4);
		CallableStatement stm = conection.prepareCall(consulta);

		stm.setString(1, nombre);

		stm.setString(2, descripcion);

		stm.registerOutParameter(3, Types.NUMERIC);
		stm.registerOutParameter(4, Types.VARCHAR);
		stm.execute();

		int cod = stm.getInt(3);
		String msj = stm.getString(4);
		if (cod != 0)
			throw new Exception("Error(" + cod + "): " + msj);
		SqlTools.close(null, stm, conection);

	}

	// MADE IN CENTRAL
	@SuppressWarnings("deprecation")
	public void pCrearNuevoProyecto(String nombre, int iDGerente, Date fechaInicio, Date fechaFin) throws Exception {
		conectarBD();

		String consulta = SqlTools.buildProcedureCall(PKREGISTRO, "pInsertarProyecto", 6);
		CallableStatement stm = conection.prepareCall(consulta);

		stm.setString(1, nombre);
		stm.setDate(2, new java.sql.Date(fechaInicio.getYear(), fechaInicio.getMonth(), fechaInicio.getDay()));
		stm.setDate(3, new java.sql.Date(fechaFin.getYear(), fechaFin.getMonth(), fechaFin.getDay()));
		stm.setInt(4, iDGerente);
		stm.registerOutParameter(5, Types.NUMERIC);
		stm.registerOutParameter(6, Types.VARCHAR);
		stm.execute();

		int cod = stm.getInt(5);
		String msj = stm.getString(6);
		if (cod != 0)
			throw new Exception("Error(" + cod + "): " + msj);
		SqlTools.close(null, stm, conection);
	}

	@SuppressWarnings("deprecation")
	public void pCrearNuevaActividad(int prioridad, Date fechaInicio, Date fechaFin, String descripcion, String nombre,
			String temporalidad, int cantidadRepeticiones, int iDEstado, int iDCategoria, int idProyecto)
			throws Exception {
		conectarBD();

		String consulta = SqlTools.buildProcedureCall(PKREGISTRO, "pInsertarActividad", 12);
		CallableStatement stm = conection.prepareCall(consulta);

		stm.setInt(1, prioridad);
		stm.setDate(2, new java.sql.Date(fechaInicio.getYear(), fechaInicio.getMonth(), fechaInicio.getDay()));
		stm.setDate(3, new java.sql.Date(fechaFin.getYear(), fechaFin.getMonth(), fechaFin.getDay()));
		stm.setString(4, descripcion);
		stm.setString(5, nombre);
		stm.setString(6, temporalidad);
		stm.setInt(7, cantidadRepeticiones);
		stm.setInt(8, idProyecto);
		stm.setInt(9, iDEstado);
		stm.setInt(10, iDCategoria);

		stm.registerOutParameter(11, Types.NUMERIC);
		stm.registerOutParameter(12, Types.VARCHAR);
		stm.execute();

		int cod = stm.getInt(11);
		String msj = stm.getString(12);
		if (cod != 0)
			throw new Exception("Error(" + cod + "): " + msj);
		SqlTools.close(null, stm, conection);

	}

	public void pCrearGerente(String nombre, String telefono) throws Exception {
		conectarBD();

		String consulta = SqlTools.buildProcedureCall(PKREGISTRO, "pInsertarGerente", 4);
		CallableStatement stm = conection.prepareCall(consulta);

		stm.setString(1, nombre);
		stm.setString(2, telefono);
		stm.registerOutParameter(3, Types.NUMERIC);
		stm.registerOutParameter(4, Types.VARCHAR);
		stm.execute();

		int cod = stm.getInt(3);
		String msj = stm.getString(4);
		if (cod != 0)
			throw new Exception("Error(" + cod + "): " + msj);
		SqlTools.close(null, stm, conection);
	}

	public void pCrearCategoria(String nombre, String descripcion, int padreID, int prioridad) throws Exception {
		conectarBD();

		String consulta = SqlTools.buildProcedureCall(PKREGISTRO, "pInsertarCategoria", 6);
		CallableStatement stm = conection.prepareCall(consulta);

		stm.setString(1, nombre);
		stm.setInt(2, prioridad);
		stm.setString(3, descripcion);
		stm.setInt(4, padreID);

		stm.registerOutParameter(5, Types.NUMERIC);
		stm.registerOutParameter(6, Types.VARCHAR);
		stm.execute();

		int cod = stm.getInt(5);
		String msj = stm.getString(6);
		if (cod != 0){
			System.out.println(msj);
			throw new Exception("Error(" + cod + "): " + msj);
			}
		SqlTools.close(null, stm, conection);

	}

	public void pCrearDependencias(int idRequ, int idDepen) throws Exception {

		conectarBD();
		String consulta = SqlTools.buildProcedureCall(PKREGISTRO, "pInsertarDependenciasAct", 4);
		CallableStatement stm = conection.prepareCall(consulta);

		stm.setInt(1, idRequ);
		stm.setInt(2, idDepen);
		stm.registerOutParameter(3, Types.NUMERIC);
		stm.registerOutParameter(4, Types.VARCHAR);
		stm.execute();

		int cod = stm.getInt(3);
		String msj = stm.getString(4);
		if (cod != 0)
			throw new Exception("Error(" + cod + "): " + msj);
		SqlTools.close(null, stm, conection);

	}

	public void pCompletarActividad(int id, int iDActividad) {
		// TODO Auto-generated method stub

	}

	public void pBorrarActividad(int id, int iDActividad) throws Exception {
		conectarBD();
		String consulta = SqlTools.buildProcedureCall(PKMODIFICACION, "peliminaractividad", 3);
		CallableStatement stm = conection.prepareCall(consulta);
		stm.setInt(1, iDActividad);
		stm.registerOutParameter(2, Types.NUMERIC);
		stm.registerOutParameter(3, Types.VARCHAR);
		stm.execute();
		int cod = stm.getInt(2);
		String msj = stm.getString(3);
		if (cod != 0)
			throw new Exception("Error(" + cod + "): " + msj);
		SqlTools.close(null, stm, conection);

	}

	public void pBorrarCategoria(int iDCategoria) throws Exception {
		conectarBD();
		String consulta = SqlTools.buildProcedureCall(PKMODIFICACION, "peliminarcategoria", 3);
		CallableStatement stm = conection.prepareCall(consulta);
		stm.setInt(1, iDCategoria);
		stm.registerOutParameter(2, Types.NUMERIC);
		stm.registerOutParameter(3, Types.VARCHAR);
		stm.execute();
		int cod = stm.getInt(2);
		String msj = stm.getString(3);
		if (cod != 0)
			throw new Exception("Error(" + cod + "): " + msj);
		SqlTools.close(null, stm, conection);
	}

	public void pBorrarEstado(int IDEstado) throws Exception {

		conectarBD();
		String consulta = SqlTools.buildProcedureCall(PKMODIFICACION, "peliminarestado", 3);
		CallableStatement stm = conection.prepareCall(consulta);
		stm.setInt(1, IDEstado);
		stm.registerOutParameter(2, Types.NUMERIC);
		stm.registerOutParameter(3, Types.VARCHAR);
		stm.execute();
		int cod = stm.getInt(2);
		String msj = stm.getString(3);
		if (cod != 0)
			throw new Exception("Error(" + cod + "): " + msj);
		SqlTools.close(null, stm, conection);
	}

	public void pBorrarGerente(int IdGerente) throws Exception {

		conectarBD();
		String consulta = SqlTools.buildProcedureCall(PKMODIFICACION, "peliminargerente", 3);
		CallableStatement stm = conection.prepareCall(consulta);
		stm.setInt(1, IdGerente);
		stm.registerOutParameter(2, Types.NUMERIC);
		stm.registerOutParameter(3, Types.VARCHAR);
		stm.execute();
		int cod = stm.getInt(2);
		String msj = stm.getString(3);
		if (cod != 0)
			throw new Exception("Error(" + cod + "): " + msj);
		SqlTools.close(null, stm, conection);
	}

	public void pBorrarProyecto(int IdProyecto) throws Exception {

		conectarBD();
		String consulta = SqlTools.buildProcedureCall(PKMODIFICACION, "peliminarproyecto", 3);
		CallableStatement stm = conection.prepareCall(consulta);
		stm.setInt(1, IdProyecto);
		stm.registerOutParameter(2, Types.NUMERIC);
		stm.registerOutParameter(3, Types.VARCHAR);
		stm.execute();
		int cod = stm.getInt(2);
		String msj = stm.getString(3);
		if (cod != 0)
			throw new Exception("Error(" + cod + "): " + msj);
		SqlTools.close(null, stm, conection);
	}

	public void pBorrarDependenciasActividades(int idRequisito, int idDependiente) throws Exception {

		conectarBD();
		String consulta = SqlTools.buildProcedureCall(PKMODIFICACION, "peliminardependenciasacts", 4);
		CallableStatement stm = conection.prepareCall(consulta);
		stm.setInt(1, idRequisito);
		stm.setInt(2, idDependiente);
		stm.registerOutParameter(3, Types.NUMERIC);
		stm.registerOutParameter(4, Types.VARCHAR);
		stm.execute();
		int cod = stm.getInt(3);
		String msj = stm.getString(4);
		if (cod != 0)
			throw new Exception("Error(" + cod + "): " + msj);
		SqlTools.close(null, stm, conection);
	}

	public void pModificarActividad(int id, int prioridad, Date fechaInicio, Date fechaFin, String descripcion,
			String nombre, String temporalidad, int cantidadRepeticiones, int iDProyecto, int iDEstado, int iDCategoria)
			throws Exception {

		conectarBD();
		String consulta = SqlTools.buildProcedureCall(PKMODIFICACION, "pmodificaractividad", 13);
		CallableStatement stm = conection.prepareCall(consulta);

		stm.setInt(1, id);
		stm.setInt(2, prioridad);
		stm.setInt(9, iDProyecto);
		stm.setDate(3, new java.sql.Date(fechaInicio.getYear(), fechaInicio.getMonth(), fechaInicio.getDay()));
		stm.setDate(4, new java.sql.Date(fechaFin.getYear(), fechaFin.getMonth(), fechaFin.getDay()));
		stm.setString(5, descripcion);
		stm.setString(6, nombre);
		stm.setString(7, temporalidad);
		stm.setInt(8, cantidadRepeticiones);
		stm.setInt(10, iDEstado);
		stm.setInt(11, iDCategoria);

		stm.registerOutParameter(12, Types.NUMERIC);
		stm.registerOutParameter(13, Types.VARCHAR);
		stm.execute();

		int cod = stm.getInt(12);
		String msj = stm.getString(13);
		if (cod != 0)
			throw new Exception("Error(" + cod + "): " + msj);
		SqlTools.close(null, stm, conection);

	}

	public void pModificarCategoria(int id, String nombre, int prioridad, String descrippcion, int idpadre)
			throws Exception {

		conectarBD();
		String consulta = SqlTools.buildProcedureCall(PKMODIFICACION, "pmodificarcategoria", 7);
		CallableStatement stm = conection.prepareCall(consulta);

		stm.setInt(1, id);
		stm.setString(2, nombre);
		stm.setInt(3, prioridad);
		stm.setString(4, descrippcion);
		stm.setInt(5, idpadre);
		stm.registerOutParameter(6, Types.NUMERIC);
		stm.registerOutParameter(7, Types.VARCHAR);
		stm.execute();

		int cod = stm.getInt(6);
		String msj = stm.getString(7);

		if (cod != 0)
			throw new Exception("Error(" + cod + "): " + msj);
		SqlTools.close(null, stm, conection);

	}

	public void pModificarEstados(int id, String nombre, String descripcion) throws Exception {

		conectarBD();
		String consulta = SqlTools.buildProcedureCall(PKMODIFICACION, "pmodificarestados", 5);
		CallableStatement stm = conection.prepareCall(consulta);

		stm.setInt(1, id);
		stm.setString(2, nombre);
		stm.setString(3, descripcion);
		stm.registerOutParameter(4, Types.NUMERIC);
		stm.registerOutParameter(5, Types.VARCHAR);
		stm.execute();

		int cod = stm.getInt(4);
		String msj = stm.getString(5);
		if (cod != 0)
			throw new Exception("Error(" + cod + "): " + msj);
		SqlTools.close(null, stm, conection);

	}

	public void pModificarGerente(String id, String nombre, String telefono) throws Exception {

		conectarBD();
		String consulta = SqlTools.buildProcedureCall(PKMODIFICACION, "pmodificargerente", 5);
		CallableStatement stm = conection.prepareCall(consulta);

		stm.setString(1, id);
		stm.setString(2, nombre);
		stm.setString(3, telefono);
		stm.registerOutParameter(4, Types.NUMERIC);
		stm.registerOutParameter(5, Types.VARCHAR);
		stm.execute();

		int cod = stm.getInt(4);
		String msj = stm.getString(5);
		if (cod != 0)
			throw new Exception("Error(" + cod + "): " + msj);
		SqlTools.close(null, stm, conection);

	}

	public void pModificarProyecto(String id, String nombre, Date fechaInicio, Date fechaFin, String idGerente)
			throws Exception {

		conectarBD();
		String consulta = SqlTools.buildProcedureCall(PKMODIFICACION, "pmodificarproyecto", 7);
		CallableStatement stm = conection.prepareCall(consulta);

		stm.setString(1, id);
		stm.setString(2, nombre);
		stm.setDate(3, new java.sql.Date(fechaInicio.getYear(), fechaInicio.getMonth(), fechaInicio.getDay()));
		stm.setDate(4, new java.sql.Date(fechaFin.getYear(), fechaFin.getMonth(), fechaFin.getDay()));
		stm.setString(5, idGerente);
		stm.registerOutParameter(6, Types.NUMERIC);
		stm.registerOutParameter(7, Types.VARCHAR);
		stm.execute();

		int cod = stm.getInt(6);
		String msj = stm.getString(7);
		if (cod != 0)
			throw new Exception("Error(" + cod + "): " + msj);
		SqlTools.close(null, stm, conection);

	}

	public void pRecalcularPrioridadActividad(int idActividad, int i) throws Exception {
		conectarBD();
		String consulta = SqlTools.buildProcedureCall(PKCLASIFICACION, "pCambiarPrioridadPorRechazo", 4);
		CallableStatement stm = conection.prepareCall(consulta);

		stm.setInt(1, idActividad);
		stm.setInt(2, i);
		stm.registerOutParameter(3, Types.NUMERIC);
		stm.registerOutParameter(4, Types.VARCHAR);
		stm.execute();

		int cod = stm.getInt(3);
		String msj = stm.getString(4);
		if (cod != 0) {
			throw new Exception("Error(" + cod + "): " + msj);
		}

		SqlTools.close(null, stm, conection);
	}

	public Actividad fActividadMayorPrioridad(int idProyecto) throws Exception {
		Actividad act = null;
		conectarBD();

		String consulta = SqlTools.buildFunctionCall(PKCONSULTA, "fActividadMayorPrioridad", 3);
		CallableStatement stm = conection.prepareCall(consulta);

		stm.registerOutParameter(1, OracleTypes.CURSOR);
		stm.setInt(2, idProyecto);
		stm.registerOutParameter(3, Types.NUMERIC);
		stm.registerOutParameter(4, Types.VARCHAR);
		stm.execute();

		ResultSet actividad = (ResultSet) stm.getObject(1);
		if (actividad.next()) {
			int cod = stm.getInt(3);
			String msj = stm.getString(4);
			if (cod != 0) {
				throw new Exception("Error(" + cod + "): " + msj);
			}
			act = new Actividad(actividad.getInt(1), actividad.getInt(2), actividad.getDate(3), actividad.getDate(4),
					actividad.getString(5), actividad.getString(6), actividad.getString(7), actividad.getInt(8),
					actividad.getInt(9), actividad.getInt(10), actividad.getInt(11));
		}
		SqlTools.close(actividad, stm, conection);
		return act;

	}

	public int calcularMaximoIdActividad(int idproyecto) throws Exception {
		return fDarActividades(idproyecto).size();
	}
}