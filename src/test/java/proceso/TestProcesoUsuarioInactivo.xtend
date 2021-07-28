package proceso

import exception.ExisteException
import java.time.LocalDate
import objetos_de_dominio.Actividad
import objetos_de_dominio.Ejercicio
import objetos_de_dominio.EjercicioConSeriesYRepeticiones
import objetos_de_dominio.GrupoMuscular
import objetos_de_dominio.Rutina
import objetos_de_dominio.Usuario
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test
import service.Mail
import service.MailSender
import utilitarios.ProcesoEliminarUsuariosInactivos
import utilitarios.Repositorio
import validaciones.ValidacionEjerciciosConSeriesYRepeticiones
import static org.mockito.Mockito.*
import static org.junit.jupiter.api.Assertions.*

@DisplayName("Dado un repo de usuarios")
class TestProcesoUsuarioInactivo {
	Usuario usuario1
	Usuario usuario2
	Usuario usuario3
	Usuario usuario4

	Actividad abdominales
	Actividad flexionesDeBrazo
	Ejercicio ejerciciosDePecho
	Ejercicio ejerciciosDeAbdomen
	Rutina rutina1
	Rutina rutina2

	Repositorio<Usuario> repoU
	Repositorio<Rutina> repoR
	ProcesoEliminarUsuariosInactivos proceso

	MailSender stubMailSender
	Mail mail

	@BeforeEach
	def void init() {
		stubMailSender = mock(MailSender)
		usuario1 = new Usuario => [
			nombre = "Luciano"
			apellido = "Contreras "
			username = "JsonLasDiez"
			frecuenciaCardiacaEnReposo = 70
			fechaDeNacimiento = LocalDate.now.minusYears(30)
			porcentajeDeIntensidad = 80

		]
		usuario2 = new Usuario => [
			nombre = "Paula"
			apellido = "Perez"
			username = "usuaria123"
			frecuenciaCardiacaEnReposo = 70
			fechaDeNacimiento = LocalDate.now.minusYears(30)
			porcentajeDeIntensidad = 80
		]
		usuario3 = new Usuario => [
			nombre = "Lucas"
			apellido = "Rojo"
			username = "luker"
			frecuenciaCardiacaEnReposo = 70
			fechaDeNacimiento = LocalDate.now.minusYears(30)
			porcentajeDeIntensidad = 80
		]
		usuario4 = new Usuario => [
			nombre = "Tobías"
			apellido = "Jans"
			username = "tobyj"
			frecuenciaCardiacaEnReposo = 70
			fechaDeNacimiento = LocalDate.now.minusYears(30)
			porcentajeDeIntensidad = 80
		]

		abdominales = new Actividad => [
			nombre = "Abdominales"
			getGrupos.add(GrupoMuscular.ABDOMEN)
		]
		flexionesDeBrazo = new Actividad => [
			nombre = "Flexiones"
			getGrupos.add(GrupoMuscular.PECHO)
		]

		ejerciciosDeAbdomen = new EjercicioConSeriesYRepeticiones => [
			actividad = abdominales
			minutosDeDescanso = 2
			frecuenciaCardiacaBase = 65
			series = 10
			repeticiones = 3
			validacion = new ValidacionEjerciciosConSeriesYRepeticiones
		]

		ejerciciosDePecho = new EjercicioConSeriesYRepeticiones => [
			actividad = flexionesDeBrazo
			minutosDeDescanso = 2
			frecuenciaCardiacaBase = 65
			series = 10
			repeticiones = 3
			validacion = new ValidacionEjerciciosConSeriesYRepeticiones
		]

		rutina1 = new Rutina => [
			nombre = "Miembro Superior"
			descripcion = "Entrenamiento de abdomen y brazos"
			creador = usuario4
		]

		rutina2 = new Rutina => [
			nombre = "Miembro Superior"
			descripcion = "Entrenamiento de abdomen"
			creador = usuario3
		]

		rutina1.agregarEjercicio(ejerciciosDeAbdomen)
		rutina1.agregarEjercicio(ejerciciosDePecho)
		rutina2.agregarEjercicio(ejerciciosDeAbdomen)
		usuario3.agregarAmigo(usuario4)
		usuario4.agregarAmigo(usuario3)

		repoU = new Repositorio<Usuario>
		repoR = new Repositorio<Rutina>
		repoU.create(usuario1)
		repoU.create(usuario2)
		repoU.create(usuario3)
		repoU.create(usuario4)
		repoR.create(rutina1)
		repoR.create(rutina2)
		proceso = new ProcesoEliminarUsuariosInactivos(repoU, repoR, stubMailSender)
		proceso.ejecutarTodo()
	}

	@DisplayName("se eliminan 2 usuarios")
	@Test
	def void seEliminan2Usuarios() {
		assertEquals(2, repoU.elementos.size())
	}

	@DisplayName("el usuario 3 está en el repo")
	@Test
	def void usuario3EnElRepo() {
		assertEquals(usuario3, repoU.getById(3))
	}

	@DisplayName("el usuario 1 no está en el repo")
	@Test
	def void usuario1NoEstaEnElRepo() {
		val mensajeEsperado = "el elemento no existe"
		val exception = assertThrows(ExisteException, [repoU.getById(1)])
		assertEquals(mensajeEsperado, exception.message)
	}

	@DisplayName("el usuario 2 no está en el repo")
	@Test
	def void usuario2NoEstaEnElRepo() {
		val mensajeEsperado = "el elemento no existe"
		val exception = assertThrows(ExisteException, [repoU.getById(2)])
		assertEquals(mensajeEsperado, exception.message)
	}

	@DisplayName("envia un mail al ejecutar el proceso")
	@Test
	def void enviarMail() {
		mail = new Mail(proceso.correoAdmin, proceso.nombreProceso, proceso.mensaje)
		verify(stubMailSender, times(1)).mandarMail(mail)
	}
}
