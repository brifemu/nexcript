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
 * Servlet implementation class CPublicacion
 */
@WebServlet("/publicacion")
public class CPublicacion extends HttpServlet {
	private static final long serialVersionUID = 1L;
	HttpSession sesion;  
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Object user;
		MPublicacion publicacion;
		MRespuesta respuesta;
		MRespuesta[] respuestas;
		MProgramador programador;
		int id;
		int[] arrIndices;
		MProgramador creador;
		String[] posteador;
		String[][] responde;
		boolean existe;
		MLike like;
		boolean likeado;
		
		sesion = request.getSession();
		user = sesion.getAttribute("user");
		publicacion = new MPublicacion();
		respuesta = new MRespuesta();
		posteador = new String[3];
		like = new MLike();
		
		
		if(sesion.getAttribute("locale") != null) response.setLocale((Locale) sesion.getAttribute("locale"));
		ResourceBundle i18n = ResourceBundle.getBundle("i18n.i18n", response.getLocale());
		
		if(user == null) response.sendRedirect("login");
		else {
			if(user.getClass().getName().equals("Programador.MProgramador")) {
				programador = (MProgramador) user;
				try {
					id = Integer.parseInt(request.getParameter("id"));
					existe = publicacion.leer("id", id);
					if(existe && publicacion.isActivo()) {
						respuestas = new MRespuesta[publicacion.getRespuestas()];
						arrIndices = new int[respuestas.length];
						responde = new String[respuestas.length][3];
						sesion.setAttribute("publicacion.data", publicacion);
						
						//Sacamos el creador de la publicacion
						creador = new MProgramador();
				   	    posteador = creador.leerColumna("username","nombre", "id", publicacion.getUsuario());
				   	    likeado = false;
				   	    
				   	    //Sacamos la lista de likes, si el usuario le dio like lo marcamos
					   	ArrayList<Integer> listaLikes = like.listarRelacion("publicacion", publicacion.getId());
					   	for(int fLike: listaLikes) {
					   		like.leer("id", fLike);
					   		if(like.isActivo() && like.getUsuario() == programador.getId()) likeado = true;
					   	}
					   	sesion.setAttribute("publicacion.likeada", likeado);
						sesion.setAttribute("publicacion.likes", publicacion.getLikes());
						sesion.setAttribute("publicacion.creador", posteador);
						
						//Sacamos las respuestas de la publicacion
						arrIndices = publicacion.getIndicesRespuestas(arrIndices.length);
						if(respuestas.length > 0) {
							for(int i = 0; i < respuestas.length; i++) {
								respuesta = new MRespuesta();
								respuesta.leer("id", arrIndices[i]);
								posteador = creador.leerColumna("username","nombre", "id", respuesta.getUsuario());
								respuestas[i] = respuesta;
								responde[i][0] = posteador[0];
								responde[i][1] = posteador[1];
						   	 	responde[i][2] = posteador[2];
							}
							sesion.setAttribute("publicacion.respuestas", respuestas);
							sesion.setAttribute("publicacion.responde", responde);
						} else sesion.setAttribute("publicacion.respuestas", null);
					} else {
						sesion.setAttribute("publicacion.likes", 0);
						sesion.setAttribute("error", i18n.getString("publication.404"));
					}
				} catch(Exception e) {
					sesion.setAttribute("error", i18n.getString("publication.404"));
				}
				request.getRequestDispatcher("WEB-INF/publicacion.jsp").forward(request, response);
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
