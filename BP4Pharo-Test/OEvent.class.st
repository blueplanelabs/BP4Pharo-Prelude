"
An event that is fired when player O makes a move.
"
Class {
	#name : #OEvent,
	#superclass : #MoveEvent,
	#category : #'BP4Pharo-Test-TicTacToe-Core'
}

{ #category : #'instance creation' }
OEvent >> defaultName [
	^ 'O(' , position name , ')'
]
