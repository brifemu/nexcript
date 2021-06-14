package Inicio;

import java.io.IOException;
import java.util.Locale;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Codigo.MAportacion;


/**
 * Servlet implementation class CInicio
 */
@WebServlet("/inicio")
public class CInicio extends HttpServlet {
	private static final long serialVersionUID = 1L;
	HttpSession sesion;
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { 		
		Object user;
		MAportacion aportacion;
		MAportacion[] aportaciones;
		
		
		sesion = request.getSession();
		user = sesion.getAttribute("user");
		
		if(sesion.getAttribute("locale") != null) response.setLocale((Locale)sesion.getAttribute("locale"));
		if(user == null) response.sendRedirect("login");
		else { 
			if(user.getClass().getName().equals("Programador.MProgramador")) {
					
				aportacion = new MAportacion();	
				//Carga las últimas 5 aportaciones más recientes
				aportaciones = aportacion.realizarBusqueda(5);
			   	sesion.setAttribute("inicio.aportaciones", aportaciones);  
				request.getRequestDispatcher("WEB-INF/inicio.jsp").forward(request, response);
				
			}
			else response.sendRedirect("empresa");
		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("WEB-INF/beans/publicacion.jsp").forward(request, response);
		
	}
	
}
