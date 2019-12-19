Class {
	#name : #RulesDetectXWinSegment,
	#superclass : #BP4PScenario,
	#instVars : [
		'segment'
	],
	#category : #'BP4Pharo-Test-TicTacToe-SegmentBased'
}

{ #category : #creation }
RulesDetectXWinSegment class >> instanceToSegment: aSegment [
	"create a DetectXWin scenario for this segment"

	| scenario |
	scenario := self instance.
	scenario segment: aSegment.
	^ scenario
]

{ #category : #initialize }
RulesDetectXWinSegment >> printOn: aStream [
	super printOn: aStream.
	aStream nextPutAll: ' for segment '.
	self segment printOn: aStream
]

{ #category : #initialize }
RulesDetectXWinSegment >> run: aBP4PProgram [
	"Wait for placement of X move in the positions of the segment.
	If true request XWin.
	If any O move in the positions of the segment interrupt the scenario"

	| segmentMoves  move xwin |
	xwin := GameOverEvent name: 'xwin'.
	move := BP4PEventsOfClass class: MoveEvent.

	segmentMoves := BP4PEventSet
		with: (segment collect: [ :position | MoveEvent position: position ]).
	[ segmentMoves isNone ]
		whileFalse: [ aBP4PProgram syncRequested: none waited: segmentMoves blocked: none.
			"Interrupt if move is of type O event"
			(aBP4PProgram lastEvent belongsTo: OEvent )
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

	"Block all moves and Request XWin"
	aBP4PProgram syncRequested: xwin waited: none blocked: move.
	"Block all moves game over"
	aBP4PProgram syncRequested: none waited: none blocked: move
]

{ #category : #accessing }
RulesDetectXWinSegment >> segment [
	^ segment
]

{ #category : #accessing }
RulesDetectXWinSegment >> segment: anObject [
	segment := anObject
]
