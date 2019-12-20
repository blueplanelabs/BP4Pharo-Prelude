Class {
	#name : #GenerateForceOWinScenariosEvent,
	#superclass : #BP4PEvent,
	#instVars : [
		'position',
		'priority'
	],
	#category : #'BP4Pharo-Test-TicTacToe-SegmentBased'
}

{ #category : #'instance creation' }
GenerateForceOWinScenariosEvent class >> position: aPosition priority: aPriority [
	^ self new position: aPosition priority: aPriority 
]

{ #category : #'instance creation' }
GenerateForceOWinScenariosEvent >> defaultName [
	^ 'ForceOWin(' , position name , ' , ', priority asString , ')'
]

{ #category : #'instance creation' }
GenerateForceOWinScenariosEvent >> name [
	^ name
		ifNil: [ name := self defaultName ]
]

{ #category : #api }
GenerateForceOWinScenariosEvent >> position [
	^ position
]

{ #category : #accessing }
GenerateForceOWinScenariosEvent >> position: aPosition priority: aPriority [
	position := aPosition.
	priority:= aPriority 
]

{ #category : #api }
GenerateForceOWinScenariosEvent >> priority [
	^ priority
]
