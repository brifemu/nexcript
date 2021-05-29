package PintarImagen;

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
 * Servlet implementation class ImagenProgramador
 */
@WebServlet("/ImagenProgramador")
public class ImagenProgramador extends HttpServlet {
	private static final long serialVersionUID = 1L;
     

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		HttpSession sesion = request.getSession();
		MProgramador user = new MProgramador();
		boolean existe = false;
		int id;
		
		try {
			id = Integer.parseInt((String) request.getParameter("id"));
			if(id != 0) {
				existe = user.leer("id", id);
				if(existe) {
					// Tells the browser to output pictures
					response.setContentType ("image/jpg");
					// Output image output stream
					OutputStream out = response.getOutputStream ();
					// Output to the input of the buffer page
					out.write (user.getFoto());
					// Input is completed, clear buffer
					out.flush ();
					out.close();
				}
			} else response.sendRedirect("login");
		} catch(Exception e) {
			response.sendRedirect("login");
		}
		
		
	}



}
