package Utilidades;


public class FileExtension {
	
	//Obtenemos la extensión de un archivo
    public String getFileExtension(String name) {
        String extension = "";
        try {
            extension = name.substring(name.lastIndexOf("."));
        } catch (Exception e) {
            extension = "";
        }
        return extension;
 
    }
}
