Class {
	#name : #BP4PScenarioState,
	#superclass : #Object,
	#instVars : [
		'requestedEvents',
		'waitedEvents',
		'blockedEvents',
		'synchronized',
		'priority'
	],
	#category : #BP4Pharo
}

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
		priority: aPriority
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
BP4PScenarioState >> isSynchronized [

	^ synchronized 
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
]

{ #category : #accessing }
BP4PScenarioState >> synchronized: anObject [
	synchronized := anObject
]

{ #category : #accessing }
BP4PScenarioState >> waited: anObject [
	waitedEvents := anObject
]

{ #category : #accessing }
BP4PScenarioState >> waitedEvents [
	^ waitedEvents
]
