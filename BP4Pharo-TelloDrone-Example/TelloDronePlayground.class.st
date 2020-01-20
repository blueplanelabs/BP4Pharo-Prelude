Class {
	#name : #TelloDronePlayground,
	#superclass : #ComposablePresenter,
	#instVars : [
		'form',
		'scenarioManager'
	],
	#category : #'BP4Pharo-TelloDrone-Example-TelloDrone-GUI'
}

{ #category : #specs }
TelloDronePlayground class >> defaultSpec [
	^ SpecColumnLayout composed
		newRow: [ :row | row add: #form ] height: self toolbarHeight * 3;
		newRow: [ :row | row add: #scenarioManager ] height: self toolbarHeight * 2;
		yourself
]

{ #category : #api }
TelloDronePlayground >> extent [
	^ 400 @ (form extent y + scenarioManager extent y + self class toolbarHeight )
]

{ #category : #accessing }
TelloDronePlayground >> form [
	^ form
]

{ #category : #accessing }
TelloDronePlayground >> form: anObject [
	form := anObject
]

{ #category : #initialization }
TelloDronePlayground >> initializePresenter [
	form whenTelloDroneCreatedDo: [scenarioManager enable].
	scenarioManager
		whenScenarioSelectedDo: [ :scenario | Transcript crShow: 'Selected:' , scenario ].
]

{ #category : #initialization }
TelloDronePlayground >> initializeWidgets [
	"widget instantiation"

	form := self instantiate: TelloDroneCreationForm.
	scenarioManager := self instantiate: TelloDroneScenarioManager.

	"widget configuration"
	scenarioManager disable.

	"specification of order of focus"
	self focusOrder
		add: form;
		add: scenarioManager
]

{ #category : #accessing }
TelloDronePlayground >> scenarioManager [
	^ scenarioManager
]

{ #category : #accessing }
TelloDronePlayground >> scenarioManager: anObject [
	scenarioManager := anObject
]

{ #category : #api }
TelloDronePlayground >> title [
	^ 'TelloDronePlayground'
]
