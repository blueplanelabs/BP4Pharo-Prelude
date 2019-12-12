Class {
	#name : #RulesDetectXWinPossiblePositions,
	#superclass : #BP4PEnvironmentScenario,
	#category : #'BP4Pharo-Test-TicTacToe-PossiblePositions'
}

{ #category : #initialize }
RulesDetectXWinPossiblePositions >> run: aBP4PProgram [
	"wait for placement of at least three X marks and is checking if they are alienated three by three, if true request XWin."

	| xmove move xwin positionSet alienated |
	positionSet := Set new.
	alienated := false.
	xwin := GameOverEvent  name: 'xwin'.
	xmove := BP4PEventsOfClass class: XEvent.
	move := BP4PEventsOfClass class: MoveEvent.
	"Wait for the first X moves"
	aBP4PProgram syncRequested: none waited: xmove blocked: none.
	positionSet add: aBP4PProgram lastEvent position.
	"Wait for the second X moves"
	aBP4PProgram syncRequested: none waited: xmove blocked: none.
	positionSet add: aBP4PProgram lastEvent position.
	"Wait for the third  and following X moves"
	[ alienated ]
		whileFalse: [ aBP4PProgram syncRequested: none waited: xmove blocked: none.
			positionSet add: aBP4PProgram lastEvent position.
			positionSet
				detect: [ :a | 
					| tempSet1 |
					tempSet1 := positionSet copy.
					tempSet1 remove: a.
					tempSet1
						detect: [ :b | 
							| tempSet2 |
							tempSet2 := tempSet1 copy.
							tempSet2 remove: b.
							tempSet2
								detect: [ :c | alienated := a isAlienatedWith: b and: c ]
								ifNone: [  ].
							alienated ]
						ifNone: [  ].
					alienated ]
				ifNone: [  ].
			Transcript
				crShow: 'Set of X moves ' , positionSet asString , ' , ' , alienated asString ].
	"Block all moves and Request XWin"
	aBP4PProgram syncRequested: xwin waited: none blocked: move.
	"Block all moves game over"
	aBP4PProgram syncRequested: none waited: none blocked: move
]
