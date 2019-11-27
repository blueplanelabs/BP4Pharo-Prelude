Class {
	#name : #BP4PEventSet,
	#superclass : #BP4PEventSetInterface,
	#category : #BP4Pharo
}

{ #category : #accessing }
BP4PEventSet class >> name: aSetOfStrings [
	^ self new name: aSetOfStrings
]

{ #category : #accessing }
BP4PEventSet >> , anEventOrAnEventSet [
	"return a new BP4PEventadd with self names and the names of the other event"

	^ BP4PEventSet name: self name , anEventOrAnEventSet name
]

{ #category : #accessing }
BP4PEventSet >> events [

	^ self name collect: [ :e | BP4PEvent name: e ]
]

{ #category : #accessing }
BP4PEventSet >> includes: anEventOrAnEventSet [
	"answer if includes anEventOrAnEventSet"

	^ (self name intersection: anEventOrAnEventSet name) = anEventOrAnEventSet name
]

{ #category : #accessing }
BP4PEventSet >> name [
"	^ name
		ifNil: [ name := Set with: (self className withoutSuffix: ' class') ]"

	^ name
		ifNil: [ name := Set new ]
]

{ #category : #accessing }
BP4PEventSet >> name: aSetOfStrings [
	name := aSetOfStrings

]

{ #category : #printing }
BP4PEventSet >> printOn: aStream [
	super printOn: aStream.
	aStream nextPutAll: ' name '.
	name printOn: aStream
]
