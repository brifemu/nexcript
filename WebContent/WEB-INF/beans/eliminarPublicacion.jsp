<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Programador.MProgramador"  %>
<%@ page import="Publicacion.MPublicacion"  %>
<%@ page import="Publicacion.BEliminarPublicacion"  %>
<%@ page import="java.util.ResourceBundle" %>
<%@ page import="java.util.Locale" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>nexcript</title>
</head>
<body>
	<jsp:useBean id="EliminarPublicacion" class="Publicacion.BEliminarPublicacion" scope="page">
		<jsp:setProperty property="*" name="EliminarPublicacion"/> 
	</jsp:useBean>
	<%
		int id;
		MProgramador user;
		MPublicacion publicacion;
		boolean exito;
		ResourceBundle i18n;
		
		if(session.getAttribute("locale") != null) response.setLocale((Locale)session.getAttribute("locale"));
		i18n = ResourceBundle.getBundle("i18n.i18n", response.getLocale());
		user = (MProgramador) session.getAttribute("user");
		id = Integer.parseInt(EliminarPublicacion.getId());
		publicacion = new MPublicacion();
			
		publicacion.leer("id", id);
		//Controlamos si podemos eliminar la publicación o no, si tiene permisos lo hace
		if(publicacion.getUsuario() != user.getId()) session.setAttribute("error", i18n.getString("publication.delete.permission"));
		else {
			exito = publicacion.update("activo", false);
			if(exito) session.setAttribute("exito", i18n.getString("publication.delete.success"));
			else session.setAttribute("error", i18n.getString("publication.delete.error"));
		}
		response.sendRedirect(request.getHeader("Referer"));
		
	%>
	
</body>
</html>