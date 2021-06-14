<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="EditarPerfil.BEditarPass"  %>
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
	<jsp:useBean id="PassForm" class="EditarPerfil.BEditarPass" scope="page">
		<jsp:setProperty property="*" name="PassForm"/> 
	</jsp:useBean>
	<%
		ResourceBundle i18n;
		MProgramador programador;
		String password;
		String newpassword;
		String repassword;
		SHA2 SHA;
		String hashed;
		String newhashed;
		RegEx reg;
		boolean validPassword;
		boolean correctPassword;
		boolean coinciden;
	
		if(session.getAttribute("locale") != null) response.setLocale((Locale)session.getAttribute("locale"));
		i18n = ResourceBundle.getBundle("i18n.i18n", response.getLocale());
		
		programador = (MProgramador) session.getAttribute("user");	
	
		password = PassForm.getPassword();
		newpassword = PassForm.getNewpassword();
		repassword = PassForm.getRepassword();
		
		SHA = new SHA2();
		hashed = SHA.getSHA256(password);
		newhashed = SHA.getSHA256(newpassword);
		
		reg = new RegEx();
		
		//Controlamos el form
		validPassword = reg.comprobar("password", true, newpassword);
		correctPassword = programador.getPassword().equals(hashed);
		coinciden = newpassword.equals(repassword);
		
		if(!coinciden) session.setAttribute("error-clave", "Las contraseñas no coinciden");
		if(!correctPassword) session.setAttribute("error-clave", "Las contraseña no es correcta");
		if(!validPassword) session.setAttribute("error-clave", "Las contraseña no cumple los requisitos necesarios");
		
		
		if(session.getAttribute("error-clave") == null) {
			//Cambiamos la contraseña del usuario
			programador.update("password", newhashed);
			
			//Actualizamos los datos desde la base de datos
			programador.leer("id", programador.getId());
			session.setAttribute("user", programador);
			
			session.setAttribute("exito-clave", "Los cambios han sido guardados con éxito");
		}
		
		response.sendRedirect("../../editar-perfil#clave");
	%>
</body>
</html>