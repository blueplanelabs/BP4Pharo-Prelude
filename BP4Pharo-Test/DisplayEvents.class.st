Class {
	#name : #DisplayEvents,
	#superclass : #BP4PScenario,
	#category : #'BP4Pharo-Test'
}

{ #category : #initialize }
DisplayEvents >> run: aBP4PProgram [
	| none addHot addCold continue|
	continue := true.
	none := BP4PEvent new.
	addHot := BP4PEvent name: 'addHot'.
	addCold := BP4PEvent name: 'addCold'.
	[ continue  ]
		whileTrue: [ aBP4PProgram
				syncRequested: none
				waited: addHot , addCold
				blocked: none.
			Transcript
				crShow:
					'Último evento seleccionado: '
						, aBP4PProgram lastEvent name printString.
			continue := aBP4PProgram lastEvent name isNotEmpty ]
]
