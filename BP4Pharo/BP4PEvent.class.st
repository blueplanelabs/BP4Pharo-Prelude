Class {
	#name : #BP4PEvent,
	#superclass : #BP4PEventSetInterface,
	#category : #BP4Pharo
}

{ #category : #accessing }
BP4PEvent class >> name: aName [

	^self new name: aName
]

{ #category : #accessing }
BP4PEvent class >> none [
	^ self new name: 'none'
]

{ #category : #accessing }
BP4PEvent >> , aEventOrEventSetOrEventOfClass [
	"Return a new BP4PEventSet with name the combination of names and events the set of every event, eventSet or eventOfClass"

	^ self asEventSet , aEventOrEventSetOrEventOfClass asEventSet
]

{ #category : #accessing }
BP4PEvent >> asEventSet [
	^ BP4PEventSet with: self set
]

{ #category : #accessing }
BP4PEvent >> includes: anEventOrAnEventSet [
	"answer if includes anEventOrAnEventSet"

	^ self set includes: anEventOrAnEventSet set
]

{ #category : #accessing }
BP4PEvent >> includesEvent: anEvent [
	"answer if includes anEvent"

	^ self = anEvent
]

{ #category : #accessing }
BP4PEvent >> isNone [
	^ self = BP4PEvent none
]

{ #category : #accessing }
BP4PEvent >> name [
	"	^ name
		ifNil: [ name := Set with: (self className withoutSuffix: ' class') ]"

	^ name ifNil: [ name := 'none' ]
]

{ #category : #accessing }
BP4PEvent >> name: aString [
	name := aString
]

{ #category : #printing }
BP4PEvent >> printOn: aStream [
	super printOn: aStream.
	aStream nextPutAll: ' name: '.
	self name printOn: aStream
]

{ #category : #accessing }
BP4PEvent >> set [
	^ Set with: self
]
