package EditarPerfil;

import java.io.IOException;
import java.util.Locale;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Programador.MProgramador;
import Utilidades.Correo;
import Utilidades.Random;

/**
 * Servlet implementation class CConfirmarCorreo
 */
@WebServlet("/correoConfirmacion")
public class CEnviarCorreo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession sesion = request.getSession();
		String codigo;
		Random rand;
		Correo correo;
		Object user = sesion.getAttribute("user");
		MProgramador programador;
		
		if(sesion.getAttribute("locale") != null) {
    		response.setLocale((Locale)sesion.getAttribute("locale"));
    	}
		
		if(user == null) response.sendRedirect("login");
		else {
			if(user.getClass().getName().equals("Programador.MProgramador")) {
				programador = (MProgramador) sesion.getAttribute("user");
				rand = new Random();
				correo = new Correo();
				codigo = rand.cadena(6);
				correo.correoVerificacion(programador.getMail(), programador.getNombre(), codigo);
				sesion.setAttribute("codigo", codigo);
				response.sendRedirect("editar-perfil#confirmacion");
			}
			else response.sendRedirect("empresa");
		}

	}

}
