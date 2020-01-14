Class {
	#name : #Location,
	#superclass : #Point,
	#category : #'BP4Pharo-TelloDrone-Example'
}

{ #category : #accessing }
Location >> name [
	^ x asString , '_' , y asString
]
