package stub

import objetos_de_dominio.AmigoDelCreadorObserver
import objetos_de_dominio.MailAlCreadorObserver
import objetos_de_dominio.Rutina
import objetos_de_dominio.Usuario
import org.junit.jupiter.api.Assertions
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test
import service.Mail
import service.MailSender
import utilitarios.Repositorio

import static org.mockito.Mockito.*

@DisplayName("Cada vez que un usuario comienza a seguir una rutina ")
class TestObserver {
	Usuario usuario1
	Usuario creadorDeLaRutina
	Usuario usuarioAmigo
	Usuario creadorDeOtraRutina
	Rutina rutinaASeguir
	Rutina rutinaASeguir2
	Rutina rutinaASeguir3
	Rutina rutinaDeOtroCreador
	Mail mail
	MailSender stubMailSender
	MailAlCreadorObserver mailAlCreador
	AmigoDelCreadorObserver amigoDelCreador
	Repositorio<Rutina> repo = new Repositorio<Rutina>

	@BeforeEach
	def void init() {
		usuario1 = new Usuario => [
			nombre = "DiegoArmandoEsteBanquito"
		]

		usuarioAmigo = new Usuario()

		creadorDeLaRutina = new Usuario => [
			correo = "creador@algo2.edu.ar"
		]

		creadorDeOtraRutina = new Usuario()

		mailAlCreador = new MailAlCreadorObserver() => [
			stubMailSender = mock(MailSender)
			mailSender = stubMailSender
		]

		rutinaASeguir = new Rutina() => [
			nombre = "dificilisima"
			creador = creadorDeLaRutina
		]

		rutinaASeguir2 = new Rutina() => [
			nombre = "facilisima"
			creador = creadorDeLaRutina
		]

		rutinaASeguir3 = new Rutina() => [
			nombre = "MasomenosDificil"
			creador = creadorDeLaRutina
		]

		rutinaDeOtroCreador = new Rutina() => [
			nombre = "MasomenosDificil"
			creador = creadorDeOtraRutina
		]

		mail = new Mail(rutinaASeguir.correoCreador(), mailAlCreador.asunto,
			mailAlCreador.mensaje(rutinaASeguir, usuario1))

		creadorDeLaRutina.agregarAmigo(usuarioAmigo)
		creadorDeOtraRutina.agregarAmigo(usuarioAmigo)

		repo.create(rutinaASeguir)
		repo.create(rutinaASeguir2)
		repo.create(rutinaASeguir3)
		repo.create(rutinaDeOtroCreador)

		amigoDelCreador = new AmigoDelCreadorObserver() => [
			repositorioDeRutinas = repo
		]

	}

	@DisplayName("se manda un mail al creador")
	@Test
	def void mandarMailCadaVezQueSeAgregueUnSeguidor() {
		rutinaASeguir.agregarAcciones(mailAlCreador)
		rutinaASeguir.agregarSeguidor(usuario1)
		verify(stubMailSender, times(1)).mandarMail(mail)
	}

	@DisplayName("si sigue dos o mas rutinas del mismo creador y este no lo tiene en la lista de amigos => lo agrega como su amigo")
	@Test
	def void amigoDelCreadorObserver() {
		rutinaASeguir3.agregarSeguidor(usuario1)
		rutinaASeguir2.agregarAcciones(amigoDelCreador)
		rutinaASeguir2.agregarSeguidor(usuario1)
		Assertions.assertEquals(2, creadorDeLaRutina.tamanioListaAmigos)

	}

	@DisplayName("si no sigue dos o mas rutinas del mismo creador => este  no lo agrega como su amigo")
	@Test
	def void noloAgregaComoAmigoDelCreadorObserver() {
		rutinaASeguir3.agregarSeguidor(usuario1)
		rutinaDeOtroCreador.agregarAcciones(amigoDelCreador)
		rutinaDeOtroCreador.agregarSeguidor(usuario1)
		Assertions.assertEquals(1, creadorDeLaRutina.tamanioListaAmigos)

	}

	@DisplayName("si  sigue dos o mas rutinas del mismo creador pero ya es su amigo => este  no lo agrega como su amigo")
	@Test
	def void noAgregaAmigo() {
		rutinaASeguir.agregarSeguidor(usuario1)
		rutinaASeguir2.agregarAcciones(amigoDelCreador)
		rutinaASeguir2.agregarSeguidor(usuario1)
		verify(stubMailSender, times(0)).mandarMail(mail)

	}

}
