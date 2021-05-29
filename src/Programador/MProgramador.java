package Programador;

import java.io.File;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.Date;

import Usuario.MUsuario;
import Utilidades.Convertidor;

public class MProgramador extends MUsuario {
	String username;
	byte[] curriculum;
	Timestamp fechaCurriculum;
	
	public MProgramador() {
		super();
	}
	
	
	public String getUsername() {
		return username;
	}


	public byte[] getCurriculum() {
		return curriculum;
	}


	public Timestamp getFechaCurriculum() {
		return fechaCurriculum;
	}


	public void setUsername(String username) {
		this.username = username;
	}


	public void setCurriculum(byte[] curriculum) {
		this.curriculum = curriculum;
	}


	public void setFechaCurriculum(Timestamp fechaCurriculum) {
		this.fechaCurriculum = fechaCurriculum;
	}


	public boolean leer(String campo, String valor) {
		boolean existe = false;
		con = conexion.crearConexion();
		String query = "SELECT * from programador WHERE "+campo+" = ?";
		try {
			ps = con.prepareStatement(query);
			ps.setString(1,valor);
			rs = ps.executeQuery();
			if(rs.next()){
				id = rs.getInt("id");
				mail = rs.getString("mail");
				username = rs.getString("username");
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
				curriculum = rs.getBytes("curriculum");
				fechaCurriculum = rs.getTimestamp("fechaCurriculum");
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
		String query = "SELECT * from programador WHERE "+campo+" = ?";
		try {
			ps = con.prepareStatement(query);
			ps.setInt(1,valor);
			rs = ps.executeQuery();
			if(rs.next()){
				id = rs.getInt("id");
				mail = rs.getString("mail");
				username = rs.getString("username");
				password = rs.getString("password");
				fechaRegistro = rs.getTimestamp("registro");
				ultimaConexion = rs.getTimestamp("ultimaconexion");
				nombre = rs.getString("nombre");
				foto = rs.getBytes("foto");
				pais = rs.getString("pais");
				provincia = rs.getString("provincia");
				ciudad = rs.getString("ciudad");
				/*curriculum = rs.getBytes("curriculum");
				fechaCurriculum = rs.getDate("fechaCurriculum");*/
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
	
	public boolean insertar(String mail, String username, String password, String nombre, String pais, String provincia, String ciudad) {
		boolean resultado = false;
		Timestamp fecha = new Timestamp(System.currentTimeMillis());
		//Date fecha = new Date();
		//fFecha = "Y-MM/dd-hh-mm-ss"; 

		con = conexion.crearConexion();
		this.mail = mail;
		this.password = password;
		this.fechaRegistro = fecha;
		this.ultimaConexion = fecha;
		this.username = username;
		this.nombre = nombre;
		this.pais = pais;
		this.provincia = provincia;
		this.ciudad = ciudad;
		String query = "INSERT INTO programador (mail, username, password, registro, ultimaconexion, nombre, pais, provincia, ciudad) VALUES (?,?,?,?,?,?,?,?,?)";
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1,mail);
			ps.setString(2,username);
			ps.setString(3,password);
			ps.setTimestamp(4, fecha);
			ps.setTimestamp(5, fecha);
			ps.setString(6,nombre);
			ps.setString(7,pais);
			ps.setString(8,provincia);
			ps.setString(9,ciudad);

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
		String query = "UPDATE programador SET "+campo+" = ? WHERE id = "+id;
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
	
	public boolean setNull(String campo) {
		boolean resultado = false;
		con = conexion.crearConexion();
		String query = "UPDATE programador SET "+campo+" = null WHERE id = "+id;
		try {
			ps = con.prepareStatement(query);
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
		String query = "UPDATE programador SET "+campo+" = ? WHERE id = "+id;
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
		String query = "UPDATE programador SET "+campo+" = ? WHERE id = "+id;
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
		String query = "UPDATE programador SET "+campo+" = ? WHERE id = "+id;
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
	
	public int[] realizarBusqueda(String valor,  int pag, int filas) {
		con = conexion.crearConexion();
		int offset;
		int indice = 0;
		int[] resultado = new int[filas];
		
		if(pag == 1) offset = 0;
		else offset = (pag-1)*filas;
		
		String query = "SELECT id FROM programador WHERE UPPER(nombre) LIKE UPPER(?) OR UPPER(username) LIKE UPPER(?) LIMIT "+filas+" OFFSET "+offset;
		try {
			ps = con.prepareStatement(query);	
			ps.setString(1, "%"+valor+"%");
			ps.setString(2, "%"+valor+"%");
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
	
	public int totalResultados(String valor) {
		con = conexion.crearConexion();
		int resultado = 0;

		String query = "SELECT COUNT(id) as total FROM programador WHERE UPPER(nombre) LIKE UPPER(?) OR UPPER(username) LIKE UPPER(?)";
		try {
			ps = con.prepareStatement(query);	
			ps.setString(1, "%"+valor+"%");
			ps.setString(2, "%"+valor+"%");
			rs = ps.executeQuery();
			if(rs.next()) {
				resultado = rs.getInt("total");
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

