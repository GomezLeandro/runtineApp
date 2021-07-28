package objetos_de_dominio

import org.eclipse.xtend.lib.annotations.Accessors
import validaciones.ValidacionEjercicio
import validaciones.ValidacionEjercicioSimple
import validaciones.ValidacionEjerciciosConSeriesYRepeticiones

@Accessors
abstract class Ejercicio {

	Actividad actividad
	int minutosDeDescanso = 0
	int frecuenciaCardiacaBase = 0
	ValidacionEjercicio validacion

	new() {
	}

	def int calcularDuracion()

	def obtenerListaDeMusculos() {
		return actividad.getGrupos
	}

	def getNombre() {
		return actividad.nombre
	}

	def void asignarActividad(Actividad actividad) {
		this.actividad = actividad
	}

	def entrenaGrupoBasico() {
		return actividad.entrenaGrupoBasico()
	}

	def boolean validar() {
		validacion.validar(this)
	}
}

@Accessors
class EjercicioConSeriesYRepeticiones extends Ejercicio {
	int series = 0
	int repeticiones = 0

	new(int minutosDeDescanso, int series, int repeticiones, int frecuenciaCardiacaBase) {
		this.minutosDeDescanso = minutosDeDescanso
		this.series = series
		this.repeticiones = repeticiones
		this.frecuenciaCardiacaBase = frecuenciaCardiacaBase
		validacion = new ValidacionEjerciciosConSeriesYRepeticiones
	}

	new() {
	}

	override calcularDuracion() {
		return minutosDeDescanso * series * 2
	}

	def boolean validacionEjercicioConSeriesYRepeticiones() {
		validacion.validar(this)
	}
}

@Accessors
class EjercicioSimple extends Ejercicio {
	int minutosDeTrabajo = 0

	new(int minutosDeDescanso, int minutosDeTrabajo, int frecuenciaCardiacaBase) {
		this.minutosDeDescanso = minutosDeDescanso
		this.minutosDeTrabajo = minutosDeTrabajo
		this.frecuenciaCardiacaBase = frecuenciaCardiacaBase
		validacion = new ValidacionEjercicioSimple
	}

	new() {
	}

	override calcularDuracion() {
		return minutosDeDescanso + minutosDeTrabajo
	}

	def boolean validacionEjercicioSimple() {
		validacion.validar(this)
	}
}
