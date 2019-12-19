Class {
	#name : #StrategyPreventXForkTwoIntersectedSegments,
	#superclass : #BP4PScenario,
	#instVars : [
		'firstSegment',
		'secondSegment'
	],
	#category : #'BP4Pharo-Test-TicTacToe-SegmentBased'
}

{ #category : #creation }
StrategyPreventXForkTwoIntersectedSegments class >> instanceToSegment: aSegment andSegment: otherSegment [
	"create a PreventXFork scenario for two segments"

	| scenario |
	scenario := self instance.
	scenario firstSegment: aSegment.
	scenario secondSegment: otherSegment .
	^ scenario
]

{ #category : #accessing }
StrategyPreventXForkTwoIntersectedSegments >> firstSegment [
	^ firstSegment
]

{ #category : #accessing }
StrategyPreventXForkTwoIntersectedSegments >> firstSegment: anObject [
	firstSegment := anObject
]

{ #category : #initialize }
StrategyPreventXForkTwoIntersectedSegments >> printOn: aStream [
	super printOn: aStream.
	aStream nextPutAll: ' for segment '.
	self firstSegment printOn: aStream.
	aStream nextPutAll: ' and segment '.
	self secondSegment printOn: aStream.
]

{ #category : #initialize }
StrategyPreventXForkTwoIntersectedSegments >> run: aBP4PProgram [
	"Analyze is a fork (Doble menace) of X is possible with this two segment in each X move.
	Fork = when in each of the intersected segment only rest 2 positions to complete it and one of them is the intersection.
	If a fork is possible then request a O move in the intersection to abort it.
	If a O move happens in any segment then interrupt.
	If a X move happens in the intersection position then interrupt."

	| firstSegmentMoves secondSegmentMoves intersectionPosition |
	intersectionPosition := (firstSegment intersection: secondSegment) anyOne .
	firstSegmentMoves := BP4PEventSet
		with: (firstSegment collect: [ :position | MoveEvent position: position ]).
	secondSegmentMoves := BP4PEventSet
		with: (secondSegment collect: [ :position | MoveEvent position: position ]).
	"While the fork doesn't imminent (each segment only have the intersection position and another one)"
	[ firstSegmentMoves size = 2 and: [ secondSegmentMoves size = 2 ] ]
		whileFalse: [ "Wait for any move in the segments"
			aBP4PProgram
				syncRequested: none
				waited: firstSegmentMoves , secondSegmentMoves
				blocked: none.
			"Interrupt if move is type O event or any kind of move in the intersection position"
			((aBP4PProgram lastEvent belongsTo: OEvent)
				or: [ aBP4PProgram lastEvent position = intersectionPosition ])
				ifTrue: [ Transcript
						crShow:
							'Interrupted ' , self printString , ' by '
								, aBP4PProgram lastEvent asString.
					^ self ].
			Transcript
				crShow:
					'Continued ' , self printString , ' by '
						, aBP4PProgram lastEvent asString.
			firstSegmentMoves remove: aBP4PProgram lastEvent asMoveEvent.
			secondSegmentMoves remove: aBP4PProgram lastEvent asMoveEvent ].
	aBP4PProgram
		syncRequested: (OEvent position: intersectionPosition)
		waited: none
		blocked: none
]

{ #category : #accessing }
StrategyPreventXForkTwoIntersectedSegments >> secondSegment [
	^ secondSegment
]

{ #category : #accessing }
StrategyPreventXForkTwoIntersectedSegments >> secondSegment: anObject [
	secondSegment := anObject
]
