Class {
	#name : #GeneratePreventXWinScenariosEvent,
	#superclass : #BP4PEvent,
	#instVars : [
		'position'
	],
	#category : #'BP4Pharo-Test-TicTacToe-SegmentBased'
}

{ #category : #'instance creation' }
GeneratePreventXWinScenariosEvent class >> position: aPosition [
	^ self new position: aPosition 
]

{ #category : #'instance creation' }
GeneratePreventXWinScenariosEvent >> defaultName [
	^ 'PreventXWin(' , position name , ')'
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
GeneratePreventXWinScenariosEvent >> position: aPosition [ 
	position := aPosition.

]
