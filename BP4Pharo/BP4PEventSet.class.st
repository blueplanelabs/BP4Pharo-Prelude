Class {
	#name : #BP4PEventSet,
	#superclass : #BP4PEventSetInterface,
	#instVars : [
		'events'
	],
	#category : #BP4Pharo
}

{ #category : #accessing }
BP4PEventSet class >> name: aString [
	^ self new name: aString
]

{ #category : #accessing }
BP4PEventSet class >> with: setOfEvents [
	^ self new with: setOfEvents
]

{ #category : #accessing }
BP4PEventSet >> , aEventOrEventSetOrEventOfClass [
	"Return a new BP4PEventSet with name the combination of names and events the set of every event, eventSet or eventOfClass"

	^ BP4PEventSet with: self set , aEventOrEventSetOrEventOfClass set
]

{ #category : #'instance creation' }
BP4PEventSet >> \ anEventSet [
	"Answer the difference with anEventSet the self eventSet DONT must have eventsOfClass elements"

	| restEvents |
	"	| subtractingEventsOfClass restEvents |
	First remove the identical elements
	restEvents := self set \ anEventSet set.
	Find the eventsOfClass in the subtracting
	subtractingEventsOfClass := anEventSet set
		select: [ :e | e isKindOf: BP4PEventsOfClass ].
	Remove the events in the minuend of any class includes in subtractingEventsOfClass
	restEvents := restEvents
		select: [ :e | 
			(subtractingEventsOfClass collect: [ :eoc | eoc includes: e ])
				allSatisfy: [ :i | i = false ] ]."
	restEvents := self set
		select: [ :e | 
			anEventSet set
				noneSatisfy: [ :subtractingElement | subtractingElement includesEvent: e ] ].
	^ BP4PEventSet with: restEvents
]

{ #category : #accessing }
BP4PEventSet >> asEventSet [
	^ self
]

{ #category : #accessing }
BP4PEventSet >> includes: anEventOrAnEventSet [
	"answer if includes anEventOrAnEventSet"

	^ (self set intersection: anEventOrAnEventSet set)
		= anEventOrAnEventSet set
]

{ #category : #accessing }
BP4PEventSet >> includesEvent: anEvent [
	"Answer if includes anEvent.
	anEvent is included if any of the elements (events of eventsOffClass) includes it"

	^self set anySatisfy: [ :e | e includesEvent: anEvent ]
]

{ #category : #accessing }
BP4PEventSet >> isEmpty [
	^ self set isEmpty or: [self set allSatisfy: [ :e | e isNone ]]
]

{ #category : #accessing }
BP4PEventSet >> isNone [
	^ self set allSatisfy: [ :e | e isNone ]
]

{ #category : #accessing }
BP4PEventSet >> name [
	"	^ name
		ifNil: [ name := Set with: (self className withoutSuffix: ' class') ]
		Probar con esto y quitar nameBySetOfEvents:"

^ name := ',' join: (self set collect: [ :each | each name ])
]

{ #category : #accessing }
BP4PEventSet >> name: aString [
	name := aString
]

{ #category : #printing }
BP4PEventSet >> printOn: aStream [
	super printOn: aStream.
	aStream nextPutAll: ' name '.
	self name printOn: aStream
]

{ #category : #removing }
BP4PEventSet >> remove: aEventOrEventSetOrEventOfClass [
	events := self set difference: aEventOrEventSetOrEventOfClass set.

]

{ #category : #removing }
BP4PEventSet >> removeNone [
	self remove: BP4PEvent none.
]

{ #category : #accessing }
BP4PEventSet >> set [
	events isEmptyOrNil
		ifTrue: [ events := Set with: BP4PEvent none ].
^		events
]

{ #category : #accessing }
BP4PEventSet >> size [
	^ self set size
]

{ #category : #'instance creation' }
BP4PEventSet >> with: setOfEvents [


	events := setOfEvents
]
