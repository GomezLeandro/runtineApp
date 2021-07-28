package validaciones

import objetos_de_dominio.Actividad
import objetos_de_dominio.EjercicioConSeriesYRepeticiones
import objetos_de_dominio.GrupoMuscular
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test
import validaciones.ValidacionEjerciciosConSeriesYRepeticiones

import static org.junit.jupiter.api.Assertions.assertFalse
import static org.junit.jupiter.api.Assertions.assertTrue

@DisplayName("Dado un ejercicio con series y repeticiones")
class TestValidacionEjercicioConSeriesYRepeticiones {

	Actividad actividadBienDefinida
	EjercicioConSeriesYRepeticiones ejercicioBienDefinido
	EjercicioConSeriesYRepeticiones ejercicioMalDefinido
	EjercicioConSeriesYRepeticiones ejercicioMalDefinido1
	EjercicioConSeriesYRepeticiones ejercicioMalDefinido2

	@BeforeEach
	def void init() {
		actividadBienDefinida = new Actividad => [
			nombre = "Abdominales"
			getGrupos.add(GrupoMuscular.ABDOMEN)
		]
		ejercicioBienDefinido = new EjercicioConSeriesYRepeticiones => [
			actividad = actividadBienDefinida
			minutosDeDescanso = 2
			frecuenciaCardiacaBase = 65
			series = 10
			repeticiones = 3
			validacion = new ValidacionEjerciciosConSeriesYRepeticiones
		]

		ejercicioMalDefinido = new EjercicioConSeriesYRepeticiones => [
			actividad = actividadBienDefinida
			frecuenciaCardiacaBase = 65
			series = 10
			repeticiones = 3
			validacion = new ValidacionEjerciciosConSeriesYRepeticiones
		]

		ejercicioMalDefinido1 = new EjercicioConSeriesYRepeticiones => [
			actividad = actividadBienDefinida
			minutosDeDescanso = 2
			repeticiones = 3
			frecuenciaCardiacaBase = 65
			validacion = new ValidacionEjerciciosConSeriesYRepeticiones
		]

		ejercicioMalDefinido2 = new EjercicioConSeriesYRepeticiones => [
			actividad = actividadBienDefinida
			minutosDeDescanso = 2
			series = 10
			repeticiones = 3
			validacion = new ValidacionEjerciciosConSeriesYRepeticiones
		]

	}

	@DisplayName("Puede instanciarse si no le falta ningun requisito")
	@Test
	def void sePuedeInstanciarSi() {
		assertTrue(ejercicioBienDefinido.validar())

	}

	@DisplayName("no se puede instanciar si le falta algun requisito (minutos de descanso)")
	@Test
	def void noSePuedeInstanciarMinutosDescanso() {
		assertFalse(ejercicioMalDefinido.validar())

	}

	@DisplayName("no se puede instanciar si le falta algun requisito (series)")
	@Test
	def void noSePuedeInstanciarSeries() {
		assertFalse(ejercicioMalDefinido1.validar())

	}

	@DisplayName("no se puede instanciar si le falta algun requisito (repeticiones)")
	@Test
	def void noSePuedeInstanciarRepeticiones() {
		assertFalse(ejercicioMalDefinido1.validar())

	}

	@DisplayName("no se puede instanciar si le falta algun requisito (frecuencia cardiaca base)")
	@Test
	def void noSePuedeInstanciarFrecuenciaCardiacaBase() {
		assertFalse(ejercicioMalDefinido2.validar())

	}
}
