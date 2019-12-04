Class {
	#name : #BP4PEnvironment,
	#superclass : #Object,
	#category : #BP4Pharo
}

{ #category : #creation }
BP4PEnvironment class >> send: aString toProgram: aBP4PProgram [
	"Send a Event with aString as name to the aBP4PProgram"

	| event scenario none|
	"Create event"
	event := BP4PEvent name: aString.
	none := BP4PEvent new.
	"Create a scenario with event requested"
	scenario := BP4PScenario
		name: 'environment' , aString
		valuable: [ :bp | bp syncRequested: event waited: none blocked: none ].
	aBP4PProgram add: scenario
]
