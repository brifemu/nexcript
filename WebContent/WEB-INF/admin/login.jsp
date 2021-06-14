<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	<meta charset="UTF-8">
	<title>nexcript > Administración</title>
	<link rel="icon" type="image/png" href="${pageContext.request.contextPath}/src/images/favicon.png">
</head>
<body>
	<div class="container-fluid bg-dark">
		<div class="row d-flex justify-content-center">
			<div class="col-md-4 bg-light mt-5 mb-5">
				<h3 class="text-center text-secondary pt-5">Panel administrativo</h3>
				<hr/>
				<%
                	if(session.getAttribute("error") != null) {%>
                		<div class="alert alert-danger" role="alert"><%= (String) session.getAttribute("error") %></div>
                <%
                		session.setAttribute("error", null);
                	}
                %>
				<form action="admin-login" method="post">
					<div class="form-group">
                    <label for="mail">Dirección de correo</label>
                    <div class="input-group mb-2">
			          <div class="input-group-prepend">
			            <div class="input-group-text">
			              <i class="bi bi-envelope"></i>
			            </div>
			          </div>
			          <input type="email" class="form-control" name="mail" aria-describedby="emailHelp" placeholder="Dirección de correo" required>
			        </div>
                  </div>

				  <div class="form-group">
                    <label for="mail">Contraseña</label>
                    <div class="input-group mb-2">
			          <div class="input-group-prepend">
			            <div class="input-group-text">
			              <i class="bi bi-key"></i>
			            </div>
			          </div>
			          <input type="password" class="form-control" name="password" placeholder="Contraseña" required>
			        </div>
                  </div>
                  <button type="submit" class="btn btn-dark btn-block mb-5"><i class="bi bi-box-arrow-in-right"></i> Iniciar sesión</button>
				</form>
			</div>
		</div>		
	</div>
	<script src="https://kit.fontawesome.com/5d273a2576.js" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</body>
</html>