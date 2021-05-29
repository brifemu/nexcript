package Empleo;

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
@WebServlet("/descargarCurriculum")
public class CDescargarCurriculum extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession sesion = request.getSession();
		MProgramador programador = (MProgramador) sesion.getAttribute("user");
		
		// Tells the browser to output
		response.setContentType ("pdf");
		// Output image output stream
		OutputStream out = response.getOutputStream ();
		// Output to the input of the buffer page
		out.write (programador.getCurriculum());
		// Input is completed, clear buffer
		out.flush ();
		out.close();
	}

}
