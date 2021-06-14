<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ResourceBundle" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/sass/styles.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/devicons/devicon@v2.11.0/devicon.min.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.5.0/css/flag-icon.min.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
    <title>nexcript - Administración</title>
</head>
<%
	ResourceBundle i18n = ResourceBundle.getBundle("i18n.i18n", response.getLocale());
%>
<body>

	<div class="container">
	
		<h1><%=i18n.getString("adm.programming.title") %></h1>
		
		<p class="text-danger">¡Importante consultar <a href="https://devicon.dev/" target="_blank">esta web</a> antes de insertar cualquier lenguaje!</p>
		<p class="text-muted">Campo 'Nombre': Insertar el nombre que el usuario va a ver en el selector</p>
		<p class="text-muted">Campo 'Valor': Insertar el valor que tendrá el selector, que es el mismo nombre que tiene el icono en la web de referencia</p>
		<p class="text-muted">Campo 'Icono': Insertar el atributo class que tendrá el icono, preferiblemente escoger iconos con color y que resalten sobre blanco</p>
		<form  method="POST" action="${pageContext.request.contextPath}/beans/admin/insertarLenguaje.jsp">
			<div class="form-group">
            	<label><%=i18n.getString("adm.programming.name.label") %></label>
                <div class="input-group mb-2">
			       	<div class="input-group-prepend">
			        	<div class="input-group-text">
			            	<i class="bi bi-type"></i>
			            </div>
			      	</div>
			       	<input type="text" class="form-control" name="nombre" required>
			 	</div>
         	</div>
         	
         	<div class="form-group">
            	<label><%=i18n.getString("adm.programming.value.label") %></label>
                <div class="input-group mb-2">
			       	<div class="input-group-prepend">
			        	<div class="input-group-text">
			            	<i class="bi bi-hash"></i>
			            </div>
			      	</div>
			       	<input type="text" class="form-control" name="valor" required>
			 	</div>
         	</div>
         	
         	<div class="form-group">
            	<label><%=i18n.getString("adm.programming.icon.label") %></label>
                <div class="input-group mb-2">
			       	<div class="input-group-prepend">
			        	<div class="input-group-text">
			            	<i class="bi bi-vector-pen"></i>
			            </div>
			      	</div>
			       	<input type="text" class="form-control" name="icono" required>
			 	</div>
         	</div>
         	
         	<button type="submit" class="btn btn-dark btn-block"><i class="bi bi-box-arrow-in-right"></i> <%=i18n.getString("adm.programming.insert") %></button>
		</form>
		
		<%
       		if(session.getAttribute("error") != null) {%>
            	<div class="alert alert-danger mt-4 w-100" role="alert"><%= (String) session.getAttribute("error") %></div>
	        <%
	                session.setAttribute("error", null);
	      		}
	        %>
	        <%
	       		if(session.getAttribute("exito") != null) {%>
	            	<div class="alert alert-success mt-4 w-100" role="alert"><%= (String) session.getAttribute("exito") %></div>
	        <%
	                session.setAttribute("exito", null);
	      		}
	        %>
	</div>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.0/jquery.validate.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
		integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
		crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
		integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
		crossorigin="anonymous"></script>
</body>
</html>