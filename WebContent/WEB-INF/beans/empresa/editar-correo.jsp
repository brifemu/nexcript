<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Empresa.BEditarCorreo"  %>
<%@ page import="Empresa.MEmpresa"  %>
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
	<jsp:useBean id="CorreoForm" class="Empresa.BEditarCorreo" scope="page">
		<jsp:setProperty property="*" name="CorreoForm"/> 
	</jsp:useBean>
	<%
		ResourceBundle i18n;
		MEmpresa empresa;
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
		
		empresa = (MEmpresa) session.getAttribute("user");	
	
		mail = CorreoForm.getMail();
		newmail = CorreoForm.getNewmail();
		remail = CorreoForm.getRemail();
		password = CorreoForm.getPassword();
		repassword = CorreoForm.getRepassword();
		
		SHA = new SHA2();
		hashed = SHA.getSHA256(password);
		
		reg = new RegEx();
		
		validMail = reg.comprobar("correo", true, mail);
		ocupado = empresa.leer("mail", newmail);
		empresa = (MEmpresa) session.getAttribute("user");	

		if(!password.equals(repassword)) session.setAttribute("error-correo", "Las contraseñas no coinciden");
		if(!empresa.getPassword().equals(hashed)) session.setAttribute("error-correo", "Las contraseña no es correcta");
		if(!validMail) session.setAttribute("error-correo", "Formato de dirección de correo no válido");
		if(!newmail.equals(remail)) session.setAttribute("error-correo", "Las direcciones de correo no coinciden");
		if(ocupado) session.setAttribute("error-correo", "El correo insertado no puede ser utilizado");
		
		
		if(session.getAttribute("error-correo") == null) {
			empresa.update("mail", newmail);
			session.setAttribute("exito-correo", "Los cambios han sido guardados con éxito");
			
			//Actualizamos los datos desde la base de datos
			empresa.leer("id", empresa.getId());
			session.setAttribute("user", empresa);
		}
		
		response.sendRedirect("../../../empresa-editar-perfil#correo");
	%>
</body>
</html>