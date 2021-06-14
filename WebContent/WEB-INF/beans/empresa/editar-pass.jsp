<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Empresa.BEditarPass"  %>
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
	<jsp:useBean id="PassForm" class="Empresa.BEditarPass" scope="page">
		<jsp:setProperty property="*" name="PassForm"/> 
	</jsp:useBean>
	<%
	ResourceBundle i18n;
	MEmpresa empresa;
	String password;
	String newpassword;
	String repassword;
	SHA2 SHA;
	String hashed;
	String newhashed;
	RegEx reg;
	boolean validPassword;
	boolean correctPassword;
	boolean coinciden;
	
		if(session.getAttribute("locale") != null) response.setLocale((Locale)session.getAttribute("locale"));
		i18n = ResourceBundle.getBundle("i18n.i18n", response.getLocale());
		
		empresa = (MEmpresa) session.getAttribute("user");	
	
		password = PassForm.getPassword();
		newpassword = PassForm.getNewpassword();
		repassword = PassForm.getRepassword();
		
		SHA = new SHA2();
		hashed = SHA.getSHA256(password);
		newhashed = SHA.getSHA256(newpassword);
		
		reg = new RegEx();
		
		validPassword = reg.comprobar("password", true, newpassword);
		correctPassword = empresa.getPassword().equals(hashed);
		coinciden = newpassword.equals(repassword);
		
		if(!coinciden) session.setAttribute("error-clave", "Las contraseñas no coinciden");
		if(!correctPassword) session.setAttribute("error-clave", "Las contraseña no es correcta");
		if(!validPassword) session.setAttribute("error-clave", "Las contraseña no cumple los requisitos necesarios");
		
		
		if(session.getAttribute("error-clave") == null) {
			empresa.update("password", newhashed);
			
			//Actualizamos los datos desde la base de datos
			empresa.leer("id", empresa.getId());
			session.setAttribute("user", empresa);
			
			session.setAttribute("exito-clave", "Los cambios han sido guardados con éxito");
		}
		
		response.sendRedirect("../../../empresa-editar-perfil#clave");
	%>
</body>
</html>