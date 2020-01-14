Class {
	#name : #TickEvent,
	#superclass : #BP4PEvent,
	#instVars : [
		'seconds'
	],
	#category : #'BP4Pharo-TelloDrone-Example'
}

{ #category : #'instance creation' }
TickEvent class >> seconds: anInteger [
	self new seconds: anInteger
]

{ #category : #accessing }
TickEvent >> defaultName [
	^ 'Tick(' , self seconds asString , ')'
]

{ #category : #accessing }
TickEvent >> name [
	^ name ifNil: [ name := self defaultName ]
]

{ #category : #accessing }
TickEvent >> seconds [
	^seconds
]

{ #category : #accessing }
TickEvent >> seconds: anInteger [
	seconds := anInteger 
]
