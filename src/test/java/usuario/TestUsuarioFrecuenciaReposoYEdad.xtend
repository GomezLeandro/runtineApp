package usuario

import java.time.LocalDate
import objetos_de_dominio.Usuario
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

import static org.junit.jupiter.api.Assertions.assertEquals
import static org.junit.jupiter.api.Assertions.assertFalse
import static org.junit.jupiter.api.Assertions.assertTrue

@DisplayName("Dado un usuario")
class TestUsuarioFrecuenciaReposoYEdad {

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

	@DisplayName("Si tiene entre 60 y 100 pulsaciones => tiene frecuencia cardíaca en reposo")
	@Test
	def void frecuenciaCardiacaEnReposo() {

		// assert
		assertTrue(usuario1.tieneFrecuenciaCardiacaEnReposo(), "Este usuario no tiene frecuencia cardíaca en reposo")
	}

	@DisplayName("Si tiene más de 100 pulsaciones  => no tiene frecuencia cardíaca en reposo")
	@Test
	def void frecuenciaCardiacaNoEnReposo() {

		// assert
		assertFalse(usuario2.tieneFrecuenciaCardiacaEnReposo(), "Este usuario tiene frecuencia cardíaca en reposo")
	}

	@DisplayName("El cálculo de la edad es correcta")
	@Test
	def void usuarioConEdadCorrecta() {

		// Assert
		assertEquals(30, usuario1.getEdad)
	}

	@DisplayName("Es mayor de edad")
	@Test
	def void usuarioMayorDeEdad() {

		// Assert
		assertTrue(usuario1.esMayorDeEdad)
	}

	@DisplayName("No es mayor de edad")
	@Test
	def void usuarioNoMayorDeEdad() {

		// Assert
		assertFalse(usuario2.esMayorDeEdad)
	}

}
