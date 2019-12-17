Class {
	#name : #GenerateDetectWinScenariosEvent,
	#superclass : #BP4PEvent,
	#instVars : [
		'position',
		'type',
		'priority'
	],
	#category : #'BP4Pharo-Test-TicTacToe-SegmentBased'
}

{ #category : #'instance creation' }
GenerateDetectWinScenariosEvent class >> position: aPosition type: aXEventClassOrYEventClass priority: aPriority [
	^ self new position: aPosition type: aXEventClassOrYEventClass priority: aPriority 
]

{ #category : #'instance creation' }
GenerateDetectWinScenariosEvent >> defaultName [
	^ 'DetectWin((' , position name , '),' , type name , ')'
]

{ #category : #'instance creation' }
GenerateDetectWinScenariosEvent >> name [
	^ name
		ifNil: [ name := self defaultName ]
]

{ #category : #api }
GenerateDetectWinScenariosEvent >> position [
	^ position
]

{ #category : #accessing }
GenerateDetectWinScenariosEvent >> position: aPosition type: aXEventClassOrYEventClass priority: aPriority [
	position := aPosition.
	type := aXEventClassOrYEventClass.
	priority:= aPriority 
]

{ #category : #accessing }
GenerateDetectWinScenariosEvent >> priority [
	^ priority
]

{ #category : #accessing }
GenerateDetectWinScenariosEvent >> type [
	^type
]
