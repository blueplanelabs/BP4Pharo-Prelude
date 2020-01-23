Class {
	#name : #LowBattery,
	#superclass : #BP4PScenario,
	#category : #'BP4Pharo-TelloDrone-Example'
}

{ #category : #initialize }
LowBattery >> run: aBP4PProgram [
	| eocChangedLocation land |
	land := LandEvent name: 'emergencyLand'.
	eocChangedLocation := BP4PEventsOfClass class: ChangedLocationEvent .
	5
		timesRepeat: [ aBP4PProgram
				syncRequested: none
				waited: eocChangedLocation
				blocked: none ].
	aBP4PProgram syncRequested: land waited: none blocked: none
]
