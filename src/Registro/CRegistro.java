package Registro;

import java.io.IOException;
import java.util.Locale;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class CRegistro
 */
@WebServlet("/registro")
public class CRegistro extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession sesion = request.getSession();
		Object user = sesion.getAttribute("user");
		
		if(sesion.getAttribute("locale") != null) {
    		response.setLocale((Locale)sesion.getAttribute("locale"));
    	}
		
		if(user != null) {
			if(user.getClass().getName().equals("Programador.MProgramador")) response.sendRedirect("inicio");
			else response.sendRedirect("empresa");
		}
		else request.getRequestDispatcher("WEB-INF/registro.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
