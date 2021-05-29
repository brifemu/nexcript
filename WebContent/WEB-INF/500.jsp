<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
<%@ page import="java.util.ResourceBundle" %>
<%
	ResourceBundle i18n = ResourceBundle.getBundle("i18n.i18n", response.getLocale());
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/404.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/404.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.5.0/css/flag-icon.min.css" rel="stylesheet" type="text/css">
    <title>nexcript</title>
</head>
<body>
	<div class="text">
	  <div>ERROR</div>
	  <h1>500</h1>
	  <hr>
	  <div><%=i18n.getString("error.500") %></div>
	  <div><a href="inicio"><%=i18n.getString("footer.index") %></a> - <a href="contacto"><%=i18n.getString("footer.contact") %></a></div>
	</div>
	
	<div class="astronaut">
	  <img src="https://images.vexels.com/media/users/3/152639/isolated/preview/506b575739e90613428cdb399175e2c8-space-astronaut-cartoon-by-vexels.png" alt="" class="src">
	</div>
</body>
</html>