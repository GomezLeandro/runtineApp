package validaciones

import objetos_de_dominio.Ejercicio
import objetos_de_dominio.EjercicioSimple

class ValidacionEjercicioSimple extends ValidacionEjercicio {

	def boolean validacionAtributosEjercicio(EjercicioSimple ejercicio) {
		validacionGeneral(ejercicio) && doValidar(ejercicio)
	}

	def boolean validarMinutosTrabajo(EjercicioSimple ejercicio) {
		ejercicio.minutosDeTrabajo > 0
	}

	def boolean validacionEjercicioSimple(EjercicioSimple ejercicio) {
		validacionAtributosEjercicio(ejercicio)
	}

	override boolean doValidar(Ejercicio ejercicio) {
		val ejercicioSimple = ejercicio as EjercicioSimple
		validarMinutosTrabajo(ejercicioSimple)

	}

}
