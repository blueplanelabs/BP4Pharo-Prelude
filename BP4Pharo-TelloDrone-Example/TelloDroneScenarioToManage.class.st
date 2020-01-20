Class {
	#name : #TelloDroneScenarioToManage,
	#superclass : #ComposablePresenter,
	#instVars : [
		'checkBox',
		'scenario'
	],
	#category : #'BP4Pharo-TelloDrone-Example-TelloDrone-GUI'
}

{ #category : #specs }
TelloDroneScenarioToManage class >> defaultSpec [
	^ SpecColumnLayout composed
		newRow: [ :row | row add: #checkBox ]
		height: self toolbarHeight;
		yourself
]

{ #category : #accessing }
TelloDroneScenarioToManage >> checkBox [
	^ checkBox
]

{ #category : #accessing }
TelloDroneScenarioToManage >> checkBox: anObject [
	checkBox := anObject
]

{ #category : #initialization }
TelloDroneScenarioToManage >> initializeWidgets [
	"widget instantiation"

	checkBox := self newCheckBox.

	"widget configuration"
	checkBox
		enabled: true;
		label: 'Scenario'

	"specification of order of focus"
]

{ #category : #accessing }
TelloDroneScenarioToManage >> label: aText [
	checkBox label: aText
]

{ #category : #accessing }
TelloDroneScenarioToManage >> scenario [
	^ scenario
]

{ #category : #accessing }
TelloDroneScenarioToManage >> scenario: aBP4PScenario [
	scenario := aBP4PScenario.
	self label: aBP4PScenario name asString.
]
