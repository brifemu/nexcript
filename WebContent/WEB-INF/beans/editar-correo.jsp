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
		ResourceBundle i18n;
		MProgramador programador;
		String mail;
		String newmail;
		String remail;
		String password;
		String repassword;
		SHA2 SHA;
		String hashed;
		RegEx reg;
		boolean validMail;
		boolean ocupado;
		
		if(session.getAttribute("locale") != null) response.setLocale((Locale)session.getAttribute("locale"));
		i18n = ResourceBundle.getBundle("i18n.i18n", response.getLocale());
		
		programador = (MProgramador) session.getAttribute("user");	
	
		mail = CorreoForm.getMail();
		newmail = CorreoForm.getNewmail();
		remail = CorreoForm.getRemail();
		password = CorreoForm.getPassword();
		repassword = CorreoForm.getRepassword();
		
		SHA = new SHA2();
		hashed = SHA.getSHA256(password);
		
		reg = new RegEx();
		
		//Controlamos el form
		validMail = reg.comprobar("correo", true, mail);
		ocupado = programador.leer("mail", newmail);
		programador = (MProgramador) session.getAttribute("user");	

		if(!password.equals(repassword)) session.setAttribute("error-correo", "Las contraseñas no coinciden");
		if(!programador.getPassword().equals(hashed)) session.setAttribute("error-correo", "Las contraseña no es correcta");
		if(!validMail) session.setAttribute("error-correo", "Formato de dirección de correo no válido");
		if(!newmail.equals(remail)) session.setAttribute("error-correo", "Las direcciones de correo no coinciden");
		if(ocupado) session.setAttribute("error-correo", "El correo insertado no puede ser utilizado");
		
		
		if(session.getAttribute("error-correo") == null) {
			//Cambios el correo del usuario
			programador.update("mail", newmail);
			//Obliga a que tenga que verificar de nuevo el correo
			programador.setConfirmado(false);
			programador.update("confirmado", false);
			programador.setNull("fechaconfirmacion");
			session.setAttribute("exito-correo", "Los cambios han sido guardados con éxito, recuerda confirmar su nuevo correo");
			
			//Actualizamos los datos desde la base de datos
			programador.leer("id", programador.getId());
			session.setAttribute("user", programador);
		}
		
		response.sendRedirect("../../editar-perfil#correo");
	%>
</body>
</html>