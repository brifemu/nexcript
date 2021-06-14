package Etiquetas;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import Programador.MProgramador;

public class TarjetaPerfil extends SimpleTagSupport{
	int id;
	
	
	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	@Override
    public void doTag() throws JspException, IOException {
		JspWriter out = getJspContext().getOut();
        MProgramador programador;
        programador = new MProgramador();
        //Carga los datos del usuario según la id recibida en el parámetro de la etiqueta
        programador.leerMinimo(id);
        //Pinta la tarjeta del usuario según la id recibida en el parámetro de la etiqueta
        String tarjeta = "<div class=\"card col-md-3\" onclick=\"location.href='perfil?p="+programador.getUsername()+"'\">	\n" + 
        		"			    		  <img class=\"profile-big ml-auto mr-auto\" src=\"ImagenProgramador?id="+id+"\">  \n" + 
        		"						  <div class=\"card-body d-flex flex-column\">\n" + 
        		"						  	<a class=\"card-text ml-auto mr-auto\">@"+programador.getUsername()+"</a>\n" + 
        		"						    <a class=\"h4 card-title ml-auto mr-auto text-center\">"+programador.getNombre()+"</a>   \n" + 
        		"						  </div>\n" + 
        		"						</div>";
        out.print(tarjeta);
    }
}
