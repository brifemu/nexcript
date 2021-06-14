package Bloqueo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;

import DB.Conexion;

public class MBloqueo {
	int id;
	int emisor;
	int bloqueado;
	Timestamp fecha;
	boolean activo;
	
	protected Conexion conexion;
	protected Connection con;
	protected PreparedStatement ps;
	protected ResultSet rs;
	
	public MBloqueo() {
		conexion = new Conexion();
	}
	
	public int getId() {
		return id;
	}
	public int getEmisor() {
		return emisor;
	}
	public int getBloqueado() {
		return bloqueado;
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
	public void setEmisor(int emisor) {
		this.emisor = emisor;
	}
	public void setBloqueado(int bloqueado) {
		this.bloqueado = bloqueado;
	}
	public void setFecha(Timestamp fecha) {
		this.fecha = fecha;
	}
	public void setActivo(boolean activo) {
		this.activo = activo;
	}
	
	public boolean leer(String campo, int valor) {
		boolean existe = false;
		con = conexion.crearConexion();
		String query = "SELECT * from bloqueo WHERE "+campo+" = ?";
		try {
			ps = con.prepareStatement(query);
			ps.setInt(1,valor);
			rs = ps.executeQuery();
			if(rs.next()){
				id = rs.getInt("id");
				emisor = rs.getInt("emisor");
				bloqueado = rs.getInt("bloqueado");
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
	
	public boolean leer(int emisor, int bloqueado) {
		boolean existe = false;
		con = conexion.crearConexion();
		String query = "SELECT * from bloqueo WHERE emisor = ? AND bloqueado = ?";
		try {
			ps = con.prepareStatement(query);
			ps.setInt(1,emisor);
			ps.setInt(2,bloqueado);
			rs = ps.executeQuery();
			if(rs.next()){
				this.id = rs.getInt("id");
				this.emisor = rs.getInt("emisor");
				this.bloqueado = rs.getInt("bloqueado");
				this.fecha = rs.getTimestamp("fecha");
				this.activo = rs.getBoolean("activo");
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
	
	public boolean insertar(int emisor, int bloqueado) {
		boolean resultado = false;
		Date today = new Date();
		Timestamp fecha = new Timestamp(today.getTime());
		con = conexion.crearConexion();
		this.emisor = emisor;
		this.bloqueado = bloqueado;
		this.fecha = fecha;

		String query = "INSERT INTO bloqueo (emisor, bloqueado, fecha) VALUES (?,?,?)";
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setInt(1,emisor);
			ps.setInt(2,bloqueado);
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
	
	public boolean update(String campo, boolean valor) {
		boolean resultado = false;
		con = conexion.crearConexion();
		String query = "UPDATE bloqueo SET "+campo+" = ? WHERE id = "+id;
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
	
	public boolean update(String campo, Timestamp valor) {
		boolean resultado = false;
		con = conexion.crearConexion();
		String query = "UPDATE bloqueo SET "+campo+" = ? WHERE id = "+id;
		try {
			ps = con.prepareStatement(query);
			ps.setTimestamp(1,valor);
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
