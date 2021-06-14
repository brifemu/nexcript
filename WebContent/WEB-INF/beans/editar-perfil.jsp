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
		ResourceBundle i18n;
		MProgramador programador;
		String nombre;
		String username;
		String pais;
		String provincia;
		String ciudad;	
		String lenguaje;
		boolean existeUsername;	
		RegEx reg;
		boolean validNombre;
		boolean validPais;
		boolean validProvincia;
		boolean validCiudad;
		boolean validUsername;
	
		if(session.getAttribute("locale") != null) response.setLocale((Locale)session.getAttribute("locale"));
		i18n = ResourceBundle.getBundle("i18n.i18n", response.getLocale());
		
		programador = (MProgramador) session.getAttribute("user");	
	
		nombre = EditarForm.getNombre();
		username = EditarForm.getUsername();
		pais = EditarForm.getPais();
		provincia = EditarForm.getProvincia();
		ciudad = EditarForm.getCiudad();
		lenguaje = EditarForm.getLenguaje();
		
		reg = new RegEx();
		
		//Controlamos el form
		validNombre = reg.comprobar("texto", true, nombre);
		validPais = reg.comprobar("texto", true, pais);
		validProvincia = reg.comprobar("texto", true, provincia);
		validCiudad = reg.comprobar("texto", true, ciudad);
		validUsername = reg.comprobar("username", false, username);
		
		if(!validCiudad) session.setAttribute("error-perfil", "Formato de ciudad no válido, solo letras y espacios");
		else if (!programador.getCiudad().equals(ciudad)) programador.update("ciudad", ciudad);
		
		if(!validProvincia) session.setAttribute("error-perfil", "Formato de provincia no válido, solo letras y espacios");
		else if (!programador.getProvincia().equals(provincia)) programador.update("provincia", provincia);
		
		if(!validPais) session.setAttribute("error-perfil", "Formato de pais no válido, solo letras y espacios");
		else if (!programador.getPais().equals(pais)) programador.update("pais", pais);
		
		if(!validUsername) session.setAttribute("error-perfil", "Formato de nombre de usuario no válido, solo letras y espacios");
		
		if(!validNombre) session.setAttribute("error-perfil", "Formato de nombre no válido, solo letras y espacios");
		else if (!programador.getNombre().equals(nombre)) programador.update("nombre", nombre);
		
		if (!programador.getLenguaje().equals(lenguaje)) programador.update("lenguaje", lenguaje);
		
		existeUsername = programador.leer("username", username);
		programador = (MProgramador) session.getAttribute("user");	
		
		//Controlamos si el nick esta en uso o no
		if(!programador.getUsername().equalsIgnoreCase(username)){	
			if(existeUsername) session.setAttribute("error-perfil", "El nombre de usuario introducido ya está en uso");
			else if (!programador.getUsername().equals(username)) programador.update("username", username);
		}
		
		if(session.getAttribute("error-perfil") == null) {
			//Editamos el perfil del usuario
			session.setAttribute("exito-perfil", "Los cambios han sido guardados con éxito");
		
			//Actualizamos los datos desde la base de datos
			programador.leer("id", programador.getId());
			session.setAttribute("user", programador);
		}
		response.sendRedirect("../../editar-perfil#perfil");
	%>
</body>
</html>