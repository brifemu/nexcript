<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Programador.MProgramador" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/sass/styles.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.5.0/css/flag-icon.min.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/src/images/favicon.png">
	<title>nexcript > Desarrolladores</title>
	<%
		ArrayList<MProgramador> desarrolladores;
	
		desarrolladores = (ArrayList<MProgramador>) session.getAttribute("desarrolladores");
	%>
</head>
<body>
	<nav class="navbar navbar-expand-lg sticky-top">
        <a href="inicio">
          <img class="img-fluid mr-5" src="${pageContext.request.contextPath}/src/images/dark_logo.webp" alt="nexcript" width="200">
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon">
            <i class="bi bi-list"></i>
          </span>
        </button>
      
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav mr-auto">
            <li class="nav-item mr-4">
              <a class="nav-link active" href="empresa-desarrolladores"><i class="bi bi-people"></i> DESARROLLADORES</a>
            </li>
          </ul>
        </div>
        <a class="nav-link" href="empresa-editar-perfil"><i class="bi bi-pencil-square"></i></a>
       	<a class="nav-link" href="logout"><i class="bi bi-door-closed"></i></a>
      </nav>
	<div class="container pt-5 bt-5">
			<%
            	if(session.getAttribute("error") != null) {%>
                	<div class="alert alert-danger" role="alert"><%= (String) session.getAttribute("error") %></div>
          	<%
              		session.setAttribute("error", null);
             	}
          	%>
		<h1 class="text-primary mb-5">Desarrolladores en busca de empleo</h1>
		<% 	if(desarrolladores.size() == 0) { %>
				<div class="alert alert-danger" role="alert">Actualmente no hay desarrolladores demandando empleo</div>
		<%	} else { %>
				<table class="table table-bordered">
				  <thead>
				    <tr>
				      <th scope="col"></th>
				      <th scope="col">Nombre</th>
				      <th scope="col">Lenguaje destacado</th>
				      <th scope="col">Pais</th>
				      <th scope="col">Provincia</th>
				      <th scope="col">Ciudad</th>
				      <th scope="col">CV</th>
				    </tr>
				  </thead>
				  <tbody>
				  	<% 	for(MProgramador desarrollador:desarrolladores) { %>
				    <tr>
				      <th scope="row"><img class="profile-small" src="ImagenProgramador?id=<%=desarrollador.getId() %>"/></th>
				      <td><%=desarrollador.getNombre()%></td>
				      <td><%=desarrollador.getLenguaje()%></td>
				      <td><%=desarrollador.getPais()%></td>
				      <td><%=desarrollador.getProvincia()%></td>
				      <td><%=desarrollador.getCiudad()%></td>
				      <td><a class="btn btn-primary" href="curriculum?id=<%=desarrollador.getId()%>" target="_blank"><i class="bi bi-file-earmark-pdf"></i></a></td>
				    </tr>
				    <%	} %>
				  </tbody>
				</table>
		<%	} %>
	</div>
	<jsp:include page="../footer.jsp"></jsp:include>
	<script src="https://kit.fontawesome.com/5d273a2576.js" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.0/jquery.validate.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</body>
</html>