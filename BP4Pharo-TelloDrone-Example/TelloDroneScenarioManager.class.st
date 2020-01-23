Class {
	#name : #TelloDroneScenarioManager,
	#superclass : #ComposablePresenter,
	#instVars : [
		'altitude',
		'lowBattery'
	],
	#category : #'BP4Pharo-TelloDrone-Example-TelloDrone-GUI'
}

{ #category : #specs }
TelloDroneScenarioManager class >> defaultSpec [
	^ SpecColumnLayout composed
		newRow: [ :row | row add: #altitude ]
			height: self toolbarHeight ;
		newRow: [ :row | row add: #lowBattery ] height: self toolbarHeight ;
		yourself
]

{ #category : #accessing }
TelloDroneScenarioManager >> altitude [
	^ altitude
]

{ #category : #accessing }
TelloDroneScenarioManager >> altitude: anObject [
	altitude := anObject
]

{ #category : #protocol }
TelloDroneScenarioManager >> disable [
	altitude disable.
	lowBattery disable
]

{ #category : #protocol }
TelloDroneScenarioManager >> enable [ 
	altitude enable.
	lowBattery enable
]

{ #category : #api }
TelloDroneScenarioManager >> extent [
	^ 400 @ (altitude extent y+ lowBattery extent y)
]

{ #category : #initialization }
TelloDroneScenarioManager >> initializeWidgets [
	"widget instantiation"

	| altitudeVariationByStepFunction |
	altitude := self instantiate: TelloDroneScenarioToManage.
	lowBattery := self instantiate: TelloDroneScenarioToManage.

	"widget configuration"
	altitudeVariationByStepFunction := [ :distanceTravaled | 40 * (distanceTravaled * Float pi * 2 / 100) sin ].
	altitude
		scenario:
			(AltitudeController
				initialize;
				instanceToFunction: altitudeVariationByStepFunction);
		priority: 2.
	lowBattery
		scenario:
			(LowBattery
				initialize;
				instance);
		priority: 0.7.

	"specification of order of focus"
	self focusOrder
		add: altitude;
		add: lowBattery
]

{ #category : #accessing }
TelloDroneScenarioManager >> lowBattery [
	^ lowBattery
]

{ #category : #accessing }
TelloDroneScenarioManager >> lowBattery: anObject [
	lowBattery := anObject
]

{ #category : #api }
TelloDroneScenarioManager >> title [
	^ 'ScenarioManager'
]

{ #category : #initialization }
TelloDroneScenarioManager >> whenScenarioDeselectedDo: aBlock [
	altitude whenDeactivatedDo: aBlock.
	lowBattery whenDeactivatedDo: aBlock
]

{ #category : #initialization }
TelloDroneScenarioManager >> whenScenarioSelectedDo: aBlock [
	altitude whenActivatedDo:  aBlock .
	lowBattery whenActivatedDo: aBlock 
]
