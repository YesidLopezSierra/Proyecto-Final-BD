package Mundo;

import java.util.ArrayList;

public class Categoria {

	private int ID;
	private String nombre;
	private String descripcion;
	private double peso;
	private int idCategoriaPadre;

	public Categoria(int iD, String nombre, String descripcion, double peso, int  idPadre) {
		super();
		ID = iD;
		this.nombre = nombre;
		this.descripcion = descripcion;
		this.peso = peso;
		this.idCategoriaPadre=idPadre;
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

	public String getDescripcion() {
		return descripcion;
	}

	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}

	public double getPeso() {
		return peso;
	}

	public void setPeso(double peso) {
		this.peso = peso;
	}

}
