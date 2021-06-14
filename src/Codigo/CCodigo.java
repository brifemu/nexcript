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
 * Servlet implementation class CCodigo
 */
@WebServlet("/codigo")
public class CCodigo extends HttpServlet {
	private static final long serialVersionUID = 1L;
	HttpSession sesion;  
	final int MAX_APORTES = 20;
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		Object user;
		MAportacion[] aportaciones;
		MAportacion aportacion;
		
		sesion = request.getSession();
		user = sesion.getAttribute("user");
		aportaciones = new MAportacion[MAX_APORTES];
		
		if(sesion.getAttribute("locale") != null) response.setLocale((Locale)sesion.getAttribute("locale"));
    	
		if(user == null) response.sendRedirect("login");
		else {
			if(user.getClass().getName().equals("Programador.MProgramador")) {
				
				// CARGA APORTACIONES
			   	aportacion = new MAportacion();	

			   	aportaciones = aportacion.realizarBusqueda(MAX_APORTES);
			   	sesion.setAttribute("codigo.aportaciones", aportaciones);
			   			   	

				request.getRequestDispatcher("WEB-INF/codigo.jsp").forward(request, response);
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
