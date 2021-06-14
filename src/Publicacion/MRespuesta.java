package Publicacion;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;

import DB.Conexion;

public class MRespuesta {
	private int id;
	private int usuario;
	private String contenido;
	private Timestamp fecha;
	
	private Conexion conexion;
	private Connection con;
	private PreparedStatement ps;
	private ResultSet rs;
	
	public MRespuesta() {
		conexion = new Conexion();
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
	public void setFecha(Timestamp fecha) {
		this.fecha = fecha;
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

	public Timestamp getFecha() {
		return fecha;
	}

	public boolean insertar(int usuario, String contenido, int publicacion) {
		boolean resultado = false;
		Long insertKey = null;
		Timestamp fecha = new Timestamp(System.currentTimeMillis());
		con = conexion.crearConexion();
		this.usuario = usuario;
		this.contenido = contenido;
		this.fecha = fecha;

		String query = "INSERT INTO respuesta (usuario, contenido, fecha) VALUES (?,?,?)";
		try {
			ps = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
			ps.setInt(1,usuario);
			ps.setString(2,contenido);
			ps.setTimestamp(3, fecha);

			ps.execute();
			rs = ps.getGeneratedKeys();
			if(rs.next()) {
			    insertKey = rs.getLong(1);
			}
			
			query = "INSERT INTO pub_resp (publicacion, respuesta) VALUES (?,?)";
			ps = con.prepareStatement(query);
			ps.setInt(1,publicacion);
			ps.setInt(2,insertKey.intValue());
			ps.execute();
			
			ps.close();
			rs.close();
			con.close();
			resultado = true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return resultado;
	}
	
	public boolean leer(String campo, int valor) {
		boolean existe = false;
		con = conexion.crearConexion();
		String query = "SELECT * from respuesta WHERE "+campo+" = ?";
		try {
			ps = con.prepareStatement(query);
			ps.setInt(1,valor);
			rs = ps.executeQuery();
			if(rs.next()){
				id = rs.getInt("id");
				usuario = rs.getInt("usuario");
				contenido = rs.getString("contenido");
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
}
