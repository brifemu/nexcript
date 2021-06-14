<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Empresa.BVerificarCorreo"  %>
<%@ page import="Empresa.MEmpresa"  %>
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
	<jsp:useBean id="VerificarForm" class="Empresa.BVerificarCorreo" scope="page">
		<jsp:setProperty property="*" name="VerificarForm"/> 
	</jsp:useBean>
	
	<%
		ResourceBundle i18n;
		MEmpresa empresa;	
		String codigo;
		String codigoForm;
		Timestamp fecha;
		
		if(session.getAttribute("locale") != null) response.setLocale((Locale)session.getAttribute("locale"));
		i18n = ResourceBundle.getBundle("i18n.i18n", response.getLocale());
		
		empresa = (MEmpresa) session.getAttribute("user");	
		codigo = (String) session.getAttribute("codigo");
		codigoForm = VerificarForm.getCodigo();
		fecha = new Timestamp(System.currentTimeMillis());
		
		if(codigo.equals(codigoForm)){
			empresa.setConfirmado(true);
			empresa.update("confirmado", true);
			empresa.update("fechaconfirmacion", fecha);
			
			//Actualizamos los datos desde la base de datos
			empresa.leer("id", empresa.getId());
			session.setAttribute("user", empresa);
			
		} else session.setAttribute("error-confirmacion", "El código introducido no es válido, recuerde que puede solicitar un reenvio de su código");
		
		response.sendRedirect("../../../empresa-editar-perfil#confirmacion");
	%>
</body>
</html>