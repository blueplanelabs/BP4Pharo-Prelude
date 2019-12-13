Class {
	#name : #Position,
	#superclass : #Point,
	#category : #'BP4Pharo-Test-TicTacToe-Core'
}

{ #category : #comparing }
Position >> = aPoint [
	^ (self
		isKindOf: aPoint species)
		ifTrue: [ x = aPoint x and: [ y = aPoint y ] ]
		ifFalse: [ false ]
]

{ #category : #converting }
Position >> asPoint [
	"Answer the receiver itself."

	^ Point x: x y: y
]

{ #category : #testing }
Position >> isAlienatedWith: aPosition and: anotherPosition [
	^ (self triangleArea: aPosition with: anotherPosition) isZero
]

{ #category : #comparing }
Position >> name [
	^x asString , ',' , y asString
]

{ #category : #transforming }
Position >> translateBy: delta [
	"Answer a Point translated by delta (an instance of Point)."

	^ Position x:(delta x + x) y: (delta y + y)
]
