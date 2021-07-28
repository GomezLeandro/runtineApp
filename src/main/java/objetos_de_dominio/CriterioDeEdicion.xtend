package objetos_de_dominio

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

interface CriterioDeEdicion {
	def boolean esEditablePor(Rutina rutina, Usuario usuario)
}

class Amistoso implements CriterioDeEdicion {
	override esEditablePor(Rutina rutina, Usuario usuario) {
		rutina.esAmigoDelCreador(usuario)
	}
}

class Social implements CriterioDeEdicion {
	override esEditablePor(Rutina rutina, Usuario usuario) {
		rutina.esSeguidaPor(usuario)
	}
}

class Responsable implements CriterioDeEdicion {
	override esEditablePor(Rutina rutina, Usuario usuario) {
		return (usuario.seTomaLasCosasEnSerio() && usuario.esMayorDeEdad)
	}
}

class Free implements CriterioDeEdicion {
	override esEditablePor(Rutina rutina, Usuario usuario) {
		return true
	}
}

class Fortuito implements CriterioDeEdicion {

	List<String> listaControl = #["F", "f", "j", "J", "R", "r"]

	override esEditablePor(Rutina rutina, Usuario usuario) {
		return (rutina.nombre.length() > 6 || (listaControl.contains(usuario.primeraLetra.toString)))
	}
}

@Accessors
class CriterioMultiple implements CriterioDeEdicion {

	List<CriterioDeEdicion> criterios = newArrayList

	override esEditablePor(Rutina rutina, Usuario usuario) {
		return criterios.forall[criterio|criterio.esEditablePor(rutina, usuario)]
	}
}
