package Codigo;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Locale;
import java.util.ResourceBundle;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Programador.MProgramador;


/**
 * Servlet implementation class CAportacion
 */
@WebServlet("/aporte")
public class CAportacion extends HttpServlet {
	private static final long serialVersionUID = 1L;
	HttpSession sesion;
	MLenguaje[] arrLenguajes;
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(arrLenguajes == null) {
			MLenguaje leng = new MLenguaje();
			arrLenguajes=leng.listaLenguajes();
		}
		Object user;
		MAportacion aportacion;
		String icono;
		MProgramador cread;
		MProgramador programador;
		String creador;
		int id;
		boolean existe;
		boolean valorado;
		
		MComentario comentario;
		MComentario[] comentarios;
		int[] arrIndices;
		String[] posteador;
		String[][] comenta;
		int media;
		int nota;
		
		MValoracion valoracion;
		
		sesion = request.getSession();
		user = sesion.getAttribute("user");
		comentario = new MComentario();
		posteador = new String[3];
		cread = new MProgramador();
		valoracion = new MValoracion();
		media = 0;
		nota = 0;
		
		if(sesion.getAttribute("locale") != null) response.setLocale((Locale) sesion.getAttribute("locale"));
		ResourceBundle i18n = ResourceBundle.getBundle("i18n.i18n", response.getLocale());
		
		if(user == null) response.sendRedirect("login");
		else {
			if(user.getClass().getName().equals("Programador.MProgramador")) {
				programador = (MProgramador) user;
				sesion.setAttribute("listaLenguajes", arrLenguajes);
				//Parsea el parametro que arrastra por URL, si lo puede parsear seguimos sino devolvemos error
				try {
					id = Integer.parseInt(request.getParameter("id"));
					aportacion = new MAportacion();
					existe = aportacion.leer("id", id);
					//Comprueba si el aporte existe o ha sido eliminado por el usuario
					if(!existe || !aportacion.isActivo()) sesion.setAttribute("error", i18n.getString("contribution.none"));
					else {
						comentarios = new MComentario[aportacion.getRespuestas()];
						arrIndices = new int[comentarios.length];
						comenta = new String[comentarios.length][3];
						arrIndices = aportacion.getIndicesComentarios(arrIndices.length);
						
						valorado = false;
						//Recorremos las valoraciones del aporte, si el usuario que lo visita está en ellas lo guardamos
					   	ArrayList<Integer> listaValoraciones = valoracion.listarRelacion("codigo", aportacion.getId());
					   	for(int val: listaValoraciones) {
					   		valoracion.leer("id", val);
					   		media += valoracion.getValoracion();
					   		if(valoracion.getUsuario() == programador.getId()) {
					   			valorado = true;
					   			nota = valoracion.getValoracion();
					   			
					   		}
					   	} 
					   	//Seteamos las sesiones
					   	sesion.setAttribute("aportacion.valoracion", valorado ? String.valueOf(nota) : null);
					   	sesion.setAttribute("aportacion.valorada", valorado);
					   	sesion.setAttribute("aportacion.valoracionmedia", String.format("%.1f", (Double.valueOf(media)/Double.valueOf(listaValoraciones.size()))));
					   	sesion.setAttribute("aportacion.valoraciones", listaValoraciones.size() == 0 ? null : listaValoraciones.size());
					   	
					   	//Obtenemos los comentarios del aporte
						if(comentarios.length > 0) {
							for(int i = 0; i < comentarios.length; i++) {
								comentario = new MComentario();
								comentario.leer("id", arrIndices[i]);
								cread.leer("id", comentario.getUsuario());
								posteador = cread.leerColumna("username","nombre", "id", comentario.getUsuario());
								comentarios[i] = comentario;
								comenta[i][0] = posteador[0];
								comenta[i][1] = posteador[1];
								comenta[i][2] = posteador[2];
							}
							sesion.setAttribute("aportacion.comentarios", comentarios);
							sesion.setAttribute("aportacion.comentadores", comenta);
						} else sesion.setAttribute("aportacion.comentarios", null);
						
						
						//Obtenemos los datos del creador del aporte y del propio aporte
						cread.leer("id", aportacion.getUsuario());
						creador = cread.getUsername();
						icono = getIconoByValue(aportacion.getLenguaje());
						sesion.setAttribute("aportacion.data", aportacion);
						sesion.setAttribute("aportacion.icono", icono);
						sesion.setAttribute("aportacion.creador", creador);
					}
				} catch (Exception e) {
					sesion.setAttribute("error", i18n.getString("contribution.none"));		
				}
				request.getRequestDispatcher("WEB-INF/aportacion.jsp").forward(request, response);
			}
			else response.sendRedirect("empresa");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String boton = request.getParameter("btnSubmit");
		//Segun a que botón de submit demos, a ese bean nos llevará
		switch(boton) {
			case "eliminar":
				request.getRequestDispatcher("WEB-INF/beans/eliminarAporte.jsp").forward(request, response);
				break;
				
			case "editar":
				request.getRequestDispatcher("WEB-INF/beans/editar-aporte.jsp").forward(request, response);
				break;
				
			case "comentar":
				request.getRequestDispatcher("WEB-INF/beans/comentario.jsp").forward(request, response);
				break;
				
			case "valorar":
				request.getRequestDispatcher("WEB-INF/beans/valorar.jsp").forward(request, response);
				break;
				
			default:
				response.sendRedirect("login");
			break;
		}
	}

	public String getIconoByValue(String valor) {
		String icono = "";
		for(MLenguaje leng:arrLenguajes){
			if(leng.getValor().equalsIgnoreCase(valor)) icono = leng.getIcono();
		}
		return icono;
	}
}
