package objetos_de_dominio

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import service.Mail
import service.MailSender
import utilitarios.Notificacion
import utilitarios.Repositorio

interface AccionesObserver {
	def void seguidorAgregado(Rutina rutina, Usuario usuario)
}

@Accessors
class MailAlCreadorObserver implements AccionesObserver {
	MailSender mailSender
	// String direccionXDefault = "runtime_app@unsam.edu.ar"
	String asunto = "Rutina seguida"

	override seguidorAgregado(Rutina rutina, Usuario usuario) {
		val mail = new Mail(rutina.correoCreador(), asunto, mensaje(rutina, usuario))
		mailSender.mandarMail(mail)
	}

	def String mensaje(Rutina rutina, Usuario usuario) {
		"la rutina " + rutina.nombre + " esta siendo seguida por " + usuario.nombre
	}
}

@Accessors
class AmigoDelCreadorObserver implements AccionesObserver {
	Repositorio<Rutina> repositorioDeRutinas

	override seguidorAgregado(Rutina rutina, Usuario usuario) {
		if (cantidadRutinasMismoCreadorSeguidas(rutina, usuario) >= 2) {
			siNoEsAmigoLoAgrega(rutina, usuario)
		}
	}

	def void siNoEsAmigoLoAgrega(Rutina rutina, Usuario usuario) {
		if (!rutina.creador.esAmigoDe(usuario)) {
			rutina.creador.agregarAmigo(usuario)
		}
	}

	def cantidadRutinasMismoCreadorSeguidas(Rutina rutina, Usuario usuario) {
		listaDeRutinasSeguidasDelMismoCreador(rutina, usuario).size()
	}

	def List<Rutina> listaDeRutinasSeguidasDelMismoCreador(Rutina rutina, Usuario usuario) {
		repositorioDeRutinas.elementos.filter[r|r.esSeguidaPor(usuario)].toList()
	}

}

@Accessors
class SugerirRutinaObserver implements AccionesObserver {
	Repositorio<Rutina> repositorioDeRutinas
	Notificacion notificacion

	override seguidorAgregado(Rutina rutina, Usuario usuario) {
		if (hayRutinasSugerible(usuario)) {
			primeraQNoSigueYPuedeRealizar(usuario)
			notificacion.enviarNotificacion(usuario, this.mensaje(usuario))
		}
	}

	def String mensaje(Usuario usuario) {
		"Creemos que podrías realizar la Rutina" + primeraQNoSigueYPuedeRealizar(usuario).nombre
	}

	def Rutina primeraQNoSigueYPuedeRealizar(Usuario usuario) {
		repositorioDeRutinas.elementos.findFirst[rutina|esSugerible(rutina, usuario)]
	}

	def boolean esSugerible(Rutina r, Usuario usuario) {
		!r.esSeguidaPor(usuario) && usuario.puedeRealizarRutina(r)
	}

	def hayRutinasSugerible(Usuario usuario) {
		primeraQNoSigueYPuedeRealizar(usuario) !== null
	}

}
