<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Programador.MProgramador" %>
<%@ page import="java.util.ResourceBundle" %>
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
    <title>nexcript > Contacto</title>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/src/images/favicon.png">
    <%
    	ResourceBundle i18n = ResourceBundle.getBundle("i18n.i18n", response.getLocale());
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
          <li class="nav dropdown">
            <a class="nav-link" href="#" id="options" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              <i class="bi bi-translate"></i>
            </a>
            <div class="dropdown-menu" aria-labelledby="options">
              <a class="dropdown-item" href="setLocale?lang=es_ES"><span class="flag-icon flag-icon-es"></span> <%=i18n.getString("lang.es") %></a>
			  <a class="dropdown-item" href="setLocale?lang=en_US"><span class="flag-icon flag-icon-us"></span> <%=i18n.getString("lang.us") %></a> 
		      <a class="dropdown-item" href="setLocale?lang=fr_FR"><span class="flag-icon flag-icon-fr"></span> <%=i18n.getString("lang.fr") %></a> 
	          <a class="dropdown-item" href="setLocale?lang=de_DE"><span class="flag-icon flag-icon-de"></span> <%=i18n.getString("lang.de") %></a> 
            </div>
          </li>
        </div>
      </nav>
	<div class="container mt-5">
        <div class="row d-flex mt-5 justify-content-between ">
        	<div class="col-md-4">
        		<img src="${pageContext.request.contextPath}/src/images/contacto.webp" class="img-fluid"/>
        	</div>
        	<div class="col-md-8 text-light p-5">
        		<h1 class="text-primary mb-1"><%=i18n.getString("contact.page.title") %></h1>
        		<small class="text-muted"><%=i18n.getString("contact.page.subtitle") %></small>
        		
        		<form method="POST" action="contacto">
        		
	        		<div class="form-group text-muted font-weight-bold pt-3">
	                    <label for="mail"><%=i18n.getString("contact.mail.label") %></label>
	                    <div class="input-group mb-2">
				          <div class="input-group-prepend">
				            <div class="input-group-text">
				              <i class="bi bi-envelope"></i>
				            </div>
				          </div>
				          <input type="email" class="form-control" name="mail" aria-describedby="emailHelp" placeholder="<%=i18n.getString("login.mail.placeholder") %>" required>
				        </div>
	                </div>
	                
	                <div class="form-group text-muted font-weight-bold pt-3">
	                    <label for="nombre"><%=i18n.getString("contact.name.label") %></label>
	                    <div class="input-group mb-2">
				          <div class="input-group-prepend">
				            <div class="input-group-text">
				              <i class="bi bi-person"></i>
				            </div>
				          </div>
				          <input type="text" class="form-control" name="nombre" placeholder="<%=i18n.getString("contact.name.label") %>" required>
				        </div>
	                </div>
	                
	                <div class="form-group text-muted font-weight-bold pt-3">
	                    <label for="mail"><%=i18n.getString("contact.message.label") %></label>
	                    <div class="input-group mb-2">
				          <div class="input-group-prepend">
				            <div class="input-group-text">
				              <i class="bi bi-pencil"></i>
				            </div>
				          </div>
				          <textarea class="form-control" name="mensaje" rows="4" required></textarea>
				        </div>
	                </div>
                
                	<button type="submit" class="btn btn-primary btn-block mt-4"><i class="bi bi-forward"></i> <%=i18n.getString("contact.button.send") %></button>
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
        </div>
    </div>
    <jsp:include page="footer.jsp"></jsp:include>
	<script src="https://kit.fontawesome.com/5d273a2576.js" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</body>
</html>