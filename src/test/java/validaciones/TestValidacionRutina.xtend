package validaciones

import objetos_de_dominio.Actividad
import objetos_de_dominio.Ejercicio
import objetos_de_dominio.EjercicioConSeriesYRepeticiones
import objetos_de_dominio.GrupoMuscular
import objetos_de_dominio.Rutina
import objetos_de_dominio.Usuario
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test
import static org.junit.jupiter.api.Assertions.*
import exception.RutinaIncorrectaException

@DisplayName("Dada una Rutina")
class TestValidacionRutina {

	Actividad abdominales
	Actividad flexionesDeBrazo
	Ejercicio ejerciciosDePecho
	Ejercicio ejerciciosDeAbdomen
	Rutina rutinaBienDefinida
	Rutina rutinaMalDefinida
	Rutina rutinaMalDefinida1
	Rutina rutinaMalDefinida2
	Rutina rutinaMalDefinida3
	Usuario usuario1

	@BeforeEach
	def void init() {
		abdominales = new Actividad => [getGrupos.add(GrupoMuscular.ABDOMEN)]
		flexionesDeBrazo = new Actividad => [getGrupos.add(GrupoMuscular.PECHO)]

		ejerciciosDeAbdomen = new EjercicioConSeriesYRepeticiones => [
			asignarActividad(abdominales)
		]

		ejerciciosDePecho = new EjercicioConSeriesYRepeticiones => [
			asignarActividad(flexionesDeBrazo)
		]

		usuario1 = new Usuario
		rutinaBienDefinida = new Rutina => [
			nombre = "Miembro Superior"
			descripcion = "Entrenamiento de abdomen y brazos"
			creador = usuario1
		]

		rutinaMalDefinida = new Rutina => [
			descripcion = "Entrenamiento de abdomen"
			creador = usuario1
		]

		rutinaMalDefinida1 = new Rutina => [
			nombre = "Miembro Superior"
			creador = usuario1
		]

		rutinaMalDefinida2 = new Rutina => [
			nombre = "Miembro Superior"
			descripcion = "Entrenamiento de abdomen"
		]

		rutinaMalDefinida3 = new Rutina => [
			nombre = "Miembro Superior"
			descripcion = "Entrenamiento de abdomen y brazos"
			creador = usuario1
		]

		rutinaBienDefinida.agregarEjercicio(ejerciciosDeAbdomen)
		rutinaBienDefinida.agregarEjercicio(ejerciciosDePecho)
		rutinaMalDefinida.agregarEjercicio(ejerciciosDeAbdomen)
		rutinaMalDefinida1.agregarEjercicio(ejerciciosDeAbdomen)
		rutinaMalDefinida2.agregarEjercicio(ejerciciosDeAbdomen)
	}

	@DisplayName("Puede instanciarse si no le falta ningun requisito")
	@Test
	def void sePuedeInstanciarSi() {
		assertTrue(rutinaBienDefinida.validacion())
	}

	@DisplayName("No puede instanciarse si le faltan algunos requisitos (nombre)")
	@Test
	def void noSePuedeInstanciarPorqueLeFaltaNombre() {
		assertFalse(rutinaMalDefinida.validacion())
	}

	@DisplayName("No puede instanciarse si le faltan algunos requisitos (descripción)")
	@Test
	def void noSePuedeInstanciarPorqueLeFaltaDescripcion() {
		assertFalse(rutinaMalDefinida1.validacion())
	}

	@DisplayName("No puede instanciarse si le faltan algunos requisitos (creador)")
	@Test
	def void noSePuedeInstanciarPorqueLeFaltaCreador() {
		assertFalse(rutinaMalDefinida2.validacion())
	}

	@DisplayName("No puede instanciarse si le faltan algunos requisitos (lista vacía)")
	@Test
	def void noSePuedeInstanciar() {
		assertFalse(rutinaMalDefinida3.validacion())
	}

	@DisplayName("tira la excepción de nombre nulo")
	@Test
	def void excepcionNombreNulo() {
		val mensajeEsperado1 = "La rutina es incorrecta porque: el nombre es nulo"
		val exception = assertThrows(RutinaIncorrectaException, [rutinaMalDefinida.validacionExcepcion()])
		assertEquals(mensajeEsperado1, exception.message)
	}

	@DisplayName("tira la excepción de descripción nula")
	@Test
	def void excepcionDescripcionNula() {
		val mensajeEsperado2 = "La rutina es incorrecta porque: la descripción es nula"
		val exception = assertThrows(RutinaIncorrectaException, [rutinaMalDefinida1.validacionExcepcion()])
		assertEquals(mensajeEsperado2, exception.message)
	}

	@DisplayName("tira la excepción de creador nulo")
	@Test
	def void excepcioncreadorNulo() {
		val mensajeEsperado3 = "La rutina es incorrecta porque: el creador es nulo"
		val exception = assertThrows(RutinaIncorrectaException, [rutinaMalDefinida2.validacionExcepcion()])
		assertEquals(mensajeEsperado3, exception.message)
	}

	@DisplayName("tira la excepción de lista vacía")
	@Test
	def void excepcionListaVacia() {
		val mensajeEsperado4 = "La rutina es incorrecta porque: la lista de ejercicios está vacía"
		val exception = assertThrows(RutinaIncorrectaException, [rutinaMalDefinida3.validacionExcepcion()])
		assertEquals(mensajeEsperado4, exception.message)
	}
}
