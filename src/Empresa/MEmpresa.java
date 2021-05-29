package Empresa;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;

import Usuario.MUsuario;

public class MEmpresa extends MUsuario{
	public MEmpresa() {
		super();
	}
	
	public boolean leer(String campo, String valor) {
		boolean existe = false;
		con = conexion.crearConexion();
		String query = "SELECT * from empresa WHERE "+campo+" = ?";
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

	public boolean insertar(String mail, String password, String nombre, /*byte[] foto,*/ String pais, String provincia, String ciudad) {
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
		String query = "INSERT INTO empresa (mail, password, registro, ultimaconexion, nombre, pais, provincia, ciudad) VALUES (?,?,?,?,?,?,?,?)";
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

			/*ps.setBytes(6, foto);
			ps.setString(7,pais);
			ps.setString(8,provincia);
			ps.setString(9,ciudad);*/
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
