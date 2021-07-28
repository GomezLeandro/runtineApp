package validaciones

import java.time.DayOfWeek
import java.time.LocalDate
import objetos_de_dominio.Usuario
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test
import static org.junit.jupiter.api.Assertions.*
import exception.UsuarioIncorrectoException

@DisplayName("Dado un usuario")
class TestValidacionUsuario {

	Usuario usuarioBienDefinido
	Usuario usuarioMalDefinido
	Usuario usuarioMalDefinido1
	Usuario usuarioMalDefinido2
	Usuario usuarioMalDefinido3
	Usuario usuarioMalDefinido4
	Usuario usuarioMalDefinido5
	Usuario usuarioSinDias

	@BeforeEach
	def void init() {
		usuarioBienDefinido = new Usuario => [
			nombre = "Luciano"
			apellido = "Contreras "
			username = "JsonLasDiez"
			frecuenciaCardiacaEnReposo = 70
			fechaDeNacimiento = LocalDate.now.minusYears(30)
			porcentajeDeIntensidad = 80

		]
		usuarioMalDefinido = new Usuario => [
			apellido = "Perez"
			username = "usuaria123"
			frecuenciaCardiacaEnReposo = 70
			fechaDeNacimiento = LocalDate.now.minusYears(30)
			porcentajeDeIntensidad = 80
		]

		usuarioMalDefinido1 = new Usuario => [
			nombre = "Vladimir"
			username = "LaZapatilla"
			frecuenciaCardiacaEnReposo = 70
			fechaDeNacimiento = LocalDate.now.minusYears(30)
			porcentajeDeIntensidad = 80

		]

		usuarioMalDefinido2 = new Usuario => [
			nombre = "Analia"
			apellido = "Rosa"
			username = "AR2"
			frecuenciaCardiacaEnReposo = 70
			fechaDeNacimiento = LocalDate.now.minusYears(30)
			porcentajeDeIntensidad = 80

		]

		usuarioMalDefinido3 = new Usuario => [
			nombre = "Erminia"
			apellido = "Ancha"
			username = "LaSeñora"
			frecuenciaCardiacaEnReposo = 10
			fechaDeNacimiento = LocalDate.now.minusYears(70)
			porcentajeDeIntensidad = 100

		]

		usuarioMalDefinido4 = new Usuario => [
			nombre = "Luis"
			apellido = "Carpia"
			username = "elperroloco"
			frecuenciaCardiacaEnReposo = 70
			fechaDeNacimiento = LocalDate.now.minusYears(0)
			porcentajeDeIntensidad = 80

		]
		usuarioMalDefinido5 = new Usuario => [
			nombre = "Victor"
			apellido = "Carpia"
			username = "elloco"
			frecuenciaCardiacaEnReposo = 70
			fechaDeNacimiento = LocalDate.now.minusYears(30)
			porcentajeDeIntensidad = 101

		]

		usuarioSinDias = new Usuario => [
			nombre = "Dante"
			apellido = "Blanco"
			username = "BlaDan"
			frecuenciaCardiacaEnReposo = 70
			fechaDeNacimiento = LocalDate.now.minusYears(29)
			porcentajeDeIntensidad = 80

		]

		usuarioBienDefinido.asignarDiasYMinutos(DayOfWeek.MONDAY, 10)
		usuarioBienDefinido.asignarDiasYMinutos(DayOfWeek.TUESDAY, 10)
		usuarioMalDefinido.asignarDiasYMinutos(DayOfWeek.MONDAY, 10)
		usuarioMalDefinido1.asignarDiasYMinutos(DayOfWeek.MONDAY, 10)
		usuarioMalDefinido2.asignarDiasYMinutos(DayOfWeek.MONDAY, 10)
		usuarioMalDefinido3.asignarDiasYMinutos(DayOfWeek.MONDAY, 10)
		usuarioMalDefinido4.asignarDiasYMinutos(DayOfWeek.MONDAY, 10)
		usuarioMalDefinido5.asignarDiasYMinutos(DayOfWeek.MONDAY, 10)
	}

	@DisplayName("puede instanciarse sino le falta ningun requisito")
	@Test
	def void sePuedeInstanciarSi() {

		// Assert
		assertTrue(usuarioBienDefinido.validacion())
	}

	@DisplayName("no puede instanciarse si le faltan requisitos obligatorios (nombre)")
	@Test
	def void noSePuedeInstanciarPorNombre() {

		// Assert
		assertFalse(usuarioMalDefinido.validacion())
	}

	@DisplayName("no puede instanciarse si le faltan requisitos obligatorios(apellido)")
	@Test
	def void noSePuedeInstanciarPorApellido() {

		// Assert
		assertFalse(usuarioMalDefinido1.validacion())
	}

	@DisplayName("no puede instanciarse si tiene un username de menos de 4 caracteres")
	@Test
	def void noSePuedeInstanciarPorUsername() {

		// Assert
		assertFalse(usuarioMalDefinido2.validacion())
	}

	@DisplayName("no puede instanciarse si le faltan requisitos obligatorios(frecuencia reposo fuera del rango)")
	@Test
	def void noSePuedeInstanciarPorFrecuenciaReposo() {

		// Assert
		assertFalse(usuarioMalDefinido3.validacion())
	}

	@DisplayName("no puede instanciarse si la fecha de nacimiento es hoy")
	@Test
	def void noSePuedeInstanciarPorFechaNacimiento() {

		// Assert
		assertFalse(usuarioMalDefinido4.validacion())
	}

	@DisplayName("no puede instanciarse si el porcentaje de intensidad es mayor a 100")
	@Test
	def void noSePuedeInstanciarPorPorcentajeIntensidad() {

		// Assert
		assertFalse(usuarioMalDefinido5.validacion())
	}

	@DisplayName("no puede instanciarse si n tiene al menos un día de entrenamiento asignado")
	@Test
	def void noSePuedeInstanciarPorDiaEntrenamiento() {

		// Assert
		assertFalse(usuarioSinDias.validacion())
	}
	
	@DisplayName("tira la excepción de nombre nulo")
	@Test
	def void excepcionNombreNulo() {
		val mensajeEsperado1 = "El usuario es incorrecto porque: el nombre es nulo"
		val exception = assertThrows(UsuarioIncorrectoException, [usuarioMalDefinido.validacionExcepcion()])
		assertEquals(mensajeEsperado1, exception.message)
	}
	
	@DisplayName("tira la excepción de apellido nulo")
	@Test
	def void excepcionApellidoNulo() {
		val mensajeEsperado2 = "El usuario es incorrecto porque: el apellido es nulo"
		val exception = assertThrows(UsuarioIncorrectoException, [usuarioMalDefinido1.validacionExcepcion()])
		assertEquals(mensajeEsperado2, exception.message)
	}
	
	@DisplayName("tira la excepción de username")
	@Test
	def void excepcionUsername() {
		val mensajeEsperado3 = "El usuario es incorrecto porque: el username tiene menos de 4 caracteres"
		val exception = assertThrows(UsuarioIncorrectoException, [usuarioMalDefinido2.validacionExcepcion()])
		assertEquals(mensajeEsperado3, exception.message)
	}
	
	@DisplayName("tira la excepción de frecuencia reposo")
	@Test
	def void excepcionFrecuenciaReposo() {
		val mensajeEsperado4 = "El usuario es incorrecto porque: la frecuencia en reposo es incorrecta. Tiene que ser entre 60 y 100"
		val exception = assertThrows(UsuarioIncorrectoException, [usuarioMalDefinido3.validacionExcepcion()])
		assertEquals(mensajeEsperado4, exception.message)
	}
	
	@DisplayName("tira la excepción de fecha de nacimiento")
	@Test
	def void excepcionFechaNacimiento() {
		val mensajeEsperado5 = "El usuario es incorrecto porque: la fecha de nacimiento es incorrecta"
		val exception = assertThrows(UsuarioIncorrectoException, [usuarioMalDefinido4.validacionExcepcion()])
		assertEquals(mensajeEsperado5, exception.message)
	}
	
	@DisplayName("tira la excepción de porcentaje de intensidad")
	@Test
	def void excepcionPorcentajeIntensidad() {
		val mensajeEsperado6 = "El usuario es incorrecto porque: el porcentaje de intensidad es incorrecto. Tiene que ser entre 0 y 100"
		val exception = assertThrows(UsuarioIncorrectoException, [usuarioMalDefinido5.validacionExcepcion()])
		assertEquals(mensajeEsperado6, exception.message)
	}
	
	@DisplayName("tira la excepción de días de entrenamiento")
	@Test
	def void excepcionDiasDeEntrenamiento() {
		val mensajeEsperado7 = "El usuario es incorrecto porque: el usuario no tiene días de entrenamiento"
		val exception = assertThrows(UsuarioIncorrectoException, [usuarioSinDias.validacionExcepcion()])
		assertEquals(mensajeEsperado7, exception.message)
	}

}
