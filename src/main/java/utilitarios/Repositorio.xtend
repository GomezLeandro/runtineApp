package utilitarios

import exception.ExisteException
import exception.NoNuevoException
import java.util.List
import objetos_de_dominio.Entidad
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Repositorio<T extends Entidad> {

	List<T> elementos = newArrayList()
	int identificador = 1

	// funcion crear (valida y agrega un elemento)
	def create(T elemento) {
		validarCreate(elemento)
		agregarElemento(elemento)
	}

	def void agregarElemento(T elemento) {
		elemento.id = identificador++
		elementos.add(elemento)
	}

	def void validarCreate(T elemento) {
		validarNuevo(elemento)
		validarElemento(elemento)
	}

	def boolean validarElemento(T elemento) {
		elemento.validacion()
	}

	def validarNuevo(T elemento) {
		if (!elemento.esNuevo()) {
			throw new NoNuevoException()
		}
	}

	// Funcion delete (valida y borra un elemento de existir)
	def delete(T elemento) {
		validarExiste(elemento)
		elementos.remove(elemento)
	}

	def validarExiste(T elemento) {
		noExisteElemento(elemento.id)
	}

	def noExisteElemento(int identificador) {
		if (!existeElemento(identificador)) {
			throw new ExisteException()
		}
	}

	def boolean existeElemento(int identificador) {
		elementos.exists[it.id == identificador]
	}

	// metodo update (valida y actualiza)
	def update(T elementoModificado) {
		validarUpdate(elementoModificado)
		val elementoAModificar = this.getById(elementoModificado.id)
		reemplazarElemento(elementoAModificar, elementoModificado)
	}

	def void reemplazarElemento(T elementoAModificar, T elementoModificado) {
		val index = elementos.indexOf(elementoAModificar)
		elementos.remove(elementoAModificar)
		elementos.add(index, elementoModificado)
	}

	def boolean validarUpdate(T elementoModificado) {
		validarExiste(elementoModificado)
		validarElemento(elementoModificado)
	}

	def T getById(int identificador) {
		validarGetById(identificador)
		elementos.findFirst[it.id == identificador]
	}

	def validarGetById(int identificador) {
		noExisteElemento(identificador)
	}

	def List<T> search(String valor) {
		elementos.filter[elemento|elemento.coincide(valor)].toList
	}

	def boolean existeElemento(T elemento) {
		elementos.contains(elemento)
	}

	def int tamanioListaDelRepositorio() {
		return elementos.size
	}

}
