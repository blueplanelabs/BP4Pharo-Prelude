Class {
	#name : #Move,
	#superclass : #BP4PScenario,
	#category : #'BP4Pharo-TelloDrone-Example'
}

{ #category : #initialize }
Move >> run: aBP4PProgram [
	|  requestedMove changedLocation |

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
