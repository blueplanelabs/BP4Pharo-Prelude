Class {
	#name : #RulesSquareTakenSegmentBased,
	#superclass : #BP4PEnvironmentScenario,
	#category : #'BP4Pharo-Test-TicTacToe-SegmentBased'
}

{ #category : #initialize }
RulesSquareTakenSegmentBased >> run: aBP4PProgram [
	"Block further marking of a square already marked by X or O"

	| move newScenario lastMove lastPosition |
	move := BP4PEventsOfClass class: MoveEvent.
	"Wait for any move for a given square"
	aBP4PProgram syncRequested: none waited: move blocked: none.
	"Add a new scenario like this to wait and block again a new move"
	newScenario := self class instance.
	aBP4PProgram
		add: newScenario;
		startScenario: newScenario.
	"Take the position in the posiblePositions of TicTacToe"
	lastPosition := aBP4PProgram lastEvent position.
	TicTacToeWithSegment  takePosition: lastPosition.
	"Block the concrete last move"
	lastMove := MoveEvent position: lastPosition.
	aBP4PProgram syncRequested: none waited: none blocked: lastMove
]
