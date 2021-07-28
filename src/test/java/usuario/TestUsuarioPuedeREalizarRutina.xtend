package usuario

import java.time.DayOfWeek
import java.time.LocalDate
import objetos_de_dominio.Actividad
import objetos_de_dominio.EjercicioConSeriesYRepeticiones
import objetos_de_dominio.EjercicioSimple
import objetos_de_dominio.GrupoMuscular
import objetos_de_dominio.Rutina
import objetos_de_dominio.Tiempista
import objetos_de_dominio.Usuario
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

import static org.junit.jupiter.api.Assertions.assertFalse
import static org.junit.jupiter.api.Assertions.assertTrue

@DisplayName(" Dado un usuario")
class TestUsuarioPuedeREalizarRutina {

	Usuario usuario1
	Usuario usuario2
	Usuario usuario3
	Actividad abdominales
	Actividad flexionesDeBrazo
	Actividad actividadGrupoBasico
	EjercicioConSeriesYRepeticiones ejerciciosDePecho
	EjercicioConSeriesYRepeticiones ejerciciosDeAbdomen
	EjercicioSimple ejercicioGrupoBasico
	Rutina rutina
	Rutina rutina1

	@BeforeEach
	def void init() {
		usuario1 = new Usuario => [
			objetivo = new Tiempista(10)
			frecuenciaCardiacaEnReposo = 70
			fechaDeNacimiento = LocalDate.now.minusYears(30)
			porcentajeDeIntensidad = 80

		]
		usuario1.asignarDiasYMinutos(DayOfWeek.MONDAY, 150)
		usuario1.asignarDiasYMinutos(DayOfWeek.TUESDAY, 200)

		usuario2 = new Usuario => [
			frecuenciaCardiacaEnReposo = 150
			fechaDeNacimiento = LocalDate.now.minusYears(16)
			porcentajeDeIntensidad = 50
		]

		usuario2.asignarDiasYMinutos(DayOfWeek.MONDAY, 5)
		usuario2.asignarDiasYMinutos(DayOfWeek.TUESDAY, 2)

		usuario3 = new Usuario => [
			frecuenciaCardiacaEnReposo = 100
			fechaDeNacimiento = LocalDate.now.minusYears(23)
			porcentajeDeIntensidad = 75
		]

		usuario3.asignarDiasYMinutos(DayOfWeek.MONDAY, 10)
		usuario3.asignarDiasYMinutos(DayOfWeek.TUESDAY, 20)
		usuario3.asignarDiasYMinutos(DayOfWeek.WEDNESDAY, 15)
		usuario3.asignarDiasYMinutos(DayOfWeek.THURSDAY, 10)
		usuario3.asignarDiasYMinutos(DayOfWeek.FRIDAY, 10)
		usuario3.asignarDiasYMinutos(DayOfWeek.SATURDAY, 15)
		usuario3.asignarDiasYMinutos(DayOfWeek.SUNDAY, 10)

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
			frecuenciaCardiacaBase = 80
			asignarActividad(abdominales)

		]
		ejerciciosDePecho = new EjercicioConSeriesYRepeticiones => [
			series = 5
			repeticiones = 20
			minutosDeDescanso = 2
			frecuenciaCardiacaBase = 100
			asignarActividad(flexionesDeBrazo)

		]

		ejercicioGrupoBasico = new EjercicioSimple => [
			minutosDeDescanso = 5
			minutosDeTrabajo = 25
			frecuenciaCardiacaBase = 102
			asignarActividad(actividadGrupoBasico)
		]

		rutina = new Rutina => [
			agregarEjercicio(ejerciciosDeAbdomen)
			agregarEjercicio(ejerciciosDePecho)

		]

		rutina1 = new Rutina => [
			agregarEjercicio(ejercicioGrupoBasico)
		]

	}

	@DisplayName("no puede realizar la rutina")
	@Test
	def void noPuedeRealizarLaRutina() {

		// Assert
		assertFalse(usuario1.puedeRealizarRutina(rutina))
	}

	@DisplayName("puede realizar la rutina")
	@Test
	def void puedeRealizarLaRutina() {

		// Assert
		assertTrue(usuario2.puedeRealizarRutina(rutina1))
	}

}
