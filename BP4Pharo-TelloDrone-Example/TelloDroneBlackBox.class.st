Class {
	#name : #TelloDroneBlackBox,
	#superclass : #ComposablePresenter,
	#instVars : [
		'message',
		'bp',
		'eventsHistory'
	],
	#category : #'BP4Pharo-TelloDrone-Example-TelloDrone-GUI'
}

{ #category : #specs }
TelloDroneBlackBox class >> defaultSpec [
	^ SpecColumnLayout composed
		newRow: [ :row | row add: #message ] height: self toolbarHeight * 10;
		yourself
]

{ #category : #accessing }
TelloDroneBlackBox >> bp [
	^ bp
]

{ #category : #accessing }
TelloDroneBlackBox >> bp: anObject [
	bp := anObject
]

{ #category : #initialization }
TelloDroneBlackBox >> createSubscriptions [
	self bp
		subscribe: TakeoffEvent
		do: [ :takeoffEvent | 
			eventsHistory := 'Fasten your belts lets take off'
				, Character cr asString , eventsHistory.
			self message text: eventsHistory ].
	self bp
		subscribe: BP4PEvent
		do: [ :event | 
			eventsHistory := event name , Character cr asString , eventsHistory.
			self message text: eventsHistory ]
]

{ #category : #initialization }
TelloDroneBlackBox >> initializeWidgets [
	"widget instantiation"

	message := self newText.
	"widget configuration"
	eventsHistory := 'Waiting for takeoff ...'.
	message text: eventsHistory.

	"specification of order of focus"
	self focusOrder add: message
]

{ #category : #accessing }
TelloDroneBlackBox >> message [
	^ message
]

{ #category : #accessing }
TelloDroneBlackBox >> message: anObject [
	message := anObject
]

{ #category : #api }
TelloDroneBlackBox >> title [
^ 'Black Box'
]
