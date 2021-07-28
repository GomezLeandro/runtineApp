package rutina

import java.time.LocalDate
import objetos_de_dominio.Actividad
import objetos_de_dominio.Ejercicio
import objetos_de_dominio.EjercicioConSeriesYRepeticiones
import objetos_de_dominio.EjercicioSimple
import objetos_de_dominio.GrupoMuscular
import objetos_de_dominio.Negado
import objetos_de_dominio.Rutina
import objetos_de_dominio.Usuario
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

import static org.junit.jupiter.api.Assertions.assertFalse
import static org.junit.jupiter.api.Assertions.assertTrue

@DisplayName(" Dada una rutina")
class TestRutinaEsCompletaPara {
	Actividad abdominales
	Actividad flexionesDeBrazo
	Actividad actividadGrupoBasico
	Actividad actividadGrupoBasico1
	Ejercicio ejerciciosDePecho
	Ejercicio ejerciciosDeAbdomen
	Ejercicio ejerciciosDeGrupoBasico
	Ejercicio ejerciciosDeGrupoBasico1
	Rutina rutina
	Rutina rutinaGrupoBasico
	Usuario usuario1

	@BeforeEach
	def void init() {
		abdominales = new Actividad => [getGrupos.add(GrupoMuscular.ABDOMEN)]
		flexionesDeBrazo = new Actividad => [getGrupos.add(GrupoMuscular.PECHO)]

		actividadGrupoBasico = new Actividad => [
			getGrupos.add(GrupoMuscular.PIERNAS)
			getGrupos.add(GrupoMuscular.ABDOMEN)
			getGrupos.add(GrupoMuscular.BRAZOS)
		]
		actividadGrupoBasico1 = new Actividad => [
			getGrupos.add(GrupoMuscular.PIERNAS)
			getGrupos.add(GrupoMuscular.ABDOMEN)
			getGrupos.add(GrupoMuscular.BRAZOS)
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

		ejerciciosDeGrupoBasico = new EjercicioSimple => [
			minutosDeDescanso = 12
			minutosDeTrabajo = 35
			frecuenciaCardiacaBase = 96
			asignarActividad(actividadGrupoBasico)
		]

		ejerciciosDeGrupoBasico1 = new EjercicioSimple => [

			minutosDeDescanso = 5
			minutosDeTrabajo = 25
			frecuenciaCardiacaBase = 102
			asignarActividad(actividadGrupoBasico1)
		]
		rutina = new Rutina => [
			agregarEjercicio(ejerciciosDeAbdomen)
			agregarEjercicio(ejerciciosDePecho)
		]

		rutinaGrupoBasico = new Rutina => [
			agregarEjercicio(ejerciciosDeGrupoBasico1)
			agregarEjercicio(ejerciciosDeGrupoBasico)

		]

		usuario1 = new Usuario => [

			frecuenciaCardiacaEnReposo = 80
			fechaDeNacimiento = LocalDate.now.minusYears(33)
		]

		usuario1.objetivo = new Negado // asignarObjetivoNegado()
	}

	@DisplayName("Si su ejercicios no entrenan grupo basico => verificamos que no es completa para el usuario")
	@Test
	def void noEsCompletaPara() {
		assertFalse(rutina.entrenaGrupoBasico(usuario1))
	}

	@DisplayName("si todas los ejercicios entrenan grupo basico y no cumple con el objetivo =>la rutina es completa para el usuario")
	@Test
	def void esCompletaPara() {
		assertTrue(rutinaGrupoBasico.entrenaGrupoBasico(usuario1))
	}

}
