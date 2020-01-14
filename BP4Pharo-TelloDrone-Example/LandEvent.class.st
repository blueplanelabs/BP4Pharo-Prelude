Class {
	#name : #LandEvent,
	#superclass : #BP4PEvent,
	#category : #'BP4Pharo-TelloDrone-Example'
}

{ #category : #accessing }
LandEvent >> defaultName [
^self className withoutSuffix: ' class'
]

{ #category : #accessing }
LandEvent >> name [
	^ name ifNil: [ name := self defaultName ]
]
