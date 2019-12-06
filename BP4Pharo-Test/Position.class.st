Class {
	#name : #Position,
	#superclass : #Object,
	#instVars : [
		'x',
		'y'
	],
	#category : #'BP4Pharo-Test-TicTacToe'
}

{ #category : #'instance creation' }
Position class >> x: anInteger y: anotherInteger [
	^self new x: anInteger y: anotherInteger
]

{ #category : #comparing }
Position >> = aPosition [
	^x = aPosition x and: [ y = aPosition y ]
]

{ #category : #comparing }
Position >> name [
	^x asString , ',' , y asString
]

{ #category : #accessing }
Position >> x [
	^ x
]

{ #category : #'instance creation' }
Position >> x: anInteger y: anotherInteger [
	x:= anInteger.
	y:= anotherInteger
]

{ #category : #accessing }
Position >> y [
	^ y
]
