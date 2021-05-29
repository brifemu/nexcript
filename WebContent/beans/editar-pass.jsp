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
		if(session.getAttribute("locale") != null) response.setLocale((Locale)session.getAttribute("locale"));
		ResourceBundle i18n = ResourceBundle.getBundle("i18n.i18n", response.getLocale());
		
		MProgramador programador = (MProgramador) session.getAttribute("user");	
	
		String password = PassForm.getPassword();
		String newpassword = PassForm.getNewpassword();
		String repassword = PassForm.getRepassword();
		
		SHA2 SHA = new SHA2();
		String hashed = SHA.getSHA256(password);
		String newhashed = SHA.getSHA256(newpassword);
		
		RegEx reg = new RegEx();
		
		boolean validPassword = reg.comprobar("password", true, newpassword);
		boolean correctPassword = programador.getPassword().equals(hashed);
		boolean coinciden = newpassword.equals(repassword);
		
		if(!coinciden) session.setAttribute("error-clave", "Las contraseñas no coinciden");
		if(!correctPassword) session.setAttribute("error-clave", "Las contraseña no es correcta");
		if(!validPassword) session.setAttribute("error-clave", "Las contraseña no cumple los requisitos necesarios");
		
		
		if(session.getAttribute("error-clave") == null) {
			programador.update("password", newhashed);
			
			//Actualizamos los datos desde la base de datos
			programador.leer("id", programador.getId());
			session.setAttribute("user", programador);
			
			session.setAttribute("exito-clave", "Los cambios han sido guardados con éxito");
		}
		
		response.sendRedirect("../editar-perfil#clave");
	%>
</body>
</html>