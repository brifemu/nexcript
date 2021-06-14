package Codigo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

import DB.Conexion;

public class MAportacion {
	private int id;
	private int usuario;
	private String titulo;
	private String lenguaje;
	private String descripcion;
	private String contenido;
	private Timestamp fecha;
	private String icono;
	private boolean activo;
	private String username;
	
	private Conexion conexion;
	private Connection con;
	private PreparedStatement ps;
	private ResultSet rs;
	
	public MAportacion() {
		conexion = new Conexion();
	}
	
	

	public boolean isActivo() {
		return activo;
	}



	public String getUsername() {
		return username;
	}



	public void setUsername(String username) {
		this.username = username;
	}



	public void setActivo(boolean activo) {
		this.activo = activo;
	}



	public String getIcono() {
		return icono;
	}



	public void setIcono(String icono) {
		this.icono = icono;
	}



	public int getId() {
		return id;
	}



	public int getUsuario() {
		return usuario;
	}



	public String getTitulo() {
		return titulo;
	}



	public String getLenguaje() {
		return lenguaje;
	}



	public String getDescripcion() {
		return descripcion;
	}



	public String getContenido() {
		return contenido;
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



	public void setTitulo(String titulo) {
		this.titulo = titulo;
	}



	public void setLenguaje(String lenguaje) {
		this.lenguaje = lenguaje;
	}



	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}



	public void setContenido(String contenido) {
		this.contenido = contenido;
	}



	public void setFecha(Timestamp fecha) {
		this.fecha = fecha;
	}


	public int contador(int usuario) {
		int resultado = 0;
		con = conexion.crearConexion();
		String query = "SELECT id as total from codigo WHERE usuario = ? AND activo = true";
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
	
	public MAportacion[] realizarBusqueda(int usuario,  int pag, int filas) {
		con = conexion.crearConexion();
		int offset;
		int indice = 0;
		MAportacion[] resultado = new MAportacion[filas];
		MAportacion aportacion;
		
		if(pag == 1) offset = 0;
		else offset = (pag-1)*filas;
		
		String query = "select * from proyecto.listAporteUsuario(?, ?, ?)";
		try {
			ps = con.prepareStatement(query);	
			ps.setInt(1, usuario);
			ps.setInt(2, filas);
			ps.setInt(3, offset);
			rs = ps.executeQuery();
			while(rs.next()) {
				aportacion = new MAportacion();
				aportacion.id = rs.getInt("id");
				aportacion.titulo = rs.getString("titulo");
				aportacion.descripcion = rs.getString("descripcion");
				aportacion.fecha = rs.getTimestamp("fecha");
				aportacion.icono = rs.getString("icono");
				aportacion.username = rs.getString("username");
				resultado[indice] = aportacion;
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
	
	public MAportacion[] realizarBusqueda(int filas) {
		con = conexion.crearConexion();
		int indice = 0;
		MAportacion[] resultado = new MAportacion[filas];
		MAportacion aportacion;
				
		String query = "select * from listAporteSimple("+filas+")";
		try {
			ps = con.prepareStatement(query);	
			rs = ps.executeQuery();
			while(rs.next()) {
				aportacion = new MAportacion();
				aportacion.id = rs.getInt("id");
				aportacion.titulo = rs.getString("titulo");
				aportacion.descripcion = rs.getString("descripcion");
				aportacion.icono = rs.getString("icono");
				aportacion.username = rs.getString("username");
				aportacion.fecha = rs.getTimestamp("fecha");
				resultado[indice] = aportacion;
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
	
	public boolean leer(String campo, int valor) {
		boolean existe = false;
		con = conexion.crearConexion();
		String query = "SELECT * from codigo WHERE "+campo+" = ?";
		try {
			ps = con.prepareStatement(query);
			ps.setInt(1,valor);
			rs = ps.executeQuery();
			if(rs.next()){
				id = rs.getInt("id");
				usuario = rs.getInt("usuario");
				titulo = rs.getString("titulo");
				descripcion = rs.getString("descripcion");
				lenguaje = rs.getString("lenguaje");
				contenido = rs.getString("contenido");
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

	
	public boolean insertar(int usuario, String titulo, String descripcion, String lenguaje, String contenido) {
		boolean resultado = false;
		Timestamp fecha = new Timestamp(System.currentTimeMillis());
		con = conexion.crearConexion();
		this.usuario = usuario;
		this.titulo=titulo;
		this.descripcion=descripcion;
		this.lenguaje=lenguaje;
		this.contenido = contenido;
		this.fecha = fecha;

		String query = "INSERT INTO codigo (usuario, titulo, lenguaje, descripcion, contenido, fecha) VALUES (?,?,?,?,?,?)";
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setInt(1,usuario);
			ps.setString(2,titulo);
			ps.setString(3,lenguaje);
			ps.setString(4,descripcion);
			ps.setString(5,contenido);
			ps.setTimestamp(6, fecha);

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
		String query = "UPDATE codigo SET "+campo+" = ? WHERE id = "+id;
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
	
	public boolean update(String titulo, String lenguaje, String descripcion, String contenido) {
		boolean resultado = false;
		con = conexion.crearConexion();
		this.titulo=titulo;
		this.descripcion=descripcion;
		this.lenguaje=lenguaje;
		this.contenido = contenido;
		String query = "UPDATE codigo SET titulo = ?, lenguaje = ?, descripcion = ?, contenido = ? WHERE id = "+id;
		try {
			ps = con.prepareStatement(query);
			ps.setString(1,titulo);
			ps.setString(2,lenguaje);
			ps.setString(3,descripcion);
			ps.setString(4,contenido);
			ps.executeUpdate();
			ps.close();
			con.close();
			resultado = true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return resultado;
	}
	
	public int getRespuestas() {
		int resp = 0;
		con = conexion.crearConexion();
		String query = "SELECT id from cod_comentario WHERE codigo = "+id;
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
	
	public int[] getIndicesComentarios(int tamanio) {
		int[] res = new int[tamanio];
		int i = 0;
		con = conexion.crearConexion();
		String query = "SELECT id from cod_comentario WHERE codigo = "+id+" ORDER BY id DESC";
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
}


