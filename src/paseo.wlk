
class Familia{
	var ninios = #{}
	method puedePasear()=ninios.all({ninio=>ninio.estaListoParaSalir()})
	method infaltables()=ninios.map({ninio=>ninio.mejorPrenda()}.prendas())
	method salirDePaseo(){
		if(self.puedePasear()){
			ninios.forEach({ninio=>ninio.desgastarRopa()})
		}
	}
	method chiquitos()= ninios.filter({ninio=>ninio.edad()>4})
}


class Ropa {

	var property comodidad = 0
	var property talle = null
	var desgaste = 0
	var abrigo = null

	method calcularComodidad() {
		if (desgaste > 3) {
			comodidad = comodidad - 3
		} else {
			comodidad = comodidad - desgaste
		}
	}
	method calidad()= comodidad + abrigo
	method darComodidadA(unNinio)

	method nivelDeAbrigo()
	method sufrirDesgaste()
}

class PrendasPares inherits Ropa {
	var izquierda= null
	var derecha = null


	override method calcularComodidad() {
	}

	override method nivelDeAbrigo() = derecha.abrigoDer() + izquierda.abrigoIzq()

	method intercambio(num) {
		derecha.cambiarValor(num)
	}

	method calcularNivelDeDesgaste() = (derecha.desgasteDer() + derecha.desgasteIzq()) / 2

	override method darComodidadA(unNinio) {
		if (unNinio.edad() < 4) {
			unNinio.decrementarComodidad(1)
		}
	}

	method intercambiarPares(unPar) {
		if (self.talle() == unPar.talle()) {
			unPar.intercambio(derecha.desgasteDer())
			self.intercambio(unPar.derecha().desgasteDer())
		}else{self.error("no es del mismo par")}
	}
	override method sufrirDesgaste(){
	derecha.desgastar()
	izquierda.desgastar()}
}


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
	method cantidadDePrendas()=prendas.count()== 5
	method estaListoParaSalir()= self.cantidadDePrendas() and prendas.any({prenda=>prenda.abrigo()>=3})and
	self.promedioDePrendas() > 8
	
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

