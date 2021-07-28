package rutina

import java.time.LocalDate
import objetos_de_dominio.Actividad
import objetos_de_dominio.Ejercicio
import objetos_de_dominio.EjercicioConSeriesYRepeticiones
import objetos_de_dominio.GrupoMuscular
import objetos_de_dominio.Rutina
import objetos_de_dominio.Usuario
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

import static org.junit.jupiter.api.Assertions.assertFalse
import static org.junit.jupiter.api.Assertions.assertTrue

@DisplayName(" Dada una rutina")
class TestRutinaEsSaludable {
	Actividad abdominales
	Actividad flexionesDeBrazo
	Actividad actividadGrupoBasico
	Ejercicio ejerciciosDeAbdomen
	Ejercicio ejerciciosDePecho
	Ejercicio ejerciciosDeGrupoBasico
	Rutina rutina
	Rutina rutinaSaludable
	Usuario usuario1

	@BeforeEach
	def void init() {

		abdominales = new Actividad => [getGrupos.add(GrupoMuscular.ABDOMEN)]
		flexionesDeBrazo = new Actividad => [getGrupos.add(GrupoMuscular.PECHO)]
		actividadGrupoBasico = new Actividad => [
			getGrupos.add(GrupoMuscular.PIERNAS)
			getGrupos.add(GrupoMuscular.ABDOMEN)
			getGrupos.add(GrupoMuscular.BRAZOS)
		]

		ejerciciosDeAbdomen = new EjercicioConSeriesYRepeticiones => [
			frecuenciaCardiacaBase = 50
			asignarActividad(abdominales)
		]
		ejerciciosDePecho = new EjercicioConSeriesYRepeticiones => [
			frecuenciaCardiacaBase = 40
			asignarActividad(flexionesDeBrazo)
		]
		ejerciciosDeGrupoBasico = new EjercicioConSeriesYRepeticiones => [
			frecuenciaCardiacaBase = 240
			asignarActividad(actividadGrupoBasico)
		]

		rutina = new Rutina => [
			agregarEjercicio(ejerciciosDeAbdomen)
			agregarEjercicio(ejerciciosDePecho)
		]

		rutinaSaludable = new Rutina => [
			agregarEjercicio(ejerciciosDeGrupoBasico)
			agregarEjercicio(ejerciciosDeAbdomen)
			agregarEjercicio(ejerciciosDePecho)

		]

		usuario1 = new Usuario => [

			frecuenciaCardiacaEnReposo = 80
			fechaDeNacimiento = LocalDate.now.minusYears(33)
		]

	}

	@DisplayName("Si su frecuencia cardiaca alcanzada por el usuario no esta entre la maxima y la de reserva => no es saludable")
	@Test
	def void noEsCompletaPara() {
		assertFalse(rutina.esSaludablePara(usuario1))
	}

	@DisplayName("Si su frecuencia cardiaca alcanzada por el usuario esta entre la maxima y la de reserva =>  es saludable")
	@Test
	def void EsCompletaPara() {
		assertTrue(rutinaSaludable.esSaludablePara(usuario1))
	}

}
