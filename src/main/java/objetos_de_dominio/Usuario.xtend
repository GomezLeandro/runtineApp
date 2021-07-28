package objetos_de_dominio

import java.time.DayOfWeek
import java.time.LocalDate
import java.time.Period
import java.util.HashMap
import java.util.List
import java.util.Map
import org.eclipse.xtend.lib.annotations.Accessors
import utilitarios.Notificacion
import validaciones.ValidacionUsuario

@Accessors
class Usuario extends Entidad {

	double frecuenciaCardiacaEnReposo
	String nombre
	String apellido
	String username
	String correo
	LocalDate fechaDeNacimiento
	double porcentajeDeIntensidad
	Objetivo objetivo
	Map<DayOfWeek, Integer> mapaDias = new HashMap<DayOfWeek, Integer>()
	List<GrupoMuscular> gruposMuscularesDePreferencia = newArrayList
	List<Usuario> listaDeAmigos = newArrayList
	List<Notificacion> notificaciones = newArrayList
	List<Rutina> rutinasCreadas = newArrayList

	new(String nombre, String Apellido, String username, LocalDate fechaDeNacimiento, int porcentajeDeIntensidad) {
		this.nombre = nombre
		this.apellido = apellido
		this.username = username
		this.fechaDeNacimiento = fechaDeNacimiento
		this.porcentajeDeIntensidad = porcentajeDeIntensidad
		validacion = new ValidacionUsuario
	}

	new() {
		validacion = new ValidacionUsuario
	}

	def primeraLetra() {
		return username.charAt(0)
	}

	def tieneFrecuenciaCardiacaEnReposo() {
		val limite_inferior = 60
		val limite_superior = 100
		return (limite_inferior < frecuenciaCardiacaEnReposo && frecuenciaCardiacaEnReposo < limite_superior)
	}

	def int getEdad() {
		Period.between(fechaDeNacimiento, LocalDate.now).years
	}

	def double frecuenciaCardiacaMaxima() {
		return 220 - this.edad
	}

	def double frecuenciaDeReserva() {
		return frecuenciaCardiacaMaxima - frecuenciaCardiacaEnReposo
	}

	def asignarDiasYMinutos(DayOfWeek dia, int minutos) {
		mapaDias.put(dia, minutos)
	}

	def int minutosSemanalesDeEntrenamiento() {
		mapaDias.values.fold(0, [acumulado, minutos|acumulado + minutos])
	}

	def int minutosSemanalesOptimos() {
		val minutos_optimos_mayor_de_edad = 300
		val minutos_optimos_menor_de_edad = 420
		if (esMayorDeEdad) {
			return minutos_optimos_mayor_de_edad
		} else {
			return minutos_optimos_menor_de_edad
		}
	}

	def boolean esMayorDeEdad() {
		return getEdad > 18
	}

	def boolean esVigoroso() {
		val porcentaje_establecido = 70
		return porcentajeDeIntensidad >= porcentaje_establecido
	}

	def boolean seTomaLasCosasEnSerio() {
		return minutosSemanalesDeEntrenamiento > minutosSemanalesOptimos || (entrenaTodaLaSemana && esVigoroso)
	}

	def boolean entrenaTodaLaSemana() {
		return obtenerListaDeMinutos.size == 7
	}

	def frecuenciaCardiacaDeEntrenamiento() {
		return frecuenciaDeReserva * porcentajeDeIntensidad + frecuenciaCardiacaEnReposo
	}

	def agregarGrupoMuscularDePreferencia(GrupoMuscular grupoMuscular) {
		gruposMuscularesDePreferencia.add(grupoMuscular)
	}

	def obtenerListaDeGruposMuscularesDePreferencia() {
		return gruposMuscularesDePreferencia
	}

	def obtenerListaDeMinutos() {
		return mapaDias.values
	}

	def entrenamientoConIgualDuracionOMasQueLaRutina(Rutina rutina) {
		return obtenerListaDeMinutos.exists[minutos|minutos >= rutina.duracion]
	}

	def boolean estaConformeCon(Rutina rutina) {
		return objetivo.cumpleConObjetivo(this, rutina)
	}

	def int tamanioListaAmigos() {
		listaDeAmigos.size
	}

	def void agregarAmigo(Usuario usuario) {
		listaDeAmigos.add(usuario)
	}

	def void eliminarAmigo(Usuario usuario) {
		listaDeAmigos.remove(usuario)
	}

	def esAmigoDe(Usuario usuario) {
		listaDeAmigos.contains(usuario)
	}

	def puedeRealizarRutina(Rutina rutina) {
		return rutina.esCompletaPara(this) && rutina.esSaludablePara(this)
	}

	override coincide(String valor) {
		nombre.contains(valor) || apellido.contains(valor) || username.equals(valor)
	}

	def boolean noTieneAmigos() {
		listaDeAmigos.empty
	}

	def boolean noTieneRutinasCreadas() {
		rutinasCreadas.empty
	}

	def leerNotificacion(Notificacion notificacion) {
		if (notificaciones.contains(notificacion)) {
			notificacion.cambiarEstadoNotificacion
		}
	}
	
	def void eliminarNotificaciones(List<Notificacion> notificaciones) {
		this.notificaciones.removeAll(notificaciones)
	}

}
