package Codigo;

import java.io.IOException;
import java.util.Locale;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class CCrearAporte
 */
@WebServlet("/crear-aporte")
public class CCrearAporte extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	HttpSession sesion;
	MLenguaje[] lenguajes;
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MLenguaje leng;
		Object user;
				
		sesion = request.getSession();
		leng = new MLenguaje();
		user = sesion.getAttribute("user");
		
		if(lenguajes == null) lenguajes = leng.listaLenguajes();
		if(sesion.getAttribute("locale") != null) response.setLocale((Locale)sesion.getAttribute("locale"));
    	
		if(user == null) response.sendRedirect("login");
		else {
			if(user.getClass().getName().equals("Programador.MProgramador")) {
				sesion.setAttribute("listaLenguajes", lenguajes);
				request.getRequestDispatcher("WEB-INF/crear-aporte.jsp").forward(request, response);
			}
			else response.sendRedirect("empresa");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("WEB-INF/beans/crear-aporte.jsp").forward(request, response);
	}

}
