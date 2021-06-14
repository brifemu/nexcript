<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="et" uri="etiquetas.tld"%>
<%@ page import="Programador.MProgramador" %>
<%@ page import="Codigo.MAportacion" %>
<%@ page import="Publicacion.MPublicacion" %>
<%@ page import="java.util.ResourceBundle" %>
<%@ page import="java.util.Locale" %>
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
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/devicons/devicon@v2.11.0/devicon.min.css">
    <title>nexcript > Perfil</title>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/src/images/favicon.png">
    <script>
    	function pasarID(id){
    		document.getElementById("idReply").value = id;
    	}
    	
    	function pasarIDBorrar(id){
    		document.getElementById("idDelete").value = id;
    	}
    </script>
    <%    
    	ResourceBundle i18n = ResourceBundle.getBundle("i18n.i18n", response.getLocale());
    	String locale = response.getLocale().toString();
    	MProgramador user = (MProgramador) session.getAttribute("user");
    	MProgramador perfil;
    	MProgramador creador;
    	int[] likes;
    	int[] respuestas;
    	boolean userbloqueado;
    	boolean bloqueado;
    	String formatFecha;
    	boolean likeado[];
    	
    	String username = request.getParameter("p");
    	perfil = (MProgramador) session.getAttribute("perfil.data");
    	userbloqueado = (boolean) session.getAttribute("perfil.user.bloqueado");
    	bloqueado = (boolean) session.getAttribute("perfil.bloqueado");
    	
    	
    	
    	MPublicacion publicacion = new MPublicacion();
    	int totalPublicaciones = publicacion.contador(perfil.getId());
    	
    	MPublicacion[] publicaciones = (MPublicacion[]) session.getAttribute("perfil.publicaciones");
    	likes = (int[]) session.getAttribute("perfil.publicaciones.likes");
    	respuestas = (int[]) session.getAttribute("perfil.publicaciones.respuestas");
    	likeado = (boolean[]) session.getAttribute("perfil.publicaciones.likes.propios");
    	
    	MAportacion aportacion = new MAportacion();
    	int totalAportaciones = aportacion.contador(perfil.getId());
    	MAportacion[] aportaciones = (MAportacion[]) session.getAttribute("perfil.aportaciones");
    	
    	boolean perfilPropio = user.getUsername().equals(username) ? true : false;
    		
    %>
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
            <li class="nav-item mr-4 active">
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
        <div class="row d-flex flex-row justify-content-between pt-5">
        <%
        	if(session.getAttribute("error-perfil") != null){  	
        %>
        		<div class="alert alert-danger mt-4 w-100" role="alert"><%= (String) session.getAttribute("error-perfil") %></div>
        <%
        	session.setAttribute("error-perfil", null);
        	} else {
        		if(!bloqueado) {
        			formatFecha = new SimpleDateFormat("dd/MM/yyyy").format(perfil.getFechaRegistro());
        %>
          <div class="col-md-3 d-flex flex-column align-items-center">
		    <img class="profile-big mb-3" src="ImagenProgramador?id=<%=perfil.getId() %>" alt="<%=i18n.getString("img.profile.alt") %>"/>
            <span class="text-primary font-weight-bold "><%=perfil.getNombre() %></span>
            <span class="text-primary font-italic">@<%=perfil.getUsername() %></span>
            <hr/>
            <div class="d-flex flex-column align-items-center">
            	<span><i class="bi bi-clock-history"></i> <%=formatFecha %></span>
            	<span><i class="bi bi-award"></i> <%=perfil.getLenguaje() %></span>
                <span><i class="bi bi-geo-alt"></i> <%=perfil.getCiudad() %></span>
                <span><%=perfil.getProvincia() %> - <%=perfil.getPais() %></span>
               	<hr/>
                <span><i class="bi bi-stickies"></i> <%=totalPublicaciones %> <i class="bi bi-code-slash"></i> <%=totalAportaciones %></span>      
            </div>

            <%
            	if(!perfilPropio) {
            %>
<%--             		<a class="btn btn-success btn-block mt-4" href="peticionAmistad?id=<%=perfil.getId()%>"><i class="bi bi-emoji-smile"></i> <%=i18n.getString("profile.send.friend") %></a>
 --%>            		<a class="btn btn-danger btn-block mt-2" href="bloquear?bloq=<%=perfil.getUsername()%>"><i class="bi bi-exclamation-diamond"></i> <%= userbloqueado ? i18n.getString("profile.unblock") : i18n.getString("profile.block") %></a>
            <%
            	}
            %>
          </div>
          <div class="col-md-8">
            <ul class="nav nav-tabs">
              <li class="nav-item">
                <a class="nav-link active" data-toggle="tab" href="#publicaciones"><i class="bi bi-stickies"></i> <%=i18n.getString("profile.publications.tab") %></a>
              </li>
              <li class="nav-item">
                <a class="nav-link" data-toggle="tab" href="#aportaciones"><i class="bi bi-code-slash"></i> <%=i18n.getString("profile.code.tab") %></a>
              </li>
            </ul>
            
            <div class="tab-content">
              <div class="tab-pane container mt-2 active" id="publicaciones">
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
                <%	if(totalPublicaciones > 0){
						for(int i = 0; i < publicaciones.length; i++) { 
							if(publicaciones[i] != null) {
								formatFecha = new SimpleDateFormat("EEE d MMM yyyy HH:mm").format(publicaciones[i].getFecha());
				%>
								<div class="row mt-5">
									<img class="profile-medium" src="ImagenProgramador?id=<%=publicaciones[i].getUsuario() %>" alt="<%=i18n.getString("img.profile.alt") %>"/>
					                <div class="col-md-10 d-flex flex-column pl-4 pr-2">
					                  <div class="d-flex flex-row justify-content-between">
						                  	<div>
						                  		<a href="perfil?p=<%=publicaciones[i].getPuUsername() %>" class="text-primary font-weight-bold"><%=publicaciones[i].getPuNombre() %></a>
						                  		<a class="text-muted small" href="publicacion?id=<%=publicaciones[i].getId()%>"><%=formatFecha %></a>
						                  	</div>
					                    
					                    
						                    <div>
						                    	<a type="button" class="btn <%=likeado[i] ? "btn-like" : "btn-light" %>" href="like?id=<%=publicaciones[i].getId()%>">
												  <i class="bi bi-heart"></i> <span class="badge badge-light"><%=likes[i]%></span>
												</a>
						                    	<button type="button" class="btn btn-light" data-toggle="modal" data-target="#modalResponder" onclick="pasarID(<%=publicaciones[i].getId()%>);"><i class="bi bi-reply"></i></button>
						                    	<% if(perfilPropio) {%>
						        						<button type="button" class="btn btn-danger" data-toggle="modal" data-target="#modalEliminar" onclick="pasarIDBorrar(<%=publicaciones[i].getId()%>);"><i class="bi bi-trash"></i></button>
						            			<%} %>
						                    </div>				                    	
					                  </div>
					                  
					                  <span class="mt-2"><%=publicaciones[i].getContenido() %></span><br>
					                  <% 	if(respuestas[i] > 0) { %>					                    	
					                    		<a class="text-muted mt-2 font-italic" href="publicacion?id=<%=publicaciones[i].getId() %>"><i class="bi bi-reply-all"></i> <%=i18n.getString("profile.publication.reply.list") %> (<%=respuestas[i]%>)</a>
					                    	<% 	} %>
					                  <%
					                  	if(publicaciones[i].getImagen() != null) {
					                  %>
					                  <img class="img-fluid mt-4" src="ImagenPublicacion?id=<%=publicaciones[i].getId() %>" alt="<%=i18n.getString("img.publication.alt") %>"/>
					                  <%
					                  	}
					                  %>
					                </div>
					              </div>
				<%     		}
						}
					} else { %>
						<div class="alert alert-danger mt-3" role="alert">
						  <%=i18n.getString("profile.publications.none") %>
						</div>
				<%	}	%>
              </div>
              <div class="tab-pane container mt-2" id="aportaciones">
                <%	if(totalAportaciones > 0){
						for(int i = 0; i < aportaciones.length; i++) { 
							if(aportaciones[i] != null){
								formatFecha = new SimpleDateFormat("EEE d MMM yyyy HH:mm").format(aportaciones[i].getFecha());
				%>
								<div class="row code d-flex flex-row justify-content-between mb-4 mt-5">
					              <div class="col-md-1">
					                <i class="<%= aportaciones[i].getIcono()%>"></i>
					              </div>
					              <div class="col-md-11 d-flex flex-column pl-5">
					                <a class="text-primary font-weight-bold" href="aporte?id=<%= aportaciones[i].getId()%>"><%= aportaciones[i].getTitulo()%></a>
					                <small><%=i18n.getString("contribution.by") %> <a class="text-secondary" href="perfil?p=<%= aportaciones[i].getUsername()%>">@<%= aportaciones[i].getUsername()%></a> - <%= formatFecha%></small>
					                <small><%=aportaciones[i].getDescripcion() %></small>
					              </div>
					            </div>
				<% 			}
						}
					} else { %>
						<div class="alert alert-danger mt-3" role="alert">
						  <%=i18n.getString("profile.code.none") %>
						</div>
				<%	}	%>
              </div>
            </div>
          </div>
        <%
        		} else { %>
        			<div class="alert alert-danger mt-3 w-100" role="alert">
						 <%=i18n.getString("profile.error.block") %>
					</div>     			
        <%			
        		}
        	} 
        %>
        </div>
      </div>
      
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
    <jsp:include page="footer.jsp"></jsp:include>
	<script src="https://kit.fontawesome.com/5d273a2576.js" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</body>
</html>