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

{ #category : #protocol }
TelloDroneScenarioToManage >> disable [
	checkBox state: false; disable
]

{ #category : #protocol }
TelloDroneScenarioToManage >> enable [
	checkBox enable
]

{ #category : #api }
TelloDroneScenarioToManage >> extent [
	^ 400 @ self class toolbarHeight
]

{ #category : #accessing }
TelloDroneScenarioToManage >> height [ 
	^ self extent y
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
TelloDroneScenarioToManage >> scenario: aScenarioClass [
	scenario := aScenarioClass .
	self label: aScenarioClass name asString 
]

{ #category : #api }
TelloDroneScenarioToManage >> title [
	^ 'ScenarioToManage'
]

{ #category : #enumerating }
TelloDroneScenarioToManage >> whenActivatedDo: aBlock [
	"aBlock with the scenario class like argument"
	checkBox whenActivatedDo: [ aBlock value: scenario ]
]

{ #category : #enumerating }
TelloDroneScenarioToManage >> whenDeactivatedDo: aBlock [
	"aBlock with the scenario class like argument"

	checkBox whenChangedDo: [ :bool | bool ifFalse: [ aBlock value: scenario ]]
]
