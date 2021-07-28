package proceso

import java.time.DayOfWeek
import java.time.LocalDate
import objetos_de_dominio.Actividad
import objetos_de_dominio.Ejercicio
import objetos_de_dominio.EjercicioConSeriesYRepeticiones
import objetos_de_dominio.EjercicioSimple
import objetos_de_dominio.GrupoMuscular
import objetos_de_dominio.Rutina
import objetos_de_dominio.Tiempista
import objetos_de_dominio.Usuario
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test
import service.MailSender
import utilitarios.ProcesoEliminarRutinasNoAptasParaElUsuario
import utilitarios.Repositorio
import static org.mockito.Mockito.*
import static org.junit.jupiter.api.Assertions.*
import exception.ExisteException
import service.Mail

@DisplayName("Dado un repo de Rutinas")
class TestProcesoEliminarRutinas {
	Usuario usuario1
	Usuario usuario2

	Actividad abdominales
	Actividad flexionesDeBrazo
	Actividad actividadGrupoBasico
	Ejercicio ejerciciosDePecho
	Ejercicio ejerciciosDeAbdomen
	EjercicioSimple ejercicioGrupoBasico
	Rutina rutina1
	Rutina rutina2

	Repositorio<Usuario> repoU
	Repositorio<Rutina> repoR
	ProcesoEliminarRutinasNoAptasParaElUsuario proceso
	MailSender stubMailSender
	Mail mail

	@BeforeEach
	def void init() {
		stubMailSender = mock(MailSender)
		usuario1 = new Usuario => [
			objetivo = new Tiempista(10)
			frecuenciaCardiacaEnReposo = 70
			fechaDeNacimiento = LocalDate.now.minusYears(30)
			porcentajeDeIntensidad = 80

		]
		usuario1.asignarDiasYMinutos(DayOfWeek.MONDAY, 150)
		usuario1.asignarDiasYMinutos(DayOfWeek.TUESDAY, 200)

		usuario2 = new Usuario => [
			objetivo = new Tiempista(5)
			frecuenciaCardiacaEnReposo = 70
			fechaDeNacimiento = LocalDate.now.minusYears(16)
			porcentajeDeIntensidad = 80
		]

		usuario2.asignarDiasYMinutos(DayOfWeek.MONDAY, 5)
		usuario2.asignarDiasYMinutos(DayOfWeek.TUESDAY, 2)

		abdominales = new Actividad => [
			getGrupos.add(GrupoMuscular.ABDOMEN)
			getGrupos.add(GrupoMuscular.PIERNAS)
		]
		flexionesDeBrazo = new Actividad => [
			getGrupos.add(GrupoMuscular.PECHO)
			getGrupos.add(GrupoMuscular.BRAZOS)
		]

		actividadGrupoBasico = new Actividad => [
			getGrupos.add(GrupoMuscular.ABDOMEN)
			getGrupos.add(GrupoMuscular.BRAZOS)
			getGrupos.add(GrupoMuscular.PIERNAS)
		]

		ejerciciosDeAbdomen = new EjercicioConSeriesYRepeticiones => [
			series = 3
			repeticiones = 10
			minutosDeDescanso = 2
			frecuenciaCardiacaBase = 110
			asignarActividad(abdominales)

		]
		ejerciciosDePecho = new EjercicioConSeriesYRepeticiones => [
			series = 5
			repeticiones = 20
			minutosDeDescanso = 2
			frecuenciaCardiacaBase = 150
			asignarActividad(flexionesDeBrazo)

		]

		ejercicioGrupoBasico = new EjercicioSimple => [
			minutosDeDescanso = 5
			minutosDeTrabajo = 25
			frecuenciaCardiacaBase = 110
			asignarActividad(actividadGrupoBasico)
		]

		rutina1 = new Rutina => [
			agregarEjercicio(ejerciciosDeAbdomen)
			agregarEjercicio(ejerciciosDePecho)

		]

		rutina2 = new Rutina => [
			agregarEjercicio(ejercicioGrupoBasico)
		]

		rutina1.agregarEjercicio(ejerciciosDeAbdomen)
		rutina1.agregarEjercicio(ejerciciosDePecho)
		rutina2.agregarEjercicio(ejercicioGrupoBasico)

		repoU = new Repositorio<Usuario>
		repoR = new Repositorio<Rutina>
		repoU.create(usuario1)
		repoU.create(usuario2)
		repoR.create(rutina1)
		repoR.create(rutina2)
		proceso = new ProcesoEliminarRutinasNoAptasParaElUsuario(repoU, repoR, stubMailSender)
		proceso.ejecutarTodo()
	}

	@DisplayName("se elimina 1 rutina")
	@Test
	def void seElimina1Rutina() {
		assertEquals(1, repoR.elementos.size())
	}

	@DisplayName("la rutina 1 está en el repo")
	@Test
	def void Rutina1EstaEnElRepo() {
		assertEquals(rutina1, repoR.getById(1))
	}

	@DisplayName("la rutina 2 no está en el repo")
	@Test
	def void rutina2NoEstaEnElRepo() {
		val mensajeEsperado = "el elemento no existe"
		val exception = assertThrows(ExisteException, [repoR.getById(2)])
		assertEquals(mensajeEsperado, exception.message)
	}

	@DisplayName("envia un mail al ejecutar el proceso")
	@Test
	def void enviarMail() {
		mail = new Mail(proceso.correoAdmin, proceso.nombreProceso, proceso.mensaje)
		verify(stubMailSender, times(1)).mandarMail(mail)
	}
}
