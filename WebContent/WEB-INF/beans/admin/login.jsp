<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Login.BLogin"  %>
<%@ page import="Empleado.MEmpleado"  %>
<%@ page import="Utilidades.SHA2"  %>
<%@ page import="Utilidades.RegEx"  %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>nexcript</title>
</head>
<body>
	<jsp:useBean id="LoginForm" class="Login.BLogin" scope="page">
		<jsp:setProperty property="*" name="LoginForm"/> 
	</jsp:useBean>
	
	<%
		MEmpleado empleado;
		Cookie cookie;
		String mail;
		String password;
		boolean recordar;
		SHA2 SHA;
		String hashed;
		RegEx reg;
		boolean validMail;
	

	
		empleado = new MEmpleado();
		
		mail = LoginForm.getMail();
		password = LoginForm.getPassword();
		recordar = Boolean.parseBoolean(LoginForm.getRecordar());
		SHA = new SHA2();
		hashed = SHA.getSHA256(password);
		
		reg = new RegEx();
		validMail = reg.comprobar("correo", false, mail);
		
		if(!validMail) {
			session.setAttribute("error", "Formato de correo inválido");
			response.sendRedirect("../../../admin-login");
		} else {
			if(empleado.leer("mail", mail)) {
				
				if(empleado.getPassword().equals(hashed)) {
					session.setAttribute("user", empleado);
					response.sendRedirect("../../../admin-inicio");	
				} else {
					session.setAttribute("error", "Datos incorrectos");
					response.sendRedirect("../../../admin-login");
				}
			} else {
				session.setAttribute("error", "Datos incorrectos");
				response.sendRedirect("../../../admin-login");
			}
			
		}
	%>
</body>
</html>