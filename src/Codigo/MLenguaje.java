package Codigo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import DB.Conexion;

public class MLenguaje {
	int id;
	String nombre;
	String valor;
	String icono;
	
	private Conexion conexion;
	private Connection con;
	private PreparedStatement ps;
	private ResultSet rs;
	
	public String getNombre() {
		return nombre;
	}
	public String getValor() {
		return valor;
	}
	public String getIcono() {
		return icono;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public void setValor(String valor) {
		this.valor = valor;
	}
	public void setIcono(String icono) {
		this.icono = icono;
	}
	
	public MLenguaje() {
		conexion = new Conexion();
	}
	
	public boolean leer(String campo, int valor) {
		boolean existe = false;
		con = conexion.crearConexion();
		String query = "SELECT * from lenguaje WHERE "+campo+" = ?";
		try {
			ps = con.prepareStatement(query);
			ps.setInt(1,valor);
			rs = ps.executeQuery();
			if(rs.next()){
				this.id = rs.getInt("id");
				this.nombre = rs.getString("nombre");
				this.valor = rs.getString("valor");
				this.icono = rs.getString("icono");
				existe = true;
		    } 
			rs.close();
			ps.close();
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return existe;
	}
	
	public boolean leer(String campo, String valor) {
		boolean existe = false;
		con = conexion.crearConexion();
		String query = "SELECT * from lenguaje WHERE "+campo+" = ?";
		try {
			ps = con.prepareStatement(query);
			ps.setString(1,valor);
			rs = ps.executeQuery();
			if(rs.next()){
				this.id = rs.getInt("id");
				this.nombre = rs.getString("nombre");
				this.valor = rs.getString("valor");
				this.icono = rs.getString("icono");
				existe = true;
		    } 
			rs.close();
			ps.close();
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return existe;
	}
	
	public int contadorTotal() {
		int resultado = 0;
		con = conexion.crearConexion();
		String query = "SELECT id as total from lenguaje";
		try {
			ps = con.prepareStatement(query, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = ps.executeQuery();
			if(rs.last()) {
				resultado = rs.getRow();
			}
			rs.close();
			ps.close();
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return resultado;
	}
	
	public MLenguaje[] listaLenguajes() {	
		int indice = 0;
		int total = contadorTotal();
		MLenguaje lenguaje;
		con = conexion.crearConexion();
		MLenguaje[] resultado = new MLenguaje[total];
				
		String query = "SELECT * FROM lenguaje ORDER BY nombre";
		try {
			ps = con.prepareStatement(query);	
			rs = ps.executeQuery();
			while(rs.next()) {
				lenguaje = new MLenguaje();
				lenguaje.id = rs.getInt("id");
				lenguaje.nombre = rs.getString("nombre");
				lenguaje.valor = rs.getString("valor");
				lenguaje.icono = rs.getString("icono");
				resultado[indice] = lenguaje;
				indice++;
			}
			rs.close();
			ps.close();
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return resultado;
	}

	public boolean insertar(String nombre, String valor, String icono) {
		boolean resultado = false;
		con = conexion.crearConexion();
		this.nombre = nombre;
		this.valor=valor;
		this.icono=icono;


		String query = "INSERT INTO lenguaje (nombre, valor, icono) VALUES (?,?,?)";
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1,nombre);
			ps.setString(2,valor);
			ps.setString(3,icono);

			ps.execute();
			ps.close();
			con.close();
			resultado = true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return resultado;
	}
}
