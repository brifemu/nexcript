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
		ResourceBundle i18n;
		String busqueda;
		MProgramador user;
		
		int max_registros;	
		int pagina;
		int paginas;
		int resultados;
		int contador;
		MProgramador[] resultado;
		
		user = (MProgramador) session.getAttribute("user");
		max_registros = 4;
		pagina = 1;
		contador = 0;
		
		if(session.getAttribute("locale") != null) response.setLocale((Locale)session.getAttribute("locale"));
		i18n = ResourceBundle.getBundle("i18n.i18n", response.getLocale());
	
		//Controlamos los parametros que arrastramos por la URL
		if(request.getParameter("q") == null) busqueda = BusquedaForm.getBusqueda();
		else busqueda = request.getParameter("q");
				
		if(request.getParameter("p") == null) pagina = 1;
		else {
			try {
				pagina = Integer.parseInt((String) request.getParameter("p"));
				if(pagina == 0) pagina = 1;
			} catch (Exception e) {
				response.sendRedirect("../../inicio");
			}
		}
		
		//Controlamos las páginas y realizamos la búsqueda
		if(pagina < 1) session.setAttribute("error", "Página inválida");
		resultado = user.realizarBusqueda(busqueda, pagina, max_registros);
		resultados = user.totalResultados(busqueda);
		for(int i = 0; i < max_registros; i++){
			if(resultado[i] != null) contador++;
		}
		paginas = (int) Math.ceil((double)resultados/(double)max_registros);
		if(pagina > paginas) session.setAttribute("error", "Página inválida");
		
		//Seteamos los atributos de sesión
		session.setAttribute("busqueda.data", resultado);
		session.setAttribute("busqueda.resultados.totales", resultados);
		session.setAttribute("busqueda.resultados.consulta", contador);
		session.setAttribute("busqueda.paginas", paginas);
			
		
		
		response.sendRedirect("../../busqueda?q="+busqueda+"&p="+pagina);
			
	%>
</body>
</html>