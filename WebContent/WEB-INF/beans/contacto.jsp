<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Contacto.BContacto"  %>
<%@ page import="java.util.ResourceBundle" %>
<%@ page import="java.util.Locale" %>
<%@ page import="Utilidades.RegEx"  %>
<%@ page import="Utilidades.Correo"  %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>nexcript</title>
</head>
<body>
	<jsp:useBean id="ContactoForm" class="Contacto.BContacto" scope="page">
		<jsp:setProperty property="*" name="ContactoForm"/> 
	</jsp:useBean>
	
	<%		
		String correo_empresa;
		ResourceBundle i18n;
		Correo correo;
		String mail;
		String nombre;
		String mensaje;
		RegEx reg;
		boolean validMail;
		boolean validNombre;
		
		correo_empresa = "brian94mj@gmail.com";
		mail = ContactoForm.getMail();
		nombre = ContactoForm.getNombre();
		mensaje = ContactoForm.getMensaje();
		reg = new RegEx();
		
		//Controlamos el formulario
		validMail = reg.comprobar("correo", false, mail);
		validNombre = reg.comprobar("texto", true, nombre);
		
		if(session.getAttribute("locale") != null) response.setLocale((Locale)session.getAttribute("locale"));
		i18n = ResourceBundle.getBundle("i18n.i18n", response.getLocale());
			
		if(!validNombre) session.setAttribute("error", i18n.getString("contact.error.name.format"));
		if(!validMail) session.setAttribute("error", i18n.getString("contact.error.mail.format"));
		
		if(session.getAttribute("error") == null){
			correo = new Correo();
			//Enviamos el form de contacto al correo de la empresa
			correo.correoContacto(correo_empresa, mail, nombre, mensaje);
			session.setAttribute("exito", i18n.getString("contact.success"));
		}
		response.sendRedirect("../../contacto");
	%>
</body>
</html>