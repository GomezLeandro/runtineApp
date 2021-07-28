package rutina

import objetos_de_dominio.Actividad
import objetos_de_dominio.Ejercicio
import objetos_de_dominio.EjercicioConSeriesYRepeticiones
import objetos_de_dominio.EjercicioSimple
import objetos_de_dominio.GrupoMuscular
import objetos_de_dominio.Rutina
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

import static org.junit.jupiter.api.Assertions.assertEquals

@DisplayName(" Dada una rutina")
class TestDuracionDeLaRutina {

	Actividad abdominales
	Actividad flexionesDeBrazo
	Actividad piernas
	Ejercicio ejerciciosDePecho
	Ejercicio ejerciciosDeAbdomen
	Ejercicio ejerciciosDePiernas
	Rutina rutina
	Rutina rutina1

	@BeforeEach
	def void init() {
		abdominales = new Actividad => [getGrupos.add(GrupoMuscular.ABDOMEN)]
		flexionesDeBrazo = new Actividad => [getGrupos.add(GrupoMuscular.BRAZOS)]
		piernas = new Actividad
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
		ejerciciosDePiernas = new EjercicioSimple => [
			minutosDeDescanso = 2
			minutosDeTrabajo = 10
			frecuenciaCardiacaBase = 96
			asignarActividad(piernas)
		]

		rutina = new Rutina => [
			agregarEjercicio(ejerciciosDeAbdomen)
			agregarEjercicio(ejerciciosDePecho)
		]
		rutina1 = new Rutina => [
			agregarEjercicio(ejerciciosDeAbdomen)
			agregarEjercicio(ejerciciosDePecho)
			agregarEjercicio(ejerciciosDePiernas)
		]
	}

	@DisplayName("se calcula el tiempo en minutos de duracion de ejercicios con series y repeticiones")
	@Test
	def void DuracionConSeries() {
		assertEquals(32, rutina.duracion())
	}

	@DisplayName("se calcula el tiempo en minutos de duracion de ejercicios con y sin repeticiones")
	@Test
	def void DuracionConYSinSeries() {

		assertEquals(44, rutina1.duracion())
	}
}
