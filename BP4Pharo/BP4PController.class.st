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
		createSubscriptions;
		yourself.
	^ controller
]

{ #category : #'private-actions' }
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
	^ auctionner := auctionner
		ifNil: [ BP4PAuctionner checkIn: self announcer]
]

{ #category : #'private-actions' }
BP4PController >> checkAllScenariosSync [
	"	Check if all the scenarios are sync.
		Called when each synchronizedScenarioAnnouncement arrived.
		Create allScenariosSyncAnnouncement if true
	"

	((scenarios collect: [ :each | each isSynchronized ]) values
		allSatisfy: [ :each | each ])
		ifFalse: [ Transcript crShow: 'Scenarios NOT Synchronized'.
			^self ].
	Transcript crShow: 'ALL Scenarios Synchronized'.
	announcer
		announce: (BP4PAllScenariosSyncAnnouncement scenariosStates: scenarios values)
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
		to: self.
	announcer
		subscribe: BP4POutOfSyncScenarioAnnouncement
		send: #outOfSyncScenario:
		to: self
]

{ #category : #'private-actions' }
BP4PController >> outOfSyncScenario: aBP4POutOfSyncScenarioAnnouncement [
	"change the synchronized value of scenario to false in the map scenarios"

	| scenarioName |
	scenarioName := aBP4POutOfSyncScenarioAnnouncement scenario.
	scenarios
		at: scenarioName
		put: ((scenarios at: scenarioName) synchronized: false).
		
	"Trace"
	Transcript
		crShow: 'Received ' , aBP4POutOfSyncScenarioAnnouncement printString
]

{ #category : #'private - initialization' }
BP4PController >> scenarios [
	^ scenarios := scenarios ifNil: [ Dictionary new ]
]

{ #category : #api }
BP4PController >> start [
	"initially check if all the scenarios are sync"
	
	self checkAllScenariosSync
	
	"check if all bscenarios are synchronized and if is true publish event allscenariossync with all scenarios states

	[ true ]
		whileTrue: [ ((scenarios collect: [ :each | each isSynchronized ]) values
				allSatisfy: [ :each | each ])
				ifTrue: [ Transcript crShow: 'All Scenarios Synchronized'.
					announcer
						announce: (BP4PAllScenariosSyncAnnouncement scenariosStates: scenarios values) ] ]"
]

{ #category : #'private-actions' }
BP4PController >> syncScenario: aBP4PSynchronizedScenarioAnnouncement [
	"	Change info from the announcement of scenario synchronized in the BP4PProgram to the map scenarios. "

	| scenarioName |
	scenarioName := aBP4PSynchronizedScenarioAnnouncement scenario.
	scenarios
		at: scenarioName
		put:
			((scenarios at: scenarioName)
				requested: aBP4PSynchronizedScenarioAnnouncement requestedEvents;
				waited: aBP4PSynchronizedScenarioAnnouncement waitedEvents;
				blocked: aBP4PSynchronizedScenarioAnnouncement blockedEvents;
				synchronized: true;
				yourself).

	"check if all the scenarios are sync in every change"
	self checkAllScenariosSync.

	"Trace"
	Transcript
		crShow: 'Received ' , aBP4PSynchronizedScenarioAnnouncement printString
]
