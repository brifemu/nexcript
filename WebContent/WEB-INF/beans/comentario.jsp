<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Codigo.BComentario"  %>
<%@ page import="Codigo.MComentario"  %>
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
	<jsp:useBean id="ComentarioForm" class="Codigo.BComentario" scope="page">
		<jsp:setProperty property="*" name="ComentarioForm"/>
	</jsp:useBean>
<%
	if(session.getAttribute("locale") != null) response.setLocale((Locale)session.getAttribute("locale"));
	ResourceBundle i18n;
		
	MProgramador programador;
	MComentario comentario;
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
	comentario = new MComentario();
	
	//Controlamos los datos del formulario
	id = Integer.parseInt(ComentarioForm.getId());
	contenido = ComentarioForm.getContenido();
	
	validSize = contenido.length() <= 240 ? true : false;
	detectHTML = reg.comprobar("html", true, contenido);
	confirmado = programador.getConfirmado();
	
	if(!validSize) session.setAttribute("error", i18n.getString("comment.error.length"));
	if(detectHTML) session.setAttribute("error", i18n.getString("comment.error.html"));
	if(!confirmado) session.setAttribute("error", i18n.getString("comment.error.confirmed"));
		
	if(session.getAttribute("error") == null)
	{
		//Controlamos la creación del comentario
		exito = comentario.insertar(programador.getId(), contenido, id);
		if(!exito) session.setAttribute("error", i18n.getString("comment.error.insert"));
		else session.setAttribute("exito", i18n.getString("comment.success.insert"));
	}
	response.sendRedirect(request.getHeader("Referer"));
	%>
</body>
</html>