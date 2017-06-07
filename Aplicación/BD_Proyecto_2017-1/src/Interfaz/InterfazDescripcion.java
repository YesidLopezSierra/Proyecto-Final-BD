package Interfaz;

import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.awt.*;
import javax.swing.*;

public class InterfazDescripcion extends JFrame implements MouseListener {

	private InterfazProyecto interfaz;
	private Dibujo contenedora;
	private JLabel btnAceptar;
	private JLabel btnCancelar;
	private JTextArea texto;

	public InterfazDescripcion(InterfazProyecto interfaz) {

		this.interfaz = interfaz;
		this.setLayout(null);
		this.setBounds(890, 420, 400, 290);
		this.setUndecorated(true);
		this.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
		contenedora = new Dibujo("Imagenes/FondoDescripcion.png", 400, 290);
		contenedora.setBounds(0, 0, 400, 290);

		btnAceptar = new JLabel();
		btnAceptar.setBounds(89, 263, 94, 22);
		btnAceptar.addMouseListener(this);
		btnAceptar.setIcon(convertirTamanho("Imagenes/Botones/AceptarDependencias.png", 94, 22));

		btnCancelar = new JLabel();
		btnCancelar.setBounds(287, 263, 94, 22);
		btnCancelar.addMouseListener(this);
		btnCancelar.setIcon(convertirTamanho("Imagenes/Botones/CancelarDependencias.png", 94, 22));

		btnAceptar.setCursor(new Cursor(Cursor.HAND_CURSOR));
		btnCancelar.setCursor(new Cursor(Cursor.HAND_CURSOR));
		
		texto = new JTextArea();
		texto.setBounds(22, 56, 356, 196);
		texto.setForeground(Color.white);
		texto.setBackground(new Color(39, 44, 50));
		texto.setLineWrap(true);
		texto.setWrapStyleWord(true);

		contenedora.add(btnAceptar);
		contenedora.add(btnCancelar);
		contenedora.add(texto);

		add(contenedora);
	}

	@Override
	public void mouseClicked(MouseEvent e) {

		if (e.getSource() == btnAceptar) {
			
			interfaz.cambiarDescripcion(texto.getText());
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
