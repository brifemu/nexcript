package EditarPerfil;

import java.io.IOException;
import java.util.Locale;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Codigo.MLenguaje;
import Programador.MProgramador;

/**
 * Servlet implementation class CEditarPerfil
 */
@WebServlet("/editar-perfil")
public class CEditarPerfil extends HttpServlet {
	private static final long serialVersionUID = 1L;
	HttpSession sesion; 
	MLenguaje[] arrLenguajes;
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Object user;
		MProgramador programador;
		
		sesion = request.getSession();
		user = sesion.getAttribute("user");
		
		if(arrLenguajes == null) {
			MLenguaje leng = new MLenguaje();
			arrLenguajes=leng.listaLenguajes();
		}
		
		if(sesion.getAttribute("locale") != null) {
    		response.setLocale((Locale)sesion.getAttribute("locale"));
    	}
		
		if(user == null) response.sendRedirect("login");
		else {
			if(user.getClass().getName().equals("Programador.MProgramador")) {
				sesion.setAttribute("listaLenguajes", arrLenguajes);
				//Recargamos el objeto del usuario por si no está sincronizado con los datos de la bd
				programador = (MProgramador) sesion.getAttribute("user");
				programador.leer("id", programador.getId());
				sesion.setAttribute("user", programador);
				request.getRequestDispatcher("WEB-INF/editar-perfil.jsp").forward(request, response);
			}
			else response.sendRedirect("empresa");
		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String boton = request.getParameter("btnSubmit");
		
		switch(boton) {
		
			case "perfil":
				request.getRequestDispatcher("WEB-INF/beans/editar-perfil.jsp").forward(request, response);
			break;
			
			case "correo":
				request.getRequestDispatcher("WEB-INF/beans/editar-correo.jsp").forward(request, response);
			break;
			
			case "password":
				request.getRequestDispatcher("WEB-INF/beans/editar-pass.jsp").forward(request, response);
			break;
			
			case "confirmacion":
				request.getRequestDispatcher("WEB-INF/beans/verificar-correo.jsp").forward(request, response);
			break;
			
			default:
				response.sendRedirect("login");
			break;
		
		}
	}

}
