Class {
	#name : #RequestedMoveEvent,
	#superclass : #BP4PEvent,
	#category : #'BP4Pharo-TelloDrone-Example'
}

{ #category : #accessing }
RequestedMoveEvent >> defaultName [
	^ self className withoutSuffix: ' class'
]

{ #category : #accessing }
RequestedMoveEvent >> name [
	^ name ifNil: [ name := self defaultName ]
]
