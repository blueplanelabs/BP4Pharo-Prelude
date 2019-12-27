Class {
	#name : #FunctionalityCompleteOScenariosSegment,
	#superclass : #BP4PScenario,
	#instVars : [
		'generatedScenarioPriority'
	],
	#category : #'BP4Pharo-Test-TicTacToe-SegmentBased'
}

{ #category : #creation }
FunctionalityCompleteOScenariosSegment class >> instanceWithGeneratedScenariosPriority: aPriority [
	"create a instance with a priority for the generated scenarios"

	| scenario |
	scenario := self instance.
	scenario generatedScenarioPriority: aPriority.
	^ scenario
]

{ #category : #accessing }
FunctionalityCompleteOScenariosSegment >> generatedScenarioPriority [ 
^generatedScenarioPriority 
]

{ #category : #accessing }
FunctionalityCompleteOScenariosSegment >> generatedScenarioPriority: aPriority [
	generatedScenarioPriority := aPriority 
]

{ #category : #initialize }
FunctionalityCompleteOScenariosSegment >> run: aBP4PProgram [
	"Generate CompleteOSegment scenarios with the possible segments for each O move"

	| omove generateCompleteOSegmentScenarios newScenario |
	omove := BP4PEventsOfClass class: OEvent.
	"Wait for any Oevent"
	aBP4PProgram syncRequested: none waited: omove blocked: none.
	"Add a new scenario like this to wait again a new OEvent. PRECHART"
	newScenario := self class
		instanceWithGeneratedScenariosPriority: self generatedScenarioPriority.
	aBP4PProgram
		addScenario: newScenario withPriority: self priority;
		startScenario: newScenario.
	"Request a GenerateCompleteOScenariosEvent"
	generateCompleteOSegmentScenarios := GenerateCompleteOSegmentScenariosEvent 
		position: aBP4PProgram lastEvent position
		priority: self generatedScenarioPriority.
	aBP4PProgram
		syncRequested: generateCompleteOSegmentScenarios
		waited: none
		blocked: none
]
