Class {
	#name : #RulesDetectDraw,
	#superclass : #BP4PEnvironmentScenario,
	#category : #'BP4Pharo-Test-TicTacToe'
}

{ #category : #initialize }
RulesDetectDraw >> run: aBP4PProgram [
	"wait for placement of all posible square taken, if true request Draw."

	| move draw all |
	move := BP4PEventsOfClass class: MoveEvent.
	all := BP4PEventsOfClass class: BP4PEvent.
	draw := GameOverEvent name: 'draw'.
	1 to: TicTacToeExample axesSize squared do: [ :i | aBP4PProgram syncRequested: none waited: move blocked: none ].
	aBP4PProgram syncRequested: draw waited: none blocked: move.
	aBP4PProgram syncRequested: none waited: none blocked: all
]
