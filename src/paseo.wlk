//NOTA 2(DOS)
//test no andan ninguno
//1) MAL. Mala estrategia basada en precalculo. 
// Mal uso de la herencia en prenda par/impar. 
// No cumple requerimiento. Mal uso de properties. 
//2) REGULAR- . Bien que usa errores, pero graves conceptos de referencias en la implementación.
//3) MAL. Confunde orden con pregunta. No maneja prolijamente los elementos de las prendasPares. 
//Prenda Pesada no entiende el mensaje y la Liviana tiene una orden en lugar de una pregunta. 
//Ademas no se puede cambiar en un único lugar el nivel de la liviana 
//4) REGULAR: Bien la estrategia, pero se marea con la cantidad de prendas
//5) REGULAR: La idea de heredar está bien, pero tiene problemas con el cambio de 4 por el 5 en la cantidad de juguetes (duplica codigo y no anda)
//6) REGULAR+: No se entiende por qué quiere mandar el mensaje prendas a la coleccion de prendas...
//7) Bin: Problema de responsabilidad para saber si un niño es pequeño



class Familia{
	var ninios = #{}
	method puedePasear()=ninios.all({ninio=>ninio.estaListoParaSalir()})
	//TODO: El map devuelve una colección, no entiende el mensaje prendas
	method infaltables()=ninios.map({ninio=>ninio.mejorPrenda()}.prendas())
	method salirDePaseo(){
		if(self.puedePasear()){
			ninios.forEach({ninio=>ninio.desgastarRopa()})
		}
	}
	//TODO: PEqueña duplicación de código ninio.edad() > 4 se usa en la comodidad del ninio
	method chiquitos()= ninios.filter({ninio=>ninio.edad()>4})
}


class Ropa {

	//TODO: evitar la property si se trata de un calculo: hacer directamente el metodo
	//No se necesita el metodo comodida(value)
	var property comodidad = 0
	var property talle = null
	var desgaste = 0
	//Todo: No todas las ropas necesitan esta variable.
	var abrigo = null

	//TODO: LA comodidad es un cálculo, entonces
	//no debe ser un atributo: tiene que ser 
	//una pregunta!
	//Además, cuando se envia este mensaje?? 
	//MUY MALA ESTRATEGIA
	method calcularComodidad() {
		if (desgaste > 3) {
			comodidad = comodidad - 3
		} else {
			comodidad = comodidad - desgaste
		}
	}
	method calidad()= comodidad + abrigo
	//TODO: Cuando se usa?
	method darComodidadA(unNinio)

	method nivelDeAbrigo()
	method sufrirDesgaste()
}

class PrendasPares inherits Ropa {
	var izquierda= null
	var derecha = null


	override method calcularComodidad() {
		//TODO por que sobrescribe??
	}

	//Por que es un mensaje distinto para cada prenda??
	override method nivelDeAbrigo() = derecha.abrigoDer() + izquierda.abrigoIzq()

	method intercambio(num) {
		derecha.cambiarValor(num)
	}


	method calcularNivelDeDesgaste() = (derecha.desgasteDer() + derecha.desgasteIzq()) / 2

	//La comodidad de un niño se deba calcular
	override method darComodidadA(unNinio) {
		if (unNinio.edad() < 4) {
			unNinio.decrementarComodidad(1)
		}
	}

	method intercambiarPares(unPar) {
		if (self.talle() == unPar.talle()) {
			//TODO: NO! lo que hay que intercambiar son izquierdo y derecho, no solo los valores internos 
			//de sus atributos. Porque si alguien estaba referenciando a la media izquierda de zoe, de repente
			//se le cambia el valor de desgaste de ese objeto!
			unPar.intercambio(derecha.desgasteDer())
			self.intercambio(unPar.derecha().desgasteDer())
		}else{self.error("no es del mismo par")} 
	}
	override method sufrirDesgaste(){
	derecha.desgastar()
	izquierda.desgastar()}
}


//TODO Mal uso de la herencia ¿Qué es lo que te interesa heredad?
class PrendaDerecha inherits PrendasPares {
	var property desgasteDer= 0
	var property abrigoDer = 1
	method desgastar(){
		desgasteDer =desgasteDer+ 1.20
	 	//desgasteIzq = desgasteDer+0.8
	}
	method cambiarValor(num){
		desgasteDer= num
	}
	
} 
class PrendaIzquierda inherits PrendasPares {
	var property desgasteIzq= 0
	var property abrigoIzq = 1
	method desgastar(){
		desgasteIzq = desgasteIzq+0.8
	}
}




class PrendaPesada inherits Ropa {
	//TODO no entiende el mensaje nivel de abrigo:
	
	override method sufrirDesgaste(){
		desgaste++
	}
	override method nivelDeAbrigo() {
		abrigo = 3
	}
	override method darComodidadA(unNinio){
		unNinio.incrementarComodidad(0)
	}
}

class PrendaLiviana inherits PrendaPesada {

	override method nivelDeAbrigo() {
		//TODO Esto tiene que ser una pregunta pero esta implementado como una orden!
		abrigo = 1
	}
	method cambiarNiveldeAbrigo(num){
		abrigo = num
	}
	override method darComodidadA(unNinio){
		unNinio.incrementarComodidad(2)
	}
}

class Ninio {

	var nivelDeComodidad = 0
	var talle = null
	var property edad = 0
	var prendas= #{}

	method coincideTalle(unaPrenda) {
		if (talle == unaPrenda.talle()) {
			nivelDeComodidad = nivelDeComodidad + 8
		} else {
			nivelDeComodidad = nivelDeComodidad + 0
		}
	}

	method darComodidad(unaPrenda) {
		unaPrenda.darComodidadA(self)
	}

	method decrementarComodidad(num) {
		nivelDeComodidad = nivelDeComodidad - num
	}

	method incrementarComodidad(num) {
		nivelDeComodidad = nivelDeComodidad + num
	}
	//TODO: Tiene que tener como minimo 5: prendas.size() >= 5
	method cantidadDePrendas()=prendas.count()== 5
	method estaListoParaSalir()= self.cantidadDePrendas() and prendas.any({prenda=>prenda.abrigo()>=3})and
	self.promedioDePrendas() > 8
	
	//TODO: cantidadDePrendas está devolviendo un booleano, y vos necesitás un número.
	method promedioDePrendas()= prendas.sum({prenda=>prenda.calidada()}) / self.cantidadDePrendas() 
	method desgastarRopa(){
		prendas.forEach({prenda=>prenda.sufrirDesgaste()})
	}
	method mejorPrenda()= prendas.max({prenda=>prenda.calidad()})

}
class NinioNoProblematico inherits Ninio{
	override method estaListoParaSalir()= super() and self.cantidadDePrendas()==5
}

class NinioProblematico inherits Ninio{
	var juguete= null
	//TODO: poder sobreescribir el 4. El super puede fallar porque exige 5 prendas.
	override method estaListoParaSalir()= super() and self.cantidadDePrendas()==4 and self.esAcorde() 
	method esAcorde()= juguete.edadMin()> self.edad() and juguete.edadMax()< self.edad()
}


class Juguete{
	var property edadMin=null
	var property edadMax=null
}

//Objetos usados para los talles
object xs {

}

object s {

}

object m {

}

object l {

}

object xl {

}

