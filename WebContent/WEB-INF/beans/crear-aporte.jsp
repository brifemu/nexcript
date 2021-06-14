<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Codigo.BAporte"  %>
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
	<jsp:useBean id="AporteForm" class="Codigo.BAporte" scope="page">
		<jsp:setProperty property="*" name="AporteForm"/> 
	</jsp:useBean>
	<%
		ResourceBundle i18n;	
		MProgramador programador;
		MAportacion aportacion;
		String titulo;
		String lenguaje;
		String descripcion;
		String codigo;
		RegEx reg;
		boolean tituloHTLM ;
		boolean descripcionHTML;
		boolean sizeTitulo;
		boolean sizeDescripcion;		
		boolean exito;
		boolean confirmado;
		
		if(session.getAttribute("locale") != null) response.setLocale((Locale)session.getAttribute("locale"));
		i18n = ResourceBundle.getBundle("i18n.i18n", response.getLocale());
				
		
		titulo = AporteForm.getTitulo();
		lenguaje = AporteForm.getLenguaje();
		descripcion = AporteForm.getDescripcion();
		codigo = AporteForm.getCodigo();	
		reg = new RegEx();	
		programador = (MProgramador) session.getAttribute("user");
		
		//Controlamos el form
		tituloHTLM = reg.comprobar("html", false, titulo);
		descripcionHTML = reg.comprobar("html", false, descripcion);
		sizeTitulo = titulo.length() <= 50 ? true : false;
		sizeDescripcion = titulo.length() <= 240 ? true : false;	
		exito = false;
		
		confirmado = programador.getConfirmado();
		
		if(!sizeDescripcion) session.setAttribute("error", i18n.getString("contribution.description.title.size"));
		if(descripcionHTML) session.setAttribute("error", i18n.getString("contribution.error.description.format"));
		if(!sizeTitulo) session.setAttribute("error", i18n.getString("contribution.error.title.size"));
		if(tituloHTLM) session.setAttribute("error", i18n.getString("contribution.error.title.format"));
		if(!confirmado) session.setAttribute("error", i18n.getString("contribution.error.confirmed"));
		
		if(session.getAttribute("error") == null) {
			aportacion = new MAportacion();
			//Controlamos la creación del aporte
			exito = aportacion.insertar(programador.getId(), titulo, descripcion, lenguaje, codigo);
			if(exito) response.sendRedirect("../../codigo");
			else { 
				session.setAttribute("error", i18n.getString("contribution.error.insert"));
				response.sendRedirect("../../crear-aporte");
			}
		} else response.sendRedirect("../../crear-aporte");
		

	%>
</body>
</html>