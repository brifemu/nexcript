package BarraBusqueda;

import java.io.IOException;
import java.util.Locale;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Programador.MProgramador;

/**
 * Servlet implementation class CBarraBusqueda
 */
@WebServlet("/busqueda")
public class CBarraBusqueda extends HttpServlet {
	private static final long serialVersionUID = 1L;
	HttpSession sesion;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Object user;
		String busqueda;
		int pagina;
		
		sesion = request.getSession();
		user = sesion.getAttribute("user");
		busqueda = request.getParameter("q");
		pagina = 1;
		
		int max_registros;	
		int paginas;
		int resultados;
		int contador;
		MProgramador programador;
		MProgramador[] resultado;
		
		max_registros = 4;
		pagina = 1;
		contador = 0;
		
		if(sesion.getAttribute("locale") != null) response.setLocale((Locale)sesion.getAttribute("locale"));
		if(user == null) response.sendRedirect("login");
		else {
			if(user.getClass().getName().equals("Programador.MProgramador")) {
				programador = (MProgramador) user;
				try {
					pagina = Integer.parseInt(request.getParameter("p"));
					if(busqueda == null || busqueda == "") response.sendRedirect("inicio");
					else {
						//Controla las páginas y carga los datos
						if(pagina < 1) sesion.setAttribute("error", "Página inválida");
						resultado = programador.realizarBusqueda(busqueda, pagina, max_registros);
						resultados = programador.totalResultados(busqueda);
						for(int i = 0; i < max_registros; i++){
							if(resultado[i] != null) contador++;
						}
						paginas = (int) Math.ceil((double)resultados/(double)max_registros);
						if(pagina > paginas) sesion.setAttribute("error", "Página inválida");
						//Setea las sesiones
						sesion.setAttribute("busqueda.data", resultado);
						sesion.setAttribute("busqueda.resultados.totales", resultados);
						sesion.setAttribute("busqueda.resultados.consulta", contador);
						sesion.setAttribute("busqueda.paginas", paginas);
						request.getRequestDispatcher("WEB-INF/busqueda.jsp").forward(request, response);
					}
				} catch(Exception e) {
					response.sendRedirect("inicio");
				}	
			}
			else response.sendRedirect("empresa");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("WEB-INF/beans/barra-busqueda.jsp").forward(request, response);
	}

}
