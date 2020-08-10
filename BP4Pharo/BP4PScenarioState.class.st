Class {
	#name : #BP4PScenarioState,
	#superclass : #Object,
	#instVars : [
		'requestedEvents',
		'waitedEvents',
		'blockedEvents',
		'synchronized',
		'auctioned',
		'priority'
	],
	#category : #BP4Pharo
}

{ #category : #creation }
BP4PScenarioState class >> requested: rEvents waited: wEvents blocked: bEvents synchronized: aBoolean auctioned: anotherBoolean priority: aPriority [
	^ self new
		requested: rEvents
		waited: wEvents
		blocked: bEvents
		synchronized: aBoolean
		auctioned: anotherBoolean
		priority: aPriority
]

{ #category : #creation }
BP4PScenarioState class >> requested: rEvents waited: wEvents blocked: bEvents synchronized: aBoolean priority: aPriority [
	^ self new
		requested: rEvents
		waited: wEvents
		blocked: bEvents
		synchronized: aBoolean
		priority: aPriority
]

{ #category : #creation }
BP4PScenarioState class >> withPriority: aPriority [
	"comment stating purpose of message"

	^ self new
		requested: nil
		waited: nil
		blocked: nil
		synchronized: false
		auctioned: false
		priority: aPriority
]

{ #category : #accessing }
BP4PScenarioState >> auctioned [
	^ auctioned ifNil: [ auctioned := false]
]

{ #category : #accessing }
BP4PScenarioState >> blocked: anObject [
	blockedEvents := anObject
]

{ #category : #accessing }
BP4PScenarioState >> blockedEvents [
	^ blockedEvents
]

{ #category : #api }
BP4PScenarioState >> isAuctioned [
	^ self auctioned
]

{ #category : #accessing }
BP4PScenarioState >> isProgressedWithEvent: aBP4PEvent [
^ self requestedEvents , self waitedEvents includesEvent: aBP4PEvent
]

{ #category : #api }
BP4PScenarioState >> isSynchronized [
	^ synchronized
"Changing to:
isSynchronized
	^ synchronized ifNil: [  ]"	

]

{ #category : #printing }
BP4PScenarioState >> printOn: aStream [
	aStream nextPut: Character cr.
	super printOn: aStream.
	aStream nextPutAll: ' Request: '.
	self requestedEvents printOn: aStream.
	aStream nextPutAll: ' Waited: '.
	self waitedEvents printOn: aStream.
	aStream nextPutAll: ' Blocked: '.
	self blockedEvents printOn: aStream.
	aStream nextPutAll: ' Priority: '.
	self priority printOn: aStream.
	aStream nextPutAll: ' Synchronized: '.
	self isSynchronized printOn: aStream
]

{ #category : #accessing }
BP4PScenarioState >> priority [
	^ priority
]

{ #category : #accessing }
BP4PScenarioState >> priority: anObject [
	priority := anObject
]

{ #category : #accessing }
BP4PScenarioState >> requested: anObject [
	requestedEvents := anObject
]

{ #category : #initalize }
BP4PScenarioState >> requested: rEvents waited: wEvents blocked: bEvents synchronized: aBoolean auctioned: anotherBoolean priority: aPriority [
	requestedEvents := rEvents.
	waitedEvents := wEvents.
	blockedEvents := bEvents.
	synchronized := aBoolean.
	auctioned := anotherBoolean.
	priority := aPriority
]

{ #category : #initalize }
BP4PScenarioState >> requested: rEvents waited: wEvents blocked: bEvents synchronized: aBoolean priority: aPriority [
	requestedEvents := rEvents.
	waitedEvents := wEvents.
	blockedEvents := bEvents.
	synchronized := aBoolean.
	priority := aPriority
]

{ #category : #accessing }
BP4PScenarioState >> requestedEvents [
	^ requestedEvents
		ifNil: [ requestedEvents := BP4PEvent none ]
]

{ #category : #accessing }
BP4PScenarioState >> synchronize [
	synchronized := true
]

{ #category : #accessing }
BP4PScenarioState >> synchronized: aBoolean [
	synchronized := aBoolean
]

{ #category : #accessing }
BP4PScenarioState >> unsynchronize [
	synchronized := false
]

{ #category : #accessing }
BP4PScenarioState >> waited: anObject [
	waitedEvents := anObject
]

{ #category : #accessing }
BP4PScenarioState >> waitedEvents [
	^ waitedEvents ifNil: [ waitedEvents := BP4PEvent none ]
]
