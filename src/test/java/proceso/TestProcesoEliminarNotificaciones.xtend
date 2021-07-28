package proceso

import java.time.LocalDate
import objetos_de_dominio.Usuario
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.DisplayName
import service.Mail
import service.MailSender
import utilitarios.Notificacion
import utilitarios.ProcesoEliminarNotificaciones
import utilitarios.Repositorio
import static org.mockito.Mockito.*
import org.junit.jupiter.api.Test
import static org.junit.jupiter.api.Assertions.*

@DisplayName("Dada varias listas de notificaciones")
class TestProcesoEliminarNotificaciones {
	Usuario usuario1
	Usuario usuario2

	Notificacion notificacion1
	Notificacion notificacionVieja1
	Notificacion notificacionVieja2
	Notificacion notificacionVieja3

	Repositorio<Usuario> repoU
	ProcesoEliminarNotificaciones proceso
	MailSender stubMailSender
	Mail mail

	@BeforeEach
	def void init() {
		stubMailSender = mock(MailSender)
		usuario1 = new Usuario()
		usuario2 = new Usuario()

		notificacion1 = new Notificacion() => [
			asunto = "Notificacion de prueba"
			texto = "Estamos testeando las notificaciones"
		]

		notificacionVieja1 = new Notificacion() => [
			asunto = "Notificacion de prueba"
			texto = "Estamos testeando las notificaciones"
		]
		notificacionVieja2 = new Notificacion() => [
			asunto = "Notificacion de prueba"
			texto = "Estamos testeando las notificaciones"
		]

		notificacionVieja3 = new Notificacion() => [
			asunto = "Notificacion de prueba"
			texto = "Estamos testeando las notificaciones"
		]

		notificacionVieja1.fechaDeRecepcion = LocalDate.now.minusDays(31)
		notificacionVieja2.fechaDeRecepcion = LocalDate.now.minusDays(32)
		notificacionVieja3.fechaDeRecepcion = LocalDate.now.minusDays(33)

		notificacion1.enviarNotificacion(usuario1, "Prueba notificación")
		notificacionVieja1.enviarNotificacion(usuario1, "Prueba notificación")
		notificacionVieja2.enviarNotificacion(usuario2, "Prueba notificación")
		notificacionVieja3.enviarNotificacion(usuario2, "Prueba notificación")

		usuario1.leerNotificacion(notificacion1)
		usuario1.leerNotificacion(notificacionVieja1)
		usuario2.leerNotificacion(notificacionVieja2)

		repoU = new Repositorio<Usuario>
		repoU.create(usuario1)
		repoU.create(usuario2)
		proceso = new ProcesoEliminarNotificaciones(repoU, stubMailSender)
		proceso.ejecutarTodo()

	}

	@DisplayName("se elimina 1 notificacion del usuario 1")
	@Test
	def void seEliminanNotificacionesUsuario1() {
		assertEquals(1, usuario1.notificaciones.size())
	}

	@DisplayName("la notificacion vieja 1 no esta en el inbox del usuario1")
	@Test
	def void notificacionVieja1NoEsta() {
		assertFalse(usuario1.notificaciones.contains(notificacionVieja1))
	}

	@DisplayName("se elimina 1 notificacion del usuario 2")
	@Test
	def void seEliminaNotificacionUsuario2() {
		assertEquals(1, usuario2.notificaciones.size())
	}

	@DisplayName("la notificacion vieja 3 esta en el inbox porque no fue leida")
	@Test
	def void notificacionVieja3EstaEnElInbox() {
		assertFalse(usuario1.notificaciones.contains(notificacionVieja1))
	}

	@DisplayName("envia un mail al ejecutar el proceso")
	@Test
	def void enviarMail() {
		mail = new Mail(proceso.correoAdmin, proceso.nombreProceso, proceso.mensaje)
		verify(stubMailSender, times(1)).mandarMail(mail)
	}

}
