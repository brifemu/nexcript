<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Publicacion.BPublicacion"  %>
<%@ page import="Programador.MProgramador"  %>
<%@ page import="Publicacion.MPublicacion"  %>
<%@ page import="Utilidades.RegEx"  %>
<%@ page import="Utilidades.FileExtension"  %>
<%@ page import="Utilidades.Convertidor"  %>

<%@ page import="org.apache.commons.fileupload.FileItem"  %>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"  %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"  %>

<%@ page import="java.io.File"  %>
<%@ page import="java.io.PrintWriter"  %>
<%@ page import="java.io.IOException"  %>
<%@ page import="java.util.Arrays"  %>
<%@ page import="java.util.Iterator"  %>
<%@ page import="java.util.List"  %>

<%@ page import="java.util.ResourceBundle" %>
<%@ page import="java.util.Locale" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>nexcript</title>
</head>
<body>
	<jsp:useBean id="PublicacionForm" class="Publicacion.BPublicacion" scope="page">
		<jsp:setProperty property="*" name="PublicacionForm"/> 
	</jsp:useBean>
<%
	if(session.getAttribute("locale") != null) response.setLocale((Locale)session.getAttribute("locale"));
	ResourceBundle i18n;
		
	FileExtension fe;
	MProgramador programador;
	MPublicacion publicacion;
	boolean exito = false;
	
	RegEx reg = new RegEx();
	String contenido = "";
	byte[] fotoByte = null;
	boolean detectHTML = false;
	boolean validSize = false;
	boolean adjunto = false;
	Convertidor conv = new Convertidor();
	
	File file = null;
	int maxFileSize = 5000 * 1024;
	int maxMemSize = 5000 * 1024;
	ServletContext servletContext;
	String filePath;
	String contentType;
	PrintWriter outt;
	FileItem fi;
	List<FileItem> fileItems;
	DiskFileItemFactory factory;
	String fileName = null;
	boolean isInMemory;
	String fieldName;
	long sizeInBytes;
	String extension = "";
	String[] valid_extensions = {".jpg", ".png", ".gif", ".jpeg", ".webp"};
	boolean validExtension = false;
	fe = new FileExtension();
	servletContext = getServletContext();
	programador = (MProgramador) session.getAttribute("user");
	filePath = servletContext.getInitParameter("file-upload");
	outt = response.getWriter();
	contentType = request.getContentType();
	i18n = ResourceBundle.getBundle("i18n.i18n", response.getLocale());
	
	//Controla el contenido del form
	if ((contentType.indexOf("multipart/form-data") >= 0)) {
		factory = new DiskFileItemFactory();
		factory.setSizeThreshold(maxMemSize);
		factory.setRepository(new File("."));
		ServletFileUpload upload = new ServletFileUpload(factory);
		upload.setSizeMax(maxFileSize);
		try {
			fileItems = upload.parseRequest(request);
			Iterator<FileItem> i = fileItems.iterator();
			while (i.hasNext()) {
				fi = (FileItem) i.next();
				if(fi.getFieldName().equals("contenido")) contenido = fi.getString("UTF-8");
				if (!fi.isFormField()) {
					fieldName = fi.getFieldName();
					fileName = fi.getName();
					extension = fe.getFileExtension(fileName);
					isInMemory = fi.isInMemory();
					sizeInBytes = fi.getSize();
					if(sizeInBytes > 0) adjunto = true;
					if (fileName.lastIndexOf("/") >= 0) {
						file = new File(filePath + fileName.substring(fileName.lastIndexOf("/")));
					} else {
						file = new File(filePath + "/" + fileName.substring(fileName.lastIndexOf("/") + 1));
					}
					fi.write(file);
					if(adjunto) fotoByte = conv.convertFileToByteArray(file);
					
				}
			}
		} catch (Exception ex) {
			ex.getStackTrace();
		}
	}
	//Controla la extension de la foto
	for(String ext: valid_extensions) {
		if(ext.equals(extension)) validExtension = true;
	}
	
	if(validExtension || extension == "") {
		//Controla el contenido de la publicacion
		detectHTML = reg.comprobar("html", true, contenido);
		validSize = contenido.length() <= 240 ? true : false;
		if(!validSize) session.setAttribute("error", i18n.getString("index.error.publish.length"));
		if(detectHTML) session.setAttribute("error", i18n.getString("index.error.publish.html"));
		if(!programador.getConfirmado()) session.setAttribute("error", i18n.getString("index.error.publish.confirmed"));
			
		if(session.getAttribute("error") == null)
		{
			publicacion = new MPublicacion();
			if(adjunto) exito = publicacion.insertar(programador.getId(), contenido, fotoByte);
			else exito = publicacion.insertar(programador.getId(), contenido);
			if(!exito) session.setAttribute("error", i18n.getString("index.error.insert"));
			else session.setAttribute("exito", i18n.getString("index.success.insert"));
		}
		
	} else session.setAttribute("error", i18n.getString("index.error.img.format")+" ("+extension+"). "+i18n.getString("index.error.img.info")+" "+Arrays.toString(valid_extensions));
	
	response.sendRedirect("../../inicio");
	outt.close();
	if(adjunto) file.delete();
	%>
</body>
</html>