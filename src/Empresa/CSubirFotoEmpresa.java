package Empresa;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import Empresa.MEmpresa;
import Utilidades.FileExtension;

/**
 * Servlet implementation class CSubirFotoPerfil
 */
@WebServlet("/subirfotoempresa")
public class CSubirFotoEmpresa extends HttpServlet {
	private static final long serialVersionUID = 1L;


	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		FileExtension fe;
		HttpSession sesion;
		MEmpresa user;

		File file = null;
		int maxFileSize = 5000 * 1024;
		int maxMemSize = 5000 * 1024;
		ServletContext servletContext;
		String filePath;
		String contentType;
		PrintWriter out;
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
		sesion = request.getSession();
		user = (MEmpresa) sesion.getAttribute("user");
		filePath = servletContext.getInitParameter("file-upload");

		if(sesion.getAttribute("locale") != null) {
    		response.setLocale((Locale)sesion.getAttribute("locale"));
    	}
		
		out = response.getWriter();

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
						//Detecta que el input del formulario es de tipo file
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
						//Termina de cargar el archivo del input
						fi.write(file);
					}
				}
			} catch (Exception ex) {
				ex.getStackTrace();
			}
		} 
		//Comprueba si la extensión del archivo es válida
		for(String ext: valid_extensions) {
			if(ext.equals(extension)) validExtension = true;
		}
		if(validExtension) {
			//Si lo es, actualizamos
			user.setImgFile(file);
			user.update("foto", file);
			sesion.setAttribute("user", user);
			sesion.setAttribute("exito-foto", "Has cambiado tu foto de perfil");
		} else {
			sesion.setAttribute("error-foto", "Formato inválido ("+extension+"). Formatos soportados: "+Arrays.toString(valid_extensions));
		}
		response.sendRedirect("empresa-editar-perfil#foto");
		out.close();
		file.delete();
	}

}
