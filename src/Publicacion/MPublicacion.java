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
	private boolean activo;
	
	private String puUsername;
	private String puNombre;
	
	
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

	

	public String getPuUsername() {
		return puUsername;
	}

	public String getPuNombre() {
		return puNombre;
	}

	public void setPuUsername(String puUsername) {
		this.puUsername = puUsername;
	}

	public void setPuNombre(String puNombre) {
		this.puNombre = puNombre;
	}

	public boolean isActivo() {
		return activo;
	}

	public void setActivo(boolean activo) {
		this.activo = activo;
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
	
	public int getRespuestas() {
		int resp = 0;
		con = conexion.crearConexion();
		String query = "SELECT id from pub_resp WHERE publicacion = "+id;
		try {
			ps = con.prepareStatement(query, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = ps.executeQuery();
			if(rs.last()){
				resp = rs.getRow();
		    } 
			rs.close();
			ps.close();
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return resp;
	}
	
	public int[] getIndicesRespuestas(int tamanio) {
		int[] res = new int[tamanio];
		int i = 0;
		con = conexion.crearConexion();
		String query = "SELECT id from pub_resp WHERE publicacion = "+id+" ORDER BY id DESC";
		try {
			ps = con.prepareStatement(query);
			rs = ps.executeQuery();
			while(rs.next()){		
				res[i] = rs.getInt("id");
				i++;
		    } 
			rs.close();
			ps.close();
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return res;
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
	
	public boolean update(String campo, boolean valor) {
		boolean resultado = false;
		con = conexion.crearConexion();
		String query = "UPDATE publicacion SET "+campo+" = ? WHERE id = "+id;
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
	
	public int contador(int usuario) {
		int resultado = 0;
		con = conexion.crearConexion();
		String query = "SELECT id as total from publicacion WHERE usuario = ? AND activo = true";
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
	
	public boolean likeado(int usuario) {
		boolean result = false;
		con = conexion.crearConexion();
		String query = "SELECT * FROM isliked(?,?)";
		try {
			ps = con.prepareStatement(query);	
			ps.setInt(1, id);
			ps.setInt(2, usuario);
			rs = ps.executeQuery();
			
			if(rs.next()) result = true;
	
			rs.close();
			ps.close();
			con.close();
		}catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public MPublicacion[] realizarBusqueda(int usuario,  int pag, int filas) {
		con = conexion.crearConexion();
		int offset;
		int indice;
		MPublicacion[] resultado = new MPublicacion[filas];
		MPublicacion publi;
		
		indice = 0;
		if(pag == 1) offset = 0;
		else offset = (pag-1)*filas;
		
		String query = "SELECT * FROM publicacionData(?,?,?)";
		try {
			ps = con.prepareStatement(query);	
			ps.setInt(1, usuario);
			ps.setInt(2, filas);
			ps.setInt(3, offset);
			rs = ps.executeQuery();
			while(rs.next()) {
				publi = new MPublicacion();
				publi.id = rs.getInt("id");
				publi.usuario = rs.getInt("usuario");
				publi.contenido = rs.getString("contenido");
				publi.imagen = rs.getBytes("imagen");
				publi.fecha = rs.getTimestamp("fecha");
				publi.puNombre = rs.getString("puNombre");
				publi.puUsername = rs.getString("puUsername");
				resultado[indice] = publi;
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


