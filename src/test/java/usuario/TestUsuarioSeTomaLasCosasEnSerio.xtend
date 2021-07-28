package usuario

import java.time.DayOfWeek
import java.time.LocalDate
import objetos_de_dominio.Usuario
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

import static org.junit.jupiter.api.Assertions.assertFalse
import static org.junit.jupiter.api.Assertions.assertTrue

class TestUsuarioSeTomaLasCosasEnSerio {

	Usuario usuario1
	Usuario usuario2
	Usuario usuario3

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

		usuario3 = new Usuario => [
			frecuenciaCardiacaEnReposo = 100
			fechaDeNacimiento = LocalDate.now.minusYears(23)
			porcentajeDeIntensidad = 75
		]

		usuario3.asignarDiasYMinutos(DayOfWeek.MONDAY, 10)
		usuario3.asignarDiasYMinutos(DayOfWeek.TUESDAY, 20)
		usuario3.asignarDiasYMinutos(DayOfWeek.WEDNESDAY, 15)
		usuario3.asignarDiasYMinutos(DayOfWeek.THURSDAY, 10)
		usuario3.asignarDiasYMinutos(DayOfWeek.FRIDAY, 10)
		usuario3.asignarDiasYMinutos(DayOfWeek.SATURDAY, 15)
		usuario3.asignarDiasYMinutos(DayOfWeek.SUNDAY, 10)

	}

	@DisplayName("Se toma las cosas en serio si los minutos semanales de entrenamiento son mayores a los minutos semanales óptimos")
	@Test
	def void seTomaLasCosasEnSerioConLosMinutosSemanalesDeEntrenamiento() {

		// Assert
		assertTrue(usuario1.seTomaLasCosasEnSerio)
	}

	@DisplayName("No se toma las cosas en serio si los minutos semanales de entrenamiento son menores a los minutos semanales óptimos")
	@Test
	def void noSeTomaLasCosasEnSerioConLosMinutosSemanalesDeEntrenamiento() {

		// Assert
		assertFalse(usuario2.seTomaLasCosasEnSerio)
	}

	@DisplayName("Se toma las cosas en serio si entrena toda la semana y es vigoroso")
	@Test
	def void seTomaLasCosasEnSerioEntrenandoTodaLaSemanaYEsVigoroso() {

		// Assert
		assertTrue(usuario3.seTomaLasCosasEnSerio)
	}

}
