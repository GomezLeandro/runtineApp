package rutina

import objetos_de_dominio.Actividad
import objetos_de_dominio.Ejercicio
import objetos_de_dominio.EjercicioConSeriesYRepeticiones
import objetos_de_dominio.GrupoMuscular
import objetos_de_dominio.Rutina
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

import static org.junit.jupiter.api.Assertions.assertEquals

@DisplayName(" Dada una rutina")
class TestRuntinaEntrenaGruposMusculares {
	Actividad abdominales
	Actividad flexionesDeBrazo

	Ejercicio ejerciciosDePecho
	Ejercicio ejerciciosDeAbdomen
	Rutina rutina

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

		rutina = new Rutina => [
			agregarEjercicio(ejerciciosDeAbdomen)
			agregarEjercicio(ejerciciosDePecho)
		]

	}

	@DisplayName("Verificamos que entrene el grupo muscular correcto")
	@Test
	def void GruposMusculares() {

		assertEquals(#[GrupoMuscular.ABDOMEN, GrupoMuscular.PECHO], rutina.gruposMusculares())
	}

/* NO SE VERIFICA EL TEST CON LA CLASE DE EQUIVALENCIA CONTRARIA PORQUE
 NO TENDRIA SENTIDO PARA LO QUE HACE ESTA FUNCION*/
}
