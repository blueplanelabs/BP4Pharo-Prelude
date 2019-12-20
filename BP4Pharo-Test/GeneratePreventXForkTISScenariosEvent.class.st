Class {
	#name : #GeneratePreventXForkTISScenariosEvent,
	#superclass : #BP4PEvent,
	#instVars : [
		'position',
		'priority',
		'segments'
	],
	#category : #'BP4Pharo-Test-TicTacToe-SegmentBased'
}

{ #category : #'instance creation' }
GeneratePreventXForkTISScenariosEvent class >> position: aPosition segments: aSegmentsSet priority: aPriority [
	^ self new position: aPosition segments: aSegmentsSet priority: aPriority
]

{ #category : #'instance creation' }
GeneratePreventXForkTISScenariosEvent >> defaultName [
	^ 'PreventXFork(position:' , position name , ',segments:' , segments asString , ',priority:'
		, priority asString , ')'
]

{ #category : #'instance creation' }
GeneratePreventXForkTISScenariosEvent >> name [
	^ name
		ifNil: [ name := self defaultName ]
]

{ #category : #api }
GeneratePreventXForkTISScenariosEvent >> position [
	^ position
]

{ #category : #accessing }
GeneratePreventXForkTISScenariosEvent >> position: aPosition segments: aSegmentsSet priority: aPriority [
	position := aPosition.
	segments := aSegmentsSet .
	priority := aPriority
]

{ #category : #api }
GeneratePreventXForkTISScenariosEvent >> priority [
	^ priority
]

{ #category : #accessing }
GeneratePreventXForkTISScenariosEvent >> segments [
	^ segments
]
