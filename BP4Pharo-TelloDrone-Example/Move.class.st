Class {
	#name : #Move,
	#superclass : #BP4PScenario,
	#category : #'BP4Pharo-TelloDrone-Example'
}

{ #category : #initialize }
Move >> run: aBP4PProgram [
	| takeoff requestedMove changedLocation |
	takeoff := TakeoffEvent new.

	aBP4PProgram syncRequested: takeoff waited: none blocked: none.
	[ true ]
		whileTrue: [ requestedMove := RequestedMoveEvent name: 'requestedMove'.
			aBP4PProgram
				syncRequested: requestedMove
				waited: none
				blocked: none.
			changedLocation := BP4PEventsOfClass class: ChangedLocationEvent.
			aBP4PProgram
				syncRequested: none
				waited: changedLocation
				blocked: none ]
]
