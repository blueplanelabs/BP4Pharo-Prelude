Class {
	#name : #RulesDetectDrawSegment,
	#superclass : #BP4PScenario,
	#category : #'BP4Pharo-Test-TicTacToe-SegmentBased'
}

{ #category : #initialize }
RulesDetectDrawSegment >> run: aBP4PProgram [
	"wait for placement of all posible square taken, if true request Draw."

	| move draw all posibleMoves |
	move := BP4PEventsOfClass class: MoveEvent.
	all := BP4PEventsOfClass class: BP4PEvent.
	draw := GameOverEvent name: 'draw'.
	posibleMoves := TicTacToeWithSegment possiblePositions size.
	posibleMoves timesRepeat: [ 
			Transcript
				crShow:
					'Possible Positions: '
						, TicTacToeWithSegment possiblePositions asString.
	aBP4PProgram syncRequested: none waited: move blocked: none ].
	aBP4PProgram syncRequested: draw waited: none blocked: move.
	aBP4PProgram syncRequested: none waited: none blocked: all
]
