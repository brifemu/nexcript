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
import Publicacion.MPublicacion;

/**
 * Servlet implementation class ImagenProgramador
 */
@WebServlet("/ImagenPublicacion")
public class ImagenPublicacion extends HttpServlet {
	private static final long serialVersionUID = 1L;
     

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		MPublicacion publicacion = new MPublicacion();
		boolean existe = false;
		int id;
		
		try {
			id = Integer.parseInt((String) request.getParameter("id"));
			if(id != 0) {
				existe = publicacion.leer("id", id);
				if(existe) {
					// Tells the browser to output pictures
					response.setContentType ("image/jpg");
					// Output image output stream
					OutputStream out = response.getOutputStream ();
					// Output to the input of the buffer page
					out.write (publicacion.getImagen());
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
