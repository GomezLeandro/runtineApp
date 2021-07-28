package validaciones

import objetos_de_dominio.Actividad
import exception.ActividadIncorrectaException

class ValidacionActividad implements Validador<Actividad> {
	def boolean nombreActividadNoEsNulo(Actividad actividad) {
		!actividad.getNombre.isNullOrEmpty
	}

	def boolean listaDeGrupoMuscularContieneElementos(Actividad actividad) {
		actividad.cantidadGposEntrenados() >= 1
	}

	def boolean validacionActividad(Actividad actividad) {
		nombreActividadNoEsNulo(actividad) && listaDeGrupoMuscularContieneElementos(actividad)
	}

	def void validarNombreActividad(Actividad actividad) {
		if (!nombreActividadNoEsNulo(actividad)) {
			throw new ActividadIncorrectaException("el nombre es nulo")
		}
	}

	def void validarListaDeGruposMusculares(Actividad actividad) {
		if (!listaDeGrupoMuscularContieneElementos(actividad)) {
			throw new ActividadIncorrectaException("la lista de grupos musculares está vacía")
		}
	}

	override validar(Actividad actividad) {
		validarNombreActividad(actividad)
		validarListaDeGruposMusculares(actividad)
	}

	override esValido(Actividad actividad) {
		nombreActividadNoEsNulo(actividad) && listaDeGrupoMuscularContieneElementos(actividad)
	}

}
