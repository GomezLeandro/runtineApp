package validaciones

import objetos_de_dominio.Rutina
import exception.RutinaIncorrectaException

class ValidacionRutina implements Validador<Rutina> {
	def boolean validacionNombreYDescripcionRutina(Rutina rutina) {
		nombreRutinaNoEsNulo(rutina) && descripcionRutinaNoEsNula(rutina)
	}

	def boolean descripcionRutinaNoEsNula(Rutina rutina) {
		!rutina.descripcion.isNullOrEmpty
	}

	def boolean nombreRutinaNoEsNulo(Rutina rutina) {
		!rutina.nombre.isNullOrEmpty
	}

	def boolean creadorNoEsNulo(Rutina rutina) {
		rutina.creador !== null
	}

	def boolean listaDeEjerciciosContieneElementos(Rutina rutina) {
		rutina.tamanioListaDeEjercicios() > 0
	}

	def boolean validacionRutina(Rutina rutina) {
		listaDeEjerciciosContieneElementos(rutina) && creadorNoEsNulo(rutina) &&
			validacionNombreYDescripcionRutina(rutina)
	}

	def void validarNombreRutina(Rutina rutina) {
		if (!nombreRutinaNoEsNulo(rutina)) {
			throw new RutinaIncorrectaException("el nombre es nulo")
		}
	}

	def void validarDescripcionRutina(Rutina rutina) {
		if (!descripcionRutinaNoEsNula(rutina)) {
			throw new RutinaIncorrectaException("la descripción es nula")
		}
	}

	def void validarCreadorDeLaRutina(Rutina rutina) {
		if (!creadorNoEsNulo(rutina)) {
			throw new RutinaIncorrectaException("el creador es nulo")
		}
	}

	def void validarListaDeEjercicios(Rutina rutina) {
		if (!listaDeEjerciciosContieneElementos(rutina)) {
			throw new RutinaIncorrectaException("la lista de ejercicios está vacía")
		}
	}

	override validar(Rutina rutina) {
		validarNombreRutina(rutina)
		validarDescripcionRutina(rutina)
		validarCreadorDeLaRutina(rutina)
		validarListaDeEjercicios(rutina)
	}

	override esValido(Rutina rutina) {
		listaDeEjerciciosContieneElementos(rutina) && creadorNoEsNulo(rutina) &&
			validacionNombreYDescripcionRutina(rutina)
	}

}
