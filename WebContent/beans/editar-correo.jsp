<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="EditarPerfil.BEditarCorreo"  %>
<%@ page import="Programador.MProgramador"  %>
<%@ page import="Utilidades.SHA2"  %>
<%@ page import="Utilidades.RegEx"  %>
<%@ page import="java.util.ResourceBundle" %>
<%@ page import="java.util.Locale" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>nexcript</title>
</head>
<body>
	<jsp:useBean id="CorreoForm" class="EditarPerfil.BEditarCorreo" scope="page">
		<jsp:setProperty property="*" name="CorreoForm"/> 
	</jsp:useBean>
	<%
		if(session.getAttribute("locale") != null) response.setLocale((Locale)session.getAttribute("locale"));
		ResourceBundle i18n = ResourceBundle.getBundle("i18n.i18n", response.getLocale());
		
		MProgramador programador = (MProgramador) session.getAttribute("user");	
	
		String mail = CorreoForm.getMail();
		String newmail = CorreoForm.getNewmail();
		String remail = CorreoForm.getRemail();
		String password = CorreoForm.getPassword();
		String repassword = CorreoForm.getRepassword();
		
		SHA2 SHA = new SHA2();
		String hashed = SHA.getSHA256(password);
		
		RegEx reg = new RegEx();
		
		boolean validMail = reg.comprobar("correo", true, mail);
		boolean ocupado = programador.leer("mail", newmail);
		programador = (MProgramador) session.getAttribute("user");	

		if(!password.equals(repassword)) session.setAttribute("error-correo", "Las contraseñas no coinciden");
		if(!programador.getPassword().equals(hashed)) session.setAttribute("error-correo", "Las contraseña no es correcta");
		if(!validMail) session.setAttribute("error-correo", "Formato de dirección de correo no válido");
		if(!newmail.equals(remail)) session.setAttribute("error-correo", "Las direcciones de correo no coinciden");
		if(ocupado) session.setAttribute("error-correo", "El correo insertado no puede ser utilizado");
		
		
		if(session.getAttribute("error-correo") == null) {
			programador.update("mail", newmail);
			session.setAttribute("exito-correo", "Los cambios han sido guardados con éxito");
			
			//Actualizamos los datos desde la base de datos
			programador.leer("id", programador.getId());
			session.setAttribute("user", programador);
		}
		
		response.sendRedirect("../editar-perfil#correo");
	%>
</body>
</html>