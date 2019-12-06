"
Scenario for not allowing two symbols in the same square
"
Class {
	#name : #RulesSquareTaken,
	#superclass : #BP4PEnvironmentScenario,
	#category : #'BP4Pharo-Test-TicTacToe'
}

{ #category : #initialize }
RulesSquareTaken >> run: aBP4PProgram [
	"Block further marking of a square already marked by X or O"

	| move newScenario lastMove|
	move := BP4PEventsOfClass class: MoveEvent.
	"Wait for any move for a given square"
	aBP4PProgram syncRequested: none waited: move blocked: none.
	"Add a new scenario like this to wait and block again a new move"
	newScenario := self class instance.
	aBP4PProgram add: newScenario; startScenario: newScenario.
	"Block the concrete last move"
	lastMove := MoveEvent position: aBP4PProgram lastEvent copy position.
	aBP4PProgram syncRequested: none waited: none blocked: lastMove
]
