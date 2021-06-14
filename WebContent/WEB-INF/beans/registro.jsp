<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Registro.BRegistro"  %>
<%@ page import="Programador.MProgramador"  %>
<%@ page import="Empresa.MEmpresa"  %>
<%@ page import="Utilidades.SHA2"  %>
<%@ page import="Utilidades.RegEx"  %>
<%@ page import="Utilidades.Convertidor"  %>
<%@ page import="java.util.ResourceBundle" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.io.File"  %>
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
		ResourceBundle i18n;
		MProgramador programador;
		MEmpresa empresa;	
		String rol;
		String mail;
		String password;
		String repassword;
		String nombre;
		String pais;
		String provincia;
		String ciudad;
		String username;
		String lenguaje;
		
		SHA2 SHA;
		String hashed;
		boolean existeProgramador;
		boolean existeEmpresa;
		boolean existeUsername;
		RegEx reg;
		boolean validMail;
		boolean validPassword;
		boolean validNombre;
		boolean validPais;
		boolean validProvincia;
		boolean validCiudad;
		boolean validUsername;
		boolean exito;
		byte[] foto;
		Convertidor conv;
		
		ServletContext servletContext = getServletContext();
		String filePath = servletContext.getInitParameter("src-load");
	
		if(session.getAttribute("locale") != null) response.setLocale((Locale)session.getAttribute("locale"));
		i18n = ResourceBundle.getBundle("i18n.i18n", response.getLocale());
				
		programador = new MProgramador();
		empresa = new MEmpresa();
		
		rol = RegistroForm.getRol();
		mail = RegistroForm.getMail();
		password = RegistroForm.getPassword();
		repassword = RegistroForm.getRepassword();
		nombre = RegistroForm.getNombre();
		pais = RegistroForm.getPais();
		provincia = RegistroForm.getProvincia();
	 	ciudad = RegistroForm.getCiudad();
	 	lenguaje = RegistroForm.getLenguaje();
	 	
		username = null;
		SHA = new SHA2();
		hashed = SHA.getSHA256(password);
		
		existeProgramador = programador.leer("mail", mail);
		existeEmpresa = empresa.leer("mail", mail);
		
		reg = new RegEx();
		
		validMail = reg.comprobar("correo", false, mail);
		validPassword = reg.comprobar("password", false, password);
		validNombre = reg.comprobar("texto", true, nombre);
		validPais= reg.comprobar("texto", true, pais);
		validProvincia = reg.comprobar("texto", true, provincia);
		validCiudad = reg.comprobar("texto", true, ciudad);
		validUsername = false;
		
		exito = false;
		
		if(!validCiudad) session.setAttribute("error", i18n.getString("register.error.city.format"));
		if(!validProvincia) session.setAttribute("error", i18n.getString("register.error.state.format"));
		if(!validPais) session.setAttribute("error", i18n.getString("register.error.country.format"));
		if(!validNombre) session.setAttribute("error", i18n.getString("register.error.name.format"));
		if(!validPassword) session.setAttribute("error", i18n.getString("register.error.password.format"));
		if(!validMail) session.setAttribute("error", i18n.getString("register.error.mail.format"));
		
		if(existeProgramador || existeEmpresa) {
			session.setAttribute("error", i18n.getString("register.error.mail.used"));
			response.sendRedirect("../../registro");
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
				conv = new Convertidor();
				foto = conv.convertFileToByteArray(new File(filePath+"/src/images/profile.webp"));
			
				if(rol.equalsIgnoreCase("programador")) {
					exito = programador.insertar(mail, username, hashed, nombre, pais, provincia, ciudad, foto, lenguaje);
					if(exito) {
						//Recargamos el usuario para obtener todos los datos de la base de datos
						programador.leer("mail", mail);
						session.setAttribute("user", programador);
						response.sendRedirect("../../inicio");
					}
				}
				else {
					exito = empresa.insertar(mail, hashed, nombre, pais, provincia, ciudad, foto);
					if(exito) {
						//Recargamos el usuario para obtener todos los datos de la base de datos
						empresa.leer("mail", mail);
						session.setAttribute("user", empresa);
						response.sendRedirect("../../empresa");
					}
				}
				if(!exito){ 
					session.setAttribute("error", i18n.getString("register.error.insert"));
					response.sendRedirect("../../registro");
				}
			}
		}
	
	%>
</body>
</html>