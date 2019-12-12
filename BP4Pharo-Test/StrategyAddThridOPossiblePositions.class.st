Class {
	#name : #StrategyAddThridOPossiblePositions,
	#superclass : #BP4PEnvironmentScenario,
	#category : #'BP4Pharo-Test-TicTacToe-PossiblePositions'
}

{ #category : #initialize }
StrategyAddThridOPossiblePositions >> run: aBP4PProgram [
	"when two Os are noticed in a line, add an O in that line (and win)."

	| omove oPositionsSet alienated selectedMove |
	oPositionsSet := Set new.
	omove := BP4PEventsOfClass class: OEvent.


	"Wait for the first O move"
	aBP4PProgram syncRequested: none waited: omove blocked: none.
	oPositionsSet add: aBP4PProgram lastEvent position.
	"Wait for the second O move"
	aBP4PProgram syncRequested: none waited: omove blocked: none.
	oPositionsSet add: aBP4PProgram lastEvent position.
	[ true ]
		whileTrue: [ "Wait for the thrid X move"
			alienated := false.
			[ alienated ]
				whileFalse: [ oPositionsSet
						detect: [ :a | 
							| tempSet1 |
							tempSet1 := oPositionsSet copy.
							tempSet1 remove: a.
							tempSet1
								detect: [ :b | 
									TicTacToeWithPossiblePositions possiblePositions
										detect: [ :c | alienated := a isAlienatedWith: b and: c ]
										ifFound: [ :c | selectedMove := OEvent position: c ]
										ifNone: [  ].
									alienated ]
								ifNone: [  ].
							alienated ]
						ifNone: [  ].
					alienated
						ifTrue: [ "Request the O move that achieve three O alienated"
							Transcript
								crShow: 'Selected to achieve 3 O ' , selectedMove asString.
							aBP4PProgram syncRequested: selectedMove waited: none blocked: none.
 ]
						ifFalse: [ "Wait the O move"
							aBP4PProgram syncRequested: none waited: omove blocked: none.
							oPositionsSet add: aBP4PProgram lastEvent position ] ] ]
]
