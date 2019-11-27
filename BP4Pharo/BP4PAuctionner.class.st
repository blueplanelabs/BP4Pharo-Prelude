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
BP4PAuctionner >> chooseEvent: scenariosStates [
	| selectedEvent requested blocked candidates |
	scenariosStates sort: [ :a :b | a priority > b priority ].
	requested := self
		extractFrom: scenariosStates
		eventsType: #requestedEvents.
	"There are none event requested return none event"
	requested isEmpty
		ifTrue: [ ^ BP4PEvent new ].
	blocked := self
		extractFrom: scenariosStates
		eventsType: #blockedEvents.
	candidates := requested select: [ :r | (blocked includes: r) not ].
	"If all requested events are blocked return an event with name nil else the first event of the candidates"
	candidates isEmpty
		ifTrue: [ Transcript crShow: 'ALL REQUESTED EVENTS ARE BLOCKED'.
			selectedEvent := BP4PEvent name: nil ]
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
BP4PAuctionner >> extractFrom: scenariosStates eventsType: aEventsTypeSymbol [
	"types: requested -> #requestedEvents , waited -> #waitedEvents , blocked -> blockedEvents"

	| elements |
	elements := OrderedCollection new.
	elements := scenariosStates
		collect: [ :scenarioState | 
			(MessageSend receiver: scenarioState selector: aEventsTypeSymbol)
				value events ].
	"Remove the none events"
	^ elements flattened asOrderedCollection
		removeAllSuchThat: [ :e | e name isEmpty ]
]

{ #category : #'private - initialization' }
BP4PAuctionner >> selectEvent: aBP4PAllScenariosSyncAnnouncement [
	"select an event and publish a selectedEventAnnouncement"

	| selectedEvent |
	selectedEvent := self
		chooseEvent: aBP4PAllScenariosSyncAnnouncement scenariosStates.

	"Trace for show selected Event"
	Transcript crShow: 'Selected Event ' , selectedEvent printString .
	announcer
		announce: (BP4PSelectedEventAnnouncement event: selectedEvent)
]
