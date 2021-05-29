package Publicacion;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

import DB.Conexion;

public class MPublicacion {
	private int id;
	private int usuario;
	private String contenido;
	private byte[] imagen;
	private Timestamp fecha;
	private int likes;
	
	private Conexion conexion;
	private Connection con;
	private PreparedStatement ps;
	private ResultSet rs;
	
	public MPublicacion() {
		conexion = new Conexion();
	}
	
	public int getId() {
		return id;
	}



	public int getUsuario() {
		return usuario;
	}



	public String getContenido() {
		return contenido;
	}



	public byte[] getImagen() {
		return imagen;
	}



	public Timestamp getFecha() {
		return fecha;
	}



	public void setId(int id) {
		this.id = id;
	}



	public void setUsuario(int usuario) {
		this.usuario = usuario;
	}



	public void setContenido(String contenido) {
		this.contenido = contenido;
	}



	public void setImagen(byte[] imagen) {
		this.imagen = imagen;
	}



	public void setFecha(Timestamp fecha) {
		this.fecha = fecha;
	}
	
	public int getLikes() {
		likes = 0;
		con = conexion.crearConexion();
		String query = "SELECT id from pub_like WHERE publicacion = "+id;
		try {
			ps = con.prepareStatement(query, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = ps.executeQuery();
			if(rs.last()){
				likes = rs.getRow();
		    } 
			rs.close();
			ps.close();
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return likes;
	}

	public boolean leer(String campo, int valor) {
		boolean existe = false;
		con = conexion.crearConexion();
		String query = "SELECT * from publicacion WHERE "+campo+" = ?";
		try {
			ps = con.prepareStatement(query);
			ps.setInt(1,valor);
			rs = ps.executeQuery();
			if(rs.next()){
				id = rs.getInt("id");
				usuario = rs.getInt("usuario");
				contenido = rs.getString("contenido");
				imagen = rs.getBytes("imagen");
				fecha = rs.getTimestamp("fecha");
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

	public boolean insertar(int usuario, String contenido, byte[] foto) {
		boolean resultado = false;
		Timestamp fecha = new Timestamp(System.currentTimeMillis());
		con = conexion.crearConexion();
		this.usuario = usuario;
		this.contenido = contenido;
		this.imagen = foto;
		this.fecha = fecha;

		String query = "INSERT INTO publicacion (usuario, contenido, imagen, fecha) VALUES (?,?,?,?)";
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setInt(1,usuario);
			ps.setString(2,contenido);
			ps.setBytes(3,foto);
			ps.setTimestamp(4, fecha);

			ps.execute();
			ps.close();
			con.close();
			resultado = true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return resultado;
	}
	
	public boolean insertar(int usuario, String contenido) {
		boolean resultado = false;
		Timestamp fecha = new Timestamp(System.currentTimeMillis());
		con = conexion.crearConexion();
		this.usuario = usuario;
		this.contenido = contenido;
		this.fecha = fecha;

		String query = "INSERT INTO publicacion (usuario, contenido, fecha) VALUES (?,?,?)";
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setInt(1,usuario);
			ps.setString(2,contenido);
			ps.setTimestamp(3, fecha);

			ps.execute();
			ps.close();
			con.close();
			resultado = true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return resultado;
	}
	
	public int contador(int usuario) {
		int resultado = 0;
		con = conexion.crearConexion();
		String query = "SELECT id as total from publicacion WHERE usuario = ?";
		try {
			ps = con.prepareStatement(query, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			ps.setInt(1,usuario);
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
	
	public int[] realizarBusqueda(int usuario,  int pag, int filas) {
		con = conexion.crearConexion();
		int offset;
		int indice = 0;
		int[] resultado = new int[filas];
		
		if(pag == 1) offset = 0;
		else offset = (pag-1)*filas;
		
		String query = "SELECT id FROM publicacion WHERE usuario = ? ORDER BY id DESC LIMIT "+filas+" OFFSET "+offset;
		try {
			ps = con.prepareStatement(query);	
			ps.setInt(1, usuario);
			rs = ps.executeQuery();
			while(rs.next()) {
				resultado[indice] = rs.getInt("id");
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
}


