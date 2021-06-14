package Utilidades;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class RegEx {
	
	//Comprobación de las expresiones regulares más usadas
	public boolean comprobar(String tipo, boolean espacio, String cadena) {		
		String regEx = null;
		switch(tipo.toLowerCase()) {
			case "texto":
				regEx = espacio ? "^[a-zA-ZáéíóúÁÉÍÓÚñÑ]+(?: [a-zA-ZáéíóúÁÉÍÓÚñÑ]+)*$" : "^[a-zA-ZáéíóúÁÉÍÓÚñÑ]*$";
				break;
			case "entero":
				regEx = "^\\d+$";
				break;
			case "decimal":
				regEx = "^\\d*\\.\\d+$";
				break;
			case "textoynumero":
				regEx = espacio ? "^[a-zA-ZáéíóúÁÉÍÓÚñÑ0-9 ]*$" : "^[a-zA-ZáéíóúÁÉÍÓÚñÑ0-9]*$";
				break;
			case "username":
				regEx = "^[a-z0-9]+$";
				break;
			case "password":
				regEx = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$";
				break;
			case "correo":
				regEx = "(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
				break;
			case "html":
				regEx = "<(\\w+)( +.+)*>((.*))</\\1>";
				break;
			default:
				regEx = ".*";		
				break;
		}
		
		Pattern pattern = Pattern.compile(regEx, Pattern.CASE_INSENSITIVE);
	    Matcher matcher = pattern.matcher(cadena);
		return matcher.matches();
	}
}
