package validaciones

import objetos_de_dominio.Actividad
import objetos_de_dominio.GrupoMuscular
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test
import static org.junit.jupiter.api.Assertions.*

import exception.ActividadIncorrectaException

@DisplayName("Dada una actividad")
class TestValidacionActividad {

	Actividad actividadBienDefinida
	Actividad actividadMalDefinida
	Actividad actividadMalDefinida1

	@BeforeEach
	def void init() {
		actividadBienDefinida = new Actividad => [
			nombre = "Abdominales"
			grupos.add(GrupoMuscular.ABDOMEN)
		]

		actividadMalDefinida = new Actividad => [
			grupos.add(GrupoMuscular.PECHO)
		]

		actividadMalDefinida1 = new Actividad => [
			nombre = "Abdominales"
		]
	}

	@DisplayName("Puede instanciarse si no le falta ningun requisito")
	@Test
	def void sePuedeInstanciarSi() {
		assertTrue(actividadBienDefinida.validacion())
	}

	@DisplayName("no se puede instanciar si le falta algun requisito (nombre)")
	@Test
	def void noSePuedeInstanciarSi() {
		assertFalse(actividadMalDefinida.validacion())
	}

	@DisplayName("no se puede instanciar si le falta algun requisito (lista de grupos musculares vacía)")
	@Test
	def void noSePuedeInstanciarListaVacia() {
		assertFalse(actividadMalDefinida1.validacion())
	}

	@DisplayName("tira la excepción de nombre nulo")
	@Test
	def void excepcionNombreNulo() {
		val mensajeEsperado1 = "La actividad es incorrecta porque: el nombre es nulo"
		val exception = assertThrows(ActividadIncorrectaException, [actividadMalDefinida.validacionExcepcion()])
		assertEquals(mensajeEsperado1, exception.message)
	}

	@DisplayName("tira la excepción de lista vacía")
	@Test
	def void excepcionListaVacia() {
		val mensajeEsperado2 = "La actividad es incorrecta porque: la lista de grupos musculares está vacía"
		val exception = assertThrows(ActividadIncorrectaException, [actividadMalDefinida1.validacionExcepcion()])
		assertEquals(mensajeEsperado2, exception.message)
	}

}
