package actividad

import objetos_de_dominio.Actividad
import objetos_de_dominio.GrupoMuscular
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

import static org.junit.jupiter.api.Assertions.assertFalse
import static org.junit.jupiter.api.Assertions.assertTrue

@DisplayName("Dado una actividad")
class TestActividad {

	Actividad actividad

	@BeforeEach
	def void init() {

		actividad = new Actividad => [
			getGrupos.add(GrupoMuscular.PIERNAS)
			getGrupos.add(GrupoMuscular.BRAZOS)
			getGrupos.add(GrupoMuscular.ABDOMEN)
		]

	}

	@DisplayName("esta entrena al menos un musculo")
	@Test
	def void unaActividadEntrenaUnMusculo() {

		assertFalse(actividad.listaEstaVacia)

	}

	@DisplayName("entrena el grupo basico si entrena Piernas, brazos y abdomen")
	@Test
	def void entrenaGpoBasico() {

		assertTrue(actividad.entrenaGrupoBasico)
	}
}
