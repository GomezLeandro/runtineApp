package objetos_de_dominio

import org.eclipse.xtend.lib.annotations.Accessors
import validaciones.Validador

@Accessors
abstract class Entidad {
	Validador validacion

	int id = 0

	def boolean esNuevo() {
		this.id == 0
	}

	def boolean validacion() {
		validacion.esValido(this)
	}

	def void validacionExcepcion() {
		validacion.validar(this)
	}

	def boolean coincide(String valor)

}
