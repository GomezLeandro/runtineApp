package objetos_de_dominio

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import validaciones.ValidacionRutina

import static extension utilitarios.NumberUtils.*

@Accessors
class Rutina extends Entidad {

	String nombre
	String descripcion
	Usuario creador
	CriterioDeEdicion criterioDeEdicion = new Amistoso
	List<Ejercicio> listaDeEjercicios = newArrayList
	List<Usuario> listaSeguidores = newArrayList
	List<AccionesObserver> accionesObservers = newArrayList

	new(String nombre, String descripcion) {
		this.nombre = nombre
		this.descripcion = descripcion
		validacion = new ValidacionRutina
	}

	new() {
		validacion = new ValidacionRutina
	}

	def void agregarAcciones(AccionesObserver accion) {
		accionesObservers.add(accion)
	}

	def agregarSeguidor(Usuario usuario) {
		listaSeguidores.add(usuario)
		validacionObservers(usuario)
	}

	def void validacionObservers(Usuario usuario) {
		if (accionesObservers !== null) {
			accionesObservers.forEach[seguidorAgregado(this, usuario)]
		}
	}

	def esSeguidaPor(Usuario usuario) {
		listaSeguidores.contains(usuario)
	}

	def puedeSerEditadoPor(Rutina rutina, Usuario usuario) {
		return criterioDeEdicion.esEditablePor(this, usuario) || esCreador(usuario)
	}

	def esCreador(Usuario usuario) {
		return usuario.equals(creador)
	}

	def gruposMusculares() {
		return listaDeEjercicios.flatMap[obtenerListaDeMusculos()].toList
	}

	def void agregarEjercicio(Ejercicio ejercicio) {
		listaDeEjercicios.add(ejercicio)
	}

	def int duracion() {
		listaDeEjercicios.fold(0, [acumulado, ejercicio|acumulado + ejercicio.calcularDuracion])
	}

	def int SumatoriaFrecuenciasCardiacasBase() {
		listaDeEjercicios.fold(0, [acumulado, ejercicio|acumulado + ejercicio.frecuenciaCardiacaBase])
	}

	def int tamanioListaDeEjercicios() {
		listaDeEjercicios.length()
	}

	def float frecuenciaCardiacaBase() {
		return (SumatoriaFrecuenciasCardiacasBase() / tamanioListaDeEjercicios)
	}

	def double frecuenciaCardiacaAlcanzadaPor(Usuario usuario) {
		return (frecuenciaCardiacaBase() + usuario.frecuenciaDeReserva()) / 2
	}

	def entrenaGrupoBasico(Usuario usuario) {
		return (listaDeEjercicios.forall[ejercicio|ejercicio.entrenaGrupoBasico()])
	}

	def esCompletaPara(Usuario usuario) {
		return entrenaGrupoBasico(usuario) || usuario.estaConformeCon(this)
	}

	def esSaludablePara(Usuario usuario) {
		frecuenciaCardiacaAlcanzadaPor(usuario).between(usuario.frecuenciaDeReserva, usuario.frecuenciaCardiacaMaxima)
	}

	def boolean esAmigoDelCreador(Usuario usuario) {
		creador.esAmigoDe(usuario)
	}

	override coincide(String valor) {
		nombre.contains(valor) || contieneNombreDeEjercicio(valor) || descripcion.contains(valor)
	}

	def boolean contieneNombreDeEjercicio(String valor) {
		listaDeEjercicios.exists[ejercicio|ejercicio.getNombre.contains(valor)]
	}

	def String correoCreador() {
		creador.correo
	}
}
