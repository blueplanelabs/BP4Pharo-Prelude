Class {
	#name : #AddColdFiveTimes,
	#superclass : #BP4PEnvironmentScenario,
	#category : #'BP4Pharo-Test-AlterningTaps'
}

{ #category : #initialize }
AddColdFiveTimes >> run: aBP4PProgram [
	| none addCold |
	none := BP4PEvent new.
	addCold := BP4PEvent name: 'addCold'.
	1 to: 5 do: [:i | aBP4PProgram syncRequested: addCold waited: none blocked: none ]
]
