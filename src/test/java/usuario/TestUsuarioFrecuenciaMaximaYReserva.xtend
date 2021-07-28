package usuario

import java.time.LocalDate
import objetos_de_dominio.Usuario
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

import static org.junit.jupiter.api.Assertions.assertEquals

class TestUsuarioFrecuenciaMaximaYReserva {
	Usuario usuario1

	@BeforeEach
	def void init() {
		usuario1 = new Usuario => [
			frecuenciaCardiacaEnReposo = 70
			fechaDeNacimiento = LocalDate.now.minusYears(30)
			porcentajeDeIntensidad = 80

		]

	}

	@DisplayName("Su frecuencia cardíaca máxima es correcta")
	@Test
	def void usuarioConFrecuenciaCardiacaMaximaCorrecta() {

		// Assert
		assertEquals(190, usuario1.frecuenciaCardiacaMaxima, "La frecuencia cardíaca no es correcta")

	}

	@DisplayName("Su frecuencia cardíaca de reserva está correcta")
	@Test
	def void frecuenciaDeReserva() {

		// assert
		assertEquals(120, usuario1.frecuenciaDeReserva)

	}
}
