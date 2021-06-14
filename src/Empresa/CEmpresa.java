package Empresa;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class CEmpresa
 */
@WebServlet("/empresa")
public class CEmpresa extends HttpServlet {
	private static final long serialVersionUID = 1L;
	HttpSession sesion;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Object user;
		
		sesion = request.getSession();
		user = sesion.getAttribute("user");
		if(user == null) response.sendRedirect("login");
		else {
			if(user.getClass().getName().equals("Empresa.MEmpresa")) {
				request.getRequestDispatcher("WEB-INF/empresa/inicio.jsp").forward(request, response);
			}
			else response.sendRedirect("inicio");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
