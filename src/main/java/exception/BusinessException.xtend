package exception

import java.lang.RuntimeException

class BusinessException extends RuntimeException {
	new(String mensaje) {
		super(mensaje)
	}
}

class UsuarioIncorrectoException extends RuntimeException {
	new(String mensaje) {
		super("El usuario es incorrecto porque: " + mensaje)
	}
}

class RutinaIncorrectaException extends RuntimeException {
	new(String mensaje) {
		super("La rutina es incorrecta porque: " + mensaje)
	}
}

class ActividadIncorrectaException extends RuntimeException {
	new(String mensaje) {
		super("La actividad es incorrecta porque: " + mensaje)
	}
}

class NoNuevoException extends RuntimeException {
	new() {
		super("el elemento no es nuevo")
	}
}

class ExisteException extends RuntimeException {
	new() {
		super("el elemento no existe")
	}
}
