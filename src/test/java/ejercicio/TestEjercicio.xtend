package ejercicio

import objetos_de_dominio.EjercicioConSeriesYRepeticiones
import objetos_de_dominio.EjercicioSimple
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

import static org.junit.jupiter.api.Assertions.assertEquals

@DisplayName("Dado un ejercicio")
class TestEjercicio {

	@DisplayName("es correcto el calculo si tiene series y repeticiones")
	@Test
	def void calculoDeDuracionConSeriesYRepeticiones() {
		// arrange
		val ejercicio = new EjercicioConSeriesYRepeticiones => [
			repeticiones = 10
			series = 3
			minutosDeDescanso = 2
		]

		// assert
		assertEquals(12, ejercicio.calcularDuracion)
	}

	@DisplayName("es correcto el calculo si no tiene series ni repeticiones")
	@Test
	def void calculoDeDuracionSinSeriesNiRepeticiones() {
		// arrange
		val ejercicio = new EjercicioSimple => [
			minutosDeDescanso = 3
			minutosDeTrabajo = 10
		]

		// assert
		assertEquals(13, ejercicio.calcularDuracion)
	}

}
