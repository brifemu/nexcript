package DB;

import java.sql.*;
public class Conexion {
	/*final String url = "jdbc:postgresql://ns3034756.ip-91-121-81.eu:5432/a20-bfermun?currentSchema=proyecto";
    final String user = "a20-bfermun";
    final String pass = "a20-bfermun"; */
	
	final String ip = "localhost";
    final int port = 5432;
    final String db = "proyecto";
    final String schema = "proyecto";
	final String user = "usuario";
    final String pass = "usuaria";
	final String url = "jdbc:postgresql://"+ip+":"+port+"/"+db+"?currentSchema="+schema;
	
    Connection con;
    
    public Connection crearConexion() {
    	try{
            try{
            	Class.forName("org.postgresql.Driver");
            } catch(Exception e) {
            	System.err.println("Error al cargar el driver");
            }
            this.con = DriverManager.getConnection(url, user, pass);
            return this.con;
        } catch(Exception e){
        	System.err.println("Ha ocurrido un error al conectarse a la base de datos. Comprueba el estado del servidor o los datos de acceso introducidos.");
        	return this.con;
        }
    }
}