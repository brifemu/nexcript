<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Empresa.MEmpresa" %>
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
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/src/images/favicon.png">
	<title>nexcript > Editar perfil</title>
	<%
    	MEmpresa user = (MEmpresa) session.getAttribute("user");
    	String formatFecha;
    %>
    <script>
	    function comprobar() {
			if(document.getElementById("fotofile").files[0].size > 5000000){
				alert('El archivo no debe superar los 5MB');
				document.getElementById("fotofile").value = '';
				document.getElementById("fotofile").name = '';
			} 
		};
    </script>
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
              <a class="nav-link" href="desarrolladores"><i class="bi bi-people"></i> DESARROLLADORES</a>
            </li>
          </ul>
        </div>
        <a class="nav-link" href="empresa-editar-perfil"><i class="bi bi-pencil-square"></i></a>
       	<a class="nav-link" href="logout"><i class="bi bi-door-closed"></i></a>
    </nav>
	<div class="container">
        <h1 class="text-primary mt-5">Editar perfil</h1>
        <ul class="nav nav-tabs mt-4">
          <li class="nav-item">
            <a class="nav-link active" data-toggle="tab" href="#perfil">Editar perfil</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" data-toggle="tab" href="#foto">Cambiar foto de perfil</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" data-toggle="tab" href="#correo">Editar correo</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" data-toggle="tab" href="#clave">Editar contraseña</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" data-toggle="tab" href="#confirmacion">Confirmar correo</a>
          </li>
        </ul>
        
        <div class="tab-content">
          <div class="tab-pane container mt-5 active" id="perfil">
            <form id="empresa-editar-perfil" method="post" action="empresa-editar-perfil">

              <div class="form-group">
                <label class="font-weight-bold text-secondary">Nombre de la empresa</label>
                <input type="text" class="form-control" name="nombre" value="<%= user.getNombre()%>">
              </div>
    
              <div class="form-group">
                <label class="font-weight-bold text-secondary">País</label>
                <input type="text" class="form-control" name="pais" value="<%= user.getPais()%>">
              </div>
    
              <div class="form-group">
                <label class="font-weight-bold text-secondary">Provincia</label>
                <input type="text" class="form-control" name="provincia" value="<%= user.getProvincia()%>">
              </div>
    
              <div class="form-group">
                <label class="font-weight-bold text-secondary">Ciudad</label>
                <input type="text" class="form-control" name="ciudad" value="<%= user.getCiudad()%>">
              </div>
    
              <button type="submit" class="btn btn-primary" name="btnSubmit" value="perfil">Confirmar cambios</button>
            </form>
            <%
		       	if(session.getAttribute("error-perfil") != null) {%>
		            <div class="alert alert-danger mt-4 w-100" role="alert"><%= (String) session.getAttribute("error-perfil") %></div>
			<%
			        session.setAttribute("error-perfil", null);
			    }
			%>
			<%
			     if(session.getAttribute("exito-perfil") != null) {%>
			        <div class="alert alert-success mt-4 w-100" role="alert"><%= (String) session.getAttribute("exito-perfil") %></div>
			<%
			   		session.setAttribute("exito-perfil", null);
			   }
			%>
          </div>
          <div class="tab-pane container mt-5" id="foto">
	          <div class="row d-flex justify-content-between">
	          	<div class="col-md-6">
	          		<form method="post" action="subirfotoempresa" enctype="multipart/form-data">
	              		<div class="form-group">
	                		<label class="font-weight-bold text-secondary">Seleccionar imagen</label>
	                 		<input type="file" id="fotofile" onchange="comprobar();" name="file" value="Examinar" accept="image/*" required>
	              		</div>
	              		<button type="submit" class="btn btn-primary">Cambiar foto de perfil</button>
	            	</form>
	            	<%
		       		if(session.getAttribute("error-foto") != null) {%>
		            	<div class="alert alert-danger mt-4 w-100" role="alert"><%= (String) session.getAttribute("error-foto") %></div>
			        <%
			                session.setAttribute("error-foto", null);
			      		}
			        %>
			        <%
			       		if(session.getAttribute("exito-foto") != null) {%>
			            	<div class="alert alert-success mt-4 w-100" role="alert"><%= (String) session.getAttribute("exito-foto") %></div>
			        <%
			                session.setAttribute("exito-foto", null);
			      		}
			        %>
	          	</div>
	          	<div class="col-md-4">
	          		<p class="font-weight-bold text-secondary">Imagen de perfil actual</p>
	          		<img class="profile-big" src="ImagenEmpresa?id=<%=user.getId() %>"/>
	          	</div>
	          </div>
          </div>
          <div class="tab-pane container mt-5" id="correo">
            <form id="editar-correo" method="post" action="empresa-editar-perfil">
    
              <div class="form-group">
                <label class="font-weight-bold text-secondary">Dirección de correo</label>
                <input type="email" class="form-control" name="mail" id="mail" value="<%= user.getMail()%>"readonly>
              </div>
    
              <div class="form-group">
                <label class="font-weight-bold text-secondary">Nueva dirección de correo</label>
                <input type="email" class="form-control" name="newmail" id="newmail" placeholder="usuario@dominio.com" required>
              </div>

              <div class="form-group">
                <label class="font-weight-bold text-secondary">Confirma tu nueva dirección de correo</label>
                <input type="email" class="form-control" name="remail" id="remail" placeholder="usuario@dominio.com" required>
              </div>

              <hr class="mt-5 mb-3"/>

              <p class="text-primary">Para poder realizar este cambio debemos comprobar que usted es el propietario de la cuenta:</p>
              <div class="form-group">
                <label class="font-weight-bold text-secondary">Contraseña</label>
                <input type="password" class="form-control" name="password" id="password" placeholder="Contraseña" autocomplete="false" required>
              </div>
    
              <div class="form-group">
                <label class="font-weight-bold text-secondary">Repite tu contraseña</label>
                <input type="password" class="form-control" name="repassword" id="repassword" placeholder="Repite tu contraseña" required>
              </div>
    
              <button type="submit" class="btn btn-primary" name="btnSubmit" value="correo">Editar correo</button>
            </form>
            <%
       		if(session.getAttribute("error-correo") != null) {%>
            	<div class="alert alert-danger mt-4 w-100" role="alert"><%= (String) session.getAttribute("error-correo") %></div>
	        <%
	                session.setAttribute("error-correo", null);
	      		}
	        %>
	        <%
	       		if(session.getAttribute("exito-correo") != null) {%>
	            	<div class="alert alert-success mt-4 w-100" role="alert"><%= (String) session.getAttribute("exito-correo") %></div>
	        <%
	                session.setAttribute("exito-correo", null);
	      		}
	        %>
          </div>
          <div class="tab-pane container mt-5" id="clave">
            <form id="editar-clave" method="post" action="empresa-editar-perfil">
              <div class="form-group">
                <label class="font-weight-bold text-secondary">Contraseña actual</label>
                <input type="password" class="form-control" name="password" id="password" placeholder="Contraseña" required>
              </div>
    
              <div class="form-group">
                <label class="font-weight-bold text-secondary">Nueva contraseña</label>
                <input type="password" class="form-control" name="newpassword" id="newpassword"placeholder="Nueva contraseña" required>
                <small>
					La contraseña debe cumplir lo siguiente:
					<ul>
						<li>Tener una longitud mínima de 8 caracteres</li>
						<li>Contener al menos un caracter numérico</li>
						<li>Contener al menos una minúscula</li>
						<li>Contener al menos una mayúscula</li>
						<li>Contener al menos un caracter especial</li>
					</ul>
				</small>
              </div>
				
              <div class="form-group">
                <label class="font-weight-bold text-secondary">Repite tu nueva contraseña</label>
                <input type="password" class="form-control" name="repassword" id="repassword" placeholder="Repite tu nueva contraseña" required>
              </div>
    
              <button type="submit" class="btn btn-primary" name="btnSubmit" value="password">Editar contraseña</button>
            </form>
            <%
       		if(session.getAttribute("error-clave") != null) {%>
            	<div class="alert alert-danger mt-4 w-100" role="alert"><%= (String) session.getAttribute("error-clave") %></div>
	        <%
	                session.setAttribute("error-clave", null);
	      		}
	        %>
	        <%
	       		if(session.getAttribute("exito-clave") != null) {%>
	            	<div class="alert alert-success mt-4 w-100" role="alert"><%= (String) session.getAttribute("exito-clave") %></div>
	        <%
	                session.setAttribute("exito-clave", null);
	      		}
	        %>
          </div>
          <div class="tab-pane container mt-5" id="confirmacion">
            <%
            	if(user.getConfirmado() == true) { 
            		formatFecha = new SimpleDateFormat("dd/MM/yyyy").format(user.getFechaConfirmacion());
            %>
            	
            		<div class="alert alert-success w-100" role="alert">Su dirección de correo fue confirmada el día <i class="bi bi-clock-history"></i> <%=formatFecha %> por lo que no necesita confirmarla de nuevo</div>
            		
            <% 	}
            	else { %>
            		<p>Para poder publicar contenido en nuestro sitio web es necesario que verifique su dirección de correo por cuestiones de seguridad.
            		Para ello solo debe hacer click en el botón 'Recibir correo de confirmación' e insertar en el campo inferior el código que le llegara a
            		su correo. Por favor, revise la bandeja de SPAM ya que puede llegar ahí por error.</p>
            		
            		<% if(session.getAttribute("codigo") == null) %><a href="correoConfirmacionEmpresa" class="btn btn-primary">Recibir correo de confirmación</a>
            		
            		<%
            			if(session.getAttribute("codigo") != null){
            		%>
            				<div class="alert alert-success mt-4 mb-4 w-100" role="alert">Se ha enviado un código de verificación a la dirección de correo asociada a tu cuenta de nexcript.
            				En caso de no haberlo recibido puedes <a href="correoConfirmacionEmpresa">solicitar un reenvio de su código de verificación</a></div>
            				
            				<form method="post" action="empresa-editar-perfil">
            					<div class="form-group">
					                <label class="font-weight-bold text-secondary">Código de verificación</label>
					                <input type="text" class="form-control" name="codigo">
					           	</div>
					           	<button type="submit" class="btn btn-primary" name="btnSubmit" value="confirmacion">Confirmar correo</button>
            				</form>
            <%				
            			}
            	}
            %>
            
            <%
       		if(session.getAttribute("error-confirmacion") != null) {%>
            	<div class="alert alert-danger mt-4 w-100" role="alert"><%= (String) session.getAttribute("error-confirmacion") %></div>
	        <%
	                session.setAttribute("error-confirmacion", null);
	      		}
	        %>
          </div>
        </div>
        
      </div>
	<jsp:include page="../footer.jsp"></jsp:include>
	<script src="https://kit.fontawesome.com/5d273a2576.js" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.0/jquery.validate.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/js/formValidation/editar-perfil.js"></script>
</body>
</html>