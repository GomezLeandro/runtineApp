package validaciones

import objetos_de_dominio.Ejercicio
import objetos_de_dominio.EjercicioConSeriesYRepeticiones

class ValidacionEjerciciosConSeriesYRepeticiones extends ValidacionEjercicio {

	def boolean validacionAtributosEjercicio(EjercicioConSeriesYRepeticiones ejercicio) {

		validacionGeneral(ejercicio) && doValidar(ejercicio)
	}

	def boolean validarRepeticiones(EjercicioConSeriesYRepeticiones ejercicio) {
		ejercicio.repeticiones > 0
	}

	def boolean validarSeries(EjercicioConSeriesYRepeticiones ejercicio) {
		ejercicio.series > 0
	}

	def boolean validacionEjercicioConSeriesYRepeticiones(EjercicioConSeriesYRepeticiones ejercicio) {
		validacionAtributosEjercicio(ejercicio)
	}

	override boolean doValidar(Ejercicio ejercicio) {
		val ejercicioConSeries = ejercicio as EjercicioConSeriesYRepeticiones
		validarSeries(ejercicioConSeries) && validarRepeticiones(ejercicioConSeries)
	}
}
