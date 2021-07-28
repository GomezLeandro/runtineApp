package rutina

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

import static org.junit.jupiter.api.Assertions.assertEquals

class TestRutinaFrecuenciasCardiaca {
	Actividad abdominales
	Actividad flexionesDeBrazo
	Ejercicio ejerciciosDePecho
	Ejercicio ejerciciosDeAbdomen
	Rutina rutina
	Usuario usuario1

	@BeforeEach
	def void init() {
		abdominales = new Actividad => [getGrupos.add(GrupoMuscular.ABDOMEN)]
		flexionesDeBrazo = new Actividad => [getGrupos.add(GrupoMuscular.PECHO)]

		ejerciciosDeAbdomen = new EjercicioConSeriesYRepeticiones => [
			frecuenciaCardiacaBase = 80
			asignarActividad(abdominales)
		]
		ejerciciosDePecho = new EjercicioConSeriesYRepeticiones => [
			frecuenciaCardiacaBase = 100
			asignarActividad(flexionesDeBrazo)
		]

		rutina = new Rutina => [
			agregarEjercicio(ejerciciosDeAbdomen)
			agregarEjercicio(ejerciciosDePecho)
		]

		usuario1 = new Usuario => [

			frecuenciaCardiacaEnReposo = 80
			fechaDeNacimiento = LocalDate.now.minusYears(33)
		]

	}

	@DisplayName("Se calcula la frecuencia cardiaca base como las pulsasiones por minuto que la rutina demanda ")
	@Test
	def void FrecuenciaCardiacaBase() {
		assertEquals(90, rutina.frecuenciaCardiacaBase())
	}

	@DisplayName(" la frecuencia cardiaca alcanzada por un usuario es igual al valor esperado")
	@Test
	def void FrecuenciaCardiacaAlcanzada() {
		assertEquals(98.5, rutina.frecuenciaCardiacaAlcanzadaPor(usuario1))
	}
}
