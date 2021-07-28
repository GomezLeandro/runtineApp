package service

import com.fasterxml.jackson.core.type.TypeReference
import com.fasterxml.jackson.databind.ObjectMapper
import java.util.List
import objetos_de_dominio.Actividad
import org.eclipse.xtend.lib.annotations.Accessors
import utilitarios.Repositorio

@Accessors
class ActualizadorDeActividades {
	ServiceActividades service
	Repositorio<Actividad> repositorio

	new(ServiceActividades service) {
		this.service = service
	}

	// Esto lo utilizo para trasformar el json que viene a una lista
	def List<Actividad> jsonToActividad(String json) {
		val objectMapper = new ObjectMapper()
		val List<Actividad> lista = objectMapper.readValue(json, new TypeReference<List<Actividad>>() {
		})
		return lista
	}

	def void createOrUpdate(Actividad actividad) {
		if (actividad.esNuevo()) {
			repositorio.create(actividad)
		} else {
			repositorio.update(actividad)
		}
	}

	def void actualizarActividades() {
		val json = service.getActividades()
		jsonToActividad(json).forEach[actividad|createOrUpdate(actividad)]
	}

}
