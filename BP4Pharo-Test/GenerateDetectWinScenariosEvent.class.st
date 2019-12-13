Class {
	#name : #GenerateDetectWinScenariosEvent,
	#superclass : #BP4PEvent,
	#instVars : [
		'position',
		'type'
	],
	#category : #'BP4Pharo-Test-TicTacToe-SegmentBased'
}

{ #category : #'instance creation' }
GenerateDetectWinScenariosEvent class >> position: aPosition type: aXEventClassOrYEventClass [
	^ self new
		position: aPosition
		type: aXEventClassOrYEventClass
]

{ #category : #'instance creation' }
GenerateDetectWinScenariosEvent >> defaultName [
	^ 'DetectXWin((' , position name , '),' , type name , ')'
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
GenerateDetectWinScenariosEvent >> position: aPosition type: aXEventClassOrYEventClass [
	position := aPosition.
	type:= aXEventClassOrYEventClass
]

{ #category : #accessing }
GenerateDetectWinScenariosEvent >> type [
	^type
]

{ #category : #accessing }
GenerateDetectWinScenariosEvent >> type: anObject [
	type := anObject
]
