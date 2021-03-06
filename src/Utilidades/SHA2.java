package Utilidades;

import java.math.BigInteger;
import java.security.MessageDigest;

public class SHA2 {
	
	//Cifra cualquier cadena de texto
	public String getSHA256(String input) {
		String toReturn = null;
		try {
		    MessageDigest digest = MessageDigest.getInstance("SHA-256");
		    digest.reset();
		    digest.update(input.getBytes("utf8"));
		    toReturn = String.format("%064x", new BigInteger(1, digest.digest()));
		} catch (Exception e) {
		    e.printStackTrace();
		}	
		return toReturn;
	}

}
