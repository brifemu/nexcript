<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Programador.MProgramador" %>
<%@ page import="Publicacion.MPublicacion" %>
<%@ page import="Publicacion.MRespuesta" %>
<%@ page import="java.util.ResourceBundle" %>
<%@ page import="java.text.SimpleDateFormat" %>
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
	<title>nexcript > Publicación</title>
	<link rel="icon" type="image/png" href="${pageContext.request.contextPath}/src/images/favicon.png">
</head>
<script>
    	function pasarID(id){
    		document.getElementById("idReply").value = id;
    	}
    	
    	function pasarIDBorrar(id){
    		document.getElementById("idDelete").value = id;
    	}
</script>
<body>
<%
    	MProgramador user;
    	ResourceBundle i18n;
    	MPublicacion publicacion;
    	MRespuesta[] respuestas;
    	String[] posteador;
    	int likes;	
    	String formatFecha;
    	String[][] responde;
    	boolean perfilPropio;
    	boolean likeado;
    	
    	user = (MProgramador) session.getAttribute("user");
    	i18n = ResourceBundle.getBundle("i18n.i18n", response.getLocale());
    	publicacion = (MPublicacion) session.getAttribute("publicacion.data");
    	respuestas = (MRespuesta[]) session.getAttribute("publicacion.respuestas");
    	posteador = (String[]) session.getAttribute("publicacion.creador");
    	likes = (int) session.getAttribute("publicacion.likes");
    	responde = (String[][]) session.getAttribute("publicacion.responde");
    	perfilPropio = false;
%>

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

          <form method="post" action ="busqueda">
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
      <%
             if(session.getAttribute("exito") != null) {%>
                	<div class="alert alert-success mt-3" role="alert"><%= (String) session.getAttribute("exito") %></div>
      <%
                	session.setAttribute("exito", null);    
             }

             if(session.getAttribute("error") != null) {%>
                	<div class="alert alert-danger mt-3" role="alert"><%= (String) session.getAttribute("error") %></div>
      <%
                	session.setAttribute("error", null);               	
      %>
      <% 			
      		} else {
      			perfilPropio = user.getId() == publicacion.getUsuario() ? true : false;
      			likeado = (boolean) session.getAttribute("publicacion.likeada");
      			formatFecha = new SimpleDateFormat("EEE d MMM yyyy HH:mm").format(publicacion.getFecha());
      %>
      				<div class="row mt-5 border border-secondary rounded p-5 d-flex justify-content-center ">
						<img class="profile-medium" src="ImagenProgramador?id=<%=Integer.parseInt(posteador[2]) %>" alt="<%=i18n.getString("img.profile.alt") %>"/>
					    <div class="col-md-10 d-flex flex-column pl-4 pr-2">
					    	<div class="d-flex flex-row justify-content-between">
						    	<div>
						        	<a href="perfil?p=<%=posteador[0] %>" class="text-primary font-weight-bold"><%=posteador[1] %></a>
						            <small class="text-muted"><%=formatFecha %></small>
						        </div>					                    					                    
						        <div>
						            <a type="button" class="btn <%=likeado ? "btn-like" : "btn-light" %>" href="like?id=<%=publicacion.getId()%>">
										<i class="bi bi-heart"></i> <span class="badge badge-light"><%=likes%></span>
									</a>
						            <button type="button" class="btn btn-light" data-toggle="modal" data-target="#modalResponder" onclick="pasarID(<%=publicacion.getId()%>);"><i class="bi bi-reply"></i></button>
						        	<% if(perfilPropio) {%>
						        			<button type="button" class="btn btn-danger" data-toggle="modal" data-target="#modalEliminar" onclick="pasarIDBorrar(<%=publicacion.getId()%>);"><i class="bi bi-trash"></i></button>
						            <%} %>
						        </div>				                    	
					      	</div>
					                  
					        <span><%=publicacion.getContenido() %></span>
					        <% 
					           if(publicacion.getImagen() != null) {
					        %>
					                  <img class="img-thumbnail mt-4" src="ImagenPublicacion?id=<%=publicacion.getId() %>" alt="<%=i18n.getString("img.publication.alt") %>"/>
					        <%
					           }
					        %>
						</div>
					</div>
					<%
						if(respuestas != null) {
							for(int i = 0; i < respuestas.length; i++) {
								formatFecha = new SimpleDateFormat("EEE d MMM yyyy HH:mm").format(respuestas[i].getFecha());
					%>
								<div class="row ml-5 mt-2 p-5 border border-secondary rounded p-5 d-flex justify-content-center">
									<img class="profile-medium" src="ImagenProgramador?id=<%=Integer.parseInt(responde[i][2]) %>" alt="<%=i18n.getString("img.profile.alt") %>"/>
					    			<div class="col-md-10 d-flex flex-column pl-4 pr-2">
								    	<div class="d-flex flex-row justify-content-between">
									    	<div>
									        	<a href="perfil?p=<%=responde[i][0] %>" class="text-primary font-weight-bold"><%=responde[i][1] %></a>
									            <small class="text-muted"><%=formatFecha %></small>
									        </div>					                    					                    			                    	
								      	</div>			                  
					        			<span><%=respuestas[i].getContenido() %></span>
									</div>
								</div>			
					<%			
							}
					
						} %>
      <%	} %>
      </div>
    <jsp:include page="footer.jsp"></jsp:include>
	
	<div class="modal fade" id="modalResponder" tabindex="-1" role="dialog" aria-labelledby="modalResponder" aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modalResponder"><%=i18n.getString("profile.publication.reply.title") %></h5>
				    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				    	<span aria-hidden="true">&times;</span>
				    </button>
				</div>
				<div class="modal-body">
					<form action="respuesta" method="post">
						<input type="text" name="id" id="idReply" class="d-none"/>
						<textarea class="publication" name="contenido" cols="100" rows="4" maxlength="240" required></textarea>
						<div class="modal-footer">
							<button type="submit" class="btn btn-success text-center" ><i class="bi bi-reply"></i> <%=i18n.getString("profile.publication.reply.button") %></button>
						</div>					
					</form>
				</div>
			</div>
		</div>
	</div>
	
	<div class="modal fade" id="modalEliminar" tabindex="-1" role="dialog" aria-labelledby="modalEliminar" aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header">
				    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				    	<span aria-hidden="true">&times;</span>
				    </button>
				</div>
				<div class="modal-body">
					<form action="eliminarPublicacion" method="post">
						<input type="text" name="id" id="idDelete" class="d-none"/>
						<div class="row d-flex flex-column justify-content-center text-center">
								<i class="bi bi-exclamation-octagon" style="color: #c0392b; font-size: 5em !important;"></i>
								<p><%=i18n.getString("publication.confirm.delete") %></p>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-danger text-center" data-dismiss="modal"><i class="bi bi-x-lg"></i></button>
							<button type="submit" class="btn btn-success text-center" ><i class="bi bi-check-lg"></i></button>
						</div>					
					</form>
				</div>
			</div>
		</div>
	</div>
	<script src="https://kit.fontawesome.com/5d273a2576.js" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</body>
</html>