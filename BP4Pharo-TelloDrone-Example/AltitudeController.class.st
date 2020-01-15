Class {
	#name : #AltitudeController,
	#superclass : #BP4PScenario,
	#instVars : [
		'altFunction'
	],
	#category : #'BP4Pharo-TelloDrone-Example'
}

{ #category : #'as yet unclassified' }
AltitudeController class >> instanceToFunction: anAltitudeFunction [
	"create a AltitudeController scenario with an altitude function"

	| scenario |
	scenario := self instance.
	scenario altitudeFunction: anAltitudeFunction .
	^ scenario
]

{ #category : #'as yet unclassified' }
AltitudeController >> altitudeFunction: anAltitudeFunction [
	altFunction := anAltitudeFunction 
]

{ #category : #initialize }
AltitudeController >> run: aBP4PProgram [
	| changedLocation fitAltitude traveledDistance land |
	changedLocation := BP4PEventsOfClass class: ChangedLocationEvent.
	land := BP4PEventsOfClass class: LandEvent .
	[ aBP4PProgram lastEvent belongsTo: TakeoffEvent ]
		whileFalse: [ aBP4PProgram
				syncRequested: none
				waited: changedLocation
				blocked: none.
			traveledDistance := aBP4PProgram lastEvent traveledDistance.
			fitAltitude := FitAltitudeEvent
				altitudeVariation: (altFunction value: traveledDistance).
			aBP4PProgram
				syncRequested: fitAltitude
				waited: land
				blocked: none ]
]
