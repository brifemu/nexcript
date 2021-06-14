package Programador;

import java.io.File;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;

import Usuario.MUsuario;
import Utilidades.Convertidor;

public class MProgramador extends MUsuario {
	String username;
	byte[] curriculum;
	Timestamp fechaCurriculum;
	String lenguaje;
	
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

	
	public String getLenguaje() {
		return lenguaje;
	}


	public void setLenguaje(String lenguaje) {
		this.lenguaje = lenguaje;
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
				lenguaje = rs.getString("lenguaje");
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
				lenguaje = rs.getString("lenguaje");
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
	
	public String leerColumna(String columna, String campo, int valor) {
		String devolucion = "";
		con = conexion.crearConexion();
		String query = "SELECT "+columna+" as result from programador WHERE "+campo+" = ?";
		try {
			ps = con.prepareStatement(query);
			ps.setInt(1,valor);
			rs = ps.executeQuery();
			if(rs.next()){
				devolucion = rs.getString("result");
		    } 
			rs.close();
			ps.close();
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return devolucion;
	}
	
	public String[] leerColumna(String columna1, String columna2, String campo, int valor) {
		String[] devolucion = new String[3];
		con = conexion.crearConexion();
		String query = "SELECT "+columna1+" as result1, "+columna2+" as result2, id  from programador WHERE "+campo+" = ?";
		try {
			ps = con.prepareStatement(query);
			ps.setInt(1,valor);
			rs = ps.executeQuery();
			if(rs.next()){
				devolucion[0] = rs.getString("result1");
				devolucion[1] = rs.getString("result2");
				devolucion[2] = String.valueOf(rs.getInt("id"));
		    } 
			rs.close();
			ps.close();
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return devolucion;
	}
	
	public boolean leerMinimo(int valor) {
		boolean exito = false;
		con = conexion.crearConexion();
		String query = "SELECT username, nombre from programador WHERE id = ?";
		try {
			ps = con.prepareStatement(query);
			ps.setInt(1,valor);
			rs = ps.executeQuery();
			if(rs.next()){
				username = rs.getString("username");
				nombre = rs.getString("nombre");
				exito = true;
		    } 
			rs.close();
			ps.close();
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return exito;
	}
	
	public boolean insertar(String mail, String username, String password, String nombre, String pais, String provincia, String ciudad, byte[] foto, String lenguaje) {
		boolean resultado = false;
		Date today = new Date();
		Timestamp fecha = new Timestamp(today.getTime());
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
		this.foto = foto;
		this.lenguaje = lenguaje;
		String query = "INSERT INTO programador (mail, username, password, registro, ultimaconexion, nombre, pais, provincia, ciudad, foto, lenguaje) VALUES (?,?,?,?,?,?,?,?,?,?,?)";
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
			ps.setBytes(10,foto);
			ps.setString(11,lenguaje);
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
	
	public MProgramador[] realizarBusqueda(String valor,  int pag, int filas) {
		con = conexion.crearConexion();
		int offset;
		int indice = 0;
		MProgramador[] resultado = new MProgramador[filas];
		MProgramador user;
		if(pag == 1) offset = 0;
		else offset = (pag-1)*filas;
		
		String query = "SELECT id, username, foto, nombre FROM programador WHERE UPPER(nombre) LIKE UPPER(?) OR UPPER(username) LIKE UPPER(?) LIMIT "+filas+" OFFSET "+offset;
		try {
			ps = con.prepareStatement(query);	
			ps.setString(1, "%"+valor+"%");
			ps.setString(2, "%"+valor+"%");
			rs = ps.executeQuery();
			while(rs.next()) {
				user = new MProgramador();
				user.id = rs.getInt("id");
				user.username = rs.getString("username");
				user.foto = rs.getBytes("foto");
				user.nombre = rs.getString("nombre");
				resultado[indice] = user;
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
	
	public ArrayList<MProgramador> listar(String columna) {
		con = conexion.crearConexion();
		ArrayList<MProgramador> resultado = new ArrayList<MProgramador>();
		MProgramador user;

		
		String query = "SELECT id, nombre, pais, provincia, ciudad, lenguaje FROM programador WHERE "+columna+" IS NOT NULL";
		try {
			ps = con.prepareStatement(query);	
			rs = ps.executeQuery();
			while(rs.next()) {
				user = new MProgramador();
				user.id = rs.getInt("id");
				user.nombre = rs.getString("nombre");
				user.pais = rs.getString("pais");
				user.provincia = rs.getString("provincia");
				user.ciudad = rs.getString("ciudad");
				user.lenguaje = rs.getString("lenguaje");
				resultado.add(user);
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
	
	public void logConexion(String ip) {
		con = conexion.crearConexion();
		Date today = new Date();
		Timestamp fecha = new Timestamp(today.getTime());
		String query = "INSERT INTO log_login (usuario, fecha, ip, tipo) VALUES (?,?,?,'P')";
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setInt(1,id);
			ps.setTimestamp(2,fecha);
			ps.setString(3,ip);
			ps.execute();
			ps.close();
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}

