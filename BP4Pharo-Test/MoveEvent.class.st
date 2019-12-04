"
I'm a type of event for moves (X or O) in the tic-tac-toe game.

I keep information about the position of the move with x and y coordinates.
"
Class {
	#name : #MoveEvent,
	#superclass : #BP4PEvent,
	#instVars : [
		'x',
		'y'
	],
	#category : #'BP4Pharo-Test-TicTacToe'
}

{ #category : #'instance creation' }
MoveEvent class >> x: aRowNumber y: aColumnNumber [
	self new x: aRowNumber y: aColumnNumber
]

{ #category : #'instance creation' }
MoveEvent >> defaultName [
	^  'Move(' , self x asString , ',' , self y asString , ')'
]

{ #category : #'instance creation' }
MoveEvent >> name [
	^ name
		ifNil: [ name := self defaultName ]
]

{ #category : #accessing }
MoveEvent >> x [
	^ x
]

{ #category : #accessing }
MoveEvent >> x: anObject [
	x := anObject
]

{ #category : #'instance creation' }
MoveEvent >> x: aRowNumber y: aColumnNumber [
	self
		x: aRowNumber;
		y: aColumnNumber
]

{ #category : #accessing }
MoveEvent >> y [
	^ y
]

{ #category : #accessing }
MoveEvent >> y: anObject [
	y := anObject
]
