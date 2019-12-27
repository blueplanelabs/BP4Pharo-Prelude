Class {
	#name : #TicTacToeActuatorSegment,
	#superclass : #BP4PScenario,
	#category : #'BP4Pharo-Test-TicTacToe-SegmentBased'
}

{ #category : #initialize }
TicTacToeActuatorSegment >> run: aBP4PProgram [
	"Execute logic associated to each event"

	| event lastEvent priorityToGenerate lastPosition segments typeOfMove scenarioType newScenario |
	event := BP4PEventsOfClass class: BP4PEvent.

	"Wait for any event and depending on the type of event performs the corresponding action"
	[ true ]
		whileTrue: [ aBP4PProgram syncRequested: none waited: event blocked: none.
			lastEvent := aBP4PProgram lastEvent.
			(lastEvent belongsTo: DisableEvent)
				ifTrue: [ "Action for DisableEvent"
					"Take the position in the posiblePositions of TicTacToe"
					lastPosition := lastEvent position.
					TicTacToeWithSegment takePosition: lastPosition ].
			(lastEvent belongsTo: GenerateDetectWinScenariosEvent)
				ifTrue:
					[ "Generate the DetectXWin or DetectOWin with the possible segments available"
					lastPosition := lastEvent position.
					typeOfMove := lastEvent type.
					priorityToGenerate := lastEvent priority.
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
								addScenario: newScenario withPriority: priorityToGenerate;
								startScenario: newScenario ] ].
			(lastEvent belongsTo: GeneratePreventXWinScenariosEvent)
				ifTrue:
					[ "Generate the PreventXWin scenarios with the possible segments available"
					lastPosition := lastEvent position.
					priorityToGenerate := lastEvent priority.
					segments := TicTacToeWithSegment
						generateAvailabeSegmentsTo: lastPosition.
					segments
						do: [ :segment | 
							newScenario := StrategyPreventXWinSegment instanceToSegment: segment.
							aBP4PProgram
								addScenario: newScenario withPriority: priorityToGenerate;
								startScenario: newScenario ] ].
			(lastEvent belongsTo: GenerateForceOWinScenariosEvent)
				ifTrue:
					[ "Generate the ForceOWin scenarios with the possible segments avaible"
					lastPosition := lastEvent position.
					priorityToGenerate := lastEvent priority.
					segments := TicTacToeWithSegment
						generateAvailabeSegmentsTo: lastPosition.
					segments
						do: [ :segment | 
							newScenario := StrategyForceOWinSegment instanceToSegment: segment.
							aBP4PProgram
								addScenario: newScenario withPriority: priorityToGenerate;
								startScenario: newScenario ] ].
			(lastEvent belongsTo: GenerateCompleteOSegmentScenariosEvent )
				ifTrue:
					[ "Generate the CompleteOSegment scenarios with the possible segments avaible"
					lastPosition := lastEvent position.
					priorityToGenerate := lastEvent priority.
					segments := TicTacToeWithSegment
						generateAvailabeSegmentsTo: lastPosition.
					segments
						do: [ :segment | 
							newScenario := StrategyCompleteOSegment  instanceToSegment: segment.
							aBP4PProgram
								addScenario: newScenario withPriority: priorityToGenerate;
								startScenario: newScenario ] ].
			(lastEvent belongsTo: GeneratePreventXForkTISScenariosEvent)
				ifTrue:
					[ "Generate the PreventXForkTwoIntersectedSegments possible with segments and worked position received"
					| originalXSegments workedXSegments intersectedSegments |
					workedXSegments := TicTacToeWithSegment
						generateAvailabeSegmentsTo: lastEvent position.
					intersectedSegments := Set new.
					originalXSegments := lastEvent segments.
					originalXSegments
						do: [ :oxs | 
							workedXSegments
								do: [ :wxs | 
									(oxs intersection: wxs) size = 1
										ifTrue: [ newScenario := StrategyPreventXForkTwoIntersectedSegments
												instanceToSegment: oxs
												andSegment: wxs.
											priorityToGenerate := lastEvent priority.
											aBP4PProgram
												addScenario: newScenario withPriority: priorityToGenerate;
												startScenario: newScenario	"intersectedSegments add: (Array with: oxs with: wxs)" ] ] ] ] ]
]
