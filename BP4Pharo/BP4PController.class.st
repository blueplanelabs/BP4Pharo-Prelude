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

	self scenarios
		at: aBP4PAddedScenarioAnnouncement scenario
		put:
			(BP4PScenarioState
				withPriority: aBP4PAddedScenarioAnnouncement priority).

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
BP4PController >> changeScenarioPriority: aBP4PChangedScenarioPriorityAnnouncement [
	""

	(self scenarios
		at: aBP4PChangedScenarioPriorityAnnouncement scenario)
		priority: aBP4PChangedScenarioPriorityAnnouncement priority.

	"Trace"
	Transcript
		crShow: 'Received ' , aBP4PChangedScenarioPriorityAnnouncement printString
]

{ #category : #'private-actions' }
BP4PController >> checkAllScenariosSync [
	"	Check if all the scenarios are sync.
		Called when each synchronizedScenarioAnnouncement arrived.
		Create allScenariosSyncAnnouncement if true
	"
	|allScenariosSyncAnnouncement|
	(scenarios allSatisfy: [ :e | e isSynchronized ])
		ifFalse: [ Transcript crShow: 'Scenarios NOT Synchronized'.
			^ self ].
	Transcript
		crShow:
			'ALL Scenarios Synchronized '
				, Processor activeProcess effectiveProcess printString , ' '
				, Processor activeProcess effectiveProcess name.

	allScenariosSyncAnnouncement := BP4PAllScenariosSyncAnnouncement scenariosStates: scenarios values.
	"Trace"
	Transcript
		crShow: 'Announced ' , allScenariosSyncAnnouncement printString.
	announcer
		announce: allScenariosSyncAnnouncement
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
		subscribe: BP4PChangedScenarioPriorityAnnouncement
		send: #changeScenarioPriority:
		to: self.
	announcer
		subscribe: BP4PSynchronizedScenarioAnnouncement
		send: #syncScenario:
		to: self.
	announcer
		subscribe: BP4PEndScenarioAnnouncement
		send: #removeScenario:
		to: self.
	announcer subscribe: BP4PEvent send: #updateScenariosStates: to: self
]

{ #category : #'private-actions' }
BP4PController >> removeScenario: aBP4PEndScenarioAnnouncement [
	"remove scenario ended in the map scenarios"

	"Trace"

	Transcript
		crShow:
			'Removed in controller '
				, aBP4PEndScenarioAnnouncement scenario asString.
	self scenarios
		removeKey: aBP4PEndScenarioAnnouncement scenario
		ifAbsent: [ 'Not present in controller' ].



	"check if all the scenarios are sync in every change"
	self checkAllScenariosSync
]

{ #category : #'private - initialization' }
BP4PController >> scenarios [
	^ scenarios ifNil: [scenarios := Dictionary new ]
]

{ #category : #api }
BP4PController >> start [
	"initially check if all the scenarios are sync"

	self checkAllScenariosSync


]

{ #category : #api }
BP4PController >> stop [
	""

	self scenarios removeAll
]

{ #category : #'private-actions' }
BP4PController >> syncScenario: aBP4PSynchronizedScenarioAnnouncement [
	"	Change info from the announcement of scenario synchronized in the BP4PProgram to the map scenarios. "

	| scenarioName |
	"Trace"
	Transcript
		crShow: 'Received ' , aBP4PSynchronizedScenarioAnnouncement printString.
	scenarioName := aBP4PSynchronizedScenarioAnnouncement scenario.
	self scenarios
		at: scenarioName
		ifPresent: [ :scenarioState | 
			scenarioState
				requested: aBP4PSynchronizedScenarioAnnouncement requestedEvents;
				waited: aBP4PSynchronizedScenarioAnnouncement waitedEvents;
				blocked: aBP4PSynchronizedScenarioAnnouncement blockedEvents;
				synchronized: true ]
		ifAbsent: [ Transcript
				crShow:
					'Trying to synchronize scenario ' , scenarioName
						, ' not present in Controller' ].


	"check if all the scenarios are sync in every change"
	self checkAllScenariosSync
]

{ #category : #'private-actions' }
BP4PController >> updateScenariosStates: aBP4PEvent [
	"	Change to usync scenariosState whose scenario has this event requested or waited. "



	aBP4PEvent isNone
		ifTrue: [ ^ self ].
	scenarios
		do: [ :scenarioState | 
			(scenarioState isProgressedWithEvent: aBP4PEvent)
				ifTrue: [ scenarioState unsynchronize ] ].
	Transcript crShow: 'Announced changedScenariosStates'.
	self announcer
		announce: (BP4PChangedScenariosStatesAnnouncement event: aBP4PEvent)
]
