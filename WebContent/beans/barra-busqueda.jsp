<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="BarraBusqueda.BBarraBusqueda"  %>
<%@ page import="Programador.MProgramador"  %>
<%@ page import="java.util.ResourceBundle" %>
<%@ page import="java.util.Locale" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>nexcript</title>
</head>
<body>
	<jsp:useBean id="BusquedaForm" class="BarraBusqueda.BBarraBusqueda" scope="page">
		<jsp:setProperty property="*" name="BusquedaForm"/> 
	</jsp:useBean>
	
	<%
		if(session.getAttribute("locale") != null) response.setLocale((Locale)session.getAttribute("locale"));
		ResourceBundle i18n = ResourceBundle.getBundle("i18n.i18n", response.getLocale());
	
		String busqueda;
	
		if(request.getParameter("q") == null) busqueda = BusquedaForm.getBusqueda();
		else busqueda = request.getParameter("q");
		
		MProgramador user = (MProgramador) session.getAttribute("user");
		int max_registros = 20;
		
		int pagina = 1;
		int paginas;
		int resultados;
		int[] resultado;
		if(request.getParameter("p") == null) pagina = 1;
		else {
			try {
				pagina = Integer.parseInt((String) request.getParameter("p"));
				if(pagina == 0) pagina = 1;
			} catch (Exception e) {
				response.sendRedirect("inicio");
			}
		}
		
			
		resultado = user.realizarBusqueda(busqueda, pagina, max_registros);
		resultados = user.totalResultados(busqueda);
		paginas = (int) Math.ceil((double)resultados/(double)max_registros);
			
		session.setAttribute("resultadoBusqueda", resultado);
		session.setAttribute("resultadosBusqueda", resultados);
		session.setAttribute("paginasBusqueda", paginas);
		
		response.sendRedirect("../busqueda?q="+busqueda+"&p="+pagina);
			
	%>
</body>
</html>