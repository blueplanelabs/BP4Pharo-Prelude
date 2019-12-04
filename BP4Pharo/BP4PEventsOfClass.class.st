Class {
	#name : #BP4PEventsOfClass,
	#superclass : #BP4PEventSetInterface,
	#category : #BP4Pharo
}

{ #category : #accessing }
BP4PEventsOfClass class >> class: anEventClass [
	^ self new name: anEventClass name asString
]

{ #category : #accessing }
BP4PEventsOfClass class >> name: anEventClass [
	^ self new name: anEventClass
]

{ #category : #accessing }
BP4PEventsOfClass >> , aEventOrEventSetOrEventOfClass [
	"Return a new BP4PEventSet with name the combination of names and events the set of every event, eventSet or eventOfClass"

	^ self asEventSet , aEventOrEventSetOrEventOfClass asEventSet
]

{ #category : #accessing }
BP4PEventsOfClass >> asEventSet [
	^ BP4PEventSet with: self set
]

{ #category : #accessing }
BP4PEventsOfClass >> includes: anEventOrAnEventSet [
	"Answer if includes aBP4PEvent or aBP4PEventSet"

	^ anEventOrAnEventSet set
		allSatisfy: [ :e | e isKindOf: self name asClass ]
]

{ #category : #accessing }
BP4PEventsOfClass >> includesEvent: anEvent [
	"Answer if includes aBP4PEvent or aBP4PEventSet"

	^ anEvent isKindOf: self name asClass 
]

{ #category : #accessing }
BP4PEventsOfClass >> isNone [
	^ self name = 'none' | (self name = UndefinedObject name asString)
]

{ #category : #accessing }
BP4PEventsOfClass >> name [
	^ name ifNil: [ name := 'none' ]
]

{ #category : #accessing }
BP4PEventsOfClass >> name: aString [
	name := aString
]

{ #category : #'as yet unclassified' }
BP4PEventsOfClass >> printOn: aStream [
	super printOn: aStream.
	aStream nextPutAll: ' name '.
	name printOn: aStream
]

{ #category : #accessing }
BP4PEventsOfClass >> set [
	^ Set with: self
]
