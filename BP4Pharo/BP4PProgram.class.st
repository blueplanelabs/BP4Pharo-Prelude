Class {
	#name : #BP4PProgram,
	#superclass : #Object,
	#instVars : [
		'controller',
		'scenarios',
		'scenarioAnnouncer'
	],
	#category : #BP4Pharo
}

{ #category : #api }
BP4PProgram >> add: aScenario [
	| addedScenarioAnnouncement |
	scenarios add: aScenario.
	addedScenarioAnnouncement := BP4PAddedScenarioAnnouncement
		scenario: aScenario name
		priority: aScenario priority.
	scenarioAnnouncer announce: addedScenarioAnnouncement.
	"Trace for show the announcement"
	Transcript
		crShow: 'Announced ' , addedScenarioAnnouncement printString
]

{ #category : #initialization }
BP4PProgram >> announcer [
^scenarioAnnouncer := scenarioAnnouncer ifNil: [ Announcer new ]
]

{ #category : #initialization }
BP4PProgram >> controller [
	^ controller := controller ifNil: [ BP4PController checkIn: self announcer ]
]

{ #category : #initialization }
BP4PProgram >> initialize [
	super initialize.
	self
		announcer;
		scenarios;
		controller
]

{ #category : #initialization }
BP4PProgram >> scenarios [
^ scenarios := scenarios ifNil: [OrderedCollection new].
]

{ #category : #api }
BP4PProgram >> start [
	"start bpcontroller in a new process"

	[ controller start ] forkAt: 20 named: 'controller'.

	"start every scenario add to the bprogram in a diferent process"
	scenarios
		do:
			[ :scenario | [ scenario valuable value: self ] forkAt: 20 named: scenario name ]
]

{ #category : #api }
BP4PProgram >> syncRequested: rEvents waited: wEvents blocked: bEvents [
	| syncScenarioAnnouncement tempContext scenario continue |
	tempContext := thisContext.

	"go through the contexts until it find the scenario to which it belongs"
	continue := false.
	[ tempContext receiver isKindOf: BP4PScenario ]
		whileFalse: [ tempContext := tempContext sender ].
	scenario := tempContext receiver.
	"Create subscription to change the value of continue in an async form by evaluate if the selectedEvent is in requested or blocked. If is true, lets continue"
	scenarioAnnouncer
		when: BP4PSelectedEventAnnouncement
		send: #value:
		to: [ :selectedEvent | 
			continue := rEvents , wEvents includes: selectedEvent event.
			"Trace for show scenario progress or NOT progress"
			continue
				ifTrue: [ Transcript crShow: 'Progress ' , scenario printString ]
				ifFalse: [ Transcript crShow: 'NOT Progress ' , scenario printString ] ].
	"create synchronizedScenarioAnnouncement with scenario's name and its events requesteds, waiteds and blockeds"
	syncScenarioAnnouncement := BP4PSynchronizedScenarioAnnouncement
		scenario: scenario name
		requested: rEvents
		waited: wEvents
		blocked: bEvents.
	scenarioAnnouncer announce: syncScenarioAnnouncement.
	Transcript
		crShow: 'Announced ' , syncScenarioAnnouncement printString.
	[ (Delay forSeconds: 10) wait.
	continue ] whileFalse.
	scenarioAnnouncer
		announce: (BP4POutOfSyncScenarioAnnouncement scenario: scenario name)
]
