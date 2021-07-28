package usuario

import java.time.DayOfWeek
import java.time.LocalDate
import objetos_de_dominio.Actividad
import objetos_de_dominio.Conformista
import objetos_de_dominio.EjercicioConSeriesYRepeticiones
import objetos_de_dominio.GrupoMuscular
import objetos_de_dominio.Indeciso
import objetos_de_dominio.Negado
import objetos_de_dominio.Rutina
import objetos_de_dominio.Tiempista
import objetos_de_dominio.Usuario
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

import static org.junit.jupiter.api.Assertions.assertFalse
import static org.junit.jupiter.api.Assertions.assertTrue

@DisplayName("Dado un usuario")
class TestUsuarioEstaConforme {

	Usuario usuario1
	Usuario usuario2
	Usuario usuario3
	Actividad abdominales
	Actividad flexionesDeBrazo
	EjercicioConSeriesYRepeticiones ejerciciosDePecho
	EjercicioConSeriesYRepeticiones ejerciciosDeAbdomen
	Rutina rutina

	@BeforeEach
	def void init() {
		usuario1 = new Usuario => [
			objetivo = new Tiempista(10)
			frecuenciaCardiacaEnReposo = 70
			fechaDeNacimiento = LocalDate.now.minusYears(30)
			porcentajeDeIntensidad = 80

		]
		usuario1.asignarDiasYMinutos(DayOfWeek.MONDAY, 150)
		usuario1.asignarDiasYMinutos(DayOfWeek.TUESDAY, 200)

		usuario2 = new Usuario => [
			objetivo = new Tiempista(10)
			frecuenciaCardiacaEnReposo = 150
			fechaDeNacimiento = LocalDate.now.minusYears(16)
			porcentajeDeIntensidad = 50
		]

		usuario2.asignarDiasYMinutos(DayOfWeek.MONDAY, 5)
		usuario2.asignarDiasYMinutos(DayOfWeek.TUESDAY, 2)

		usuario3 = new Usuario => [
			objetivo = new Tiempista(10)
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

		abdominales = new Actividad => [getGrupos.add(GrupoMuscular.ABDOMEN)]
		flexionesDeBrazo = new Actividad => [getGrupos.add(GrupoMuscular.PECHO)]
		ejerciciosDeAbdomen = new EjercicioConSeriesYRepeticiones => [
			series = 3
			repeticiones = 10
			minutosDeDescanso = 2
			frecuenciaCardiacaBase = 80
			asignarActividad(abdominales)

		]
		ejerciciosDePecho = new EjercicioConSeriesYRepeticiones => [
			series = 5
			repeticiones = 20
			minutosDeDescanso = 2
			frecuenciaCardiacaBase = 100
			asignarActividad(flexionesDeBrazo)

		]

		rutina = new Rutina => [
			agregarEjercicio(ejerciciosDeAbdomen)
			agregarEjercicio(ejerciciosDePecho)
		]

	}

	@DisplayName("Está conforme con la rutina teniendo objetivo tiempista con almenos un dia con más minutos que la duración de la rutina")
	@Test
	def void estaConformeConLaRutina() {

		// Assert
		assertTrue(usuario1.estaConformeCon(rutina))
	}

	@DisplayName("No está conforme con la rutina teniendo objetivo tiempista con almenos un dia con más minutos que la duración de la rutina")
	@Test
	def void noEstaConformeConLaRutinaSiendoTiempista() {

		// Assert
		assertFalse(usuario2.estaConformeCon(rutina))
	}

	@DisplayName("No está conforme con la rutina ya que es negado")
	@Test
	def void noEstaConformeConLaRutina() {

		// Act
		usuario1.objetivo = new Negado
		// Assert
		assertFalse(usuario1.estaConformeCon(rutina))
	}

	@DisplayName("Está conforme con la rutina con objetivo conformista")
	@Test
	def void estaConformeConLaRutinaSiendoConformista() {

		// Act
		usuario1.objetivo = new Conformista
		usuario1.agregarGrupoMuscularDePreferencia(GrupoMuscular.ABDOMEN)
		usuario1.agregarGrupoMuscularDePreferencia(GrupoMuscular.PECHO)

		// Assert
		assertTrue(usuario1.estaConformeCon(rutina))
	}

	@DisplayName("Está conforme con la rutina dependiendo el día")
	@Test
	def void estaConformeConLaRutinaSiendoIndeciso() {

		// Act
		usuario1.objetivo = new Indeciso

		// Assert
		assertFalse(usuario1.estaConformeCon(rutina))
	}

	@DisplayName("Está conforme con la rutina con objetivo atleta")
	@Test
	def void estaConformeConLaRutinaSiendoAtleta() {

		// Assert
		assertTrue(usuario1.estaConformeCon(rutina))
	}

}
