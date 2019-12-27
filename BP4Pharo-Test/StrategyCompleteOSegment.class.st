Class {
	#name : #StrategyCompleteOSegment,
	#superclass : #BP4PScenario,
	#instVars : [
		'segment'
	],
	#category : #'BP4Pharo-Test-TicTacToe-SegmentBased'
}

{ #category : #creation }
StrategyCompleteOSegment class >> instanceToSegment: aSegment [
	"create a DetectXWin scenario for this segment"

	| scenario |
	scenario := self instance.
	scenario segment: aSegment.
	^ scenario
]

{ #category : #initialize }
StrategyCompleteOSegment >> printOn: aStream [
	super printOn: aStream.
	aStream nextPutAll: ' for segment '.
	self segment printOn: aStream
]

{ #category : #initialize }
StrategyCompleteOSegment >> run: aBP4PProgram [
	"Request O move in the positions of the segment. Shorter segment, higher priority
	If any X move in the positions of the segment then interrupt the scenario"

	| segmentMoves segmentOMoves |
	segmentMoves := BP4PEventSet
		with: (segment collect: [ :position | MoveEvent position: position ]).
	segmentOMoves := BP4PEventSet
		with: (segment collect: [ :position | OEvent position: position ]).
	[ segmentMoves isNone ]
		whileFalse: [ aBP4PProgram
				syncRequested: segmentOMoves
				waited: segmentMoves 
				blocked: none.
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
			segmentMoves remove: aBP4PProgram lastEvent asMoveEvent.
			segmentOMoves remove: aBP4PProgram lastEvent.
			aBP4PProgram increasePriority: 0.01 toScenario: self ]
]

{ #category : #accessing }
StrategyCompleteOSegment >> segment [
	^ segment
]

{ #category : #accessing }
StrategyCompleteOSegment >> segment: anObject [
	segment := anObject
]
