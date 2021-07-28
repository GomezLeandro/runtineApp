package utilitarios

import objetos_de_dominio.Rutina
import objetos_de_dominio.Usuario
import org.eclipse.xtend.lib.annotations.Accessors
import service.ActualizadorDeActividades
import service.Mail
import service.MailSender

@Accessors
abstract class Proceso {
	MailSender mailSender
	String correoAdmin = "admin@runtimeapp.com.ar"
	String asunto

	new(MailSender mailSender) {
		this.mailSender = mailSender
	}

	// Ver si hay un nombre mejor
	def void ejecutarTodo() {
		this.ejecutarProceso()
		val mail = new Mail(correoAdmin, this.nombreProceso, this.mensaje)
		mailSender.mandarMail(mail)
	}

	def void ejecutarProceso()

	def String nombreProceso()

	def String mensaje() {
		"Se realizó el proceso: " + this.nombreProceso
	}

}

@Accessors
class ProcesoActualizarActividades extends Proceso {

	ActualizadorDeActividades actualizador

	new(MailSender mailSender, ActualizadorDeActividades actualizador) {
		super(mailSender)
		this.actualizador = actualizador
	}

	override ejecutarProceso() {
		actualizador.actualizarActividades()
	}

	override nombreProceso() {
		"Actualizar actividades"
	}

}

class ProcesoEliminarRutinasNoAptasParaElUsuario extends Proceso {
	Repositorio<Rutina> repoRutinas
	Repositorio<Usuario> repoUsuarios

	new(Repositorio<Usuario> repoUsuarios, Repositorio<Rutina> repoRutinas, MailSender mailSender) {
		super(mailSender)
		this.repoUsuarios = repoUsuarios
		this.repoRutinas = repoRutinas
	}

	override ejecutarProceso() {
		listaRutinasAEliminar.forEach[repoRutinas.delete(it)]
	}

	def listaRutinasAEliminar() {
		repoRutinas.elementos.filter[rutina|this.ningunUsuarioPuedeRealizarRutina(rutina)].toList
	}

	def ningunUsuarioPuedeRealizarRutina(Rutina rutina) {
		repoUsuarios.elementos.forall[usuario|!usuario.puedeRealizarRutina(rutina)]
	}

	override nombreProceso() {
		"Eliminar rutinas no aptas para los usuarios"
	}
}

class ProcesoEliminarUsuariosInactivos extends Proceso {
	Repositorio<Usuario> repoUsuarios
	Repositorio<Rutina> repoRutinas

	new(Repositorio<Usuario> repoUsuarios, Repositorio<Rutina> repoRutinas, MailSender mailSender) {
		super(mailSender)
		this.repoUsuarios = repoUsuarios
		this.repoRutinas = repoRutinas
	}

	override ejecutarProceso() {
		listaUsuariosAEliminar.forEach[repoUsuarios.delete(it)]
	}

	def listaUsuariosAEliminar() {
		repoUsuarios.elementos.filter[usuario|condicionesParaEliminarUsuario(usuario)].toList
	}

	def condicionesParaEliminarUsuario(Usuario usuario) {
		this.usuarioNoTieneRutinasCreadas(usuario) || noTieneActividadSocial(usuario)
	}

	def noTieneActividadSocial(Usuario usuario) {
		usuario.noTieneAmigos && usuarioNoSigueRutinas(usuario)
	}

	

	def usuarioNoTieneRutinasCreadas(Usuario usuario) {
		repoRutinas.elementos.forall[rutina|rutina.esCreador(usuario)]
	
	}

	def filtrarRutinaQueSigueElUsuario(Usuario usuario) {
		repoRutinas.elementos.filter[rutina|rutina.esSeguidaPor(usuario)].toList
	}

	def usuarioNoSigueRutinas(Usuario usuario) {
		filtrarRutinaQueSigueElUsuario(usuario).empty
	}

	override nombreProceso() {
		"Eliminar usuarios inactivos"
	}
}

class ProcesoEliminarNotificaciones extends Proceso {
	Repositorio<Usuario> repoUsuarios

	new(Repositorio<Usuario> repoUsuarios, MailSender mailSender) {
		super(mailSender)
		this.repoUsuarios = repoUsuarios
	}

	override ejecutarProceso() {
		repoUsuarios.elementos.forEach[usuario|usuario.eliminarNotificaciones(listaNotificacionesAEliminar(usuario))]
	}
	

	def listaNotificacionesAEliminar(Usuario usuario) {
		usuario.notificaciones.filter[notificacion|sePuedeEliminarSi(notificacion)].toList
	}

	def sePuedeEliminarSi(Notificacion notificacion) {
		notificacion.diasDeLaNotificacion && notificacion.leida
	}

	override nombreProceso() {
		"Eliminar notificaciones"
	}

}
