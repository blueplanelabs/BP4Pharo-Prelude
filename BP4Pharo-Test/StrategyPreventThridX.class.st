Class {
	#name : #StrategyPreventThridX,
	#superclass : #BP4PEnvironmentScenario,
	#category : #'BP4Pharo-Test-TicTacToe'
}

{ #category : #initialize }
StrategyPreventThridX >> run: aBP4PProgram [
	"when two Xs are noticed in a line, add an O in that line (and prevent an immediate loss)."

	| xmove omove xPositionsSet alienated selectedMove availableMoves |
	availableMoves := TicTacToeExample posiblePositions copy.
	xPositionsSet := Set new.
	xmove := BP4PEventsOfClass class: XEvent.
	omove := BP4PEventsOfClass class: OEvent.

	"Wait for the first X move"
	aBP4PProgram syncRequested: none waited: xmove blocked: none.
	xPositionsSet add: aBP4PProgram lastEvent position.
	availableMoves remove: aBP4PProgram lastEvent position.
	"Wait for the O move"
	aBP4PProgram syncRequested: none waited: omove blocked: none.
	availableMoves remove: aBP4PProgram lastEvent position.
	[ true ]
		whileTrue: [ "Wait for the second X move"
			alienated := false.
			[ alienated ]
				whileFalse: [ aBP4PProgram syncRequested: none waited: xmove blocked: none.
					xPositionsSet add: aBP4PProgram lastEvent position.
					availableMoves remove: aBP4PProgram lastEvent position.
					xPositionsSet
						detect: [ :a | 
							| tempSet1 |
							tempSet1 := xPositionsSet copy.
							tempSet1 remove: a.
							tempSet1
								detect: [ :b | 
									availableMoves 
										detect: [ :c | alienated := a isAlienatedWith: b and: c ]
										ifFound: [ :c | selectedMove := OEvent position: c ]
										ifNone: [  ].
									alienated ]
								ifNone: [  ].
							alienated ]
						ifNone: [  ] ].
			"Request the O move that avoid three X alienated"
			aBP4PProgram syncRequested: selectedMove waited: none blocked: none.
			availableMoves remove: aBP4PProgram lastEvent position.
			Transcript crShow: 'Selected to avoid 3 X ' , selectedMove asString ]
]
