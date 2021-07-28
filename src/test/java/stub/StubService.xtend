package stub

import service.ServiceActividades

class StubService implements ServiceActividades {
	override getActividades() {
		'''[
		    {
		        "id": 1,
		        "nombre": "Correr",
		        "grupos": ["ESPALDA","GLUTEOS","PIERNAS"]
		    },
		    {
		        "nombre": "Flexión De Brazos",
		        "grupos": ["BRAZOS","ESPALDA","PECHO"]
		     }
		]
	'''
	}
}
