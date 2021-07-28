package stub

import objetos_de_dominio.Actividad
import objetos_de_dominio.GrupoMuscular
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test
import service.ActualizadorDeActividades
import utilitarios.Repositorio

import static org.junit.jupiter.api.Assertions.*

@DisplayName("Dado un Json")
class TestStubService {

	ActualizadorDeActividades actualizador
	StubService service
	Actividad actividad
	Repositorio<Actividad> repo = new Repositorio<Actividad>

	@BeforeEach
	def void init() {

		service = new StubService
		actividad = new Actividad => [
			nombre = "Correr"
			grupos.add(GrupoMuscular.ABDOMEN)
		]
		repo.create(actividad)
		actualizador = new ActualizadorDeActividades(service) => [
			repositorio = repo
		]

	}

	@DisplayName("se actualiza una actividad y se agrega otra nueva")
	@Test
	def void reciboBienElJson() {
		actualizador.actualizarActividades()
		assertEquals(2, actualizador.repositorio.tamanioListaDelRepositorio)

	}

}
