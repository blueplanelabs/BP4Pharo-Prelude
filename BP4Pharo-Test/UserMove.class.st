Class {
	#name : #UserMove,
	#superclass : #BP4PEnvironmentScenario,
	#category : #'BP4Pharo-Test-TicTacToe-Core'
}

{ #category : #initialize }
UserMove >> run: aBP4PProgram [
	"Handle ClickEvent."

	| click xmove newScenario|
	click := BP4PEventsOfClass class: ClickEvent.
	aBP4PProgram syncRequested: none waited: click blocked: none.
	"Add a new scenario like this to wait again a new ClickEvent. PRECHART"
	newScenario := self class
		instance.
	aBP4PProgram
		addScenario: newScenario withPriority: self priority;
		startScenario: newScenario.
	"Request a XEvent in the ClickEventPosition"
			xmove := XEvent position: aBP4PProgram lastEvent position.
			aBP4PProgram syncRequested: xmove waited: none blocked: none.
]
