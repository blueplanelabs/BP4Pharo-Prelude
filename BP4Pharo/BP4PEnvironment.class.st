Class {
	#name : #BP4PEnvironment,
	#superclass : #Object,
	#category : #BP4Pharo
}

{ #category : #creation }
BP4PEnvironment class >> send: anEvent toProgram: aBP4PProgram [
	"Send a Event with aString as name to the aBP4PProgram"

	| scenario none |
	none := BP4PEvent none.
	"Create a scenario with event requested"
	scenario := BP4PEnvironmentScenario
		instanceWithValuable: [ :bp | bp syncRequested: anEvent waited: none blocked: none ].
	aBP4PProgram add: scenario priority: 100.
	aBP4PProgram startScenario: scenario
]
