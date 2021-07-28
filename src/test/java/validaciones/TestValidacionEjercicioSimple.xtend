package validaciones

import objetos_de_dominio.Actividad
import objetos_de_dominio.EjercicioSimple
import objetos_de_dominio.GrupoMuscular
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test
import validaciones.ValidacionEjercicioSimple

import static org.junit.jupiter.api.Assertions.assertFalse
import static org.junit.jupiter.api.Assertions.assertTrue

@DisplayName("Dado un ejercicio simple")
class TestValidacionEjercicioSimple {

	EjercicioSimple ejercicioSimpleBienDefinido
	EjercicioSimple ejercicioSimpleMalDefinido
	EjercicioSimple ejercicioSimpleMalDefinido1
	Actividad actividadBienDefinida

	@BeforeEach
	def void init() {
		actividadBienDefinida = new Actividad => [
			nombre = "Abdominales"
			getGrupos.add(GrupoMuscular.ABDOMEN)
		]
		ejercicioSimpleBienDefinido = new EjercicioSimple => [
			actividad = actividadBienDefinida
			minutosDeDescanso = 2
			frecuenciaCardiacaBase = 65
			minutosDeTrabajo = 10
			validacion = new ValidacionEjercicioSimple
		]

		ejercicioSimpleMalDefinido = new EjercicioSimple => [
			actividad = actividadBienDefinida
			minutosDeTrabajo = 10
			frecuenciaCardiacaBase = 65
			validacion = new ValidacionEjercicioSimple
		]

		ejercicioSimpleMalDefinido1 = new EjercicioSimple => [
			actividad = actividadBienDefinida
			minutosDeDescanso = 2
			minutosDeTrabajo = 10
			validacion = new ValidacionEjercicioSimple
		]

	}

	@DisplayName("Puede instanciarse si no le falta ningun requisito")
	@Test
	def void sePuedeInstanciarSi() {
		assertTrue(ejercicioSimpleBienDefinido.validacionEjercicioSimple())

	}

	@DisplayName("no se puede instanciar si le falta algun requisito (minutos de descanso)")
	@Test
	def void noSePuedeInstanciarMinutosDescanso() {
		assertFalse(ejercicioSimpleMalDefinido.validacionEjercicioSimple())

	}

	@DisplayName("no se puede instanciar si le falta algun requisito (minutos de trabajo)")
	@Test
	def void noSePuedeInstanciarMinutosTrabajo() {
		assertFalse(ejercicioSimpleMalDefinido1.validacionEjercicioSimple())

	}
}
