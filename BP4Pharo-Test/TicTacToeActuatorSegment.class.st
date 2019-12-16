Class {
	#name : #TicTacToeActuatorSegment,
	#superclass : #BP4PEnvironmentScenario,
	#category : #'BP4Pharo-Test-TicTacToe-SegmentBased'
}

{ #category : #initialize }
TicTacToeActuatorSegment >> run: aBP4PProgram [
	"Execute logic associated to each event"

	| event lastPosition segments typeOfMove scenarioType newScenario |
	event := BP4PEventsOfClass class: BP4PEvent.

	"Wait for any event and depending on the type of event performs the corresponding action"
	[ true ]
		whileTrue: [ aBP4PProgram syncRequested: none waited: event blocked: none.
			(aBP4PProgram lastEvent belongsTo: DisableEvent)
				ifTrue: [ "Action for DisableEvent"
					"Take the position in the posiblePositions of TicTacToe"
					lastPosition := aBP4PProgram lastEvent position.
					TicTacToeWithSegment takePosition: lastPosition ].
			(aBP4PProgram lastEvent belongsTo: GenerateDetectWinScenariosEvent)
				ifTrue:
					[ "Generate the DetectXWin or DetectOWin with the possible segments available"
					lastPosition := aBP4PProgram lastEvent position.
					typeOfMove := aBP4PProgram lastEvent type.
					"Get the segments that are fully available according to the possiblePositions on TicTacToe"
					segments := TicTacToeWithSegment
						generateAvailabeSegmentsTo: lastPosition.
					typeOfMove = XEvent
						ifTrue: [ scenarioType := RulesDetectXWinSegment ].
					typeOfMove = OEvent
						ifTrue: [ scenarioType := RulesDetectOWinSegment ].
					segments
						do: [ :segment | 
							newScenario := scenarioType instanceToSegment: segment.
							aBP4PProgram
								add: newScenario priority: 10;
								startScenario: newScenario ] ].
			(aBP4PProgram lastEvent
				belongsTo: GeneratePreventXWinScenariosEvent)
				ifTrue:
					[ "Generate the PreventXWin scenarios with the possible segments available"
					lastPosition := aBP4PProgram lastEvent position.
					segments := TicTacToeWithSegment
						generateAvailabeSegmentsTo: lastPosition.
					segments
						do: [ :segment | 
							newScenario := StrategyPreventXWinSegment instanceToSegment: segment.
							aBP4PProgram
								add: newScenario priority: 7;
								startScenario: newScenario ] ] ]
]
