package rutina

import objetos_de_dominio.Actividad
import objetos_de_dominio.Ejercicio
import objetos_de_dominio.EjercicioConSeriesYRepeticiones
import objetos_de_dominio.GrupoMuscular
import objetos_de_dominio.Rutina
import objetos_de_dominio.Usuario
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test
import validaciones.ValidacionRutina

import static org.junit.jupiter.api.Assertions.assertFalse
import static org.junit.jupiter.api.Assertions.assertTrue

@DisplayName("Dada una rutina")
class TestMetodosValidacionRutina {

	Actividad abdominales
	Actividad flexionesDeBrazo
	Ejercicio ejerciciosDePecho
	Ejercicio ejerciciosDeAbdomen
	Rutina rutinaBienDefinida
	Rutina rutinaMalDefinida
	Usuario usuario1
	ValidacionRutina validacion

	@BeforeEach
	def void init() {
		validacion = new ValidacionRutina
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
			nombre = "Miembro inferior"
		]
		rutinaBienDefinida.agregarEjercicio(ejerciciosDeAbdomen)
		rutinaBienDefinida.agregarEjercicio(ejerciciosDePecho)
	}

	@DisplayName("si la rutina tiene al menos un ejercicio => es valida")
	@Test
	def void alMenosUnEjercicio() {
		assertTrue(validacion.listaDeEjerciciosContieneElementos(rutinaBienDefinida))

	}

	@DisplayName("si la rutina no contiene ejercicios => es invalida")
	@Test
	def void rutinaSinEjercicios() {
		assertFalse(validacion.listaDeEjerciciosContieneElementos(rutinaMalDefinida))

	}

	@DisplayName("si la rutina tiene un creador => es valida")
	@Test
	def void rutinaConCreador() {
		assertTrue(validacion.creadorNoEsNulo(rutinaBienDefinida))

	}

	@DisplayName("si creador es igual a null => es invalida")
	@Test
	def void rutinaSinCreador() {
		assertFalse(validacion.creadorNoEsNulo(rutinaMalDefinida))

	}

	@DisplayName("si la rutina tiene un nombre y una descripcion => es valida")
	@Test
	def void rutinaConNombreYDescripcion() {
		assertTrue(validacion.validacionNombreYDescripcionRutina(rutinaBienDefinida))

	}

	@DisplayName("si la rutina no tiene un nombre ni una descripcion => es invalida")
	@Test
	def void rutinaSinNombreYDescripcion() {
		assertFalse(validacion.validacionNombreYDescripcionRutina(rutinaMalDefinida))

	}

}
