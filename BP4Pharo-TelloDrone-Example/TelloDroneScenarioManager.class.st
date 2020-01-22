Class {
	#name : #TelloDroneScenarioManager,
	#superclass : #ComposablePresenter,
	#instVars : [
		'altitude',
		'landing'
	],
	#category : #'BP4Pharo-TelloDrone-Example-TelloDrone-GUI'
}

{ #category : #specs }
TelloDroneScenarioManager class >> defaultSpec [
	^ SpecColumnLayout composed
		newRow: [ :row | row add: #altitude ]
			height: self toolbarHeight ;
		newRow: [ :row | row add: #landing ] height: self toolbarHeight ;
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
	landing disable
]

{ #category : #protocol }
TelloDroneScenarioManager >> enable [ 
	altitude enable.
	landing enable
]

{ #category : #api }
TelloDroneScenarioManager >> extent [
	^ 400 @ (altitude extent y+ landing extent y)
]

{ #category : #initialization }
TelloDroneScenarioManager >> initializeWidgets [
	"widget instantiation"

	| altitudeVariationByStepFunction |
	altitude := self instantiate: TelloDroneScenarioToManage.
	landing := self instantiate: TelloDroneScenarioToManage.

	"widget configuration"
	altitudeVariationByStepFunction := [ :distanceTravaled | 40 * (distanceTravaled * Float pi * 2 / 100) sin ].
	altitude
		scenario: (AltitudeController initialize;
		instanceToFunction: altitudeVariationByStepFunction).
	landing scenario: Landing.

	"specification of order of focus"
	self focusOrder
		add: altitude;
		add: landing
]

{ #category : #accessing }
TelloDroneScenarioManager >> landing [
	^ landing
]

{ #category : #accessing }
TelloDroneScenarioManager >> landing: anObject [
	landing := anObject
]

{ #category : #api }
TelloDroneScenarioManager >> title [
	^ 'ScenarioManager'
]

{ #category : #initialization }
TelloDroneScenarioManager >> whenScenarioDeselectedDo: aBlock [
	altitude whenDeactivatedDo: aBlock.
	landing whenDeactivatedDo: aBlock
]

{ #category : #initialization }
TelloDroneScenarioManager >> whenScenarioSelectedDo: aBlock [
	altitude whenActivatedDo:  aBlock .
	landing whenActivatedDo: aBlock 
]
