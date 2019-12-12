Class {
	#name : #BP4PAuctionner,
	#superclass : #Object,
	#instVars : [
		'announcer'
	],
	#category : #BP4Pharo
}

{ #category : #creation }
BP4PAuctionner class >> checkIn: anAnnouncer [
	"create a BP4PAuctionner for aBP4Controller"

	^ self new
		checkIn: anAnnouncer;
		createSubscriptions;
		yourself
]

{ #category : #'private - initialization' }
BP4PAuctionner >> checkIn: anAnnouncer [
	announcer := anAnnouncer 
]

{ #category : #'private - initialization' }
BP4PAuctionner >> chooseEventByPriorityStrategy: scenariosStates [
	| selectedEvent orderedRequested orderedBlocked candidates |
	"Sort scenariosStates by priority order (the smaller value the higher priority)"
	scenariosStates sort: [ :a :b | a priority < b priority ].
	orderedRequested := self
		extractByPriorityFrom: scenariosStates
		eventsType: #requestedEvents.
	"There are none event requested return none event"
	orderedRequested isEmpty
		ifTrue: [ ^ BP4PEvent none ].
	orderedBlocked := self
		extractByPriorityFrom: scenariosStates
		eventsType: #blockedEvents.
	candidates := orderedRequested
		select: [ :e | 
			orderedBlocked
				noneSatisfy: [ :blockElement | blockElement includesEvent: e ] ].
	"If all requested events are blocked return an event with name nil else the first event of the candidates"
	candidates isEmpty
		ifTrue: [ Transcript crShow: 'ALL REQUESTED EVENTS ARE BLOCKED'.
			selectedEvent := BP4PEvent none ]
		ifFalse: [ selectedEvent := candidates first ].
	^ selectedEvent
]

{ #category : #'private - initialization' }
BP4PAuctionner >> createSubscriptions [
	announcer
		subscribe: BP4PAllScenariosSyncAnnouncement 
		send: #selectEvent:
		to: self.

]

{ #category : #'private - initialization' }
BP4PAuctionner >> extractByPriorityFrom: scenariosStates eventsType: aEventsTypeSymbol [
	"types: requested -> #requestedEvents , waited -> #waitedEvents , blocked -> blockedEvents"

	| elements |
	elements := OrderedCollection new.
	"Create a collection with the requested events of each scenario"
	elements := scenariosStates
		collect: [ :scenarioState | 
			| scenarioEventSetType |
			scenarioEventSetType := (MessageSend
				receiver: scenarioState
				selector: aEventsTypeSymbol) value.
			scenarioEventSetType asEventSet removeNone set asOrderedCollection ].
	"Remove the none events"
	^elements := elements flattened.

	"Transform the EventOfClass for concrete Events"
	"	^ elements
		collect:
			[ :event | 
			(event isKindOf: BP4PEventsOfClass)
				ifTrue: [ elements select: [ :e | e isKindOf: event class ] ]
				ifFalse: [ event ] ] flattened"
]

{ #category : #'private - initialization' }
BP4PAuctionner >> selectEvent: aBP4PAllScenariosSyncAnnouncement [
	"select an event and publish a selectedEventAnnouncement"

	| selectedEvent |
	selectedEvent := self
		chooseEventByPriorityStrategy: aBP4PAllScenariosSyncAnnouncement scenariosStates.
	selectedEvent isNone
		ifTrue: [ Transcript crShow: 'ALL SCENARIOS SYNC AND NONE EVENT REQUESTED' ].
	"Trace for show selected Event"
	Transcript crShow: '===============================Selected Event ' , selectedEvent printString, '====================================='.
	announcer
		announce: (BP4PSelectedEventAnnouncement event: selectedEvent)
]
