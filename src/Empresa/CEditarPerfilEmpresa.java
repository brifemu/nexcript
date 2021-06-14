package Empresa;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class CEditarPerfil
 */
@WebServlet("empresa-editar-perfil")
public class CEditarPerfilEmpresa extends HttpServlet {
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
				request.getRequestDispatcher("WEB-INF/empresa/editar-perfil.jsp").forward(request, response);
			}
			else response.sendRedirect("inicio");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String boton = request.getParameter("btnSubmit");
		
		switch(boton) {
		
			case "perfil":
				request.getRequestDispatcher("WEB-INF/beans/empresa/editar-perfil.jsp").forward(request, response);
			break;
			
			case "correo":
				request.getRequestDispatcher("WEB-INF/beans/empresa/editar-correo.jsp").forward(request, response);
			break;
			
			case "password":
				request.getRequestDispatcher("WEB-INF/beans/empresa/editar-pass.jsp").forward(request, response);
			break;
			
			case "confirmacion":
				request.getRequestDispatcher("WEB-INF/beans/empresa/verificar-correo.jsp").forward(request, response);
			break;
			
			default:
				response.sendRedirect("login");
			break;
		
		}
	}

}
