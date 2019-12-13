"
An event that is requested (with high priority) whenever the user presses a button on the game board.
"
Class {
	#name : #ClickEvent,
	#superclass : #BP4PEvent,
	#instVars : [
		'position'
	],
	#category : #'BP4Pharo-Test-TicTacToe-Core'
}

{ #category : #creation }
ClickEvent class >> position: aPosition [
	^ self new position: aPosition
]

{ #category : #accessing }
ClickEvent >> defaultName [
	^ 'Click(' , position name ,')'
]

{ #category : #accessing }
ClickEvent >> name [
	^ name ifNil: [ name := self defaultName ]
]

{ #category : #accessing }
ClickEvent >> position [
	^ position
]

{ #category : #accessing }
ClickEvent >> position: aPosition [
	position := aPosition .
]
