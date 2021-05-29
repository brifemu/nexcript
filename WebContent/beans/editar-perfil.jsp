<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="EditarPerfil.BEditarPerfil"  %>
<%@ page import="Programador.MProgramador"  %>
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
	<jsp:useBean id="EditarForm" class="EditarPerfil.BEditarPerfil" scope="page">
		<jsp:setProperty property="*" name="EditarForm"/> 
	</jsp:useBean>
	<%
		if(session.getAttribute("locale") != null) response.setLocale((Locale)session.getAttribute("locale"));
		ResourceBundle i18n = ResourceBundle.getBundle("i18n.i18n", response.getLocale());
		
		MProgramador programador = (MProgramador) session.getAttribute("user");	
	
		String nombre = EditarForm.getNombre();
		String username = EditarForm.getUsername();
		String pais = EditarForm.getPais();
		String provincia = EditarForm.getProvincia();
		String ciudad = EditarForm.getCiudad();
		
		boolean existeUsername;
		
		RegEx reg = new RegEx();
		
		boolean validNombre = reg.comprobar("texto", true, nombre);
		boolean validPais = reg.comprobar("texto", true, pais);
		boolean validProvincia = reg.comprobar("texto", true, provincia);
		boolean validCiudad = reg.comprobar("texto", true, ciudad);
		boolean validUsername = reg.comprobar("username", false, username);
		
		if(!validCiudad) session.setAttribute("error-perfil", "Formato de ciudad no válido, solo letras y espacios");
		else if (!programador.getCiudad().equals(ciudad)) programador.update("ciudad", ciudad);
		
		if(!validProvincia) session.setAttribute("error-perfil", "Formato de provincia no válido, solo letras y espacios");
		else if (!programador.getProvincia().equals(provincia)) programador.update("provincia", provincia);
		
		if(!validPais) session.setAttribute("error-perfil", "Formato de pais no válido, solo letras y espacios");
		else if (!programador.getPais().equals(pais)) programador.update("pais", pais);
		
		if(!validUsername) session.setAttribute("error-perfil", "Formato de nombre de usuario no válido, solo letras y espacios");
		
		if(!validNombre) session.setAttribute("error-perfil", "Formato de nombre no válido, solo letras y espacios");
		else if (!programador.getNombre().equals(nombre)) programador.update("nombre", nombre);
		
		
		existeUsername = programador.leer("username", username);
		programador = (MProgramador) session.getAttribute("user");	
		
		if(!programador.getUsername().equalsIgnoreCase(username)){	
			if(existeUsername) session.setAttribute("error-perfil", "El nombre de usuario introducido ya está en uso");
			else if (!programador.getUsername().equals(username)) programador.update("username", username);
		}
		
		if(session.getAttribute("error-perfil") == null) {
			session.setAttribute("exito-perfil", "Los cambios han sido guardados con éxito");
		
			//Actualizamos los datos desde la base de datos
			programador.leer("id", programador.getId());
			session.setAttribute("user", programador);
		}
		response.sendRedirect("../editar-perfil#perfil");
	%>
</body>
</html>