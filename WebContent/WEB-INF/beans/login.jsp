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
		ResourceBundle i18n;
		MProgramador programador;
		MEmpresa empresa;
		Cookie cookie;
		String mail;
		String password;
		boolean recordar;
		SHA2 SHA;
		String hashed;
		RegEx reg;
		boolean validMail;
		String ip;
		String ipHashed;
	
		if(session.getAttribute("locale") != null) response.setLocale((Locale)session.getAttribute("locale"));
		i18n = ResourceBundle.getBundle("i18n.i18n", response.getLocale());
	
		programador = new MProgramador();
		empresa = new MEmpresa();
		
		mail = LoginForm.getMail();
		password = LoginForm.getPassword();
		recordar = Boolean.parseBoolean(LoginForm.getRecordar());
		SHA = new SHA2();
		hashed = SHA.getSHA256(password);
		
		//Controlamos el form
		reg = new RegEx();
		validMail = reg.comprobar("correo", false, mail);
		
		ip = request.getHeader("X-FORWARDED-FOR");
	    if (ip == null || "".equals(ip)) {
	        ip = request.getRemoteAddr();
	    }
		ipHashed = SHA.getSHA256(ip);
	    
		if(!validMail) {
			session.setAttribute("error", i18n.getString("login.error.mail.format"));
			response.sendRedirect("../../login");
		} else {
			//Comprueba si las credenciales existen y guardamos las cookies en caso de que lo haya seleccionado
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
					programador.logConexion(ipHashed);
					response.sendRedirect("../../inicio");	
				} else {
					session.setAttribute("error", i18n.getString("login.error.access"));
					response.sendRedirect("../../login");
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
					empresa.logConexion(ipHashed);
					response.sendRedirect("../../empresa");	
				} else {
					session.setAttribute("error", i18n.getString("login.error.access"));
					response.sendRedirect("../../login");
				}
			}
			else {
				session.setAttribute("error", i18n.getString("login.error.access"));
				response.sendRedirect("../../login");
			}
		}
	%>
</body>
</html>