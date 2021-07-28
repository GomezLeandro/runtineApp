package usuario

import java.time.DayOfWeek
import java.time.LocalDate
import objetos_de_dominio.Usuario
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

import static org.junit.jupiter.api.Assertions.assertEquals

class TestUsuarioMinutos {

	Usuario usuario1
	Usuario usuario2

	@BeforeEach
	def void init() {
		usuario1 = new Usuario => [
			frecuenciaCardiacaEnReposo = 70
			fechaDeNacimiento = LocalDate.now.minusYears(30)
			porcentajeDeIntensidad = 80

		]
		usuario1.asignarDiasYMinutos(DayOfWeek.MONDAY, 150)
		usuario1.asignarDiasYMinutos(DayOfWeek.TUESDAY, 200)

		usuario2 = new Usuario => [
			frecuenciaCardiacaEnReposo = 150
			fechaDeNacimiento = LocalDate.now.minusYears(17)
			porcentajeDeIntensidad = 50
		]

		usuario2.asignarDiasYMinutos(DayOfWeek.MONDAY, 50)
		usuario2.asignarDiasYMinutos(DayOfWeek.TUESDAY, 20)

	}

	@DisplayName("El cálculo de sus minutos semanales es correcto")
	@Test
	def void minutosSemanales() {

		// act
		usuario1.asignarDiasYMinutos(DayOfWeek.MONDAY, 20)
		usuario1.asignarDiasYMinutos(DayOfWeek.TUESDAY, 20)

		// Assert
		assertEquals(40, usuario1.minutosSemanalesDeEntrenamiento)

	}

	@DisplayName("Si es mayor de edad, sus minutos semanales óptimos son 300")
	@Test
	def void minutosSemanalesOptimosDeUsuarioMayorDeEdad() {

		// Assert
		assertEquals(300, usuario1.minutosSemanalesOptimos)
	}

	@DisplayName("Si es menor de edad, sus minutos semanales óptimos son 420")
	@Test
	def void minutosSemanalesOptimosDeUsuarioMenorDeEdad() {

		// Assert
		assertEquals(420, usuario2.minutosSemanalesOptimos)
	}
}
