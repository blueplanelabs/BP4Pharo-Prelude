Class {
	#name : #BP4PEvent,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #BP4Pharo
}

{ #category : #accessing }
BP4PEvent class >> name: aName [

	^self new name: aName
]

{ #category : #accessing }
BP4PEvent >> , aBP4PEvent [
	"return a new BP4PEventadd with self names and the names of the other event"

	^ BP4PEvent name: (self name , aBP4PEvent name)
]

{ #category : #accessing }
BP4PEvent >> includes: aBP4PEvent [
	"answer if includes aBP4PEvent"

	^(self name intersection: aBP4PEvent name) isNotEmpty
]

{ #category : #accessing }
BP4PEvent >> name [
	^ name
		ifNil: [name := Set with: (self className withoutSuffix: ' class') ]
]

{ #category : #accessing }
BP4PEvent >> name: aName [
	(aName isKindOf: Set) ifTrue: [ name:=aName ]ifFalse: [name := Set with: aName]
]

{ #category : #printing }
BP4PEvent >> printOn: aStream [
	super printOn: aStream.
	aStream nextPutAll: ' name '.
	name printOn: aStream
]
