package Bloqueo;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.Locale;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Programador.MProgramador;

/**
 * Servlet implementation class CBloqueo
 */
@WebServlet("/bloquear")
public class CBloqueo extends HttpServlet {
	private static final long serialVersionUID = 1L;
    HttpSession sesion;   

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Object user;
		String paramBloqueo;
		MProgramador programador;
		MProgramador bloqueado;
		MBloqueo bloqueo;
		boolean existeBloqueado;
		boolean existeBloqueo;
		Date today;
		Timestamp fecha;
		
		sesion = request.getSession();
		user = sesion.getAttribute("user");
		paramBloqueo = request.getParameter("bloq");
		programador = (MProgramador) user;
		bloqueo = new MBloqueo();
		bloqueado = new MProgramador();	
		today = new Date();
		fecha = new Timestamp(today.getTime());
		
		if(sesion.getAttribute("locale") != null) response.setLocale((Locale)sesion.getAttribute("locale"));
		if(user == null) response.sendRedirect("login");
		else { 
			if(user.getClass().getName().equals("Programador.MProgramador")) {		
				//Comprueba si ya existe un bloqueo entre los usuarios
				existeBloqueado = bloqueado.leer("username", paramBloqueo);
				if(existeBloqueado) {
					existeBloqueo = bloqueo.leer(programador.getId(), bloqueado.getId());
					//Si el bloqueo existia, lo coge y le hace update
					if(existeBloqueo) {
						bloqueo.update("activo", !bloqueo.isActivo());
						sesion.setAttribute("perfil.user.bloqueado", bloqueo.isActivo());
						if(bloqueo.isActivo()) bloqueo.update("fecha", fecha);
					}
					else bloqueo.insertar(programador.getId(), bloqueado.getId()); //Si no existe lo crea
				}	
				response.sendRedirect(request.getHeader("Referer"));
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
