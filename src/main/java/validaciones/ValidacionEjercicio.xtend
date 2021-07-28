package validaciones

import objetos_de_dominio.Ejercicio

abstract class ValidacionEjercicio {
	def boolean validacionNombreEjercicio(Ejercicio ejercicio) {
		!ejercicio.getNombre().isNullOrEmpty
	}

	def boolean validarMinutosDescanso(Ejercicio ejercicio) {
		ejercicio.minutosDeDescanso > 0
	}

	def boolean validarFrecuenciaCardiacaBase(Ejercicio ejercicio) {
		ejercicio.frecuenciaCardiacaBase > 0
	}

	def boolean validar(Ejercicio ejercicio) {
		validacionGeneral(ejercicio) && doValidar(ejercicio)
	}

	def abstract boolean doValidar(Ejercicio ejercicio)

	def boolean validacionGeneral(Ejercicio ejercicio) {
		validarFrecuenciaCardiacaBase(ejercicio) && validarMinutosDescanso(ejercicio) &&
			validacionNombreEjercicio(ejercicio)
	}

}
