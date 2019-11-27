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
BP4PEvent >> , aEventOrEventSet [
	"Return a new BP4PEventSet with self name and the names of the other event or eventSet"

	^ BP4PEventSet name: self name , aEventOrEventSet name
]

{ #category : #accessing }
BP4PEvent >> events [
	^self
]

{ #category : #accessing }
BP4PEvent >> includes: aBP4PEvent [
	"answer if includes aBP4PEvent"

	^(self name intersection: aBP4PEvent name) isNotEmpty
]

{ #category : #accessing }
BP4PEvent >> name [
"	^ name
		ifNil: [ name := Set with: (self className withoutSuffix: ' class') ]"

	^ name
		ifNil: [ name := Set new ]
]

{ #category : #accessing }
BP4PEvent >> name: aString [
	name := Set with: aString
]

{ #category : #printing }
BP4PEvent >> printOn: aStream [
	super printOn: aStream.
	aStream nextPutAll: ' name '.
	name printOn: aStream
]
