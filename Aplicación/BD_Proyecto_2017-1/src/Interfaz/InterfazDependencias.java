package Interfaz;

import javax.swing.*;

import Mundo.Actividad;
import Mundo.BaseDatos;

import java.awt.*;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.util.ArrayList;

public class InterfazDependencias extends JFrame implements MouseListener {

	private BaseDatos principal;
	private Dibujo contenedora;
	private JList<String> listaActividades;
	private JList<String> listaSeleccionadas;
	private JLabel btnSeleccionar;
	private JLabel btnDeseleccionar;
	private JLabel btnAceptar;
	private JLabel btnCancelar;
	private InterfazProyecto interfaz;

	public InterfazDependencias(InterfazProyecto interfaz, BaseDatos principal, ArrayList<Integer> prerequisitos) {

		this.setLayout(null);
		this.setBounds(890, 420, 400, 290);
		this.setUndecorated(true);
		this.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);

		this.principal = principal;
		this.interfaz = interfaz;
		contenedora = new Dibujo("Imagenes/FondoDependencias.png", 400, 290);
		contenedora.setBounds(0, 0, 400, 290);

		listaActividades = new JList<>();
		// listaActividades.setBounds(22, 61, 156, 196);
		listaActividades.setBackground(new Color(39, 44, 50));
		listaActividades.setForeground(Color.white);
		listaActividades.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
		listaActividades.setLayoutOrientation(JList.VERTICAL);

		JScrollPane scrollPane = new JScrollPane(listaActividades);
		scrollPane.setBounds(22, 61, 156, 196);

		scrollPane.setVerticalScrollBarPolicy(ScrollPaneConstants.VERTICAL_SCROLLBAR_ALWAYS);

		listaSeleccionadas = new JList<>();
		// listaSeleccionadas.setBounds(220, 61, 156, 196);
		listaSeleccionadas.setBackground(new Color(39, 44, 50));
		listaSeleccionadas.setForeground(Color.white);
		listaSeleccionadas.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
		listaSeleccionadas.setLayoutOrientation(JList.VERTICAL);

		JScrollPane scrollPane2 = new JScrollPane(listaSeleccionadas);
		scrollPane2.setBounds(220, 61, 156, 196);

		scrollPane2.setVerticalScrollBarPolicy(ScrollPaneConstants.VERTICAL_SCROLLBAR_ALWAYS);

		cargarActividades(prerequisitos);

		btnSeleccionar = new JLabel();
		btnSeleccionar.setBounds(191, 78, 20, 51);
		btnSeleccionar.addMouseListener(this);
		btnSeleccionar.setIcon(convertirTamanho("Imagenes/Botones/Derecha.png", 20, 51));
		btnSeleccionar.setCursor(new Cursor(Cursor.HAND_CURSOR));

		btnDeseleccionar = new JLabel();
		btnDeseleccionar.setBounds(188, 182, 20, 51);
		btnDeseleccionar.addMouseListener(this);
		btnDeseleccionar.setIcon(convertirTamanho("Imagenes/Botones/Izquierda.png", 20, 51));
		btnDeseleccionar.setCursor(new Cursor(Cursor.HAND_CURSOR));

		btnAceptar = new JLabel();
		btnAceptar.setBounds(89, 263, 94, 22);
		btnAceptar.addMouseListener(this);
		btnAceptar.setIcon(convertirTamanho("Imagenes/Botones/AceptarDependencias.png", 94, 22));
		btnAceptar.setCursor(new Cursor(Cursor.HAND_CURSOR));

		btnCancelar = new JLabel();
		btnCancelar.setBounds(287, 263, 94, 22);
		btnCancelar.addMouseListener(this);
		btnCancelar.setIcon(convertirTamanho("Imagenes/Botones/CancelarDependencias.png", 94, 22));

		btnCancelar.setCursor(new Cursor(Cursor.HAND_CURSOR));
		contenedora.add(scrollPane);
		// contenedora.add(listaActividades);
		contenedora.add(scrollPane2);
		contenedora.add(btnSeleccionar);
		contenedora.add(btnDeseleccionar);
		contenedora.add(btnAceptar);
		contenedora.add(btnCancelar);

		add(contenedora);

	}

	private void cargarActividades(ArrayList<Integer> prerequisitos) {

		ArrayList<Actividad> act = principal.darActividades(0);
		DefaultListModel<String> modelo = new DefaultListModel<String>();
		DefaultListModel<String> modelo2 = new DefaultListModel<>();
		listaSeleccionadas.setModel(modelo2);

		for (int i = 0; i < act.size(); i++) {

			if (prerequisitos.size() > 0 && prerequisitos.contains((Integer) act.get(i).getID())) {

				modelo2.addElement(act.get(i).getID() + "-" + act.get(i).getNombre());
			} else

				modelo.addElement(act.get(i).getID() + "-" + act.get(i).getNombre());
		}

		listaActividades.setModel(modelo);

	}

	@Override
	public void mouseClicked(MouseEvent e) {
		if (e.getSource() == btnSeleccionar) {

			int i = listaActividades.getSelectedIndex();
			DefaultListModel<String> modelo = (DefaultListModel<String>) listaActividades.getModel();
			String sel = modelo.getElementAt(i);

			DefaultListModel<String> modelo2 = (DefaultListModel<String>) listaSeleccionadas.getModel();
			modelo2.addElement(sel);
			listaSeleccionadas.setModel(modelo2);
			modelo.remove(i);
			listaActividades.setModel(modelo);

		} else if (e.getSource() == btnDeseleccionar) {

			int i = listaSeleccionadas.getSelectedIndex();
			DefaultListModel<String> modelo = (DefaultListModel<String>) listaSeleccionadas.getModel();
			String sel = modelo.getElementAt(i);

			DefaultListModel<String> modelo2 = (DefaultListModel<String>) listaActividades.getModel();
			modelo2.addElement(sel);
			listaActividades.setModel(modelo2);
			modelo.remove(i);
			listaSeleccionadas.setModel(modelo);

		} else if (e.getSource() == btnAceptar) {
			ArrayList<Integer> pre = new ArrayList<>();
			DefaultListModel<String> modelo2 = (DefaultListModel<String>) listaSeleccionadas.getModel();
			for (int i = 0; i < modelo2.size(); i++) {

				String[] element = modelo2.getElementAt(i).split("-");
				System.out.println(element.length);
				pre.add(Integer.parseInt(element[0]));
			}

			interfaz.cambiarPrerequisitos(pre);

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
