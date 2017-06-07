package Auxiliar;

import javax.swing.JTextField;
import javax.swing.text.AttributeSet;
import javax.swing.text.BadLocationException;
import javax.swing.text.PlainDocument;

public class LimitadorCaracteres extends PlainDocument {
	/**
	 * El editor del que estamos limitando caracteres.
	 */
	private JTextField editor;

	/**
	 * N�mero m�ximo de caracteres que deseamos en el editor.
	 */
	private int numeroMaximoCaracteres;

	/**
	 * Crea una instancia de LimitadorCaracteres.
	 * 
	 * @param editor
	 *            Editor en el que se quieren limitar los caracteres.
	 * @param numeroMaximoCaracteres
	 *            N�mero m�ximo de caracteres que queremos en el editor.
	 */
	public LimitadorCaracteres(JTextField editor, int numeroMaximoCaracteres) {
		this.editor = editor;
		this.numeroMaximoCaracteres = numeroMaximoCaracteres;
	}

	/**
	 * M�todo al que llama el editor cada vez que se intenta insertar
	 * caracteres. El m�todo comprueba que no se sobrepasa el l�mite. Si es as�,
	 * llama al m�todo de la clase padre para que se inserten los caracteres. Si
	 * se sobrepasa el l�mite, retorna sin hacer nada.
	 */
	public void insertString(int arg0, String arg1, AttributeSet arg2) throws BadLocationException {
		if ((editor.getText().length() + arg1.length()) > this.numeroMaximoCaracteres)
			return;
		super.insertString(arg0, arg1, arg2);
	}

}