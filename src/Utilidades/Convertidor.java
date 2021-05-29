package Utilidades;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

public class Convertidor {
	public byte[] convertFileToByteArray(File file){
	    FileInputStream fis = null;
	    // Creating bytearray of same length as file
	    byte[] bArray = new byte[(int) file.length()];
	    try{
	      fis = new FileInputStream(file);
	      // Reading file content to byte array
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
