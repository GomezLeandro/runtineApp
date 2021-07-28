package usuario

import java.time.LocalDate
import objetos_de_dominio.Usuario
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

import static org.junit.jupiter.api.Assertions.assertFalse
import static org.junit.jupiter.api.Assertions.assertTrue

class TestUsuarioVigoroso {

	Usuario usuario1
	Usuario usuario2

	@BeforeEach
	def void init() {
		usuario1 = new Usuario => [
			frecuenciaCardiacaEnReposo = 70
			fechaDeNacimiento = LocalDate.now.minusYears(30)
			porcentajeDeIntensidad = 80

		]

		usuario2 = new Usuario => [
			frecuenciaCardiacaEnReposo = 150
			fechaDeNacimiento = LocalDate.now.minusYears(17)
			porcentajeDeIntensidad = 50
		]

	}

	@DisplayName("Es vigoroso si su porcentaje de intensidad es mayor a 70")
	@Test
	def void esVigorosoSiTieneUnPorcentajeDe80() {

		// Assert
		assertTrue(usuario1.esVigoroso)
	}

	@DisplayName("No es vigoroso si su porcentaje de intensidad es menor a 70")
	@Test
	def void noEsVigorosoSiTieneUnPorcentajeDe50() {

		// Assert
		assertFalse(usuario2.esVigoroso)
	}
}
