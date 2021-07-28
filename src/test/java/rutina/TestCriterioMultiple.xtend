package rutina

import objetos_de_dominio.Amistoso
import objetos_de_dominio.CriterioMultiple
import objetos_de_dominio.Free
import objetos_de_dominio.Rutina
import objetos_de_dominio.Usuario
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

import static org.junit.jupiter.api.Assertions.assertTrue

@DisplayName("Dada una rutina con criterio múltiple")
class TestCriterioMultiple {
	Usuario usuarioAmigoDelCreador
	Usuario usuarioCreador
	Rutina rutinaConCriterioMultiple
	CriterioMultiple criterioMultiple
	Free free
	Amistoso amistoso

	@BeforeEach
	def void init() {
		usuarioAmigoDelCreador = new Usuario
		usuarioCreador = new Usuario
		criterioMultiple = new CriterioMultiple
		free = new Free
		amistoso = new Amistoso
		rutinaConCriterioMultiple = new Rutina => [
			criterioDeEdicion = criterioMultiple
			creador = usuarioCreador
		]

		criterioMultiple.criterios.add(free)
		criterioMultiple.criterios.add(amistoso)
		usuarioCreador.agregarAmigo(usuarioAmigoDelCreador)

	}

	@DisplayName("puede ser editada ya que cumple el criterio Free y amistoso")
	@Test
	def void puedeSerEditadaSiCumpleConCriterioMultiple() {
		assertTrue(rutinaConCriterioMultiple.puedeSerEditadoPor(rutinaConCriterioMultiple, usuarioAmigoDelCreador))
	}
}
