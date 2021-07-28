package objetos_de_dominio

import java.time.LocalDate

import static extension utilitarios.NumberUtils.*
import org.eclipse.xtend.lib.annotations.Accessors

interface Objetivo {

	def boolean cumpleConObjetivo(Usuario usuario, Rutina rutina)

}

@Accessors
class Tiempista implements Objetivo {
	int porcentaje = 50

	new() {
	}

	new(int valor) {
		this.porcentaje = valor
	}

	def calcularPorcentaje() {
		return porcentaje / 100.0
	}

	override boolean cumpleConObjetivo(Usuario usuario, Rutina rutina) {
		return usuario.entrenamientoConIgualDuracionOMasQueLaRutina(rutina) ||
			rutina.duracion >= calcularPorcentajeMinutosOptimos(usuario)
	}

	def calcularPorcentajeMinutosOptimos(Usuario usuario) {
		return usuario.minutosSemanalesOptimos * calcularPorcentaje
	}
}

class Negado implements Objetivo {
	override boolean cumpleConObjetivo(Usuario usuario, Rutina rutina) {
		return false
	}
}

class Conformista implements Objetivo {
	override boolean cumpleConObjetivo(Usuario usuario, Rutina rutina) {
		return rutina.gruposMusculares.forall [ grupoMuscular |
			usuario.gruposMuscularesDePreferencia.contains(grupoMuscular)
		]
	}
}

class Indeciso implements Objetivo {

	def Objetivo objetivoActual() {
		if (esDiaPar()) {
			new Conformista
		} else {
			new Negado
		}
	}

	override boolean cumpleConObjetivo(Usuario usuario, Rutina rutina) {
		return objetivoActual.cumpleConObjetivo(usuario, rutina)
	}

	def esDiaPar() {
		return LocalDate.now.dayOfMonth % 2 == 0
	}

}

class Atleta implements Objetivo {
	override boolean cumpleConObjetivo(Usuario usuario, Rutina rutina) {
		return rutina.frecuenciaCardiacaAlcanzadaPor(usuario).between(min(rutina, usuario), max(rutina, usuario))
	}

	protected def double max(Rutina rutina, Usuario usuario) {
		rutina.frecuenciaCardiacaAlcanzadaPor(usuario) + porcentajeFrecuenciaCardiacaAlcanzada(rutina, usuario)
	}

	protected def double min(Rutina rutina, Usuario usuario) {
		rutina.frecuenciaCardiacaAlcanzadaPor(usuario) - porcentajeFrecuenciaCardiacaAlcanzada(rutina, usuario)
	}

	def double porcentajeFrecuenciaCardiacaAlcanzada(Rutina rutina, Usuario usuario) {
		return rutina.frecuenciaCardiacaAlcanzadaPor(usuario) * 0.1
	}

}
