package Empresa;

import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Programador.MProgramador;

/**
 * Servlet implementation class CDescargarCurriculum
 */
@WebServlet("/curriculum")
public class CCurriculumEmpresa extends HttpServlet {
	private static final long serialVersionUID = 1L;
	HttpSession sesion;   

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Object user;
		MProgramador programador;
		int id;
		boolean existe;
		
		programador = new MProgramador();
		sesion = request.getSession();	
		user = (Object) sesion.getAttribute("user");
		
		if(user == null) response.sendRedirect("login");
		else {
			if(user.getClass().getName().equals("Empresa.MEmpresa")) {
				
				try {
					id = Integer.parseInt((String) request.getParameter("id"));
					if(id != 0) {
						existe = programador.leer("id", id);
						if(existe && programador.getCurriculum() != null) {
							// Tells the browser to output pictures
							response.setContentType ("pdf");
							// Output image output stream
							OutputStream out = response.getOutputStream ();
							// Output to the input of the buffer page
							out.write (programador.getCurriculum());
							// Input is completed, clear buffer
							out.flush ();
							out.close();
						} else {
							sesion.setAttribute("error", "No existen datos para la consulta requerida");
							response.sendRedirect("desarrolladores");
						}	
					} else response.sendRedirect("login");
				} catch(Exception e) {
					response.sendRedirect("login");
				}
			}
			else response.sendRedirect("inicio");
		}
		
		
	}

}
