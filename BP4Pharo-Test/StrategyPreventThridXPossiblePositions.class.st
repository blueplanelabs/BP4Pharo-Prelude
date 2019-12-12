Class {
	#name : #StrategyPreventThridXPossiblePositions,
	#superclass : #BP4PEnvironmentScenario,
	#category : #'BP4Pharo-Test-TicTacToe-PossiblePositions'
}

{ #category : #initialize }
StrategyPreventThridXPossiblePositions >> run: aBP4PProgram [
	"when two Xs are noticed in a line, add an O in that line (and prevent an immediate loss)."

	| xmove xPositionsSet alienated selectedMove |
	xPositionsSet := Set new.
	xmove := BP4PEventsOfClass class: XEvent.
	selectedMove := BP4PEvent none.

	"Wait for the first X move"
	aBP4PProgram syncRequested: none waited: xmove blocked: none.
	xPositionsSet add: aBP4PProgram lastEvent position.
	[ true ]
		whileTrue: [ "Wait for the second X move"
			alienated := false.
			[ alienated ]
				whileFalse: [ aBP4PProgram syncRequested: none waited: xmove blocked: none.
					"Check if there are some possible X move to achieve 3X"
					xPositionsSet add: aBP4PProgram lastEvent position.
					xPositionsSet
						detect: [ :a | 
							| tempSet1 |
							tempSet1 := xPositionsSet copy.
							tempSet1 remove: a.
							tempSet1
								detect: [ :b | 
									TicTacToeWithPossiblePositions possiblePositions
										detect: [ :c | alienated := a isAlienatedWith: b and: c ]
										ifFound: [ :c | selectedMove := (OEvent position: c ), selectedMove ]
										ifNone: [  ].
									alienated ]
								ifNone: [  ].
							alienated ]
						ifNone: [  ].
					alienated
						ifTrue: [ "Request the O move that avoid three X alienated"
							Transcript crShow: 'Selected to avoid 3 X ' , selectedMove asString.
							aBP4PProgram
								syncRequested: selectedMove
								waited: none
								blocked: none ] ] ]
]
