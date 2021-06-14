<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Codigo.BEditarAporte"  %>
<%@ page import="Programador.MProgramador"  %>
<%@ page import="Codigo.MAportacion"  %>
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
	<jsp:useBean id="AporteForm" class="Codigo.BEditarAporte" scope="page">
		<jsp:setProperty property="*" name="AporteForm"/> 
	</jsp:useBean>
	<%
		ResourceBundle i18n;	
		MProgramador programador;
		MAportacion aportacion;
		int id;
		String titulo;
		String lenguaje;
		String descripcion;
		String codigo;
		RegEx reg;
		boolean titutloHTLM ;
		boolean descripcionHTML;
		boolean sizeTitulo;
		boolean sizeDescripcion;		
		boolean exito;
		
		if(session.getAttribute("locale") != null) response.setLocale((Locale)session.getAttribute("locale"));
		i18n = ResourceBundle.getBundle("i18n.i18n", response.getLocale());
		
		//Controlamos el form
		id = Integer.parseInt(AporteForm.getId());
		titulo = AporteForm.getTitulo();
		lenguaje = AporteForm.getLenguaje();
		descripcion = AporteForm.getDescripcion();
		codigo = AporteForm.getCodigo();	
		reg = new RegEx();	
		titutloHTLM = reg.comprobar("html", false, titulo);
		descripcionHTML = reg.comprobar("html", false, descripcion);
		sizeTitulo = titulo.length() <= 50 ? true : false;
		sizeDescripcion = titulo.length() <= 240 ? true : false;	
		exito = false;
		
		if(!sizeDescripcion) session.setAttribute("error", i18n.getString("contribution.description.title.size"));
		if(descripcionHTML) session.setAttribute("error", i18n.getString("contribution.error.description.format"));
		if(!sizeTitulo) session.setAttribute("error", i18n.getString("contribution.error.title.size"));
		if(titutloHTLM) session.setAttribute("error", i18n.getString("contribution.error.title.format"));
		
		if(session.getAttribute("error") == null) {
			programador = (MProgramador) session.getAttribute("user");
			aportacion = new MAportacion();
			aportacion.leer("id", id);
			if(aportacion.getUsuario() != programador.getId()) session.setAttribute("error", i18n.getString("contribution.update.permission"));
			else {
				//Controlamos la edición del aporte
				exito = aportacion.update(titulo, lenguaje, descripcion, codigo);
				if(!exito) session.setAttribute("error", i18n.getString("contribution.update.error"));
				else session.setAttribute("exito", i18n.getString("contribution.update.success"));
			}
		} 
		response.sendRedirect(request.getHeader("Referer"));

	%>
</body>
</html>