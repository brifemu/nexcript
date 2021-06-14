package Utilidades;

import java.security.GeneralSecurityException;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.sun.mail.util.MailSSLSocketFactory;

public class Correo {
	String from = "brian94mj@gmail.com";
	String clave = "iawjzshutfalmvbd"; //Es una contraseña de aplicación
	String to = "";
	String asunto="";
	String mensaje="";
	MimeMessage Mimessage;
	
	// Variables para el servidor
   	String host = "smtp.gmail.com";
	String port = "465";//ssl, tls=>587";
	MailSSLSocketFactory sf;

   	// Tomar entorno del sistema
   	Properties properties = System.getProperties();
   	
   	public void correoVerificacion(String mail, String nombre, String codigo) {
   		to = mail;
   		asunto = "nexcript - Correo de confirmación";
   		mensaje = "Estimado/a "+nombre+",\n"
   				+ "Ya solo falta un paso para completar su registro, verificar su dirección de correo.\n\n"
   				+ "Para ello debe introducir el código "+codigo+" en la página de verificación.\n\n"
   				+ "Un cordial saludo,\nEquipo de nexcript";

   		try {
   			sf = new MailSSLSocketFactory();
   	    	sf.setTrustAllHosts(true);
   	        // Añadir datos del servidor
   	        properties.put("mail.smtp.host", host);
   	        properties.put("mail.smtp.port", port);
   	        properties.put("mail.smtp.ssl.enable", "true");
   	        properties.put("mail.smtp.auth", "true");
   			properties.put("mail.smtp.ssl.socketFactory", sf);
   	        
   		
   	        // Instanciar una sesión de correo y añadir usuario y contraseña
   	        Session session = Session.getInstance(properties, 
   			new javax.mail.Authenticator() {
   	        	protected PasswordAuthentication getPasswordAuthentication() {
   	        		return new PasswordAuthentication(from, clave);
   				}
   	        });
   		    // Activar depuración
   		    session.setDebug(false);

   	 	    // Crear un objeto MimeMessage por defecto.
   		    Mimessage = new MimeMessage(session);

   	        // Asignar campo 'De:' al encabezado del correo
   	        Mimessage.setFrom(new InternetAddress(from));
   	        // Asignar campo 'Para:' al encabezado del correo
   	        Mimessage.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
   	        // Asignar campo 'Asunto:' al encabezado del correo
   	        Mimessage.setSubject(asunto);
   	        // Asignar el mensaje en sí
   	        Mimessage.setText(mensaje);
   	        // Enviar el mensaje
   	        Transport.send(Mimessage);
   		} catch (MessagingException mex) {
   			mex.printStackTrace();
   		}
   		catch (GeneralSecurityException gse) {
   			gse.printStackTrace();
   		}
   	}
   	
   	public void correoContacto(String empresa, String mail, String nombre, String mensaje) {
   		to = empresa;
   		asunto = "nexcript - Formulario de contacto";
   		mensaje = "De: "+mail+"\n"
   				+ "Nombre: "+nombre+"\n"
   				+ "Mensaje:\n"+mensaje;

   		try {
   			sf = new MailSSLSocketFactory();
   	    	sf.setTrustAllHosts(true);
   	        // Añadir datos del servidor
   	        properties.put("mail.smtp.host", host);
   	        properties.put("mail.smtp.port", port);
   	        properties.put("mail.smtp.ssl.enable", "true");
   	        properties.put("mail.smtp.auth", "true");
   			properties.put("mail.smtp.ssl.socketFactory", sf);
   	        
   		
   	        // Instanciar una sesión de correo y añadir usuario y contraseña
   	        Session session = Session.getInstance(properties, 
   			new javax.mail.Authenticator() {
   	        	protected PasswordAuthentication getPasswordAuthentication() {
   	        		return new PasswordAuthentication(from, clave);
   				}
   	        });
   		    // Activar depuración
   		    session.setDebug(false);

   	 	    // Crear un objeto MimeMessage por defecto.
   		    Mimessage = new MimeMessage(session);

   	        // Asignar campo 'De:' al encabezado del correo
   	        Mimessage.setFrom(new InternetAddress(from));
   	        // Asignar campo 'Para:' al encabezado del correo
   	        Mimessage.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
   	        // Asignar campo 'Asunto:' al encabezado del correo
   	        Mimessage.setSubject(asunto);
   	        // Asignar el mensaje en sí
   	        Mimessage.setText(mensaje);
   	        // Enviar el mensaje
   	        Transport.send(Mimessage);
   		} catch (MessagingException mex) {
   			mex.printStackTrace();
   		}
   		catch (GeneralSecurityException gse) {
   			gse.printStackTrace();
   		}
   	}
   	
}
