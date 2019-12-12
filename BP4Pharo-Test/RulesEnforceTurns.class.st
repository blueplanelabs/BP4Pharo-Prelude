Class {
	#name : #RulesEnforceTurns,
	#superclass : #BP4PEnvironmentScenario,
	#category : #'BP4Pharo-Test-TicTacToe-Core'
}

{ #category : #initialize }
RulesEnforceTurns >> run: aBP4PProgram [
	"Alternately block O moves while waiting for X moves, and vice versa (we assume that X always plays first)."

	| xmove omove |
	xmove := BP4PEventsOfClass class: XEvent.
	omove := BP4PEventsOfClass class: OEvent.
	[true] whileTrue: [
	"Wait for X moves and block O moves"
	aBP4PProgram syncRequested: none waited: xmove blocked: omove.
	"Wait for O moves and block X moves"
	aBP4PProgram syncRequested: none waited: omove blocked: xmove]
]
