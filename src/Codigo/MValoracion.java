package Codigo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;

import DB.Conexion;

public class MValoracion {
	private int id;
	private int usuario;
	private int valoracion;
	private Timestamp fecha;
	
	private Conexion conexion;
	private Connection con;
	private PreparedStatement ps;
	private ResultSet rs;
	
	
	public MValoracion() {
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
	public void setId(int id) {
		this.id = id;
	}
	public void setUsuario(int usuario) {
		this.usuario = usuario;
	}
	public void setFecha(Timestamp fecha) {
		this.fecha = fecha;
	}
	
	public int getValoracion() {
		return valoracion;
	}

	public void setValoracion(int valoracion) {
		this.valoracion = valoracion;
	}

	public boolean insertar(int usuario, int codigo, int valoracion) {
		boolean resultado = false;
		Long insertKey = null;
		Timestamp fecha = new Timestamp(System.currentTimeMillis());
		con = conexion.crearConexion();
		this.usuario = usuario;
		this.valoracion = valoracion;
		this.fecha = fecha;

		String query = "INSERT INTO valoracion (usuario, valoracion, fecha) VALUES (?,?,?)";
		try {
			ps = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
			ps.setInt(1,usuario);
			ps.setInt(2,valoracion);
			ps.setTimestamp(3, fecha);

			ps.execute();
			rs = ps.getGeneratedKeys();
			if(rs.next()) {
			    insertKey = rs.getLong(1);
			}
			
			query = "INSERT INTO cod_valoracion (codigo, valoracion) VALUES (?,?)";
			ps = con.prepareStatement(query);
			ps.setInt(1,codigo);
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
		String query = "SELECT * from valoracion WHERE "+campo+" = ?";
		try {
			ps = con.prepareStatement(query);
			ps.setInt(1,valor);
			rs = ps.executeQuery();
			if(rs.next()){
				id = rs.getInt("id");
				usuario = rs.getInt("usuario");
				fecha = rs.getTimestamp("fecha");
				valoracion = rs.getInt("valoracion");
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
		String query = "SELECT * from valoracion WHERE "+campo1+" = ? AND "+campo2+" = ?";
		try {
			ps = con.prepareStatement(query);
			ps.setInt(1,valor1);
			ps.setInt(2,valor2);
			rs = ps.executeQuery();
			if(rs.next()){
				id = rs.getInt("id");
				usuario = rs.getInt("usuario");
				fecha = rs.getTimestamp("fecha");
				valoracion = rs.getInt("valoracion");
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
		String query = "SELECT * from cod_valoracion WHERE "+campo1+" = ? AND "+campo2+" = ?";
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
		String query = "SELECT * from cod_valoracion WHERE "+campo+" = ?";
		try {
			ps = con.prepareStatement(query);
			ps.setInt(1,valor);
			rs = ps.executeQuery();
			while(rs.next()){
				lista.add(rs.getInt("valoracion"));
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
	
	public boolean update(String campo, int valor) {
		boolean resultado = false;
		con = conexion.crearConexion();
		String query = "UPDATE valoracion SET "+campo+" = ? WHERE id = "+id;
		try {
			ps = con.prepareStatement(query);
			ps.setInt(1,valor);
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
	
	public boolean eliminarRelacion(int aporte) {
		boolean resultado = false;
		con = conexion.crearConexion();
		String query = "DELETE FROM cod_valoracion WHERE codigo = ? AND valoracion = ?";
		try {
			ps = con.prepareStatement(query);
			ps.setInt(1,aporte);
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
	
	public boolean insertarRelacion(int aporte) {
		boolean resultado = false;
		con = conexion.crearConexion();
		String query = "INSERT INTO cod_valoracion (codigo, valoracion) VALUES (?,?)";
		try {
			ps = con.prepareStatement(query);
			ps.setInt(1,aporte);
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
