package Empresa;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Programador.MProgramador;

/**
 * Servlet implementation class CDesarrolladores
 */
@WebServlet("/desarrolladores")
public class CDesarrolladores extends HttpServlet {
	private static final long serialVersionUID = 1L;
	HttpSession sesion;  

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Object user;
		MProgramador programador;
		ArrayList<MProgramador> desarrolladores;
		
		sesion = request.getSession();
		user = sesion.getAttribute("user");
		programador = new MProgramador();
		desarrolladores = new ArrayList<MProgramador>();
		
		if(user == null) response.sendRedirect("login");
		else {
			if(user.getClass().getName().equals("Empresa.MEmpresa")) {
				for(MProgramador dev : programador.listar("curriculum")) {
					desarrolladores.add(dev);
				}
				sesion.setAttribute("desarrolladores", desarrolladores);
				request.getRequestDispatcher("WEB-INF/empresa/desarrolladores.jsp").forward(request, response);
			}
			else response.sendRedirect("inicio");
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
