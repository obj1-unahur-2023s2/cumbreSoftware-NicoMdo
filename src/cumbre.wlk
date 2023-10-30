import participantes.*
import paises.*
import conocimientos.*
import actividades.*

object cumbre {
	const property paisesAuspiciantes = #{}
	const property participantes = #{}
	var property cantidadMinimaDeCommits = 300
	var property registroDeActividades = #{}
	
	method tieneRestringidoElAcceso(unParticipante){
		return 	unParticipante.nacionalidad().esConflictivoParaLaCumbre() or self.hay2oMasExtranjerosDelMismoPais(unParticipante) 		 
	}
	
	method hay2oMasExtranjerosDelMismoPais(unParticipante) = self.cuantosExtranjerosDeLaMismaNacionalidadQue(unParticipante) >= 2
	
	method registrarIngreso(unParticipante){
		if(self.puedeIngresar(unParticipante)){
			participantes.add(unParticipante)
		}
		else{
			self.error("No cumple requisitos para ingreso")	
		}
	}
	
	method horasDeActividadesRealizadas() = registroDeActividades.sum({a=> a.duracion()})
	
	method puedeIngresar(unParticipante) = unParticipante.cumpleRequisitosDeAccesoALaCumbre() and not self.tieneRestringidoElAcceso(unParticipante)
	
	method agregarAuspiciantes(auspicipantes){paisesAuspiciantes.addAll(auspicipantes)}
	
	method paisesDeLosParticipantes() = participantes.map({p=> p.nacionalidad()}).asSet()
	
	method cantidadDeParticipantesDe(unPais) = participantes.count({p=> p.nacionalidad() == unPais})
	
	method paisConMasParticipantes() = self.paisesDeLosParticipantes().max({p=> self.cantidadDeParticipantesDe(p)})
	
	method esDePaisAuspiciante(unParticipante) = paisesAuspiciantes.contains(unParticipante.nacionalidad())
	
	method participantesExtranjeros() = participantes.filter({p =>not self.esDePaisAuspiciante(p)})
	
	method cuantosExtranjerosDeLaMismaNacionalidadQue(unParticipante) = self.participantesExtranjeros().count({p=> p.nacionalidad() == unParticipante.nacionalidad()})
	
	method esRelevante() = participantes.all({p=> p.esCapo()})
	
	method esSegura() = participantes.all({p=> self.puedeIngresar(p)})
	
}
