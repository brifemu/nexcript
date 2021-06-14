<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Programador.MProgramador"  %>
<%@ page import="Codigo.MAportacion"  %>
<%@ page import="Codigo.BEliminarAporte"  %>
<%@ page import="java.util.ResourceBundle" %>
<%@ page import="java.util.Locale" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>nexcript</title>
</head>
<body>
	<jsp:useBean id="EliminarAporte" class="Codigo.BEliminarAporte" scope="page">
		<jsp:setProperty property="*" name="EliminarAporte"/> 
	</jsp:useBean>
	<%
		int id;
		MProgramador user;
		MAportacion aporte;
		boolean exito;
		ResourceBundle i18n;
		
		if(session.getAttribute("locale") != null) response.setLocale((Locale)session.getAttribute("locale"));
		i18n = ResourceBundle.getBundle("i18n.i18n", response.getLocale());
		user = (MProgramador) session.getAttribute("user");
		id = Integer.parseInt(EliminarAporte.getId());
		aporte = new MAportacion();
			
		aporte.leer("id", id);
		//Controlamos si podemos eliminar el aporte o no, si tiene permisos lo hace
		if(aporte.getUsuario() != user.getId()) session.setAttribute("error", i18n.getString("contribution.delete.permission"));
		else {
			exito = aporte.update("activo", false);
			if(exito) session.setAttribute("exito", i18n.getString("contribution.delete.success"));
			else session.setAttribute("error", i18n.getString("contribution.delete.error"));
		}
		response.sendRedirect(request.getHeader("Referer"));
		
	%>
	
</body>
</html>
