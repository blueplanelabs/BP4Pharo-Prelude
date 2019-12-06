Class {
	#name : #AddHotFiveTimes,
	#superclass : #BP4PEnvironmentScenario,
	#category : #'BP4Pharo-Test-AlterningTaps'
}

{ #category : #initialize }
AddHotFiveTimes >> run: aBP4PProgram [
	| none addHot |
	none := BP4PEvent new.
	addHot := BP4PEvent name: 'addHot'.
	1 to: 5 do: [:i | aBP4PProgram syncRequested: addHot waited: none blocked: none ]
]
