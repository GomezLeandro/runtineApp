package objetos_de_dominio

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import validaciones.ValidacionActividad

@Accessors
class Actividad extends Entidad {

	String nombre
	List<GrupoMuscular> grupos = newArrayList
	static List<GrupoMuscular> GRUPO_BASICO = #[GrupoMuscular.PIERNAS, GrupoMuscular.BRAZOS, GrupoMuscular.ABDOMEN]

	def boolean listaEstaVacia() {
		return grupos.empty
	}

	def entrenaGrupoBasico() {
		return grupos.containsAll(GRUPO_BASICO)
	}

	def cantidadGposEntrenados() {
		return grupos.size()
	}

	new() {
		validacion = new ValidacionActividad()
	}

	override coincide(String valor) {
		nombre.equals(valor)
	}
}

enum GrupoMuscular {
	PIERNAS,
	HOMBROS,
	BRAZOS,
	PECHO,
	ESPALDA,
	GLUTEOS,
	ABDOMEN
}
