<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Empleo.BCurriculum"  %>
<%@ page import="Programador.MProgramador"  %>
<%@ page import="Utilidades.FileExtension"  %>
<%@ page import="Utilidades.Convertidor"  %>
<%@ page import="java.sql.Timestamp"  %>

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
	<jsp:useBean id="CurriculumForm" class="Empleo.BCurriculum" scope="page">
		<jsp:setProperty property="*" name="CurriculumForm"/> 
	</jsp:useBean>
<%
	if(session.getAttribute("locale") != null) response.setLocale((Locale)session.getAttribute("locale"));
	ResourceBundle i18n = ResourceBundle.getBundle("i18n.i18n", response.getLocale());
		
	FileExtension fe;
	MProgramador programador;
	
	byte[] pdfByte = null;
	Convertidor conv = new Convertidor();
	boolean exito = false;
	
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
	String[] valid_extensions = {".pdf"};
	boolean validExtension = false;
	Timestamp fecha;
	
	fe = new FileExtension();
	servletContext = getServletContext();
	programador = (MProgramador) session.getAttribute("user");
	filePath = servletContext.getInitParameter("file-upload");
	
	outt = response.getWriter();
	
	contentType = request.getContentType();
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
				if (!fi.isFormField()) {
					fieldName = fi.getFieldName();
					fileName = fi.getName();
					extension = fe.getFileExtension(fileName);
					isInMemory = fi.isInMemory();
					sizeInBytes = fi.getSize();
					if (fileName.lastIndexOf("/") >= 0) {
						file = new File(filePath + fileName.substring(fileName.lastIndexOf("/")));
					} else {
						file = new File(filePath + "/" + fileName.substring(fileName.lastIndexOf("/") + 1));
					}
					fi.write(file);
					pdfByte = conv.convertFileToByteArray(file);
					
				}
			}
		} catch (Exception ex) {
			ex.getStackTrace();
		}
	} 
	
	for(String ext: valid_extensions) {
		if(ext.equals(extension)) validExtension = true;
	}
	if(validExtension) {
		if(!programador.getConfirmado()) session.setAttribute("error", i18n.getString("job.error.confirmed"));
			
		if(session.getAttribute("error") == null)
		{
			programador = (MProgramador) session.getAttribute("user");		
			exito = programador.update("curriculum", file);
			if(!exito) session.setAttribute("error", i18n.getString("job.error.upload"));
			else {
				fecha = new Timestamp(System.currentTimeMillis());
				programador.setCurriculum(pdfByte);
				programador.setFechaCurriculum(fecha);
				programador.update("fechaCurriculum", fecha);
				//Actualizamos los datos desde la base de datos
				programador.leer("id", programador.getId());
				session.setAttribute("user", programador);
			}
		}
		
	} else session.setAttribute("error", i18n.getString("job.error.file.format")+" ("+extension+"). "+i18n.getString("job.error.file.info")+" "+Arrays.toString(valid_extensions));
	response.sendRedirect("../../empleo");
	outt.close();
	file.delete();
	%>
</body>
</html>