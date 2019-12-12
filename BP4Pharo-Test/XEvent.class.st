"
An event that is fired when player X makes a move.
"
Class {
	#name : #XEvent,
	#superclass : #MoveEvent,
	#category : #'BP4Pharo-Test-TicTacToe-Core'
}

{ #category : #'instance creation' }
XEvent >> defaultName [
	^ 'X(' , position name, ')'
]
