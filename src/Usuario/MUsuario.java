package Usuario;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;

import DB.Conexion;

public class MUsuario {
	protected int id;
	protected String mail;
	protected String password;
	protected Timestamp fechaRegistro;
	protected Timestamp ultimaConexion;
	protected String nombre;
	protected byte[] foto;
	protected File imgFile;
	protected String pais;
	protected String provincia;
	protected String ciudad;
	protected boolean confirmado;
	protected Timestamp fechaConfirmacion;
	
	protected Conexion conexion;
	protected Connection con;
	protected PreparedStatement ps;
	protected ResultSet rs;
	
	public MUsuario() {
		conexion = new Conexion();
	}
	public int getId() {
		return id;
	}
	public String getMail() {
		return mail;
	}
	public String getPassword() {
		return password;
	}
	public Timestamp getFechaRegistro() {
		return fechaRegistro;
	}
	public Timestamp getUltimaConexion() {
		return ultimaConexion;
	}
	public String getNombre() {
		return nombre;
	}
	public byte[] getFoto() {
		return foto;
	}
	public String getPais() {
		return pais;
	}
	public String getProvincia() {
		return provincia;
	}
	public String getCiudad() {
		return ciudad;
	}
	public void setId(int id) {
		this.id = id;
	}
	public void setMail(String mail) {
		this.mail = mail;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public void setFechaRegistro(Timestamp fechaRegistro) {
		this.fechaRegistro = fechaRegistro;
	}
	public void setUltimaConexion(Timestamp ultimaConexion) {
		this.ultimaConexion = ultimaConexion;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public void setFoto(byte[] foto) {
		this.foto = foto;
	}
	public void setPais(String pais) {
		this.pais = pais;
	}
	public void setProvincia(String provincia) {
		this.provincia = provincia;
	}
	public void setCiudad(String ciudad) {
		this.ciudad = ciudad;
	}
	
	public File getImgFile() {
		return imgFile;
	}
	public void setImgFile(File imgFile) {
		this.imgFile = imgFile;
	}
	public boolean getConfirmado() {
		return confirmado;
	}
	public Timestamp getFechaConfirmacion() {
		return fechaConfirmacion;
	}
	
	public void setConfirmado(boolean confirmado) {
		this.confirmado = confirmado;
	}
	public void setFechaConfirmacion(Timestamp fechaConfirmacion) {
		this.fechaConfirmacion = fechaConfirmacion;
	}
	
	
}
