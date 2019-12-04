"
An event that is requested (with high priority) whenever the user presses a button on the game board.
"
Class {
	#name : #ClickEvent,
	#superclass : #BP4PEvent,
	#instVars : [
		'row',
		'col'
	],
	#category : #'BP4Pharo-Test-TicTacToe'
}

{ #category : #'as yet unclassified' }
ClickEvent class >> row: aRowNumber col: aColumnNumber [
	self new row: aRowNumber col: aColumnNumber
]

{ #category : #accessing }
ClickEvent >> col [
	^ col
]

{ #category : #accessing }
ClickEvent >> col: anObject [
	col := anObject
]

{ #category : #accessing }
ClickEvent >> defaultName [
	^ 'Click(' , self col asString , ',' , self row asString , ')'
]

{ #category : #accessing }
ClickEvent >> name [
	^ name ifNil: [ name := self defaultName ]
]

{ #category : #accessing }
ClickEvent >> row [
	^ row
]

{ #category : #accessing }
ClickEvent >> row: anObject [
	row := anObject
]

{ #category : #'as yet unclassified' }
ClickEvent >> row: aRowNumber col: aColumnNumber [
	self
		row: aRowNumber;
		col: aColumnNumber
]
