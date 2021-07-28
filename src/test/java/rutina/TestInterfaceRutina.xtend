package rutina

import java.time.DayOfWeek
import java.time.LocalDate
import objetos_de_dominio.Fortuito
import objetos_de_dominio.Free
import objetos_de_dominio.Responsable
import objetos_de_dominio.Rutina
import objetos_de_dominio.Social
import objetos_de_dominio.Usuario
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

import static org.junit.jupiter.api.Assertions.assertTrue

@DisplayName("Dada una rutina")
class TestInterfaceRutina {
	Usuario usuarioCreador
	Usuario noCreador

	Social social
	Free free
	Responsable responsable
	Fortuito fortuito
	Usuario usuarioMayor
	Rutina rutina1
	Rutina rutina2
	Rutina rutina3
	Rutina rutina4
	Rutina rutina5
	Rutina rutina6

	@BeforeEach
	def void init() {

		social = new Social
		responsable = new Responsable
		free = new Free
		fortuito = new Fortuito
		usuarioCreador = new Usuario
		noCreador = new Usuario => [username = "Sada"]
		usuarioMayor = new Usuario => [

			username = "frijol"
			frecuenciaCardiacaEnReposo = 70
			fechaDeNacimiento = LocalDate.now.minusYears(30)
			porcentajeDeIntensidad = 80

		]
		rutina1 = new Rutina => [
			creador = usuarioCreador

		]
		rutina2 = new Rutina => [
			criterioDeEdicion = free

		]

		rutina3 = new Rutina => [
			criterioDeEdicion = social
		]

		rutina4 = new Rutina => [
			criterioDeEdicion = responsable
		]

		rutina5 = new Rutina => [
			criterioDeEdicion = fortuito
			nombre = "easy"
		]

		rutina6 = new Rutina => [
			criterioDeEdicion = fortuito
			nombre = "rutinaMuyLarga"
		]
		// act
		rutina3.agregarSeguidor(noCreador)
		usuarioCreador.agregarAmigo(noCreador)
		usuarioMayor.asignarDiasYMinutos(DayOfWeek.MONDAY, 120)
		usuarioMayor.asignarDiasYMinutos(DayOfWeek.TUESDAY, 20)
		usuarioMayor.asignarDiasYMinutos(DayOfWeek.WEDNESDAY, 50)
		usuarioMayor.asignarDiasYMinutos(DayOfWeek.THURSDAY, 100)
		usuarioMayor.asignarDiasYMinutos(DayOfWeek.FRIDAY, 70)
		usuarioMayor.asignarDiasYMinutos(DayOfWeek.SATURDAY, 15)
		usuarioMayor.asignarDiasYMinutos(DayOfWeek.SUNDAY, 100)
	}

	@DisplayName("puede ser editada por su creador")
	@Test
	def void puedeSerEditadaPorElCreador() {
		assertTrue(rutina1.puedeSerEditadoPor(rutina1, usuarioCreador))
	}

	@DisplayName("Si el usuario no es el creador pero si un amigo de su creador => puede editar rutina")
	@Test
	def void puedeSerEditadaPorAmistoso() {
		assertTrue(rutina1.puedeSerEditadoPor(rutina1, noCreador))
	}

	@DisplayName("Si el usuario no es el creador pero si un seguidor => puede editar rutina")
	@Test
	def void puedeSerEditadaPorSocial() {
		assertTrue(rutina3.puedeSerEditadoPor(rutina3, noCreador))
	}

	@DisplayName("Si el criterio es free => cualquiera puede editar rutina")
	@Test
	def void puedeSerEditadaPorFree() {
		assertTrue(rutina2.puedeSerEditadoPor(rutina2, noCreador))
	}

	@DisplayName("Si el usuario es responsable =>  puede editar rutina")
	@Test
	def void puedeSerEditadaPorResponsable() {
		assertTrue(rutina4.puedeSerEditadoPor(rutina4, usuarioMayor))
	}

	@DisplayName("Si la rutina tiene un nombre menor de seis letras pero el username del usuario empieza con f =>  puede editar rutina")
	@Test
	def void puedeSerEditadaPorUsernameFortuito() {
		assertTrue(rutina5.puedeSerEditadoPor(rutina5, usuarioMayor))
	}

	@DisplayName("Si la rutina tiene un nombre mayor a seis letras  =>  Un usuario puede editar rutina")
	@Test
	def void puedeSerEditadaPorNombreFortuito() {
		assertTrue(rutina6.puedeSerEditadoPor(rutina6, noCreador))
	}

}
