package validaciones

import java.time.LocalDate
import objetos_de_dominio.Usuario
import static extension utilitarios.NumberUtils.*
import exception.UsuarioIncorrectoException

class ValidacionUsuario implements Validador<Usuario> {
	def boolean validacionDatosPersonales(Usuario usuario) {
		nombreUsuarioNoEsNulo(usuario) && apellidoUsuarioNoEsNulo(usuario) && usernameConMasDe4Caracteres(usuario) &&
			fechaNacimientoConDiaAnteriorAHoy(usuario) && frecuenciaCardiacaReposoEntre60y100(usuario) &&
			porcentajeIntensidadEntre0Y100(usuario)
	}

	def boolean porcentajeIntensidadEntre0Y100(Usuario usuario) {
		usuario.porcentajeDeIntensidad.between(0, 100)
	}

	def boolean frecuenciaCardiacaReposoEntre60y100(Usuario usuario) {
		usuario.frecuenciaCardiacaEnReposo.between(60, 100)
	}

	def boolean fechaNacimientoConDiaAnteriorAHoy(Usuario usuario) {
		usuario.fechaDeNacimiento < LocalDate.now()
	}

	def boolean usernameConMasDe4Caracteres(Usuario usuario) {
		usuario.username.length > 4
	}

	def boolean apellidoUsuarioNoEsNulo(Usuario usuario) {
		!usuario.getApellido.isNullOrEmpty
	}

	def boolean nombreUsuarioNoEsNulo(Usuario usuario) {
		!usuario.getNombre.isNullOrEmpty
	}

	def boolean usuarioConAlMenos1DiaDeEntrenamiento(Usuario usuario) {
		usuario.mapaDias.size() > 0
	}

	def boolean validarUsuario(Usuario usuario) {
		validacionDatosPersonales(usuario) && usuarioConAlMenos1DiaDeEntrenamiento(usuario)
	}

	def void validarNombreUsuario(Usuario usuario) {
		if (!nombreUsuarioNoEsNulo(usuario)) {
			throw new UsuarioIncorrectoException("el nombre es nulo")
		}
	}

	def void validarApellidoUsuario(Usuario usuario) {
		if (!apellidoUsuarioNoEsNulo(usuario)) {
			throw new UsuarioIncorrectoException("el apellido es nulo")
		}
	}

	def void validarUsername(Usuario usuario) {
		if (!usernameConMasDe4Caracteres(usuario)) {
			throw new UsuarioIncorrectoException("el username tiene menos de 4 caracteres")
		}
	}

	def void validarDiasEntrenamiento(Usuario usuario) {
		if (!usuarioConAlMenos1DiaDeEntrenamiento(usuario)) {
			throw new UsuarioIncorrectoException("el usuario no tiene días de entrenamiento")
		}
	}

	def void validarFechaDeNacimiento(Usuario usuario) {
		if (!fechaNacimientoConDiaAnteriorAHoy(usuario)) {
			throw new UsuarioIncorrectoException("la fecha de nacimiento es incorrecta")
		}
	}

	def void validarFrecuenciaReposo(Usuario usuario) {
		if (!frecuenciaCardiacaReposoEntre60y100(usuario)) {
			throw new UsuarioIncorrectoException("la frecuencia en reposo es incorrecta. Tiene que ser entre 60 y 100")
		}
	}

	def void validarPorcentajeDeIntensidad(Usuario usuario) {
		if (!porcentajeIntensidadEntre0Y100(usuario)) {
			throw new UsuarioIncorrectoException(
				"el porcentaje de intensidad es incorrecto. Tiene que ser entre 0 y 100")
		}
	}

	override validar(Usuario usuario) {
		validarNombreUsuario(usuario)
		validarApellidoUsuario(usuario)
		validarUsername(usuario)
		validarFechaDeNacimiento(usuario)
		validarDiasEntrenamiento(usuario)
		validarFrecuenciaReposo(usuario)
		validarPorcentajeDeIntensidad(usuario)
	}

	override esValido(Usuario usuario) {
		validacionDatosPersonales(usuario) && usuarioConAlMenos1DiaDeEntrenamiento(usuario)
	}

}
