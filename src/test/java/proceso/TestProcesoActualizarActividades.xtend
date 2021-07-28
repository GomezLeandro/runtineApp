package proceso

import objetos_de_dominio.Actividad
import objetos_de_dominio.GrupoMuscular
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test
import service.ActualizadorDeActividades
import service.Mail
import service.MailSender
import utilitarios.ProcesoActualizarActividades
import utilitarios.Repositorio
import static org.junit.jupiter.api.Assertions.*
import static org.mockito.Mockito.*

@DisplayName("Cuando ejecuto el proceso")
class TestProcesoActualizarActividades {
	ActualizadorDeActividades actualizadorActividades
	Actividad actividad
	Repositorio<Actividad> repo = new Repositorio<Actividad>
	stub.StubService service
	MailSender stubMailSender
	Mail mail
	ProcesoActualizarActividades proceso

	@BeforeEach
	def void init() {

		stubMailSender = mock(MailSender)

		service= new stub.StubService

		actividad = new Actividad => [
			nombre = "Correr"
			grupos.add(GrupoMuscular.ABDOMEN)
		]

		repo.create(actividad)
		actualizadorActividades = new ActualizadorDeActividades(service) => [
			repositorio = repo
		]

		proceso = new ProcesoActualizarActividades(stubMailSender, actualizadorActividades)
		mail = new Mail(proceso.correoAdmin, proceso.nombreProceso, proceso.mensaje)
	}

	@DisplayName("se actualiza una actividad y se agrega otra nueva , luego se envia un mail al administrador del proceso")
	@Test
	def void ProcesoActualizar() {
		proceso.ejecutarTodo()
		verify(stubMailSender, times(1)).mandarMail(mail)
		assertEquals(2, actualizadorActividades.repositorio.tamanioListaDelRepositorio)
	}

}
