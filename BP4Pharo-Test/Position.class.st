Class {
	#name : #Position,
	#superclass : #Point,
	#category : #'BP4Pharo-Test-TicTacToe'
}

{ #category : #testing }
Position >> isAlienatedWith: aPosition and: anotherPosition [
	^ (self triangleArea: aPosition with: anotherPosition) isZero
]

{ #category : #comparing }
Position >> name [
	^x asString , ',' , y asString
]
