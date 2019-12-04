Class {
	#name : #BP4PEventSetInterface,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #BP4Pharo
}

{ #category : #accessing }
BP4PEventSetInterface class >> name: aName [
	"Constructor with name."

	self subclassResponsibility
]

{ #category : #accessing }
BP4PEventSetInterface >> , aBP4PEvent [
	"Make the union with other Event."

	self subclassResponsibility
]

{ #category : #comparing }
BP4PEventSetInterface >> = anObject [
^ self name = anObject name
]

{ #category : #comparing }
BP4PEventSetInterface >> hash [ 
	^ self name hash
]

{ #category : #accessing }
BP4PEventSetInterface >> includesEvent: anEvent [
	"Answer if includes aBP4PEvent"

	self subclassResponsibility
]

{ #category : #accessing }
BP4PEventSetInterface >> isNone [
	"True if is the none event"

	self subclassResponsibility
]

{ #category : #accessing }
BP4PEventSetInterface >> name [
	"Getter for name."

	self subclassResponsibility
]

{ #category : #accessing }
BP4PEventSetInterface >> name: aName [
	"Setter for name."

	self subclassResponsibility
]

{ #category : #accessing }
BP4PEventSetInterface >> set [
	"Answer a set with all the events it contains"

	self subclassResponsibility
]

{ #category : #accessing }
BP4PEventSetInterface >> withoutNone [
	"True if is the none event"

	self subclassResponsibility
]
