"
An event that is requested (with high priority) whenever the user presses a button on the game board.
"
Class {
	#name : #ClickEvent,
	#superclass : #BP4PEvent,
	#instVars : [
		'x',
		'y'
	],
	#category : #'BP4Pharo-Test-TicTacToe-Core'
}

{ #category : #creation }
ClickEvent class >> position: aPosition [
	^ self new position: aPosition
]

{ #category : #accessing }
ClickEvent >> defaultName [
	^ 'Click(' , x asString , ',' , y asString , ')'
]

{ #category : #accessing }
ClickEvent >> name [
	^ name ifNil: [ name := self defaultName ]
]

{ #category : #accessing }
ClickEvent >> position [
	^Position x: x y: y
]

{ #category : #accessing }
ClickEvent >> position: aPosition [
	x := aPosition x.
	y := aPosition y
]
