Class {
	#name : #FunctionalityGeneratePreventXWinScenariosSegment,
	#superclass : #BP4PEnvironmentScenario,
	#instVars : [
		'generatedScenarioPriority'
	],
	#category : #'BP4Pharo-Test-TicTacToe-SegmentBased'
}

{ #category : #creation }
FunctionalityGeneratePreventXWinScenariosSegment class >> instanceWithGeneratedScenariosPriority: aPriority [
	"create a instance with a priority for the generated scenarios"

	| scenario |
	scenario := self instance.
	scenario generatedScenarioPriority: aPriority.
	^ scenario
]

{ #category : #accessing }
FunctionalityGeneratePreventXWinScenariosSegment >> generatedScenarioPriority [ 
^generatedScenarioPriority 
]

{ #category : #accessing }
FunctionalityGeneratePreventXWinScenariosSegment >> generatedScenarioPriority: aPriority [
	generatedScenarioPriority := aPriority 
]

{ #category : #initialize }
FunctionalityGeneratePreventXWinScenariosSegment >> run: aBP4PProgram [
	"Generate PreventXWin or scenarios to be monitored with the possible segments for each X move"

	| xmove generatePreventXWinScenarios newScenario |
	xmove := BP4PEventsOfClass class: XEvent.
	"Wait for any move for a given square"
	aBP4PProgram syncRequested: none waited: xmove blocked: none.
	"Add a new scenario like this to wait and block again a new move. PRECHART"
	newScenario := self class instance.
	aBP4PProgram
		add: newScenario priority: 7;
		startScenario: newScenario.
	"Request a GeneratePreventXWinScenariosEvent"
	generatePreventXWinScenarios := GeneratePreventXWinScenariosEvent
		position: aBP4PProgram lastEvent position priority: self generatedScenarioPriority .
	aBP4PProgram
		syncRequested: generatePreventXWinScenarios
		waited: none
		blocked: none
]
