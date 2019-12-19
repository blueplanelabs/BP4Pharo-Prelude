Class {
	#name : #FunctionalityGenerateForceOWinScenariosSegment,
	#superclass : #BP4PScenario,
	#instVars : [
		'generatedScenarioPriority'
	],
	#category : #'BP4Pharo-Test-TicTacToe-SegmentBased'
}

{ #category : #creation }
FunctionalityGenerateForceOWinScenariosSegment class >> instanceWithGeneratedScenariosPriority: aPriority [
	"create a instance with a priority for the generated scenarios"

	| scenario |
	scenario := self instance.
	scenario generatedScenarioPriority: aPriority.
	^ scenario
]

{ #category : #accessing }
FunctionalityGenerateForceOWinScenariosSegment >> generatedScenarioPriority [ 
	^generatedScenarioPriority 
]

{ #category : #accessing }
FunctionalityGenerateForceOWinScenariosSegment >> generatedScenarioPriority: aPriority [
	generatedScenarioPriority := aPriority
]

{ #category : #initialize }
FunctionalityGenerateForceOWinScenariosSegment >> run: aBP4PProgram [
	"Generate ForceOWin scenarios to be monitored with the possible segments for each O move"

	| omove generateForceOWinScenarios newScenario |
	omove := BP4PEventsOfClass class: OEvent.
	"Wait for any Oevent"
	aBP4PProgram syncRequested: none waited: omove blocked: none.
	"Add a new scenario like this to wait again a new OEvent. PRECHART"
	newScenario := self class instanceWithGeneratedScenariosPriority: self generatedScenarioPriority.
	aBP4PProgram
		add: newScenario priority: self priority;
		startScenario: newScenario.
	"Request a GenerateForceOWinScenariosEvent"
	generateForceOWinScenarios := GenerateForceOWinScenariosEvent
		position: aBP4PProgram lastEvent position
		priority: self generatedScenarioPriority.
	aBP4PProgram
		syncRequested: generateForceOWinScenarios
		waited: none
		blocked: none
]
