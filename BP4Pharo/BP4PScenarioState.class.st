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

{ #category : #api }
BP4PScenarioState >> updateBySync: aBP4PScenarioState [
	"change the values modified by a sync"

	requestedEvents := aBP4PScenarioState requestedEvents.
	waitedEvents := aBP4PScenarioState waitedEvents.
	blockedEvents := aBP4PScenarioState blockedEvents.
	synchronized := aBP4PScenarioState isSynchronized
]

{ #category : #accessing }
BP4PScenarioState >> waitedEvents [
	^ waitedEvents
]
