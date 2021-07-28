package utilitarios

import java.time.LocalDate
import java.time.temporal.ChronoUnit
import objetos_de_dominio.Usuario
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Notificacion {
	LocalDate fechaDeRecepcion
	String asunto
	String texto
	boolean leida = false

	new() {
		this.fechaDeRecepcion = LocalDate.now
	}

	
	def cambiarEstadoNotificacion(){
		leida = !leida
	}

	def enviarNotificacion(Usuario usuario, String mensaje) {
		asunto = "nueva Sugerencia"
		texto = mensaje
		usuario.notificaciones.add(this)
	}


	def diasDeLaNotificacion() {
		return ChronoUnit.DAYS.between(fechaDeRecepcion, LocalDate.now)>30
	}
}
