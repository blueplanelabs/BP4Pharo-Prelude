Class {
	#name : #StrategyDefaultOMovesSegment,
	#superclass : #BP4PEnvironmentScenario,
	#category : #'BP4Pharo-Test-TicTacToe-SegmentBased'
}

{ #category : #initialize }
StrategyDefaultOMovesSegment >> run: aBP4PProgram [
	"Request all possible moves - as default moves in the following order of center, corners and edges."

	| desiredPositions move |
	move := BP4PEventsOfClass class: MoveEvent.
	desiredPositions := TicTacToeWithSegment possiblePositions
		asOrderedCollection.
	[ desiredPositions isEmpty ]
		whileFalse:
			[ "Request a O move by default priority and wait any move. Remove the selected move from the desiredPositions"
			desiredPositions
				sort: [ :a :b | 
					(TicTacToeWithSegment numAvailabeSegmentsTo: a)
						> (TicTacToeWithSegment numAvailabeSegmentsTo: b) ].
			aBP4PProgram
				syncRequested: (OEvent position: desiredPositions first)
				waited: move
				blocked: none.
			desiredPositions remove: aBP4PProgram lastEvent position ]
]
