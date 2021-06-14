<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="Programador.MProgramador" %>
<%@ page import="Codigo.MAportacion" %>
<%@ page import="java.util.ResourceBundle" %>
<%@ page import="java.text.SimpleDateFormat" %>
<html>
<head>
	<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/sass/styles.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.5.0/css/flag-icon.min.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/devicons/devicon@v2.11.0/devicon.min.css">
    <title>nexcript > Inicio</title>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/src/images/favicon.png">
    <%
    	MProgramador user = (MProgramador) session.getAttribute("user");
    	ResourceBundle i18n = ResourceBundle.getBundle("i18n.i18n", response.getLocale());

    	MAportacion[] aportaciones = (MAportacion[]) session.getAttribute("inicio.aportaciones");
    	String formatFecha;
    	int nAportaciones = 0;
    	for(int i = 0; i < aportaciones.length; i++){
    		if(aportaciones[i] != null) nAportaciones++;
    	}
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
            <li class="nav-item mr-4">
              <a class="nav-link" href="empleo"><i class="bi bi-briefcase-fill"></i> <%=i18n.getString("nav.job") %></a>
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

          <form method="post" action="busqueda">
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
      <div class="container">
        <div class="row pt-5 d-flex flex-row align-content-center flex-wrap">
		  <img class="profile-big" src="ImagenProgramador?id=<%=user.getId() %>"/>      
          <div class="d-flex flex-column pl-5">
            <span class="display-4 text-primary">
              <%=user.getNombre() %>
            </span> 
            <a class="display-4 text-primary" href="perfil?p=<%=user.getUsername()%>" >@<%=user.getUsername() %></a>
          </div>
        </div>
        <div class="row pt-5 d-flex justify-content-between">
          <div class="col-md-7">
          
            <form id="form" method="post" action="inicio" enctype="multipart/form-data">
              <h2 class="text-primary pb-3"><%=i18n.getString("index.publications.title") %></h2>
              <textarea class="publication" name="contenido" cols="100" rows="4" maxlength="240" required></textarea>
              <div class="row d-flex flex-row justify-content-between p-3">
              	<div>
              		<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modalFoto"><i class="bi bi-images"></i></button>
              		<span id="fileName"></span>
              	</div>
              	<button type="submit" class="btn btn-primary text-center"><i class="bi bi-cloud-upload"></i> <%=i18n.getString("index.publications.button.publish") %></button>
              </div>
              
              <div class="modal fade" id="modalFoto" tabindex="-1" role="dialog" aria-labelledby="modalFoto" aria-hidden="true">
				  <div class="modal-dialog modal-lg" role="document">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h5 class="modal-title" id="modalFoto"><%=i18n.getString("index.image.modal.title") %></h5>
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				          <span aria-hidden="true">&times;</span>
				        </button>
				      </div>
				      <div class="modal-body">
				        <div class="file-loading">
				          <input type="file" name="foto" id="foto" onchange="PreviewImage();" accept="image/*">
				        </div>
				        <img src="" id="preview" class="img-thumbnail">
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-danger" onclick="LimpiarImage();"data-dismiss="modal"><i class="bi bi-trash-fill"></i></button>
				        <button type="button" class="btn btn-success" data-dismiss="modal"><i class="bi bi-check-lg"></i></button>
				      </div>
				    </div>
				  </div>
				</div>
              
			  
            </form>
            	<%
                	if(session.getAttribute("error") != null) {%>
                		<div class="alert alert-danger mt-3" role="alert"><%= (String) session.getAttribute("error") %></div>
                <%
                		session.setAttribute("error", null);
                	}
                %>
                <%
                	if(session.getAttribute("exito") != null) {%>
                		<div class="alert alert-success mt-3" role="alert"><%= (String) session.getAttribute("exito") %></div>
                <%
                		session.setAttribute("exito", null);
                	}
                %>
            <div id="publications" class="pt-5 ml-3 mr-3">
            	
            </div>
            
          </div>

          <div class="col-md-4 col-lg-offset-3" style="position: -webkit-sticky;position: sticky; top: 20px;">
            <h2 class="text-primary pb-3"><%=i18n.getString("index.code.title") %></h2>
            
            <%	if(nAportaciones > 0){
						for(int i = 0; i < aportaciones.length; i++) { 
							if(aportaciones[i] != null) {
								formatFecha = new SimpleDateFormat("EEE d MMM yyyy").format(aportaciones[i].getFecha());
				%>
							<div class="row code d-flex flex-row justify-content-between mb-4">
				              <div class="col-md-1">
				                <i class="<%= aportaciones[i].getIcono()%>"></i>
				                
				              </div>
				              <div class="col-md-10 d-flex flex-column pl-5">
				                <a class="text-primary font-weight-bold" href="aporte?id=<%= aportaciones[i].getId()%>"><%= aportaciones[i].getTitulo()%></a>
				                <small><%=i18n.getString("contribution.by") %> <a class="text-secondary" href="perfil?p=<%=aportaciones[i].getUsername()%>">@<%=aportaciones[i].getUsername()%></a> - <%= formatFecha%></small>
				              </div>
				            </div>
				<%     		}
						}
					} else { %>
						<div class="alert alert-danger mt-3" role="alert">
						  <%=i18n.getString("index.code.nodata") %>
						</div>
				<%	}	%>
          </div>
        </div>
      </div>
    
	<jsp:include page="footer.jsp"></jsp:include>
	
	<script src="https://kit.fontawesome.com/5d273a2576.js" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.0/jquery.validate.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/js/formValidation/publicacion.js"></script>
</body>
</html>