package Empleo;

import java.io.IOException;
import java.util.Locale;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Programador.MProgramador;

/**
 * Servlet implementation class CEliminarCurriculum
 */
@WebServlet("/eliminarCurriculum")
public class CEliminarCurriculum extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession sesion = request.getSession();
		Object user = sesion.getAttribute("user");
		MProgramador programador;
		
		if(sesion.getAttribute("locale") != null) response.setLocale((Locale)sesion.getAttribute("locale"));
		
		if(user == null) response.sendRedirect("login");
		else {
			if(user.getClass().getName().equals("Programador.MProgramador")) {
				programador = (MProgramador) sesion.getAttribute("user");
				programador.setCurriculum(null);
				programador.setNull("curriculum");
				programador.setNull("fechaCurriculum");
				//Actualizamos los datos desde la base de datos
				programador.leer("id", programador.getId());
				sesion.setAttribute("user", programador);
				request.getRequestDispatcher("WEB-INF/empleo.jsp").forward(request, response);
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
