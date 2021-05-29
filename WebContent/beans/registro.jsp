<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Registro.BRegistro"  %>
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
	<jsp:useBean id="RegistroForm" class="Registro.BRegistro" scope="page">
		<jsp:setProperty property="*" name="RegistroForm"/> 
	</jsp:useBean>
	
	<%
		if(session.getAttribute("locale") != null) response.setLocale((Locale)session.getAttribute("locale"));
		ResourceBundle i18n = ResourceBundle.getBundle("i18n.i18n", response.getLocale());
				
		MProgramador programador = new MProgramador();
		MEmpresa empresa = new MEmpresa();
		
		String rol = RegistroForm.getRol();
		String mail = RegistroForm.getMail();
		String password = RegistroForm.getPassword();
		String repassword = RegistroForm.getRepassword();
		String nombre = RegistroForm.getNombre();
		String pais = RegistroForm.getPais();
		String provincia = RegistroForm.getProvincia();
		String ciudad = RegistroForm.getCiudad();
		String username = null;
		SHA2 SHA = new SHA2();
		String hashed = SHA.getSHA256(password);
		
		boolean existeProgramador = programador.leer("mail", mail);
		boolean existeEmpresa = empresa.leer("mail", mail);
		boolean existeUsername;
		
		RegEx reg = new RegEx();
		
		boolean validMail = reg.comprobar("correo", false, mail);
		boolean validPassword = reg.comprobar("password", false, password);
		boolean validNombre = reg.comprobar("texto", true, nombre);
		boolean validPais= reg.comprobar("texto", true, pais);
		boolean validProvincia = reg.comprobar("texto", true, provincia);
		boolean validCiudad = reg.comprobar("texto", true, ciudad);
		boolean validUsername = false;
		
		boolean exito = false;
		
		if(!validCiudad) session.setAttribute("error", i18n.getString("register.error.city.format"));
		if(!validProvincia) session.setAttribute("error", i18n.getString("register.error.state.format"));
		if(!validPais) session.setAttribute("error", i18n.getString("register.error.country.format"));
		if(!validNombre) session.setAttribute("error", i18n.getString("register.error.name.format"));
		if(!validPassword) session.setAttribute("error", i18n.getString("register.error.password.format"));
		if(!validMail) session.setAttribute("error", i18n.getString("register.error.mail.format"));
		
		if(existeProgramador || existeEmpresa) {
			session.setAttribute("error", i18n.getString("register.error.mail.used"));
			response.sendRedirect("../registro");
		} else {
			
			if(!password.equals(repassword)) session.setAttribute("error", i18n.getString("register.error.password.different"));
			
			if(rol.equalsIgnoreCase("programador")) {
				username = RegistroForm.getUsername();
				validUsername = reg.comprobar("username", false, username);
				existeUsername = programador.leer("username", username);
				if(!validUsername) session.setAttribute("error", i18n.getString("register.error.username.format"));
				if(existeUsername) session.setAttribute("error", i18n.getString("register.error.username.used"));
			}
			
			if(session.getAttribute("error")!=null) response.sendRedirect("../registro");
			else {
				if(rol.equalsIgnoreCase("programador")) {
					exito = programador.insertar(mail, username, hashed, nombre, pais, provincia, ciudad);
					if(exito) {
						session.setAttribute("user", programador);
						response.sendRedirect("../inicio");
					}
				}
				else {
					exito = empresa.insertar(mail, hashed, nombre, pais, provincia, ciudad);
					if(exito) {
						session.setAttribute("user", empresa);
						response.sendRedirect("../empresa");
					}
				}
				if(!exito){ 
					session.setAttribute("error", i18n.getString("register.error.insert"));
					response.sendRedirect("../registro");
				}
			}
		}
	
	%>
</body>
</html>