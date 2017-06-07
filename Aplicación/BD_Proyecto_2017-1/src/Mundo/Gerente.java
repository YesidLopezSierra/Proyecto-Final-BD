package Mundo;

public class Gerente {

	private int ID;
	private String nombre;
	private String telefono;

	public Gerente(int iD, String nombre, String telefono) {
		super();
		ID = iD;
		this.nombre = nombre;
		this.telefono = telefono;
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

	public String getTelefono() {
		return telefono;
	}

	public void setTelefono(String telefono) {
		this.telefono = telefono;
	}

}
