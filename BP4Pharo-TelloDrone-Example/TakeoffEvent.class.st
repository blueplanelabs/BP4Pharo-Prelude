Class {
	#name : #TakeoffEvent,
	#superclass : #BP4PEvent,
	#category : #'BP4Pharo-TelloDrone-Example'
}

{ #category : #accessing }
TakeoffEvent >> defaultName [
	^ self className withoutSuffix: ' class'
]

{ #category : #accessing }
TakeoffEvent >> name [
	^ name ifNil: [ name := self defaultName ]
]
