package Publicacion;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;

import DB.Conexion;

public class MLike {
	private int id;
	private int usuario;
	private Timestamp fecha;
	private boolean activo;
	
	private Conexion conexion;
	private Connection con;
	private PreparedStatement ps;
	private ResultSet rs;
	
	
	public MLike() {
		conexion = new Conexion();
	}
	
	public int getId() {
		return id;
	}
	public int getUsuario() {
		return usuario;
	}
	public Timestamp getFecha() {
		return fecha;
	}
	public boolean isActivo() {
		return activo;
	}
	public void setId(int id) {
		this.id = id;
	}
	public void setUsuario(int usuario) {
		this.usuario = usuario;
	}
	public void setFecha(Timestamp fecha) {
		this.fecha = fecha;
	}
	public void setActivo(boolean activo) {
		this.activo = activo;
	}
	
	public boolean insertar(int usuario, int publicacion) {
		boolean resultado = false;
		Long insertKey = null;
		Timestamp fecha = new Timestamp(System.currentTimeMillis());
		con = conexion.crearConexion();
		this.usuario = usuario;
		this.fecha = fecha;

		String query = "INSERT INTO likes (usuario, fecha) VALUES (?,?)";
		try {
			ps = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
			ps.setInt(1,usuario);
			ps.setTimestamp(2, fecha);

			ps.execute();
			rs = ps.getGeneratedKeys();
			if(rs.next()) {
			    insertKey = rs.getLong(1);
			}
			
			query = "INSERT INTO pub_like (publicacion, likes) VALUES (?,?)";
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
		String query = "SELECT * from likes WHERE "+campo+" = ?";
		try {
			ps = con.prepareStatement(query);
			ps.setInt(1,valor);
			rs = ps.executeQuery();
			if(rs.next()){
				id = rs.getInt("id");
				usuario = rs.getInt("usuario");
				fecha = rs.getTimestamp("fecha");
				activo = rs.getBoolean("activo");
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
	
	public boolean leer(String campo1, String campo2, int valor1, int valor2) {
		boolean existe = false;
		con = conexion.crearConexion();
		String query = "SELECT * from likes WHERE "+campo1+" = ? AND "+campo2+" = ?";
		try {
			ps = con.prepareStatement(query);
			ps.setInt(1,valor1);
			ps.setInt(2,valor2);
			rs = ps.executeQuery();
			if(rs.next()){
				id = rs.getInt("id");
				usuario = rs.getInt("usuario");
				fecha = rs.getTimestamp("fecha");
				activo = rs.getBoolean("activo");
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
	
	public boolean leerRelacion(String campo1, String campo2, int valor1, int valor2) {
		boolean existe = false;
		con = conexion.crearConexion();
		String query = "SELECT * from pub_like WHERE "+campo1+" = ? AND "+campo2+" = ?";
		try {
			ps = con.prepareStatement(query);
			ps.setInt(1,valor1);
			ps.setInt(2,valor2);
			rs = ps.executeQuery();
			if(rs.next()){
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
	
	public ArrayList<Integer> listarRelacion(String campo, int valor) {
		ArrayList<Integer> lista = new ArrayList<Integer>();
		con = conexion.crearConexion();
		String query = "SELECT * from pub_like WHERE "+campo+" = ?";
		try {
			ps = con.prepareStatement(query);
			ps.setInt(1,valor);
			rs = ps.executeQuery();
			while(rs.next()){
				lista.add(rs.getInt("likes"));
		    } 
			rs.close();
			ps.close();
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return lista;
	}
	
	public boolean update(String campo, boolean valor) {
		boolean resultado = false;
		con = conexion.crearConexion();
		String query = "UPDATE likes SET "+campo+" = ? WHERE id = "+id;
		try {
			ps = con.prepareStatement(query);
			ps.setBoolean(1,valor);
			ps.executeUpdate();
			rs.close();
			ps.close();
			con.close();
			resultado = true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return resultado;
	}
	
	public boolean eliminarRelacion(int publicacion) {
		boolean resultado = false;
		con = conexion.crearConexion();
		String query = "DELETE FROM pub_like WHERE publicacion = ? AND likes = ?";
		try {
			ps = con.prepareStatement(query);
			ps.setInt(1,publicacion);
			ps.setInt(2,id);
			ps.executeUpdate();
			rs.close();
			ps.close();
			con.close();
			resultado = true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return resultado;
	}
	
	public boolean insertarRelacion(int publicacion) {
		boolean resultado = false;
		con = conexion.crearConexion();
		String query = "INSERT INTO pub_like (publicacion, likes) VALUES (?,?)";
		try {
			ps = con.prepareStatement(query);
			ps.setInt(1,publicacion);
			ps.setInt(2,id);
			ps.executeUpdate();
			rs.close();
			ps.close();
			con.close();
			resultado = true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return resultado;
	}
}
