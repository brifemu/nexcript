package BarraBusqueda;

import java.io.IOException;
import java.util.Locale;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class CBarraBusqueda
 */
@WebServlet("/busqueda")
public class CBarraBusqueda extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession sesion = request.getSession();
		String busqueda = request.getParameter("q");
		int pagina;
		Object user = sesion.getAttribute("user");
		
		if(sesion.getAttribute("locale") != null) response.setLocale((Locale)sesion.getAttribute("locale"));
		if(user == null) response.sendRedirect("login");
		else {
			if(user.getClass().getName().equals("Programador.MProgramador")) {
				try {
					pagina = Integer.parseInt(request.getParameter("p"));
					if(busqueda == null || busqueda == "") response.sendRedirect("inicio");
					else request.getRequestDispatcher("WEB-INF/busqueda.jsp").forward(request, response);
				} catch(Exception e) {
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
