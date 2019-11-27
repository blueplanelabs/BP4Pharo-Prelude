Class {
	#name : #AddHotFiveTimes,
	#superclass : #BP4PScenario,
	#category : #'BP4Pharo-Test'
}

{ #category : #initialize }
AddHotFiveTimes >> run: aBP4PProgram [
	| none addHot |
	none := BP4PEvent new.
	addHot := BP4PEvent name: 'addHot'.
	1 to: 5 do: [:i | aBP4PProgram syncRequested: addHot waited: none blocked: none ]
]
