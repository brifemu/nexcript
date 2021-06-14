<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Empresa.BEditarPerfil"  %>
<%@ page import="Empresa.MEmpresa"  %>
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
	<jsp:useBean id="EditarForm" class="Empresa.BEditarPerfil" scope="page">
		<jsp:setProperty property="*" name="EditarForm"/> 
	</jsp:useBean>
	<%
		ResourceBundle i18n;
		MEmpresa empresa;
		String nombre;
		String pais;
		String provincia;
		String ciudad;	
		RegEx reg;
		boolean validNombre;
		boolean validPais;
		boolean validProvincia;
		boolean validCiudad;
	
		if(session.getAttribute("locale") != null) response.setLocale((Locale)session.getAttribute("locale"));
		i18n = ResourceBundle.getBundle("i18n.i18n", response.getLocale());
		
		empresa = (MEmpresa) session.getAttribute("user");	
	
		nombre = EditarForm.getNombre();
		pais = EditarForm.getPais();
		provincia = EditarForm.getProvincia();
		ciudad = EditarForm.getCiudad();
		
		
		reg = new RegEx();
		
		validNombre = reg.comprobar("texto", true, nombre);
		validPais = reg.comprobar("texto", true, pais);
		validProvincia = reg.comprobar("texto", true, provincia);
		validCiudad = reg.comprobar("texto", true, ciudad);
		
		if(!validCiudad) session.setAttribute("error-perfil", "Formato de ciudad no válido, solo letras y espacios");
		else if (!empresa.getCiudad().equals(ciudad)) empresa.update("ciudad", ciudad);
		
		if(!validProvincia) session.setAttribute("error-perfil", "Formato de provincia no válido, solo letras y espacios");
		else if (!empresa.getProvincia().equals(provincia)) empresa.update("provincia", provincia);
		
		if(!validPais) session.setAttribute("error-perfil", "Formato de pais no válido, solo letras y espacios");
		else if (!empresa.getPais().equals(pais)) empresa.update("pais", pais);
		
		if(!validNombre) session.setAttribute("error-perfil", "Formato de nombre no válido, solo letras y espacios");
		else if (!empresa.getNombre().equals(nombre)) empresa.update("nombre", nombre);
		
		
		empresa = (MEmpresa) session.getAttribute("user");	
		
		if(session.getAttribute("error-perfil") == null) {
			session.setAttribute("exito-perfil", "Los cambios han sido guardados con éxito");
		
			//Actualizamos los datos desde la base de datos
			empresa.leer("id", empresa.getId());
			session.setAttribute("user", empresa);
		}
		response.sendRedirect("../../../empresa-editar-perfil#perfil");
	%>
</body>
</html>