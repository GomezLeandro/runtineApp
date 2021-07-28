package stub

import java.time.LocalDate
import objetos_de_dominio.Actividad
import objetos_de_dominio.Ejercicio
import objetos_de_dominio.EjercicioConSeriesYRepeticiones
import objetos_de_dominio.EjercicioSimple
import objetos_de_dominio.GrupoMuscular
import objetos_de_dominio.Rutina
import objetos_de_dominio.SugerirRutinaObserver
import objetos_de_dominio.Usuario
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test
import utilitarios.Notificacion
import utilitarios.Repositorio
import static org.junit.jupiter.api.Assertions.assertEquals
import objetos_de_dominio.Tiempista

@DisplayName("Cuando un usuario comienza a seguir una rutina")
class TestObserverSugerenciaRutina {

	Usuario usuario
	Usuario usuarioCreador
	Actividad abdominales
	Actividad flexionesDeBrazo
	Actividad actividadGrupoBasico
	Actividad actividadGrupoBasico1
	Ejercicio ejerciciosDeGrupoBasico
	Ejercicio ejerciciosDeGrupoBasico1
	Ejercicio ejerciciosDeAbdomen
	Ejercicio ejerciciosDePecho
	Rutina rutina
	Rutina rutinaGrupoBasico1
	Rutina rutinaGrupoBasico2
	Repositorio<Rutina> repoDeRutinas
	SugerirRutinaObserver sugerirRutinaObserver
	Notificacion notificarSugerencia

	@BeforeEach
	def void init() {
		usuario = new Usuario() => [
			objetivo = new Tiempista(10)
			nombre = "pepe"
			frecuenciaCardiacaEnReposo = 80
			fechaDeNacimiento = LocalDate.now.minusYears(33)
		]

		usuarioCreador = new Usuario()

		repoDeRutinas = new Repositorio<Rutina>

		abdominales = new Actividad => [getGrupos.add(GrupoMuscular.ABDOMEN)]
		flexionesDeBrazo = new Actividad => [getGrupos.add(GrupoMuscular.PECHO)]

		actividadGrupoBasico = new Actividad => [
			getGrupos.add(GrupoMuscular.PIERNAS)
			getGrupos.add(GrupoMuscular.ABDOMEN)
			getGrupos.add(GrupoMuscular.BRAZOS)
		]
		actividadGrupoBasico1 = new Actividad => [
			getGrupos.add(GrupoMuscular.PIERNAS)
			getGrupos.add(GrupoMuscular.ABDOMEN)
			getGrupos.add(GrupoMuscular.BRAZOS)
		]

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

		ejerciciosDeGrupoBasico = new EjercicioSimple => [
			minutosDeDescanso = 12
			minutosDeTrabajo = 35
			frecuenciaCardiacaBase = 120
			asignarActividad(actividadGrupoBasico)
		]

		ejerciciosDeGrupoBasico1 = new EjercicioSimple => [

			minutosDeDescanso = 5
			minutosDeTrabajo = 25
			frecuenciaCardiacaBase = 100
			asignarActividad(actividadGrupoBasico1)
		]

		rutina = new Rutina => [
			nombre = "rutina1"
			agregarEjercicio(ejerciciosDeAbdomen)
			agregarEjercicio(ejerciciosDePecho)
		]

		rutinaGrupoBasico1 = new Rutina => [
			nombre = "rutina2"
			creador = usuarioCreador
			agregarEjercicio(ejerciciosDeGrupoBasico1)
			agregarEjercicio(ejerciciosDeGrupoBasico)

		]

		rutinaGrupoBasico2 = new Rutina => [
			nombre = "rutina3"
			creador = usuarioCreador
			agregarEjercicio(ejerciciosDeGrupoBasico)
			agregarEjercicio(ejerciciosDeGrupoBasico1)

		]

		repoDeRutinas.create(rutina)
		repoDeRutinas.create(rutinaGrupoBasico1)
		repoDeRutinas.create(rutinaGrupoBasico2)

		sugerirRutinaObserver = new SugerirRutinaObserver => [
			repositorioDeRutinas = repoDeRutinas
			notificarSugerencia = new Notificacion()
			notificacion = notificarSugerencia

		]
	}

	@DisplayName("le envia una sugerencia de rutina")
	@Test
	def void noloAgregaComoAmigoDelCreadorObserver() {
		rutinaGrupoBasico1.agregarAcciones(sugerirRutinaObserver)
		rutinaGrupoBasico1.agregarSeguidor(usuario)
		assertEquals(1, usuario.notificaciones.size)

	}

}
