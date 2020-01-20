Class {
	#name : #StopEvent,
	#superclass : #BP4PEvent,
	#category : #'BP4Pharo-TelloDrone-Example'
}

{ #category : #accessing }
StopEvent >> defaultName [
^self className withoutSuffix: ' class'
]

{ #category : #accessing }
StopEvent >> name [
	^ name ifNil: [ name := self defaultName ]
]
