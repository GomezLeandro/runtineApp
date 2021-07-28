package utilitarios

class NumberUtils {

	static def between(double numero, double desde, double hasta) {
		numero >= desde && numero <= hasta
	}
}
