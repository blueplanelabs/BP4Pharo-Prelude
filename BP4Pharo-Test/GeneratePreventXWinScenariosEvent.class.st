Class {
	#name : #GeneratePreventXWinScenariosEvent,
	#superclass : #BP4PEvent,
	#instVars : [
		'position',
		'priority'
	],
	#category : #'BP4Pharo-Test-TicTacToe-SegmentBased'
}

{ #category : #'instance creation' }
GeneratePreventXWinScenariosEvent class >> position: aPosition priority: aPriority [
	^ self new position: aPosition priority: aPriority 
]

{ #category : #'instance creation' }
GeneratePreventXWinScenariosEvent >> defaultName [
	^ 'PreventXWin(' , position name , ' , ' , priority asString , ')'
]

{ #category : #'instance creation' }
GeneratePreventXWinScenariosEvent >> name [
	^ name
		ifNil: [ name := self defaultName ]
]

{ #category : #api }
GeneratePreventXWinScenariosEvent >> position [
	^ position
]

{ #category : #accessing }
GeneratePreventXWinScenariosEvent >> position: aPosition priority: aPriority [
	position := aPosition.
	priority:= aPriority 
]

{ #category : #api }
GeneratePreventXWinScenariosEvent >> priority [
	^ priority
]
