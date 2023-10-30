import conocimientos.*
import cumbre.*
import empresas.*

class Participante {
	const property nacionalidad
	const property conocimientos = #{}
	var commits
	const property registroDeActividades = #{}
	
	method commits() = commits
	
	method esCapo()
	
	method cumpleRequisitosDeAccesoALaCumbre(){
		return conocimientos.contains(programacionBasica)
	}
	
	method commits(valor){
		commits = commits + valor
	}
	
	method hacerUnaActividad(unaActividad){
		conocimientos.add(unaActividad.tema())
		self.commits(unaActividad.tema().commitsPorHora() * unaActividad.duracion())
		registroDeActividades.add(unaActividad)
	}

}


class Programador inherits Participante{
	
	override method esCapo() = commits > 500
	
	override method cumpleRequisitosDeAccesoALaCumbre(){
		return super() and commits > cumbre.cantidadMinimaDeCommits()
	}
}


class Especialista inherits Participante{
	
	override method esCapo() = conocimientos.size() > 2
	
	override method cumpleRequisitosDeAccesoALaCumbre(){
		return super() and commits > (cumbre.cantidadMinimaDeCommits() - 100) and self.sabeObjetos()
	}
	
	method sabeObjetos() = conocimientos.contains(objetos)

}


class Gerente inherits Participante{
	var empresa
	
	override method esCapo() = empresa.esMultinacional()
	
	override method cumpleRequisitosDeAccesoALaCumbre(){
		return super() and conocimientos.contains(manejoDeGrupos) 
	}
	
}

