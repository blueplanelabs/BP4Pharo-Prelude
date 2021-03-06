Class {
	#name : #StrategyDefaultOMovesPossiblePositions,
	#superclass : #BP4PEnvironmentScenario,
	#category : #'BP4Pharo-Test-TicTacToe-PossiblePositions'
}

{ #category : #initialize }
StrategyDefaultOMovesPossiblePositions >> run: aBP4PProgram [
	"Request all possible 9 moves - as default moves in the following order of center, corners and edges."

	| desiredPositions move  |
	move := BP4PEventsOfClass class: MoveEvent.

	desiredPositions := OrderedCollection new
		add: (Position x: 2 y: 2);
		add: (Position x: 1 y: 1);
		add: (Position x: 1 y: 3);
		add: (Position x: 3 y: 1);
		add: (Position x: 3 y: 3);
		add: (Position x: 1 y: 2);
		add: (Position x: 2 y: 1);
		add: (Position x: 2 y: 3);
		add: (Position x: 3 y: 2);
		yourself.
	[ desiredPositions isEmpty ]
		whileFalse:
			[ "Request a O move by default priority and wait any move. Remove the selected move from the desiredPositions"
			aBP4PProgram
				syncRequested: (OEvent position: desiredPositions first)
				waited: move 
				blocked: none.

			desiredPositions remove: aBP4PProgram lastEvent position ]
]
