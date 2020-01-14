Class {
	#name : #Move,
	#superclass : #BP4PScenario,
	#instVars : [
		'drone'
	],
	#category : #'BP4Pharo-TelloDrone-Example'
}

{ #category : #'as yet unclassified' }
Move class >> instanceToDrone: aDrone [
	"create a Move scenario with a drone"

	| scenario |
	scenario := self instance.
	scenario drone: aDrone.
	^ scenario
]

{ #category : #accessing }
Move >> drone [
	^ drone
]

{ #category : #accessing }
Move >> drone: aDrone [
	drone:= aDrone
]

{ #category : #initialize }
Move >> run: aBP4PProgram [
	| takeoff land requestedMove changedLocation |
	takeoff := TakeoffEvent new.
	land := LandEvent new.
	aBP4PProgram syncRequested: takeoff waited: none blocked: none.
	[ aBP4PProgram lastEvent belongsTo: LandEvent ]
		whileFalse: [ requestedMove := RequestedMoveEvent name: 'requestedMove'.
			aBP4PProgram
				syncRequested: requestedMove
				waited: none
				blocked: none.
			changedLocation := BP4PEventsOfClass class: ChangedLocationEvent.
			aBP4PProgram
				syncRequested: none
				waited: changedLocation , land
				blocked: none ]
]
