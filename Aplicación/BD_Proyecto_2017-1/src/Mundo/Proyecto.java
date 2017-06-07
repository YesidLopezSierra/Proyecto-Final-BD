package Mundo;

import java.util.ArrayList;
import java.util.Date;

public class Proyecto {

	private int ID;
	private String nombre;
	private Date fechaInicio;
	private Date fechaFin;
	private int gerente;
	private int actividadesTotales=0;
	private int actividadesCompletadas=0;
	private ArrayList<Actividad> actividades;


	public Proyecto(int iD, String nombre, Date fechaInicio, Date fechaFin, int gerente) {
		super();
		ID = iD;
		this.nombre = nombre;
		this.fechaInicio = fechaInicio;
		this.fechaFin = fechaFin;
		this.gerente = gerente;
		this.actividades = new ArrayList<>();

	}

	public int getID() {
		return ID;
	}

	public void setID(int iD) {
		ID = iD;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public Date getFechaInicio() {
		return fechaInicio;
	}

	public void setFechaInicio(Date fechaInicio) {
		this.fechaInicio = fechaInicio;
	}

	public Date getFechaFin() {
		return fechaFin;
	}

	public void setFechaFin(Date fechaFin) {
		this.fechaFin = fechaFin;
	}

	public int getGerente() {
		return gerente;
	}

	public void setGerente(int gerente) {
		this.gerente = gerente;
	}

	public ArrayList<Actividad> getActividades() {
		return actividades;
	}

	

	public void setActividades(ArrayList<Actividad> actividades) {
		this.actividades = actividades;
	}

	public int getActividadesTotales() {
		return actividadesTotales;
	}

	public void setActividadesTotales(int actividadesTotales) {
		this.actividadesTotales = actividadesTotales;
	}

	public int getActividadesCompletadas() {
		return actividadesCompletadas;
	}

	public void setActividadesCompletadas(int actividadesCompletadas) {
		this.actividadesCompletadas = actividadesCompletadas;
	}
	
	

}
