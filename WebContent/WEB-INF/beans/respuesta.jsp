<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Publicacion.BRespuesta"  %>
<%@ page import="Publicacion.MRespuesta"  %>
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
	<jsp:useBean id="RespuestaForm" class="Publicacion.BRespuesta" scope="page">
		<jsp:setProperty property="*" name="RespuestaForm"/>
	</jsp:useBean>
<%
	if(session.getAttribute("locale") != null) response.setLocale((Locale)session.getAttribute("locale"));
	ResourceBundle i18n;
		
	MProgramador programador;
	MRespuesta respuesta;
	boolean exito;
	boolean detectHTML;
	boolean validSize;
	boolean confirmado;
	int id;
	String contenido;
	RegEx reg;
	
	reg = new RegEx();
	detectHTML = false;
	validSize = false;
	exito = false;
	programador = (MProgramador) session.getAttribute("user");
	i18n = ResourceBundle.getBundle("i18n.i18n", response.getLocale());
	respuesta = new MRespuesta();
	confirmado = programador.getConfirmado();
	
	id = Integer.parseInt(RespuestaForm.getId());
	contenido = RespuestaForm.getContenido();
	
	validSize = contenido.length() <= 240 ? true : false;
	detectHTML = reg.comprobar("html", true, contenido);
	
	if(!validSize) session.setAttribute("error", i18n.getString("profile.error.reply.length"));
	if(detectHTML) session.setAttribute("error", i18n.getString("profile.error.reply.html"));
	if(!confirmado) session.setAttribute("error", i18n.getString("profile.error.reply.confirmed"));
	
	if(session.getAttribute("error") == null)
	{
		exito = respuesta.insertar(programador.getId(), contenido, id);
		if(!exito) session.setAttribute("error", i18n.getString("profile.error.reply.insert"));
		else session.setAttribute("exito", i18n.getString("profile.success.reply"));
	}
	response.sendRedirect(request.getHeader("Referer"));
	%>
</body>
</html>