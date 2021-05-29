package Utilidades;

import java.io.File;

public class FileExtension {
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
