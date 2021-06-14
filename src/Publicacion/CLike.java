package Publicacion;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Locale;
import java.util.ResourceBundle;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Programador.MProgramador;

/**
 * Servlet implementation class CLike
 */
@WebServlet("/like")
public class CLike extends HttpServlet {
	private static final long serialVersionUID = 1L;
	HttpSession sesion;     


	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int iPublicacion;
		Object user;
		MPublicacion publicacion;
		MProgramador programador;
		MLike like;
		boolean existe;
		
		sesion = request.getSession();
		user = sesion.getAttribute("user");
		publicacion = new MPublicacion();
		like = new MLike();
		
		if(sesion.getAttribute("locale") != null) response.setLocale((Locale) sesion.getAttribute("locale"));
		ResourceBundle i18n = ResourceBundle.getBundle("i18n.i18n", response.getLocale());
		
		if(user == null || request.getParameter("id") == null) response.sendRedirect("login");
		else {
			if(user.getClass().getName().equals("Programador.MProgramador")) {
				programador = (MProgramador) user;
				if(programador.getConfirmado()) {
					//Parsea el parametro que arrastra por URL, si lo puede parsear seguimos sino devolvemos error
					try {
						iPublicacion = Integer.parseInt(request.getParameter("id"));
						existe = publicacion.leer("id", iPublicacion);
						//Comprueba si la publicacion existe o ha sido eliminada por el usuario
						if(existe && publicacion.isActivo()) {
							
							ArrayList<Integer> listaLikes = like.listarRelacion("publicacion", iPublicacion);
							int existeLike = 0;
							//Obtenemos los likes de la publicacion, si uno de ellos es del usuario lo guardamos
						   	for(int fLike: listaLikes) {
						   		existe = like.leer("id", fLike);
						   		if(like.getUsuario() == programador.getId()) existeLike = like.getId();
						   		
						   	} 
						   	
						   	//Si el like existe y esta activo, lo quitamos. Si existe y no esta activo, lo activamos
						   	if(existeLike > 0) {
						   		if(like.isActivo()) {
						   			like.update("activo", false);
									like.eliminarRelacion(iPublicacion);
						   		} else  {
									like.update("activo", true);
									like.insertarRelacion(iPublicacion);
								}
						   	} else {
						   		existe = like.leer("id", existeLike);
						   		if(existe) {
						   			if(like.isActivo()) {
							   			like.update("activo", false);
										like.eliminarRelacion(iPublicacion);
							   		} else  {
										like.update("activo", true);
										like.insertarRelacion(iPublicacion);
									}
						   		} else like.insertar(programador.getId(), iPublicacion);
						   		
						   	}
						} else sesion.setAttribute("error", i18n.getString("publication.404"));
							
					} catch(Exception e) {
						sesion.setAttribute("error", i18n.getString("publication.404"));
					}
				} else sesion.setAttribute("error", i18n.getString("publication.like.confirmed"));
				
				try {
					response.sendRedirect(request.getHeader("Referer"));
				} catch (Exception  e) {
					response.sendRedirect("inicio");
				}
				
			}
			else response.sendRedirect("empresa");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
