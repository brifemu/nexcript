<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<%@ page import="Programador.MProgramador" %>
<%@ page import="Codigo.MAportacion" %>
<%@ page import="Codigo.MComentario" %>
<%@ page import="java.util.ResourceBundle" %>
<%@ page import="Codigo.MLenguaje" %>
<%@ page import="java.text.SimpleDateFormat" %>
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
    <title>nexcript > Aporte</title>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/src/images/favicon.png">
    <script>
	    function pasarIDEliminar(id){
			document.getElementById("idDelete").value = id;
		}
	    function pasarIDEditar(id){
			document.getElementById("idUpdate").value = id;
		}
	    function pasarIDValorar(id){
	    	console.log("entra sin nota");
			document.getElementById("idRate").value = id;
		}
	    function limpiarValoracion(){
	    	var radio = document.querySelector('input[type=radio][name=rating]:checked');
	        radio.checked = false;
	    }
    </script>
    <%
    	MLenguaje[] lenguajes;
    	String media;
    	int valoraciones;
    	String nota;
    	lenguajes = (MLenguaje[]) session.getAttribute("listaLenguajes");
    	MProgramador user = (MProgramador) session.getAttribute("user");
    	ResourceBundle i18n = ResourceBundle.getBundle("i18n.i18n", response.getLocale());
    	MAportacion aporte = (MAportacion) session.getAttribute("aportacion.data");
    	String icono = (String) session.getAttribute("aportacion.icono");
    	String creador = (String) session.getAttribute("aportacion.creador");   
    	
    	MComentario[] comentarios = (MComentario[]) session.getAttribute("aportacion.comentarios");
    	String[][] comentadores = (String[][]) session.getAttribute("aportacion.comentadores");
    	
    	
    	boolean propio = aporte.getUsuario() == user.getId() ? true : false;
    	boolean valorado = (boolean) session.getAttribute("aportacion.valorada");
    	String formatFecha = new SimpleDateFormat("EEE d MMM yyyy HH:mm").format(aporte.getFecha());
    	
    	media = null;
    	valoraciones = 0;
    	if(session.getAttribute("aportacion.valoraciones") != null){
    		media = (String) session.getAttribute("aportacion.valoracionmedia");
    		valoraciones = (int) session.getAttribute("aportacion.valoraciones");
    	}
    	nota = null;
    	if(session.getAttribute("aportacion.valoracion") != null) nota = (String) session.getAttribute("aportacion.valoracion");
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
            <li class="nav-item mr-4 active">
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
        	if(session.getAttribute("exito") != null){  	
        %>
        		<div class="alert alert-success mt-4 w-100" role="alert"><%= (String) session.getAttribute("exito") %></div>
        <%
        		session.setAttribute("exito", null);
        	} 
        	if(session.getAttribute("error") != null){  	
        %>
        		<div class="alert alert-danger mt-4 w-100" role="alert"><%= (String) session.getAttribute("error") %></div>
        <%
        	session.setAttribute("error", null);
        	} else {
        %>
        		<div class="row mt-5">
        			<div class="col-md-2 code d-flex flex-column justify-content-center text-center">
        				<i class="<%=icono %>"></i>		
        					
        						<div class="dropdown show pt-2">
								  <a class="btn btn-secondary dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
								    <%=i18n.getString("contribution.actions.button") %>
								  </a>
								
								  <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
								  	<% if(propio) { %>
								    	<a class="dropdown-item" href="" data-toggle="modal" data-target="#modalEditar" onclick="pasarIDEditar(<%=aporte.getId()%>);"><i class="bi bi-pencil" style="font-size: 1.3em !important"></i> <%=i18n.getString("contribution.option.edit") %></a>
								    	<a class="dropdown-item" href="" data-toggle="modal" data-target="#modalEliminar" onclick="pasarIDEliminar(<%=aporte.getId()%>);"><i class="bi bi-trash" style="font-size: 1.3em !important"></i> <%=i18n.getString("contribution.option.delete") %></a>
								    <% } else { %>
								    	<a class="dropdown-item" href="" data-toggle="modal" data-target="#modalValorar" onclick="pasarIDValorar(<%=aporte.getId()%>);"><i class="bi bi-star-half" style="font-size: 1.3em !important"></i> <%=i18n.getString("contribution.option.rate") %></a>
								    <% } %>
								  </div>
								</div>
        				
        			</div>
        			<div class="col-md-10 d-flex flex-column">
        				<h1 class="text-primary mb-1"><%=aporte.getTitulo() %></h1>
        				<small><%=i18n.getString("contribution.by") %> <a href="perfil?p=<%=creador %>">@<%=creador %></a> - <%=formatFecha %></small>
        				<%
        				if(session.getAttribute("aportacion.valoraciones") != null) {
        				%>
        					<small><%=media %>/5 <i class="bi bi-star"></i> (<%=valoraciones %>) - <%=aporte.getLenguaje() %></small>
        				<%
        				} else {
        				%>
        					<small>N/A <i class="bi bi-star"></i> - <%=aporte.getLenguaje() %></small>
        				<%
        				}
        				%>
        			</div>
        		</div>
        		<div class="row mt-5 d-flex flex-column">
        			<h4 class="text-primary mb-1"><%=i18n.getString("contribution.description.title") %></h4>
					<p><%=aporte.getDescripcion() %></p>
        			<textarea class="publication" cols="100" rows="20" readonly><%=aporte.getContenido() %></textarea>
        		</div>
        		<a class="btn btn-primary mt-4" href="" data-toggle="modal" data-target="#modalComentar"><i class="bi bi-chat-right-quote" style="font-size: 1.3em !important"></i> Realizar comentario</a>
        		<div class="row mt-5 d-flex flex-column">
        			<h4 class="text-primary mb-1"><%=i18n.getString("contribution.comments.title") %> <%=comentarios!= null ? "("+comentarios.length+")" : "" %></h4>		
        			<%
						if(comentarios != null) {
							for(int i = 0; i < comentarios.length; i++) {
								formatFecha = new SimpleDateFormat("EEE d MMM yyyy HH:mm").format(comentarios[i].getFecha());
					%>
								<div class="row ml-5 mt-2 p-2 d-flex justify-content-center">
									<img class="profile-medium" src="ImagenProgramador?id=<%=Integer.parseInt(comentadores[i][2]) %>" alt="<%=i18n.getString("img.profile.alt") %>"/>
					    			<div class="col-md-10 d-flex flex-column pl-4 pr-2">
								    	<div class="d-flex flex-row justify-content-between">
									    	<div>
									        	<a href="perfil?p=<%=comentadores[i][0] %>" class="text-primary font-weight-bold"><%=comentadores[i][1] %></a>
									            <small class="text-muted"><%=formatFecha %></small>
									        </div>					                    					                    			                    	
								      	</div>			                  
					        			<span><%=comentarios[i].getContenido() %></span>
									</div>
								</div>			
					<%			
							}
					
						} else {%>
							<p><%=i18n.getString("contribution.comments.none") %></p>
					<%	} %>
        		</div>
        <%
        	} 
        %>
      </div>
    
	<jsp:include page="footer.jsp"></jsp:include>

	<div class="modal fade" id="modalEliminar" tabindex="-1" role="dialog" aria-labelledby="modalEliminar" aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header">
				    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				    	<span aria-hidden="true">&times;</span>
				    </button>
				</div>
				<div class="modal-body">
					<form action="aporte" method="post">
						<input type="text" name="id" id="idDelete" class="d-none"/>
						<div class="row d-flex flex-column justify-content-center text-center">
								<i class="bi bi-exclamation-octagon" style="color: #c0392b; font-size: 5em !important;"></i>
								<p><%=i18n.getString("contribution.confirm.delete") %></p>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-danger text-center" data-dismiss="modal"><i class="bi bi-x-lg"></i></button>
							<button type="submit" class="btn btn-success text-center" name="btnSubmit" value="eliminar"><i class="bi bi-check-lg"></i></button>
						</div>					
					</form>
				</div>
			</div>
		</div>
	</div>
	
	<div class="modal fade" id="modalValorar" tabindex="-1" role="dialog" aria-labelledby="modalValorar" aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header">
				    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				    	<span aria-hidden="true">&times;</span>
				    </button>
				</div>
				<div class="modal-body">
					<form action="aporte" method="post">
						<input type="text" name="id" id="idRate" class="d-none"/>
						<div class="row d-flex flex-column justify-content-center text-center">
								<i class="bi bi-star-half" style="color: #2ecc71; font-size: 5em !important;"></i>
								<p><%=valorado ? i18n.getString("contribution.edit.rate") : i18n.getString("contribution.confirm.rate") %></p>
								<p><%=valorado ? nota+" <i class='bi bi-star-fill'></i>" : "" %></p>
								<div class="rating">
									<input type="radio" name="rating" value="5" id="5"><label for="5">☆</label> <input type="radio" name="rating" value="4" id="4"><label for="4">☆</label> <input type="radio" name="rating" value="3" id="3"><label for="3">☆</label> <input type="radio" name="rating" value="2" id="2"><label for="2">☆</label> <input type="radio" name="rating" value="1" id="1"><label for="1">☆</label>
								</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-danger text-center" onclick="limpiarValoracion();"><i class="bi bi-x-lg"></i></button>
							<button type="submit" class="btn btn-success text-center" name="btnSubmit" value="valorar"><i class="bi bi-check-lg"></i></button>
						</div>					
					</form>
				</div>
			</div>
		</div>
	</div>
	
	<div class="modal fade" id="modalEditar" tabindex="-1" role="dialog" aria-labelledby="modalEditar" aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modalEditar"><%=i18n.getString("contribution.button.edit") %></h5>
				    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				    	<span aria-hidden="true">&times;</span>
				    </button>
				</div>
				<div class="modal-body">
					<form action="aporte" method="POST">       
						<input type="text" name="id" id="idUpdate" class="d-none"/>      
			        	<div class="form-group">
			            	<label class="font-weight-bold text-secondary"><%=i18n.getString("contribution.title.label") %></label>
			             	<div class="input-group mb-2">
								<div class="input-group-prepend">
						            <div class="input-group-text">
						              <i class="bi bi-type-h1"></i>
						            </div>
						    	</div>
						        <input type="text" class="form-control" name="titulo" value="<%=aporte.getTitulo() %>" maxlength="50" required>
							</div>
						   	<small class="form-text"><%=i18n.getString("contribution.title.help") %></small>
			        	</div>
			        	
			        	<div class="form-group">
			            	<label class="font-weight-bold text-secondary"><%=i18n.getString("contribution.langcode.label") %></label>
			             	<div class="input-group mb-2">
								<div class="input-group-prepend">
						            <div class="input-group-text">
						              <i class="bi bi-code-slash"></i>
						            </div>
						    	</div>
						        <select class="form-control" name="lenguaje">
						        	<%
						        		for(MLenguaje lenguaje: lenguajes){
						        	%>
						        			<option value="<%=lenguaje.getValor()%>" <%=lenguaje.getValor().equals(aporte.getLenguaje()) ? "selected" : null %>> <%=lenguaje.getNombre()%></option>
						        	<%
						        		}
						        	%>
								</select>
							</div>
			        	</div>
			        	
			        	<div class="form-group">
			            	<label class="font-weight-bold text-secondary"><%=i18n.getString("contribution.description.label") %></label>
			             	<div class="input-group mb-2">
						        <textarea class="publication" name="descripcion" cols="100" rows="4" maxlength="240" required><%=aporte.getDescripcion() %></textarea>
							</div>
			        	</div>
			        	
			        	<div class="form-group">
			            	<label class="font-weight-bold text-secondary"><%=i18n.getString("contribution.code.label") %></label>
			             	<div class="input-group mb-2">
						        <textarea class="publication" name="codigo" cols="100" rows="25" required><%=aporte.getContenido() %></textarea>
							</div>
			        	</div>
			         	<button type="submit" class="btn btn-primary btn-block" name="btnSubmit" value="editar"><i class="bi bi-cloud-upload"></i> <%=i18n.getString("contribution.button.edit") %></button>
			     	</form>
				</div>
			</div>
		</div>
	</div>
	
	<div class="modal fade" id="modalComentar" tabindex="-1" role="dialog" aria-labelledby="modalComentar" aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modalComentar"><%=i18n.getString("contribution.comment.button") %></h5>
				    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				    	<span aria-hidden="true">&times;</span>
				    </button>
				</div>
				<div class="modal-body">
					<form action="aporte" method="POST">
						<input type="text" name="id" id="idComment" class="d-none" value="<%=aporte.getId()%>"/>
						<div class="form-group text-muted font-weight-bold pt-3">
	                    <div class="input-group mb-2">
				          <div class="input-group-prepend">
				            <div class="input-group-text">
				              <i class="bi bi-pencil"></i>
				            </div>
				          </div>
				          <textarea class="form-control" name="contenido" rows="4" required></textarea>
				        </div>
	                </div>
						<div class="modal-footer">
							<button type="submit" class="btn btn-success text-center" name="btnSubmit" value="comentar"><i class="bi bi-upload"></i> <%=i18n.getString("contribution.comment.insert") %></button>
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