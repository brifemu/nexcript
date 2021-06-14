package Perfil;

import java.io.IOException;
import java.util.Locale;
import java.util.ResourceBundle;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Bloqueo.MBloqueo;
import Codigo.MAportacion;
import Programador.MProgramador;
import Publicacion.MPublicacion;

/**
 * Servlet implementation class CPerfil
 */
@WebServlet("/perfil")
public class CPerfil extends HttpServlet {
	private static final long serialVersionUID = 1L;
	HttpSession sesion;
	
	final int MAX_PUBLICACIONES = 10;
	final int MAX_APORTES = 10;
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Object user;
		MPublicacion publicacion;
		MAportacion aportacion;
		MProgramador programador;
		MProgramador perfil;
		MBloqueo bloqueo;
		String username;
		boolean existeBloqueo;
		boolean bloqueoActivo;
		
		MPublicacion[] publicaciones;
		
		MAportacion[] aportaciones;

		int[] likes;
		int[] respuestas;
		boolean[] likeado;
		

		
		sesion = request.getSession();
		user = sesion.getAttribute("user");
		

		bloqueoActivo = false;
		programador = (MProgramador) user;
		bloqueo = new MBloqueo();
		publicaciones = new MPublicacion[MAX_PUBLICACIONES];
		likes = new int[MAX_PUBLICACIONES];
		respuestas = new int[MAX_PUBLICACIONES];
		likeado = new boolean[MAX_PUBLICACIONES];
				
		aportaciones = new MAportacion[MAX_APORTES];

		
		if(sesion.getAttribute("locale") != null) response.setLocale((Locale) sesion.getAttribute("locale"));
		ResourceBundle i18n = ResourceBundle.getBundle("i18n.i18n", response.getLocale());
		
		if(user == null) response.sendRedirect("login");
		else {
			if(user.getClass().getName().equals("Programador.MProgramador")) {

				username = request.getParameter("p");
				perfil = new MProgramador();
				if(perfil.leer("username", username)) {
					
					//SETEA EL PERFIL QUE VAMOS A VER
					sesion.setAttribute("perfil.data", perfil);
					
					
					//COMPROBAMOS SI LO TENEMOS BLOQUEADO
					existeBloqueo = bloqueo.leer(programador.getId(), perfil.getId());
					if(existeBloqueo) bloqueoActivo = bloqueo.isActivo();
					sesion.setAttribute("perfil.user.bloqueado", bloqueoActivo);
					
					
					//Limpiamos la variable que vamos a reutilizar
					bloqueoActivo = false;
					
					
					//COMPROBAMOS SI EL USUARIO NOS TIENE BLOQUEADO
					existeBloqueo = bloqueo.leer(perfil.getId(), programador.getId());
					if(existeBloqueo) bloqueoActivo = bloqueo.isActivo();
					sesion.setAttribute("perfil.bloqueado", bloqueoActivo);
					
					
				   	// CARGA PUBLICACIONES
				   	publicacion = new MPublicacion();				   	
				   	publicaciones = publicacion.realizarBusqueda(perfil.getId(), 1, MAX_PUBLICACIONES);
				   	sesion.setAttribute("perfil.publicaciones", publicaciones);
				   	
				   	
				   	int ii = 0;
				   	while(publicaciones[ii] != null) {
						likes[ii] = publicaciones[ii].getLikes();
						respuestas[ii] = publicaciones[ii].getRespuestas();
						likeado[ii] = publicaciones[ii].likeado(programador.getId());
						ii++;
				   	}
				   	sesion.setAttribute("perfil.publicaciones.likes", likes);
				   	sesion.setAttribute("perfil.publicaciones.likes.propios", likeado);
				   	sesion.setAttribute("perfil.publicaciones.respuestas", respuestas);
				   	
				   	
				   	// CARGA APORTACIONES
				   	aportacion = new MAportacion();				   	
				   	aportaciones = aportacion.realizarBusqueda(perfil.getId(), 1, MAX_APORTES);
				   	sesion.setAttribute("perfil.aportaciones", aportaciones);				  

				   	
		    	} else  sesion.setAttribute("error-perfil", i18n.getString("profile.none"));
				request.getRequestDispatcher("WEB-INF/perfil.jsp").forward(request, response);
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
