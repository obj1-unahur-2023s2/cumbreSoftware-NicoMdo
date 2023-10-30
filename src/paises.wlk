import cumbre.*

class Pais {
	const property paisesEnConflicto = #{}
	
	method registrarConflicto(unPais){
		paisesEnConflicto.add(unPais)
	}
	
	method esConflictivo(unPais){
		return paisesEnConflicto.contains(unPais)
	}
	
	method esConflictivoParaLaCumbre(){
		return cumbre.paisesAuspiciantes().any({p=> self.esConflictivo(p)})
	}
	
}
