Class {
	#name : #BP4PProgram,
	#superclass : #Object,
	#instVars : [
		'controller',
		'scenarios',
		'scenarioAnnouncer',
		'processes',
		'lastEvent'
	],
	#category : #BP4Pharo
}

{ #category : #api }
BP4PProgram >> add: aScenario [
	| addedScenarioAnnouncement |
	aScenario announcer: self announcer .
	self scenarios add: aScenario.
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

{ #category : #api }
BP4PProgram >> createSubscriptions [
	self announcer
		subscribe: BP4PChangedScenariosStatesAnnouncement
		send: #lastEvent:
		to: self
]

{ #category : #initialization }
BP4PProgram >> initialize [
	super initialize.
	self
		announcer;
		scenarios;
		controller;
		processes
]

{ #category : #accessing }
BP4PProgram >> lastEvent [
	^ lastEvent
]

{ #category : #accessing }
BP4PProgram >> lastEvent: aBP4PChangedScenariosStatesAnnouncement [
	lastEvent := aBP4PChangedScenariosStatesAnnouncement event.
	lastEvent = (BP4PEvent none)
		ifFalse: [ ^ self ].
	Transcript crShow: 'Program stopped'.
	self stop
]

{ #category : #initialization }
BP4PProgram >> processes [
	^ processes ifNil: [ processes := Dictionary new ]
]

{ #category : #initialization }
BP4PProgram >> scenarios [
^ scenarios := scenarios ifNil: [OrderedCollection new].
]

{ #category : #api }
BP4PProgram >> start [
	"Create all the subscriptions needed"

	self createSubscriptions.

	"start bpcontroller in a new process"
	self processes
		add:
			self controller
				-> ([ controller start ] forkAt: 20 named: 'controller').

	"start every scenario add to the bprogram in a diferent process"
	self scenarios
		do: [ :scenario | 
			self processes
				add:
					scenario
						-> ([ scenario valuable value: self ] forkAt: 20 named: scenario name) ]
]

{ #category : #api }
BP4PProgram >> stop [
	"Terminate all the processes "

	self processes do: [ :process | process terminate ].
	processes := nil
]

{ #category : #api }
BP4PProgram >> syncRequested: rEvents waited: wEvents blocked: bEvents [
	| syncScenarioAnnouncement tempContext scenario continue outOfSyncScenarioAnnouncement continueProcessSubscription scenarioProcess |
	"tempContext := thisContext."
	continue := false.

	"go through the contexts until it find the scenario to which it belongs
	[ tempContext receiver isKindOf: BP4PScenario ]
		whileFalse: [ tempContext := tempContext sender ].
	scenario := tempContext receiver."
	scenario := self processes
		keyAtValue: Processor activeProcess effectiveProcess.
	scenarioProcess := self processes at: scenario.

	"Create subscription to change the state of the process that has the scenario execution in an async form by evaluate if the selectedEvent is in requested or waited. If is true, lets resume"
	continueProcessSubscription := [ :selectedEvent | 
	continue := rEvents , wEvents includesEvent: selectedEvent event.
	continue
		ifTrue: [ scenarioProcess = Processor activeProcess effectiveProcess
				ifFalse: [ "This is not the process of the scenario execution. Resumes it"
					Transcript
						crShow:
							'Resumed process ' , scenarioProcess printString , ' '
								, scenarioProcess name.
					scenarioProcess resume ]
				ifTrue: [ "This is the same process of the scenario execution"
					"scenarioProcess isSuspended"
					Transcript
						crShow:
							'Progress process ' , scenarioProcess printString , ' '
								, scenarioProcess name ] ]
		ifFalse: [ Transcript crShow: 'NOT Progress ' , scenario printString ] ].
	self announcer
		when: BP4PChangedScenariosStatesAnnouncement
		send: #value:
		to: continueProcessSubscription.

	"create synchronizedScenarioAnnouncement with scenario's name and its events requesteds, waiteds and blockeds"
	syncScenarioAnnouncement := BP4PSynchronizedScenarioAnnouncement
		scenario: scenario name
		requested: rEvents
		waited: wEvents
		blocked: bEvents.
	self announcer announce: syncScenarioAnnouncement.
	Transcript
		crShow: 'Announced ' , syncScenarioAnnouncement printString.
	"	[ (Delay forSeconds: 10) wait.
	continue ] whileFalse."
	continue
		ifFalse: [ Transcript crShow: 'Suspended process ' , scenarioProcess name.
			scenarioProcess suspend ].
	"Unsubscribe continueProcessSubscription from scenarioAnnouncer"
	self announcer unsubscribe: continueProcessSubscription
	"outOfSyncScenarioAnnouncement := BP4POutOfSyncScenarioAnnouncement
		scenario: scenario name.
	self announcer announce: outOfSyncScenarioAnnouncement.
	Transcript
		crShow: 'Announced ' , outOfSyncScenarioAnnouncement printString"
]
