package Perfil;

import java.io.IOException;
import java.util.Locale;
import java.util.ResourceBundle;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Programador.MProgramador;
import Publicacion.MPublicacion;

/**
 * Servlet implementation class CPerfil
 */
@WebServlet("/perfil")
public class CPerfil extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession sesion = request.getSession();
		Object user = sesion.getAttribute("user");
		MPublicacion publicacion;
		MProgramador programador;
		int pagina = 1;
		String username;
		int[] resultado;
		
		if(sesion.getAttribute("locale") != null) response.setLocale((Locale) sesion.getAttribute("locale"));
		ResourceBundle i18n = ResourceBundle.getBundle("i18n.i18n", response.getLocale());
		
		if(user == null) response.sendRedirect("login");
		else {
			if(user.getClass().getName().equals("Programador.MProgramador")) {
				username = request.getParameter("p");
				programador = (MProgramador) sesion.getAttribute("user");
				if(programador.leer("username", username)) {
					publicacion = new MPublicacion();
			    	if(sesion.getAttribute("paginaPublicaciones") == null) pagina = 1;
			   		else pagina = Integer.parseInt((String)sesion.getAttribute("paginaPublicaciones"));
			   		if( pagina <= 0) pagina = 1;	
				   	
				   	resultado = publicacion.realizarBusqueda(programador.getId(), pagina, 20);
				   	sesion.setAttribute("busqPublicaciones", resultado);
		    	} else  sesion.setAttribute("error-perfil", i18n.getString("profile.none"));
				request.getRequestDispatcher("WEB-INF/perfil.jsp").forward(request, response);
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
