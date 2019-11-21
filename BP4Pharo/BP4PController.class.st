Class {
	#name : #BP4PController,
	#superclass : #Object,
	#instVars : [
		'scenarios',
		'announcer',
		'auctionner'
	],
	#category : #BP4Pharo
}

{ #category : #creation }
BP4PController class >> checkIn: anAnnouncer [
	"create a BP4PController for aBP4PProgram"

	| controller |
	controller := self new
		checkIn: anAnnouncer;
		scenarios;
		auctionner;
		createSubscriptions.
	^ controller
]

{ #category : #'private - initialization' }
BP4PController >> addScenario: aBP4PAddedScenarioAnnouncement [
	"add info from the announcement of scenario added in the BP4PProgram to the map scenarios"

	scenarios
		at: aBP4PAddedScenarioAnnouncement scenario
		put: (BP4PScenarioState withPriority: aBP4PAddedScenarioAnnouncement priority).

	"Trace"
	Transcript
		crShow: 'Received ' , aBP4PAddedScenarioAnnouncement printString
]

{ #category : #accessing }
BP4PController >> announcer [
	^ announcer
]

{ #category : #accessing }
BP4PController >> auctionner [
	^ auctionner ifNil: [ auctionner := BP4PAuctionner checkIn: self announcer ] 
]

{ #category : #'private - initialization' }
BP4PController >> checkIn: anAnnouncer [
	announcer := anAnnouncer
]

{ #category : #'private - initialization' }
BP4PController >> createSubscriptions [
	announcer
		subscribe: BP4PAddedScenarioAnnouncement
		send: #addScenario:
		to: self.
	announcer
		subscribe: BP4PSynchronizedScenarioAnnouncement
		send: #syncScenario:
		to: self
]

{ #category : #'private - initialization' }
BP4PController >> scenarios [
	^ scenarios := scenarios ifNil: [ Dictionary new ]
]

{ #category : #'private - initialization' }
BP4PController >> start [
	[ true ]
		whileTrue: [ ((scenarios collect: [ :each | each isSynchronized ]) values
				allSatisfy: [ :each | each ] )ifTrue: [ Transcript crShow: 'All Scenarios Synchronized' ] ]
]

{ #category : #'private - initialization' }
BP4PController >> syncScenario: aBP4PSynchronizedScenarioAnnouncement [
	"change info from the announcement of scenario synchronized in the BP4PProgram to the map scenarios"
	|scenarioName|
	
	scenarioName := aBP4PSynchronizedScenarioAnnouncement scenario.
	scenarios
		at: scenarioName
		put:
			((scenarios at: scenarioName)
				requested: aBP4PSynchronizedScenarioAnnouncement requestedEvents
				waited: aBP4PSynchronizedScenarioAnnouncement waitedEvents 
				blocked: aBP4PSynchronizedScenarioAnnouncement blockedEvents 
				synchronized: true
				priority:
					(scenarios at: scenarioName )
						priority).

	"Trace"
	Transcript
		crShow: 'Received ' , aBP4PSynchronizedScenarioAnnouncement printString
]
