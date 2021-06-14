<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ResourceBundle" %>
<%
	ResourceBundle i18n = ResourceBundle.getBundle("i18n.i18n", response.getLocale());

	Cookie[] cookies = request.getCookies();
	String mail = "";
	if(cookies != null) {
		for(Cookie cookie:cookies){
			if(cookie.getName().equals("mail")) mail = cookie.getValue();
		}
	}
%>
<!DOCTYPE html>
<html lang="<%=response.getLocale() %>">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/sass/styles.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.5.0/css/flag-icon.min.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
    <title>nexcript > Login</title>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/src/images/favicon.png"/>
</head>
<body style="background-color: black;">
    <video autoplay muted loop id="video" class="login-video">
      <source src="${pageContext.request.contextPath}/src/video/background.mp4" type="video/mp4">
    </video>
    <div class="container-fluid" >
        <div class="row h-100">
            <div class="col-lg-8 login-start">
              <img src="${pageContext.request.contextPath}/src/images/dark_logo.webp" alt="Logotipo de nexcript" class="img-fluid">
              <h1><%=i18n.getString("login.slogan") %></h1>           
            </div>
            <div class="col-md-4 login-form">
                <h1><%=i18n.getString("login.title") %></h1>
                <form method="POST" action="login">
                
                  <div class="form-group">
                    <label for="mail"><%=i18n.getString("login.mail.label") %></label>
                    <div class="input-group mb-2">
			          <div class="input-group-prepend">
			            <div class="input-group-text">
			              <i class="bi bi-envelope"></i>
			            </div>
			          </div>
			          <input type="email" class="form-control" name="mail" aria-describedby="emailHelp" placeholder="<%=i18n.getString("login.mail.placeholder") %>" value="<%=mail %>" required>
			        </div>
			        <small id="emailHelp" class="form-text"><%=i18n.getString("login.mail.small") %></small>
                  </div>

				  <div class="form-group">
                    <label for="mail"><%=i18n.getString("login.password.label") %></label>
                    <div class="input-group mb-2">
			          <div class="input-group-prepend">
			            <div class="input-group-text">
			              <i class="bi bi-key"></i>
			            </div>
			          </div>
			          <input type="password" class="form-control" name="password" placeholder="<%=i18n.getString("login.password.placeholder") %>" required>
			        </div>
                  </div>
                  
                  <div class="form-check">
                    <input type="checkbox" class="form-check-input" name="recordar" value="true" <%=mail != "" ? "checked" : "" %>>
                    <label class="form-check-label mb-3" for="recordar"><%=i18n.getString("login.remember.label") %></label>
                  </div>
                  <%
                	if(session.getAttribute("error") != null) {%>
                		<div class="alert alert-danger" role="alert"><%= (String) session.getAttribute("error") %></div>
                <%
                		session.setAttribute("error", null);
                	}
                %>
                  <button type="submit" class="btn btn-dark btn-block"><i class="bi bi-box-arrow-in-right"></i> <%=i18n.getString("login.button.login") %></button>
                  <hr/>
                  <a href="registro" class="btn btn-light btn-block"><i class="bi bi-people"></i> <%=i18n.getString("login.button.register") %></a>
                </form>
                <div class="dropdown">
				  <button class="btn btn-light dropdown-toggle mt-4" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				    <i class="bi bi-translate"></i> <%=i18n.getString("login.button.lang") %>
				  </button>
				  <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
				    <a class="dropdown-item" href="setLocale?lang=es_ES"><span class="flag-icon flag-icon-es"></span> <%=i18n.getString("lang.es") %></a>
			        <a class="dropdown-item" href="setLocale?lang=en_US"><span class="flag-icon flag-icon-us"></span> <%=i18n.getString("lang.us") %></a> 
			        <a class="dropdown-item" href="setLocale?lang=fr_FR"><span class="flag-icon flag-icon-fr"></span> <%=i18n.getString("lang.fr") %></a> 
			        <a class="dropdown-item" href="setLocale?lang=de_DE"><span class="flag-icon flag-icon-de"></span> <%=i18n.getString("lang.de") %></a> 
			       </div>
				</div>
				<div class="row pt-5">
					<div class="footer-copyright text-center ">
				  		<a class="text-light" href="aviso-legal" target="_blank"><%=i18n.getString("footer.legal") %></a> - 
				    	<a class="text-light" href="privacidad" target="_blank"><%=i18n.getString("footer.privacy") %></a> - 
				    	<a class="text-light" href="cookies" target="_blank"><%=i18n.getString("footer.cookies") %></a> - 
				    	<a class="text-light" href="contacto" target="_blank"><%=i18n.getString("footer.contact") %></a>
				  	</div>
				</div>
            </div>
            
        </div>
    </div>
    <script src="https://unpkg.com/ionicons@5.4.0/dist/ionicons.js"></script>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</body>
</html>