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
    <title>nexcript</title>
    <%
    	ResourceBundle i18n = ResourceBundle.getBundle("i18n.i18n", response.getLocale());
    	MProgramador user = (MProgramador) session.getAttribute("user");
    	byte[] cv = user.getCurriculum();
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
              <a class="nav-link" href="perfil?p=<%= user.getUsername()%>"><i class="bi bi-person-badge-fill"></i> <%=i18n.getString("nav.profile") %></a>
            </li>
            <li class="nav-item mr-4">
              <a class="nav-link" href="codigo"><i class="bi bi-file-earmark-code-fill"></i> <%=i18n.getString("nav.code") %></a>
            </li>
            <li class="nav-item mr-4 active">
              <a class="nav-link" href="empleo"><i class="bi bi-briefcase-fill"></i> <%=i18n.getString("nav.job") %></a>
            </li>
            <li class="nav-item mr-4">
              <a class="nav-link" href="contacto"><i class="bi bi-mailbox2"></i> <%=i18n.getString("nav.contact") %></a>
            </li>
          </ul>
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
          <li class="nav dropdown">
            <a class="nav-link" href="#" id="chats" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              <i class="bi bi-chat-left-dots"></i>
            </a>
            <div class="dropdown-menu" aria-labelledby="chats">
              <a class="dropdown-item text-center font-italic" href="#"><%=i18n.getString("chats.default") %></a>
            </div>
          </li>
          <li class="nav dropdown">
            <a class="nav-link" href="#" id="notifications" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              <i class="bi bi-bell"></i>
            </a>
            <div class="dropdown-menu" aria-labelledby="notifications">
              <a class="dropdown-item text-center font-italic" href="#"><%=i18n.getString("notifications.default") %></a>
            </div>
          </li>
        
          <li class="nav dropdown">
            <a class="nav-link" href="#" id="options" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              <i class="bi bi-gear"></i>
            </a>
            <div class="dropdown-menu" aria-labelledby="options">
              <a class="dropdown-item" href="editar-perfil"><i class="bi bi-pencil-square"></i> <%=i18n.getString("settings.edit") %></a>
              <div class="dropdown-divider"></div>
              <a class="dropdown-item" href="logout"><i class="bi bi-door-closed"></i> <%=i18n.getString("settings.logout") %></a>
            </div>
          </li>

          <form method="post" action ="${pageContext.request.contextPath}/beans/barra-busqueda.jsp">
            <div class="input-group">
              <input type="text" class="input-ol form-control" name="busqueda" placeholder="<%=i18n.getString("searchbox.placeholder") %>" required/>
              <span class="input-group-btn">
                <button class="btn btn-primary rounded" type="submit">
                  <i class="bi bi-search"></i>
                </button>
               </span>
            </div>
          </form>
        </div>
      </nav>
	<div class="container mt-5">
        <div class="row d-flex mt-5 justify-content-between ">
        	<div class="col-md-4">
        		<img src="${pageContext.request.contextPath}/src/images/empleo.webp" class="img-fluid"/>
        	</div>
        	<div class="col-md-8 text-light p-5 bg-secondary">
        	<% if(cv == null) { %>
        		 <h1><%=i18n.getString("job.title") %></h1>
		         <p><%=i18n.getString("job.p1") %></p>
		         <p><%=i18n.getString("job.p2") %></p>

		         <form method="post" action="${pageContext.request.contextPath}/beans/subirCurriculum.jsp" enctype="multipart/form-data">
		         	<input type="file" name="cv" accept="application/pdf" required>
		         	<button class="form-control btn-dark mt-4" type="submit"><i class="bi bi-file-earmark-arrow-up"></i> <%=i18n.getString("job.button.upload") %></button>  
		         </form>
		    <%
		      } else {
		    %> 
		    	<h1><%=i18n.getString("job.title") %></h1>
		         <p><%=i18n.getString("job.uploaded.p1") %> <%=user.getFechaCurriculum() %></p>
		         <p><%=i18n.getString("job.uploaded.p2") %></p>
		         
		         <form method="post" action="${pageContext.request.contextPath}/beans/subirCurriculum.jsp" enctype="multipart/form-data">
		         	<input type="file" name="cv" accept="application/pdf" required>
		         	<button class="form-control btn-dark mt-4" type="submit"><i class="bi bi-file-earmark-break"></i> <%=i18n.getString("job.button.update") %></button>
		         	<a class="form-control btn-dark mt-4 text-center" href="descargarCurriculum" target="_blank"><i class="bi bi-file-earmark-arrow-down"></i> <%=i18n.getString("job.button.download") %></a>
		         	<a class="form-control btn-dark mt-4 text-center" href="eliminarCurriculum"><i class="bi bi-file-earmark-x"></i> <%=i18n.getString("job.button.delete") %></a>  
		         </form>
		    <%
		      } 
		    %>     
        	</div>
        </div>
        <%
          if(session.getAttribute("error") != null) {%>
             <div class="alert alert-danger mt-4" role="alert"><%= (String) session.getAttribute("error") %></div>
        <%
              session.setAttribute("error", null);
           }
        %>
    </div>
    <footer class="page-footer font-small bg-light  text-muted pt-3">
	  <div class="container">
	    <ul class="list-unstyled list-inline text-center">
	      <li class="list-inline-item">
	        <a class="btn-floating btn-fb text-muted mx-1" href="https://www.instagram.com/brifemu" target="_blank">
	          <i class="fab fa-instagram"> </i>
	        </a>
	      </li>
	      <li class="list-inline-item">
	        <a class="btn-floating btn-tw text-muted mx-1" href="https://twitter.com/brifemu" target="_blank">
	          <i class="fab fa-twitter"> </i>
	        </a>
	      </li>
	      <li class="list-inline-item">
	        <a class="btn-floating btn-li mx-1 text-muted" href="https://www.linkedin.com/in/brifemu" target="_blank">
	          <i class="fab fa-linkedin-in"> </i>
	        </a>
	      </li>
	      <li class="list-inline-item">
	        <a class="btn-floating btn-dribbble text-muted mx-1" href="https://github.com/brifemu" target="_blank">
	          <i class="fab fa-github"> </i>
	        </a>
	      </li>
	    </ul>
	  </div>
	  <div class="footer-copyright text-center">
	  	<a class="text-muted" href="aviso-legal" target="_blank">Aviso Legal</a> - 
	    <a class="text-muted" href="privacidad" target="_blank">Política de privacidad</a> - 
	    <a class="text-muted" href="cookies" target="_blank">Política de cookies</a> - 
	    <a class="text-muted" href="contacto">Contacto</a>
	  </div>
	  <div class="footer-copyright text-center py-3">© 2021 Copyright
	    <a class="text-muted" href="https://www.linkedin.com/in/brifemu" target="_blank"> nexcript</a>
	  </div>
	</footer>
	<script src="https://kit.fontawesome.com/5d273a2576.js" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</body>
</html>