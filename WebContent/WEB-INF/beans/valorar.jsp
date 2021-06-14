<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Codigo.BValorarAporte"  %>
<%@ page import="Codigo.MValoracion"  %>
<%@ page import="Codigo.MAportacion"  %>
<%@ page import="Programador.MProgramador"  %>

<%@ page import="java.util.ResourceBundle" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>nexcript</title>
</head>
<body>
	<jsp:useBean id="ValorarForm" class="Codigo.BValorarAporte" scope="page">
		<jsp:setProperty property="*" name="ValorarForm"/>
	</jsp:useBean>
<%
	if(session.getAttribute("locale") != null) response.setLocale((Locale)session.getAttribute("locale"));
	ResourceBundle i18n;
		
	MProgramador programador;
	MAportacion aporte;
	MValoracion valoracion;
	boolean existe;
	boolean confirmado;
	
	int id;
	String nota;
	int intNota;
	int existeValoracion;

	
	programador = (MProgramador) session.getAttribute("user");
	i18n = ResourceBundle.getBundle("i18n.i18n", response.getLocale());
	
	id = Integer.parseInt(ValorarForm.getId());
	nota = ValorarForm.getRating();
	confirmado = programador.getConfirmado();
	aporte = new MAportacion();
	valoracion = new MValoracion();
	existeValoracion = 0;
	
	if(nota == null) intNota = 0;
	else intNota = Integer.parseInt(nota);
	
	if(!confirmado) session.setAttribute("error", i18n.getString("rating.error.confirmed"));
		
	if(session.getAttribute("error") == null)
	{
		existe = aporte.leer("id", id);
		if(existe) {		
			ArrayList<Integer> listaValoraciones = valoracion.listarRelacion("codigo", id);

		   	for(int val: listaValoraciones) {
		   		existe = valoracion.leer("id", val);
		   		if(valoracion.getUsuario() == programador.getId()) existeValoracion = valoracion.getId();	   		
		   	} 
		   	
		   	if(existeValoracion > 0) {
		   		valoracion.update("valoracion", intNota);
		   	} else valoracion.insertar(programador.getId(), id, intNota);
		   			   	
		} else session.setAttribute("error", i18n.getString("contribution.none"));
	}
	response.sendRedirect(request.getHeader("Referer"));
	%>
</body>
</html>