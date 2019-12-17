Class {
	#name : #StrategyForceOWinSegment,
	#superclass : #BP4PEnvironmentScenario,
	#instVars : [
		'segment'
	],
	#category : #'BP4Pharo-Test-TicTacToe-SegmentBased'
}

{ #category : #creation }
StrategyForceOWinSegment class >> instanceToSegment: aSegment [
	"create a DetectXWin scenario for this segment"

	| scenario |
	scenario := self instance.
	scenario segment: aSegment.
	^ scenario
]

{ #category : #initialize }
StrategyForceOWinSegment >> printOn: aStream [
	super printOn: aStream.
	aStream nextPutAll: ' for segment '.
	self segment printOn: aStream
]

{ #category : #initialize }
StrategyForceOWinSegment >> run: aBP4PProgram [
	"Wait for placement of O move in the positions of the segment until only rest one position.
	Then request OEvent in this last position.
	If any X move in the positions of the segment then interrupt the scenario"

	| segmentMoves move |
	move := BP4PEventsOfClass class: MoveEvent.
	segmentMoves := BP4PEventSet
		with: (segment collect: [ :position | MoveEvent position: position ]).
	[ segmentMoves set size = 1 ]
		whileFalse: [ aBP4PProgram syncRequested: none waited: segmentMoves blocked: none.
			"Interrupt if move is of type X event"
			(aBP4PProgram lastEvent belongsTo: XEvent)
				ifTrue: [ Transcript
						crShow:
							'Interrupted ' , self printString , ' by '
								, aBP4PProgram lastEvent asString.
					^ self ].
			Transcript
				crShow:
					'Continued ' , self printString , ' by '
						, aBP4PProgram lastEvent asString.
			segmentMoves remove: aBP4PProgram lastEvent asMoveEvent ].

	"Request the last OEvent "
	aBP4PProgram
		syncRequested: segmentMoves set anyOne asOEvent
		waited: none
		blocked: none
]

{ #category : #accessing }
StrategyForceOWinSegment >> segment [
	^ segment
]

{ #category : #accessing }
StrategyForceOWinSegment >> segment: anObject [
	segment := anObject
]
