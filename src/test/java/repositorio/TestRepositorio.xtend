package repositorio

import exception.NoNuevoException
import objetos_de_dominio.Actividad
import objetos_de_dominio.GrupoMuscular
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test
import utilitarios.Repositorio

import static org.junit.jupiter.api.Assertions.*
import exception.ExisteException

@DisplayName("Dada una actividad")
class TestRepositorio {

	Actividad actividadBienDefinida
	Repositorio<Actividad> repositorio = new Repositorio

	@BeforeEach
	def void init() {

		actividadBienDefinida = new Actividad => [
			nombre = "Abominables"
			getGrupos.add(GrupoMuscular.ABDOMEN)
		]

	}

	@DisplayName("tira la excepción no es nuevo")
	@Test
	def void excepcionActividadNoEsNueva() {
		repositorio.create(actividadBienDefinida)
		val mensajeEsperado1 = "el elemento no es nuevo"
		val exception = assertThrows(NoNuevoException, [repositorio.create(actividadBienDefinida)])
		assertEquals(mensajeEsperado1, exception.message)
	}

	@DisplayName("Si es nueva la agrega al repositorio")
	@Test
	def void siUnElementoEsNuevoLoCrea() {
		repositorio.create(actividadBienDefinida)
		assertTrue(repositorio.existeElemento(1))
	}

	@DisplayName("Si intento borrar y el elemento no existe tira la excepción no existe")
	@Test
	def void excepcionActividadNoExiste() {
		val mensajeEsperado1 = "el elemento no existe"
		val exception = assertThrows(ExisteException, [repositorio.delete(actividadBienDefinida)])
		assertEquals(mensajeEsperado1, exception.message)
	}

	@DisplayName("Si la borro => el id deja de existir en la lista")
	@Test
	def void siExisteElementoLoBorra() {
		repositorio.create(actividadBienDefinida)
		repositorio.delete(actividadBienDefinida)
		assertFalse(repositorio.existeElemento(1))
	}

	@DisplayName("Si actualizo => el id no cambia")
	@Test
	def void update() {
		repositorio.create(actividadBienDefinida)
		actividadBienDefinida.nombre = "abdominales"
		repositorio.update(actividadBienDefinida)
		assertEquals(actividadBienDefinida, repositorio.getById(1))
	}

	@DisplayName("Si intento actualizar y el elemento no existe tira la excepción no existe")
	@Test
	def void excepcionUpdateActividadNoExiste() {
		val mensajeEsperado1 = "el elemento no existe"
		val exception = assertThrows(ExisteException, [repositorio.update(actividadBienDefinida)])
		assertEquals(mensajeEsperado1, exception.message)
	}
}
