<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ResourceBundle" %>
<%@ page import="Codigo.MLenguaje" %>
<%
	ResourceBundle i18n = ResourceBundle.getBundle("i18n.i18n", response.getLocale());
	MLenguaje[] lenguajes = (MLenguaje[]) session.getAttribute("listaLenguajes");
%>

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
    <title>nexcript > Registro</title>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/src/images/favicon.png">
</head>
<body style="background-color: black;">
	<video autoplay muted loop id="video" class="login-video">
		<source src="${pageContext.request.contextPath}/src/video/background.mp4" type="video/mp4">
	</video>
	<div class="container">
		<div class="row d-flex justify-content-center">
			<a href="login"><img class="img-fluid" src="${pageContext.request.contextPath}/src/images/dark_logo.webp" alt="Logotipo de nexcript"></a>
		</div>
		<div class="row d-flex justify-content-between mb-5">
			<div class="col-md-6 bg-light p-5">
				<div class="dropdown">
				  <button class="btn btn-dark dropdown-toggle mb-3" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				    <i class="bi bi-translate"></i> <%=i18n.getString("login.button.lang") %>
				  </button>
				  <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
				    <a class="dropdown-item" href="setLocale?lang=es_ES"><span class="flag-icon flag-icon-es"></span> <%=i18n.getString("lang.es") %></a>
			        <a class="dropdown-item" href="setLocale?lang=en_US"><span class="flag-icon flag-icon-us"></span> <%=i18n.getString("lang.us") %></a> 
			        <a class="dropdown-item" href="setLocale?lang=fr_FR"><span class="flag-icon flag-icon-fr"></span> <%=i18n.getString("lang.fr") %></a> 
			        <a class="dropdown-item" href="setLocale?lang=de_DE"><span class="flag-icon flag-icon-de"></span> <%=i18n.getString("lang.de") %></a> 
			       </div>
				</div>
				<h1 class="font-weight-bold text-primary"><%=i18n.getString("register.title") %></h1>
				
				<form id="registro-form" action="registro" method="POST">
					<div class="form-group">
						<label class="font-weight-bold text-secondary"><%=i18n.getString("register.profile.label") %></label>
						<select class="form-control" id="rol" name="rol">
							<option value="Programador"><%=i18n.getString("register.profile.option1") %></option>
							<option value="Empresa"><%=i18n.getString("register.profile.option2") %></option>
						</select>
					</div>

					<div class="form-group">
						<label class="font-weight-bold text-secondary"><%=i18n.getString("register.mail.label") %></label>
						<input type="email" class="form-control" id="mail" name="mail" placeholder="<%=i18n.getString("register.mail.placeholder") %>" maxlength="50">
					</div>

					<div class="form-group">
						<label class="font-weight-bold text-secondary"><%=i18n.getString("register.password.label") %></label>
						<input type="password" class="form-control" id="password" name="password" id="password" placeholder="<%=i18n.getString("register.password.placeholder") %>">
						<small>
						<%=i18n.getString("register.password.requirements.title") %>
						<ul>
							<li><%=i18n.getString("register.password.requirements.req1") %></li>
							<li><%=i18n.getString("register.password.requirements.req2") %></li>
							<li><%=i18n.getString("register.password.requirements.req3") %></li>
							<li><%=i18n.getString("register.password.requirements.req4") %></li>
							<li><%=i18n.getString("register.password.requirements.req5") %></li>
						</ul>
						</small>
					</div>

					<div class="form-group">
						<label class="font-weight-bold text-secondary"><%=i18n.getString("register.repassword.label") %></label>
						<input type="password" class="form-control" name="repassword" id= "repassword" placeholder="<%=i18n.getString("register.repassword.placeholder") %>" >
					</div>
					<small id="errorPass" class="text-danger" style="display: none"><%=i18n.getString("register.error.password.different") %></small>
					<div class="form-group">
						<label class="font-weight-bold text-secondary"><%=i18n.getString("register.name.label") %></label>
						<input type="text" class="form-control" id="nombre" name="nombre" maxlength="36">
					</div>
					
					<div class="form-group" id="form-username">
						<label class="font-weight-bold text-secondary"><%=i18n.getString("register.username.label") %></label>
						<input type="text" class="form-control" id="username" name="username" maxlength="20">
					</div>
					
					<div class="form-group">
						<label class="font-weight-bold text-secondary"><%=i18n.getString("register.country.label") %></label>
						<input type="text" class="form-control" id="pais" name="pais" maxlength="36">
					</div>

					<div class="form-group">
						<label class="font-weight-bold text-secondary"><%=i18n.getString("register.state.label") %></label>
						<input type="text" class="form-control" id="provincia" name="provincia" maxlength="36">
					</div>

					<div class="form-group">
						<label class="font-weight-bold text-secondary"><%=i18n.getString("register.city.label") %></label>
						<input type="text" class="form-control" id="ciudad" name="ciudad" maxlength="36">
					</div>
					
					<div class="form-group" id="form-lenguaje">
		            	<label class="font-weight-bold text-secondary"><%=i18n.getString("contribution.langcode.label") %></label>
		             	<div class="input-group mb-2">
							<div class="input-group-prepend">
					            <div class="input-group-text">
					              <i class="bi bi-code-slash"></i>
					            </div>
			    			</div>
					        <select class="form-control" name="lenguaje">
					        	<option value="-">-</option>
					        	<%
					        		for(MLenguaje lenguaje: lenguajes){
					        	%>
					        			<option value="<%=lenguaje.getValor()%>"> <%=lenguaje.getNombre()%></option>
					        	<%
					        		}
					        	%>
							</select>
						</div>
	        		</div>

					
					<button type="submit" class="btn btn-primary btn-block mb-3"><i class="bi bi-person-plus-fill"></i> <%=i18n.getString("register.button.register") %></button>
				</form>
				
				<%
                	if(session.getAttribute("error") != null) {%>
                		<div class="alert alert-danger" role="alert"><%= (String) session.getAttribute("error") %></div>
                <%
                		session.setAttribute("error", null);
                	}
                %>
				
			</div>
			<div class="col-md-5 p-5">
				<h2 class="text-light pl-4"><%=i18n.getString("register.claim") %></h2>
				<br />
				<ul class="text-light">
					<li><%=i18n.getString("register.claim.line1") %></li>
					<li><%=i18n.getString("register.claim.line2") %></li>
					<li><%=i18n.getString("register.claim.line3") %></li>
					<li><%=i18n.getString("register.claim.line4") %></li>
					<li><%=i18n.getString("register.claim.line5") %></li>
				</ul>
			</div>
		</div>
		<div class="row pb-5">
			<div class="footer-copyright text-center">
		  		<a class="text-muted" href="aviso-legal" target="_blank"><%=i18n.getString("footer.legal") %></a> - 
		    	<a class="text-muted" href="privacidad" target="_blank"><%=i18n.getString("footer.privacy") %></a> - 
		    	<a class="text-muted" href="cookies" target="_blank"><%=i18n.getString("footer.cookies") %></a> - 
		    	<a class="text-muted" href="contacto" target="_blank"><%=i18n.getString("footer.contact") %></a>
		  	</div>
		</div>
	</div>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.0/jquery.validate.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
		integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
		crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
		integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
		crossorigin="anonymous"></script>
		
	<script src="${pageContext.request.contextPath}/js/formValidation/registro.js"></script>
</body>
</html>