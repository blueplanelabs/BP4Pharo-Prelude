Class {
	#name : #StrategyPreventXWinSegment,
	#superclass : #BP4PScenario,
	#instVars : [
		'segment'
	],
	#category : #'BP4Pharo-Test-TicTacToe-SegmentBased'
}

{ #category : #creation }
StrategyPreventXWinSegment class >> instanceToSegment: aSegment [
	"create a DetectXWin scenario for this segment"

	| scenario |
	scenario := self instance.
	scenario segment: aSegment.
	^ scenario
]

{ #category : #initialize }
StrategyPreventXWinSegment >> printOn: aStream [
	super printOn: aStream.
	aStream nextPutAll: ' for segment '.
	self firstSegment printOn: aStream.
	aStream nextPutAll: ' and segment '.
	self secondSegment printOn: aStream.
]

{ #category : #initialize }
StrategyPreventXWinSegment >> run: aBP4PProgram [
	"Wait for X move in segment positions until rest only one.
	If true request O move to prevent X Win.
	If any O move in the positions of the segment interrupt the scenario"

	| segmentMoves |
	segmentMoves := BP4PEventSet
		with: (segment collect: [ :position | MoveEvent position: position ]).
	[ segmentMoves set size = 1 ]
		whileFalse: [ aBP4PProgram syncRequested: none waited: segmentMoves blocked: none.
			"Interrupt if move is of type O event"
			(aBP4PProgram lastEvent belongsTo: OEvent)
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
			Transcript
				crShow:
					'Resquested O move in ' , self printString , ' by '
						, aBP4PProgram lastEvent asString.
	"Request O event in the rest position"
	aBP4PProgram
		syncRequested: segmentMoves set anyOne asOEvent
		waited: none
		blocked: none
]

{ #category : #accessing }
StrategyPreventXWinSegment >> segment [
	^ segment
]

{ #category : #accessing }
StrategyPreventXWinSegment >> segment: anObject [
	segment := anObject
]
