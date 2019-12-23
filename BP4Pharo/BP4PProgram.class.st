Class {
	#name : #BP4PProgram,
	#superclass : #Object,
	#instVars : [
		'controller',
		'scenarioAnnouncer',
		'processes',
		'lastEvent'
	],
	#classVars : [
		'DefaultProcessPriority',
		'DefaultScenarioPriority'
	],
	#category : #BP4Pharo
}

{ #category : #private }
BP4PProgram class >> defaultProcessPriority [
	^ DefaultProcessPriority ifNil: [ DefaultProcessPriority := 20 ]
]

{ #category : #private }
BP4PProgram class >> defaultScenarioPriority [
	^ DefaultScenarioPriority ifNil: [ DefaultScenarioPriority := 10 ]
]

{ #category : #'class initialization' }
BP4PProgram class >> initialize [
	self defaultProcessPriority.
	self defaultScenarioPriority 
]

{ #category : #api }
BP4PProgram >> add: aScenario [
	^self add: aScenario priority: DefaultScenarioPriority
]

{ #category : #api }
BP4PProgram >> add: aScenario priority: aPriority [
	| addedScenarioAnnouncement |
	aScenario announcer: self announcer.
	aScenario priority: aPriority .
	self processes
		add:
			aScenario
				->
					([ aScenario valuable value: self ] newProcess
						priority: DefaultProcessPriority;
						name: aScenario name;
						yourself).
	addedScenarioAnnouncement := BP4PAddedScenarioAnnouncement
		scenario: aScenario name
		priority: aPriority.
	"Trace for show the announcement"
	Transcript
		crShow: 'Announced ' , addedScenarioAnnouncement printString.
	scenarioAnnouncer announce: addedScenarioAnnouncement
]

{ #category : #initialization }
BP4PProgram >> announcer [
^scenarioAnnouncer := scenarioAnnouncer ifNil: [ Announcer new ]
]

{ #category : #initialization }
BP4PProgram >> controller [
	^ controller
		ifNil: [ controller := BP4PController checkIn: self announcer.
			self processes
				add:
					controller
						->
							([ controller start ] newProcess
								priority: DefaultProcessPriority ;
								name: 'controller';
								yourself) ]
]

{ #category : #api }
BP4PProgram >> createSubscriptions [
	self announcer
		subscribe: BP4PChangedScenariosStatesAnnouncement
		send: #lastEvent:
		to: self.
	self announcer
		subscribe: BP4PEndScenarioAnnouncement
		send: #removeProcess:
		to: self
]

{ #category : #api }
BP4PProgram >> increasePriority: aPriorityIncrease toScenario: aScenario [
	| changedScenarioPriority newPriority |
	"Remember bigger priority smaller value"
	newPriority := aScenario priority - aPriorityIncrease.
	self processes
		keysDo: [ :k | 
			k = aScenario
				ifTrue: [ aScenario priority: newPriority ] ].
	changedScenarioPriority := BP4PChangedScenarioPriorityAnnouncement
		scenario: aScenario name
		priority: newPriority.
	"Trace for show the announcement"
	Transcript
		crShow: 'Announced ' , changedScenarioPriority printString.
	scenarioAnnouncer announce: changedScenarioPriority
]

{ #category : #initialization }
BP4PProgram >> initialize [
	super initialize.
	self class initialize.
	self controller
]

{ #category : #accessing }
BP4PProgram >> lastEvent [
	lastEvent ifNil: [ lastEvent := BP4PEvent none ] .
	^lastEvent copy
]

{ #category : #accessing }
BP4PProgram >> lastEvent: aBP4PChangedScenariosStatesAnnouncement [
	lastEvent := aBP4PChangedScenariosStatesAnnouncement event.
 self announcer
				announce: (BP4PLastEventSettedAnnouncement event: lastEvent).
			
]

{ #category : #initialization }
BP4PProgram >> processes [
	^ processes ifNil: [ processes := Dictionary new ]
]

{ #category : #api }
BP4PProgram >> removeProcess: aBP4PEndScenarioAnnouncement [
	"remove scenario ended in the map processes"

	| endedScenarioName |
	endedScenarioName := aBP4PEndScenarioAnnouncement scenario.
	processes
		keysAndValuesRemove: [ :scenario :process | process name = endedScenarioName ].
	"check if all the scenarios are sync in every change"
	"self checkAllScenariosSync."

	"Trace"
	Transcript crShow: 'Removed process for ' , endedScenarioName asString
]

{ #category : #api }
BP4PProgram >> scenarios [
	"Return the scenarios in the BP4PProgram"

	^self processes keys select: [ :e | e isKindOf: BP4PScenario  ]
]

{ #category : #api }
BP4PProgram >> start [
	"Create all the subscriptions needed"

	self createSubscriptions.


	"Resumes all processes managed by the bprogam (controller and scenarios added)"
	self processes do: [ :process | process resume ]
]

{ #category : #api }
BP4PProgram >> startScenario: aScenario [


	"Resumes the process for this scenarios"
	(self processes at: aScenario) resume
]

{ #category : #api }
BP4PProgram >> stop [
	"Terminate all the processes "

	"Initializes the scenarios class to reset iterator"

	self processes
		keysAndValuesDo: [ :scenario :process | 
			(scenario isKindOf: BP4PScenario)
				ifTrue: [ scenario class initialize.
					Transcript crShow: 'Initialize ' , scenario class printString ].
			process terminate.
			Transcript crShow: 'Terminate ' , process printString .
			].
	processes removeAll.
	processes := nil
]

{ #category : #api }
BP4PProgram >> subscribe: aBP4PEventClass do: aValuable [
	self announcer
		subscribe: aBP4PEventClass
		do: aValuable
]

{ #category : #api }
BP4PProgram >> syncRequested: rEvents waited: wEvents blocked: bEvents [
	| syncScenarioAnnouncement scenario continue outOfSyncScenarioAnnouncement continueProcessSubscription scenarioProcess |
	continue := false.
	scenarioProcess := Processor activeProcess effectiveProcess.
	scenario := self processes keyAtValue: scenarioProcess.

	"Create subscription to change the state of the process that has the scenario execution in an async form by evaluate if the selectedEvent is in requested or waited. If is true, lets resume"
	continueProcessSubscription := [ :selectedEvent | 
	continue := rEvents , wEvents includesEvent: selectedEvent event.
	continue
		ifTrue: [ scenarioProcess = Processor activeProcess effectiveProcess
				ifFalse: [ "This is not the process of the scenario execution. Resumes it"
					Transcript
						crShow:
							'Resumed ' , scenarioProcess printString , ' scenario: ' , scenario printString.
					scenarioProcess resume ]
				ifTrue: [ "This is the same process of the scenario execution"
					"scenarioProcess isSuspended"
					Transcript
						crShow:
							'Progress ' , scenarioProcess printString , ' scenario: ' , scenario printString ] ]
		ifFalse: [ Transcript crShow: 'NOT Progress ' ,scenarioProcess printString , ' scenario: ', scenario printString ] ].
	self announcer
		when: BP4PLastEventSettedAnnouncement
		send: #value:
		to: continueProcessSubscription.

	"create synchronizedScenarioAnnouncement with scenario's name and its events requesteds, waiteds and blockeds"
	syncScenarioAnnouncement := BP4PSynchronizedScenarioAnnouncement
		scenario: scenario name
		requested: rEvents
		waited: wEvents
		blocked: bEvents.
	Transcript
		crShow: 'Announced ' , syncScenarioAnnouncement printString.
	self announcer announce: syncScenarioAnnouncement.
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
