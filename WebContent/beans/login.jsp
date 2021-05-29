<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Login.BLogin"  %>
<%@ page import="Programador.MProgramador"  %>
<%@ page import="Empresa.MEmpresa"  %>
<%@ page import="Utilidades.SHA2"  %>
<%@ page import="Utilidades.RegEx"  %>
<%@ page import="java.util.ResourceBundle" %>
<%@ page import="java.util.Locale" %>
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
		if(session.getAttribute("locale") != null) response.setLocale((Locale)session.getAttribute("locale"));
		ResourceBundle i18n = ResourceBundle.getBundle("i18n.i18n", response.getLocale());
	
		MProgramador programador = new MProgramador();
		MEmpresa empresa = new MEmpresa();
		Cookie cookie;
		
		String mail = LoginForm.getMail();
		String password = LoginForm.getPassword();
		boolean recordar = Boolean.parseBoolean(LoginForm.getRecordar());
		SHA2 SHA = new SHA2();
		String hashed = SHA.getSHA256(password);
		
		RegEx reg = new RegEx();
		boolean validMail = reg.comprobar("correo", false, mail);
		
		if(!validMail) {
			session.setAttribute("error", i18n.getString("login.error.mail.format"));
			response.sendRedirect("../login");
		} else {
			if(programador.leer("mail", mail)) {
				
				if(programador.getPassword().equals(hashed)) {
					session.setAttribute("user", programador);
					if(recordar) {
						cookie = new Cookie("mail", mail);
						cookie.setMaxAge(10 * 365 * 24 * 3600);
						cookie.setPath("/");
						response.addCookie(cookie);
					} else {
						cookie = new Cookie("mail", "");
						cookie.setMaxAge(0);
						cookie.setPath("/");
						response.addCookie(cookie);
					}
					response.sendRedirect("../inicio");	
				} else {
					session.setAttribute("error", i18n.getString("login.error.access"));
					response.sendRedirect("../login");
				}
			} else if(empresa.leer("mail", mail)){
				if(empresa.getPassword().equals(hashed)) {
					session.setAttribute("user", empresa);
					if(recordar) {
						cookie = new Cookie("mail", mail);
						cookie.setMaxAge(999999);
						cookie.setPath("/");
						response.addCookie(cookie);
					} else {
						cookie = new Cookie("mail", "");
						cookie.setMaxAge(0);
						cookie.setPath("/");
						response.addCookie(cookie);
					}
					response.sendRedirect("../empresa");	
				} else {
					session.setAttribute("error", i18n.getString("login.error.access"));
					response.sendRedirect("../login");
				}
			}
			else {
				session.setAttribute("error", i18n.getString("login.error.access"));
				response.sendRedirect("../login");
			}
		}
	%>
</body>
</html>