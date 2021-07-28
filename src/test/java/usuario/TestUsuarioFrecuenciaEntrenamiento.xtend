package usuario

import java.time.LocalDate
import objetos_de_dominio.Usuario
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

import static org.junit.jupiter.api.Assertions.assertEquals

class TestUsuarioFrecuenciaEntrenamiento {

	Usuario usuario1

	@BeforeEach
	def void init() {
		usuario1 = new Usuario => [
			frecuenciaCardiacaEnReposo = 70
			fechaDeNacimiento = LocalDate.now.minusYears(30)
			porcentajeDeIntensidad = 80

		]

	}

	@DisplayName("El cálculo de la frecuencia cardíaca de entrenamiento es correcto")
	@Test
	def void calculoDeFrecuenciaCardiacaDeEntrenamiento() {

		// Assert
		assertEquals(9670, usuario1.frecuenciaCardiacaDeEntrenamiento)
	}
}
