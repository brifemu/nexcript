package Admin;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class CLoginAdmin
 */
@WebServlet("/admin-login")
public class CLoginAdmin extends HttpServlet {
	private static final long serialVersionUID = 1L;
    HttpSession sesion;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Object user;
		sesion = request.getSession();
		user = sesion.getAttribute("user");
		
		if(user == null) {
			request.getRequestDispatcher("WEB-INF/admin/login.jsp").forward(request, response);
		} else { 
			if(user.getClass().getName().equals("Empleado.MEmpleado")) {
				response.sendRedirect("admin-inicio");
			} else response.sendRedirect("login");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("WEB-INF/beans/admin/login.jsp").forward(request, response);
	}

}
