package notificacion

import java.time.LocalDate
import objetos_de_dominio.Usuario
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test
import utilitarios.Notificacion

import static org.junit.jupiter.api.Assertions.*

@DisplayName("Dada una notificacion: ")
class TestNotificaciones {
	Notificacion notificacion
	Notificacion notificacionVieja
	Usuario usuario

	@BeforeEach
	def void init() {

		usuario = new Usuario()

		notificacion = new Notificacion() => [
			asunto = "Notificacion de prueba"
			texto = "Estamos testeando las notificaciones"
		]

		notificacionVieja = new Notificacion() => [
			asunto = "Notificacion de prueba"
			texto = "Estamos testeando las notificaciones"
		]

		notificacionVieja.fechaDeRecepcion = LocalDate.now.minusDays(31)

	}

	@DisplayName("Puede cambiar su estado")
	@Test
	def void cambiaEstadoNotificacion() {
		notificacion.cambiarEstadoNotificacion()
		assertTrue(notificacion.leida)
	}

	@DisplayName("Si se envia a un usuario => esta aparece en su inbox")
	@Test
	def void seEnviaLaNotificacion() {
		notificacion.enviarNotificacion(usuario, "fijate si te llego gil") // Te voy a acusar!
		assertTrue(usuario.notificaciones.contains(notificacion))
	}

	@DisplayName("Si tiene mas de 30 dias =>  esta para eliminar")
	@Test
	def void pasadoLos30DiasSeConsideraParaEliminar() {
		assertTrue(notificacionVieja.diasDeLaNotificacion())

	}
}
