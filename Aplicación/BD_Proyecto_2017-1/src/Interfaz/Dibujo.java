package Interfaz;

import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.Toolkit;

import javax.swing.JPanel;

public class Dibujo extends JPanel {

	private String imgFondo;
	private int ancho;
	private int alto;

	public void paintComponent(Graphics g) {

		Graphics2D g2 = (Graphics2D) g;

		Toolkit imagen = Toolkit.getDefaultToolkit();
		Image img = imagen.getImage(imgFondo);
		g2.drawImage(img, 0, 0, ancho, alto, this);

		this.repaint();

	}

	public Dibujo(String imgFondo, int ancho, int alto) {

		this.setLayout(null);
		this.imgFondo = imgFondo;
		this.ancho = ancho;
		this.alto = alto;
	}
}