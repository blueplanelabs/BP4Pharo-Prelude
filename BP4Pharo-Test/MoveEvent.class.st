"
I'm a type of event for moves (X or O) in the tic-tac-toe game.

I keep information about the position of the move with x and y coordinates.
"
Class {
	#name : #MoveEvent,
	#superclass : #BP4PEvent,
	#instVars : [
		'position'
	],
	#category : #'BP4Pharo-Test-TicTacToe-Core'
}

{ #category : #'instance creation' }
MoveEvent class >> position: aPosition [
	^ self new
		position: aPosition 
]

{ #category : #comparing }
MoveEvent >> = anObject [
	anObject == self
		ifTrue: [ ^ true ].
	(anObject isNil
		or: [ (anObject isKindOf: self class) not
				or: [ (anObject position = self position) not ] ])
		ifTrue: [ ^ false ].
	^ true
]

{ #category : #api }
MoveEvent >> asMoveEvent [
	^ MoveEvent position: position
]

{ #category : #api }
MoveEvent >> asOEvent [
	^ OEvent position: position
]

{ #category : #api }
MoveEvent >> asXEvent [
	^ XEvent position: position
]

{ #category : #'instance creation' }
MoveEvent >> defaultName [
	^ 'Move(' , position name, ')'
]

{ #category : #'instance creation' }
MoveEvent >> name [
	^ name
		ifNil: [ name := self defaultName ]
]

{ #category : #api }
MoveEvent >> position [
	^ position
]

{ #category : #accessing }
MoveEvent >> position: aPosition [
	position := aPosition 
]
