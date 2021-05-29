<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="EditarPerfil.BVerificarCorreo"  %>
<%@ page import="Programador.MProgramador"  %>
<%@ page import="java.sql.Timestamp"  %>
<%@ page import="java.util.ResourceBundle" %>
<%@ page import="java.util.Locale" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>nexcript</title>
</head>
<body>
	<jsp:useBean id="VerificarForm" class="EditarPerfil.BVerificarCorreo" scope="page">
		<jsp:setProperty property="*" name="VerificarForm"/> 
	</jsp:useBean>
	
	<%
		if(session.getAttribute("locale") != null) response.setLocale((Locale)session.getAttribute("locale"));
		ResourceBundle i18n = ResourceBundle.getBundle("i18n.i18n", response.getLocale());
		MProgramador programador = (MProgramador) session.getAttribute("user");	
		String codigo = (String) session.getAttribute("codigo");
		String codigoForm = VerificarForm.getCodigo();
		Timestamp fecha = new Timestamp(System.currentTimeMillis());
		
		if(codigo.equals(codigoForm)){
			programador.setConfirmado(true);
			programador.update("confirmado", true);
			programador.update("fechaconfirmacion", fecha);
			
			//Actualizamos los datos desde la base de datos
			programador.leer("id", programador.getId());
			session.setAttribute("user", programador);
			
		} else session.setAttribute("error-confirmacion", "El código introducido no es válido, recuerde que puede solicitar un reenvio de su código");
		
		response.sendRedirect("../editar-perfil#confirmacion");
	%>
</body>
</html>