Class {
	#name : #RulesDetectOWinSegment,
	#superclass : #BP4PEnvironmentScenario,
	#instVars : [
		'segment'
	],
	#category : #'BP4Pharo-Test-TicTacToe-SegmentBased'
}

{ #category : #creation }
RulesDetectOWinSegment class >> instanceToSegment: aSegment [
	"create a DetectXWin scenario for this segment"

	| scenario |
	scenario := self instance.
	scenario segment: aSegment.
	^ scenario
]

{ #category : #initialize }
RulesDetectOWinSegment >> printOn: aStream [
	super printOn: aStream.
	aStream nextPutAll: ' for segment '.
	self segment printOn: aStream
]

{ #category : #initialize }
RulesDetectOWinSegment >> run: aBP4PProgram [
	"Wait for placement of O move in the positions of the segment.
	If true request OWin.
	If any X move in the positions of the segment then interrupt the scenario"

	| segmentMoves  move owin |
	owin := GameOverEvent name: 'owin'.
	move := BP4PEventsOfClass class: MoveEvent.

	segmentMoves := BP4PEventSet
		with: (segment collect: [ :position | MoveEvent position: position ]).
	[ segmentMoves isNone ]
		whileFalse: [ aBP4PProgram syncRequested: none waited: segmentMoves blocked: none.
			"Interrupt if move is of type X event"
			(aBP4PProgram lastEvent belongsTo: XEvent )
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
	aBP4PProgram syncRequested: owin waited: none blocked: move.
	"Block all moves game over"
	aBP4PProgram syncRequested: none waited: none blocked: move
]

{ #category : #accessing }
RulesDetectOWinSegment >> segment [
	^ segment
]

{ #category : #accessing }
RulesDetectOWinSegment >> segment: anObject [
	segment := anObject
]
