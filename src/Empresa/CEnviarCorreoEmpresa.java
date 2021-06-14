package Empresa;

import java.io.IOException;
import java.util.Locale;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Empresa.MEmpresa;
import Utilidades.Correo;
import Utilidades.Random;

/**
 * Servlet implementation class CConfirmarCorreo
 */
@WebServlet("/correoConfirmacionEmpresa")
public class CEnviarCorreoEmpresa extends HttpServlet {
	private static final long serialVersionUID = 1L;
	HttpSession sesion;   

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String codigo;
		Random rand;
		Correo correo;
		Object user;
		MEmpresa empresa;
		
		sesion = request.getSession();
		user = sesion.getAttribute("user");
		
		if(sesion.getAttribute("locale") != null) {
    		response.setLocale((Locale)sesion.getAttribute("locale"));
    	}
		
		if(user == null) response.sendRedirect("login");
		else {
			if(user.getClass().getName().equals("Empresa.MEmpresa")) {
				empresa = (MEmpresa) sesion.getAttribute("user");
				rand = new Random();
				correo = new Correo();
				codigo = rand.cadena(6);
				correo.correoVerificacion(empresa.getMail(), empresa.getNombre(), codigo);
				sesion.setAttribute("codigo", codigo);
				response.sendRedirect("empresa-editar-perfil#confirmacion");
			}
			else response.sendRedirect("inicio");
		}

	}

}
