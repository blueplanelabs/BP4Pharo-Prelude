Class {
	#name : #FunctionalityGenerateDetectWinScenariosSegment,
	#superclass : #BP4PEnvironmentScenario,
	#category : #'BP4Pharo-Test-TicTacToe-SegmentBased'
}

{ #category : #initialize }
FunctionalityGenerateDetectWinScenariosSegment >> run: aBP4PProgram [
	"Generate DetectXWin or DetectOWin scenarios to be monitored with the possible segments for each move"

	| move generateDetectWinScenarios newScenario|
	move := BP4PEventsOfClass class: MoveEvent.
	"Wait for any move for a given square"
	aBP4PProgram syncRequested: none waited: move blocked: none.
	"Add a new scenario like this to wait and block again a new move. PRECHART"
	newScenario := self class instance.
	aBP4PProgram
		add: newScenario priority: 3;
		startScenario: newScenario.
	"Request a GenerateDetectWinScenariosEvent"
	generateDetectWinScenarios := GenerateDetectWinScenariosEvent
		position: aBP4PProgram lastEvent position
		type: aBP4PProgram lastEvent class.
	aBP4PProgram
		syncRequested: generateDetectWinScenarios
		waited: none
		blocked: none
]
