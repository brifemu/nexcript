package Utilidades;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

public class Convertidor {
	public byte[] convertFileToByteArray(File file){
	    FileInputStream fis = null;
	    // Crea un array de la longitud de bytes del archivo
	    byte[] bArray = new byte[(int) file.length()];
	    try{
	      fis = new FileInputStream(file);
	      //Lee el archivo e inserta los bytes en el array
	      fis.read(bArray);
	      fis.close();                    
	    }catch(IOException ioExp){
	      ioExp.printStackTrace();
	    }finally{
	      if(fis != null){
	        try {
	          fis.close();
	        } catch (IOException e) {
	          // TODO Auto-generated catch block
	          e.printStackTrace();
	        }
	      }
	    }
	    return bArray;
	  }
}
