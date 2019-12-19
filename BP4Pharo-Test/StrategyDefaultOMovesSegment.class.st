Class {
	#name : #StrategyDefaultOMovesSegment,
	#superclass : #BP4PScenario,
	#instVars : [
		'defaultPositions'
	],
	#category : #'BP4Pharo-Test-TicTacToe-SegmentBased'
}

{ #category : #accessing }
StrategyDefaultOMovesSegment >> defaultPositions [
^defaultPositions ifNil: [ defaultPositions  := TicTacToeWithSegment possiblePositions
		asOrderedCollection.
	defaultPositions
		sort: [ :a :b | 
			(TicTacToeWithSegment numAvailabeSegmentsTo: a)
				> (TicTacToeWithSegment numAvailabeSegmentsTo: b) ]. ]

]

{ #category : #initialize }
StrategyDefaultOMovesSegment >> printOn: aStream [
	super printOn: aStream.
	aStream nextPutAll: ' with '.
	self defaultPositions  printOn: aStream
]

{ #category : #initialize }
StrategyDefaultOMovesSegment >> run: aBP4PProgram [
	"Request all possible moves - as default moves in the following order of center, corners and edges."

	|  move |
	move := BP4PEventsOfClass class: MoveEvent.

	[ self defaultPositions  isEmpty ]
		whileFalse:
			[ "Request a O move by default priority and wait any move. Remove the selected move from the desiredPositions"
			aBP4PProgram
				syncRequested: (OEvent position: self defaultPositions  first)
				waited: move
				blocked: none.
			self defaultPositions  remove: aBP4PProgram lastEvent position ]
]
