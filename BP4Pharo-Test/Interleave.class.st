Class {
	#name : #Interleave,
	#superclass : #BP4PEnvironmentScenario,
	#category : #'BP4Pharo-Test-AlterningTaps'
}

{ #category : #initialize }
Interleave >> run: aBP4PProgram [
	| none addCold addHot continue |
	continue := true.
	none := BP4PEvent new.
	addCold := BP4PEvent name: 'addCold'.
	addHot := BP4PEvent name: 'addHot'.
	[ continue ]
		whileTrue: [ aBP4PProgram syncRequested: none waited: addHot blocked: addCold.
			aBP4PProgram syncRequested: none waited: addCold blocked: addHot.
						continue := aBP4PProgram lastEvent isNone not ]
]
