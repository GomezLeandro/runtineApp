package validaciones

interface Validador<Elemento> {

	def boolean esValido(Elemento elemento)

	def void validar(Elemento elemento)

}
