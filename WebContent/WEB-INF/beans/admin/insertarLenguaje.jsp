<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Admin.BLenguaje"  %>
<%@ page import="Codigo.MLenguaje"  %>
<%@ page import="Utilidades.RegEx"  %>
<%@ page import="java.util.ResourceBundle" %>
<%@ page import="java.util.Locale" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:useBean id="LenguajeForm" class="Admin.BLenguaje" scope="page">
		<jsp:setProperty property="*" name="LenguajeForm"/> 
	</jsp:useBean>
	
	<%
		RegEx reg;
		ResourceBundle i18n;
		String nombre;
		String valor;
		String icono;
		boolean exito;
		//boolean validNombre;
		//boolean validValor;
		//boolean validIcono;
		MLenguaje lenguaje;
		
		reg = new RegEx();	
		nombre = LenguajeForm.getNombre();
		valor = LenguajeForm.getValor();
		icono = LenguajeForm.getIcono();
		exito = false;
		//validNombre = reg.comprobar("texto", true, nombre);
		//validValor = reg.comprobar("texto", false, valor);
		//validIcono = reg.comprobar("texto", true, icono);
		
		if(session.getAttribute("locale") != null) response.setLocale((Locale)session.getAttribute("locale"));
		i18n = ResourceBundle.getBundle("i18n.i18n", response.getLocale());
	
		//if(!validNombre) session.setAttribute("error", i18n.getString("adm.programming.error.name.format"));
		//if(!validValor) session.setAttribute("error", i18n.getString("adm.programming.error.value.format"));
		//if(!validIcono) session.setAttribute("error", i18n.getString("adm.programming.error.icon.format"));
		
		if(session.getAttribute("error") == null){
			lenguaje = new MLenguaje();
			exito = lenguaje.insertar(nombre, valor, icono);
			if(exito) session.setAttribute("exito", i18n.getString("adm.programming.success.insert"));
			else session.setAttribute("error", i18n.getString("adm.programming.error.insert"));
		}
		response.sendRedirect("../../lenguajes");
	%>
</body>
</html>