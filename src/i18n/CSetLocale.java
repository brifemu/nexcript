package i18n;

import java.io.IOException;
import java.util.Locale;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class CSetLocale
 */
@WebServlet("/setLocale")
public class CSetLocale extends HttpServlet {
	private static final long serialVersionUID = 1L;
	HttpSession sesion;
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String lang;
		String[] validLangs = {"es_ES","en_US","fr_FR","de_DE"};
		boolean validLang;
		Locale locale;
		
		sesion = request.getSession();
		lang = request.getParameter("lang");
		validLang = false;
		
		for(String lg: validLangs) {
			if(lang.equals(lg)) validLang = true;
		}
		if(validLang) {
			String[] lg = lang.split("_");
			locale = new Locale(lg[0], lg[1]);
			sesion.setAttribute("locale", locale);
			response.setLocale(locale);
		}
		response.sendRedirect(request.getHeader("Referer"));
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
