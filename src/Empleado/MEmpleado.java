package Empleado;

import java.io.File;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;

import Usuario.MUsuario;
import Utilidades.Convertidor;

public class MEmpleado extends MUsuario{
	public MEmpleado() {
		super();
	}
	
	public boolean leer(String campo, String valor) {
		boolean existe = false;
		con = conexion.crearConexion();
		String query = "SELECT * from empleado WHERE "+campo+" = ?";
		try {
			ps = con.prepareStatement(query);
			ps.setString(1,valor);
			rs = ps.executeQuery();
			if(rs.next()){
				id = rs.getInt("id");
				mail = rs.getString("mail");
				password = rs.getString("password");
				fechaRegistro = rs.getTimestamp("registro");
				ultimaConexion = rs.getTimestamp("ultimaconexion");
				nombre = rs.getString("nombre");
				foto = rs.getBytes("foto");
				pais = rs.getString("pais");
				provincia = rs.getString("provincia");
				ciudad = rs.getString("ciudad");
				confirmado = rs.getBoolean("confirmado");
				fechaConfirmacion = rs.getTimestamp("fechaconfirmacion");
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
	
	public boolean leer(String campo, int valor) {
		boolean existe = false;
		con = conexion.crearConexion();
		String query = "SELECT * from empleado WHERE "+campo+" = ?";
		try {
			ps = con.prepareStatement(query);
			ps.setInt(1,valor);
			rs = ps.executeQuery();
			if(rs.next()){
				id = rs.getInt("id");
				mail = rs.getString("mail");
				password = rs.getString("password");
				fechaRegistro = rs.getTimestamp("registro");
				ultimaConexion = rs.getTimestamp("ultimaconexion");
				nombre = rs.getString("nombre");
				foto = rs.getBytes("foto");
				pais = rs.getString("pais");
				provincia = rs.getString("provincia");
				ciudad = rs.getString("ciudad");
				confirmado = rs.getBoolean("confirmado");
				fechaConfirmacion = rs.getTimestamp("fechaconfirmacion");
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

	public boolean insertar(String mail, String password, String nombre, /*byte[] foto,*/ String pais, String provincia, String ciudad, byte[] foto) {
		boolean resultado = false;
		Timestamp fecha = new Timestamp(System.currentTimeMillis());
		con = conexion.crearConexion();
		this.mail = mail;
		this.password = password;
		//this.foto = foto;
		this.fechaRegistro = fecha;
		this.ultimaConexion = fecha;
		this.nombre = nombre;
		this.pais = pais;
		this.provincia = provincia;
		this.ciudad = ciudad;
		this.foto = foto;
		String query = "INSERT INTO empleado (mail, password, registro, ultimaconexion, nombre, pais, provincia, ciudad, foto) VALUES (?,?,?,?,?,?,?,?,?)";
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1,mail);
			ps.setString(2,password);
			ps.setTimestamp(3, fecha);
			ps.setTimestamp(4, fecha);
			ps.setString(5,nombre);
			ps.setString(6,pais);
			ps.setString(7,provincia);
			ps.setString(8,ciudad);
			ps.setBytes(9,foto);
			ps.execute();
			ps.close();
			con.close();
			resultado = true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return resultado;
	}
	
	public boolean update(String campo, String valor) {
		boolean resultado = false;
		con = conexion.crearConexion();
		String query = "UPDATE empleado SET "+campo+" = ? WHERE id = "+id;
		try {
			ps = con.prepareStatement(query);
			ps.setString(1,valor);
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
	
	public boolean update(String campo, boolean valor) {
		boolean resultado = false;
		con = conexion.crearConexion();
		String query = "UPDATE empleado SET "+campo+" = ? WHERE id = "+id;
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
		String query = "UPDATE empleado SET "+campo+" = ? WHERE id = "+id;
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
	
	public boolean update(String campo, File file) {
		Convertidor cc = new Convertidor();
		boolean resultado = false;
		byte[] convertido = cc.convertFileToByteArray(file);
		con = conexion.crearConexion();
		String query = "UPDATE empleado SET "+campo+" = ? WHERE id = "+id;
		try {
			ps = con.prepareStatement(query);
			ps.setBytes(1,convertido);
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
