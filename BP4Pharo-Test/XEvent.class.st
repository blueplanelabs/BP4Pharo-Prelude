"
An event that is fired when player X makes a move.
"
Class {
	#name : #XEvent,
	#superclass : #MoveEvent,
	#category : #'BP4Pharo-Test-TicTacToe'
}

{ #category : #'instance creation' }
XEvent >> defaultName [
	^ 'X(' , self x asString , ',' , self y asString , ')'
]
