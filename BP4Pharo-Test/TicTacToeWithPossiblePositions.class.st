Class {
	#name : #TicTacToeWithPossiblePositions,
	#superclass : #Object,
	#classInstVars : [
		'possiblePositions',
		'axesSize',
		'segmentSize'
	],
	#category : #'BP4Pharo-Test-TicTacToe-PossiblePositions'
}

{ #category : #running }
TicTacToeWithPossiblePositions class >> addThridOProof [
	| bp |
	BP4PEnvironmentScenario initialize.
	bp := BP4PProgram new.
	bp
		addScenario:
			(UserMove
				initialize;
				instance)
		withPriority: 0.5.
	bp
		addScenario:
			(RulesSquareTakenPossiblePositions
				initialize;
				instance)
		withPriority: 1.
	bp
		addScenario:
			(RulesEnforceTurns
				initialize;
				instance)
		withPriority: 2.
	bp
		addScenario:
			(RulesDetectXWinPossiblePositions
				initialize;
				instance)
		withPriority: 3.
	bp
		addScenario:
			(RulesDetectOWinPossiblePositions
				initialize;
				instance)
		withPriority: 4.
	bp
		addScenario:
			(RulesDetectDrawPossiblePositions
				initialize;
				instance)
		withPriority: 5.
	bp
		addScenario:
			(StrategyAddThridOPossiblePositions
				initialize;
				instance)
		withPriority: 6.
	bp
		addScenario:
			(StrategyPreventThridXPossiblePositions
				initialize;
				instance)
		withPriority: 7.
	bp
		addScenario:
			(StrategyDefaultOMovesPossiblePositions
				initialize;
				instance)
		withPriority: 12.

	bp start.

	"	bp stop."
	^ bp
]

{ #category : #accessing }
TicTacToeWithPossiblePositions class >> axesSize [
	axesSize ifNil: [ axesSize := 3 ].
	^axesSize copy
]

{ #category : #accessing }
TicTacToeWithPossiblePositions class >> axesSize: anInteger segmentSize: anotherInteger [
	axesSize := anInteger.
	segmentSize := anotherInteger.
	possiblePositions := possiblePositions := Set new.
			1 to: self axesSize do:
				[ :x | 1 to: self axesSize do: [ :y | possiblePositions add: (Position x: x y: y) ] ]
]

{ #category : #running }
TicTacToeWithPossiblePositions class >> defaultOMovesProof [
	| bp  |
	BP4PEnvironmentScenario initialize.
	bp := BP4PProgram new.
	bp
		addScenario:
			(UserMove
				initialize;
				instance)
		withPriority: 0.5.
	bp
		addScenario:
			(RulesSquareTakenPossiblePositions
				initialize;
				instance)
		withPriority: 1.
	bp
		addScenario:
			(RulesEnforceTurns
				initialize;
				instance)
		withPriority: 2.
	bp
		addScenario:
			(RulesDetectXWinPossiblePositions
				initialize;
				instance)
		withPriority: 3.
	bp
		addScenario:
			(RulesDetectOWinPossiblePositions
				initialize;
				instance)
		withPriority: 4.
	bp
		addScenario:
			(RulesDetectDrawPossiblePositions
				initialize;
				instance)
		withPriority: 5.
	bp
		addScenario:
			(StrategyDefaultOMovesPossiblePositions
				initialize;
				instance)
		withPriority: 12.
	bp start.

	"	bp stop."
	^ bp
]

{ #category : #running }
TicTacToeWithPossiblePositions class >> detectDrawProof [
	| bp  positions omoves xmoves |

	positions := OrderedCollection new.
	omoves := OrderedCollection new.
	xmoves := OrderedCollection new.
	1 to: self axesSize do: [ :x | 
		| col |
		col := OrderedCollection new.
		1 to: axesSize do: [ :y | col add: (Position x: x y: y) ].
		positions add: col.
		omoves add: (col collect: [ :p | OEvent position: p ]).
		xmoves add: (col collect: [ :p | XEvent position: p ]) ].
	BP4PEnvironmentScenario initialize.
	bp := BP4PProgram new.
	bp
		addScenario:
			(UserMove
				initialize;
				instance)
		withPriority: 0.5.
	bp
		addScenario:
			(RulesSquareTakenPossiblePositions
				initialize;
				instance)
		withPriority: 1.
	bp
		addScenario:
			(RulesEnforceTurns
				initialize;
				instance)
		withPriority: 2.
	bp
		addScenario:
			(RulesDetectXWinPossiblePositions
				initialize;
				instance)
		withPriority: 3.
	bp
		addScenario:
			(RulesDetectOWinPossiblePositions
				initialize;
				instance)
		withPriority: 4.
	bp
		addScenario:
			(RulesDetectDrawPossiblePositions
				initialize;
				instance)
		withPriority: 5.
	bp start.
	(Delay forSeconds: 1) wait.
	BP4PEnvironment send: ((xmoves at: 2) at: 2) toProgram: bp.
	(Delay forSeconds: 1) wait.
	BP4PEnvironment send: ((omoves at: 1) at: 1) toProgram: bp.
	(Delay forSeconds: 1) wait.
	BP4PEnvironment send: ((xmoves at: 2) at: 1) toProgram: bp.
	(Delay forSeconds: 1) wait.
	BP4PEnvironment send: ((omoves at: 2) at: 3) toProgram: bp.
	(Delay forSeconds: 1) wait.
	BP4PEnvironment send: ((xmoves at: 1) at: 3) toProgram: bp.
	(Delay forSeconds: 1) wait.
	BP4PEnvironment send: ((omoves at: 3) at: 1) toProgram: bp.
	(Delay forSeconds: 1) wait.
	BP4PEnvironment send: ((xmoves at: 3) at: 2) toProgram: bp.
	(Delay forSeconds: 1) wait.
	BP4PEnvironment send: ((omoves at: 1) at: 2) toProgram: bp.
	(Delay forSeconds: 1) wait.
	BP4PEnvironment send: ((xmoves at: 3) at: 3) toProgram: bp.
	"	bp stop."
	^ bp
]

{ #category : #running }
TicTacToeWithPossiblePositions class >> detectXWinProof [
	| bp axeSize positions omoves xmoves |

	axeSize := 3.
	positions := OrderedCollection new.
	omoves := OrderedCollection new.
	xmoves := OrderedCollection new.
	1 to: axeSize do: [ :x | 
		| col |
		col := OrderedCollection new.
		1 to: axeSize do: [ :y | col add: (Position x: x y: y) ].
		positions add: col.
		omoves add: (col collect: [ :p | OEvent position: p ]).
		xmoves add: (col collect: [ :p | XEvent position: p ]) ].
	BP4PEnvironmentScenario initialize.
	bp := BP4PProgram new.
	bp
		addScenario:
			(UserMove
				initialize;
				instance)
		withPriority: 0.5.
	bp
		addScenario:
			(RulesSquareTakenPossiblePositions
				initialize;
				instance)
		withPriority: 1.
	bp
		addScenario:
			(RulesEnforceTurns
				initialize;
				instance)
		withPriority: 2.
	bp
		addScenario:
			(RulesDetectXWinPossiblePositions
				initialize;
				instance)
		withPriority: 3.	bp start.
	(Delay forSeconds: 1) wait.
	BP4PEnvironment send: ((xmoves at: 1) at: 1) toProgram: bp.
	(Delay forSeconds: 1) wait.
	BP4PEnvironment send: ((omoves at: 2) at: 1) toProgram: bp.
	(Delay forSeconds: 1) wait.
	BP4PEnvironment send: ((xmoves at: 1) at: 2) toProgram: bp.
	(Delay forSeconds: 1) wait.
	BP4PEnvironment send: ((omoves at: 2) at: 2) toProgram: bp.
	(Delay forSeconds: 1) wait.
	BP4PEnvironment send: ((xmoves at: 3) at: 1) toProgram: bp.
	(Delay forSeconds: 1) wait.
	BP4PEnvironment send: ((omoves at: 3) at: 2) toProgram: bp.
	(Delay forSeconds: 1) wait.
	BP4PEnvironment send: ((xmoves at: 1) at: 3) toProgram: bp.
	(Delay forSeconds: 1) wait.
	BP4PEnvironment send: ((omoves at: 2) at: 3) toProgram: bp.
	"	bp stop."
	^ bp
]

{ #category : #running }
TicTacToeWithPossiblePositions class >> enforceTurnProof [
	| bp x00 x01 x02 o01 o00  |

	x00 := XEvent position: (Position x: 0 y: 0).
	x01 := XEvent position: (Position x: 0 y: 1).
	x02 := XEvent position: (Position x: 0 y: 2).
	o00 := OEvent position: (Position x: 0 y: 0).
	o01 := OEvent position: (Position x: 0 y: 1).
	bp := BP4PProgram new.
	bp
		addScenario:
			(UserMove
				initialize;
				instance)
		withPriority: 0.5.
	bp
		addScenario:
			(RulesSquareTakenPossiblePositions
				initialize;
				instance)
		withPriority: 1.
	bp
		addScenario:
			(RulesEnforceTurns
				initialize;
				instance)
		withPriority: 2.
	bp start.
	(Delay forSeconds: 1) wait.
	BP4PEnvironment send: x00 toProgram: bp.
	(Delay forSeconds: 1) wait.
	BP4PEnvironment send: o00 toProgram: bp.
	(Delay forSeconds: 1) wait.
	BP4PEnvironment send: o01 toProgram: bp.
	(Delay forSeconds: 1) wait.
	BP4PEnvironment send: x01 toProgram: bp.
	(Delay forSeconds: 1) wait.
	BP4PEnvironment send: x02 toProgram: bp.

	"	bp stop."
	^ bp
]

{ #category : #accessing }
TicTacToeWithPossiblePositions class >> possiblePositions [
	^ possiblePositions copy

]

{ #category : #running }
TicTacToeWithPossiblePositions class >> preventThridXProof [
	| bp |
	BP4PEnvironmentScenario initialize.
	bp := BP4PProgram new.
	bp
		addScenario:
			(UserMove
				initialize;
				instance)
		withPriority: 0.5.
	bp
		addScenario:
			(RulesSquareTakenPossiblePositions
				initialize;
				instance)
		withPriority: 1.
	bp
		addScenario:
			(RulesEnforceTurns
				initialize;
				instance)
		withPriority: 2.
	bp
		addScenario:
			(RulesDetectXWinPossiblePositions
				initialize;
				instance)
		withPriority: 3.
	bp
		addScenario:
			(RulesDetectOWinPossiblePositions
				initialize;
				instance)
		withPriority: 4.
	bp
		addScenario:
			(RulesDetectDrawPossiblePositions
				initialize;
				instance)
		withPriority: 5.
	bp
		addScenario:
			(StrategyDefaultOMovesPossiblePositions
				initialize;
				instance)
		withPriority: 12.
	bp
		addScenario:
			(StrategyPreventThridXPossiblePositions
				initialize;
				instance)
		withPriority: 7.
	bp start.

	"	bp stop."
	^ bp
]

{ #category : #running }
TicTacToeWithPossiblePositions class >> run [
	"TO RUN: write in Playground 
bp:=TicTacToeExample preventThridXProof.
Repeat in each X move(player)
BP4PEnvironment send: ((xmoves at: 1) at: 1) toProgram: bp.
bp stop."

	self runAxesSize: self axesSize
]

{ #category : #running }
TicTacToeWithPossiblePositions class >> runAxesSize: anInteger [
	| bp axeSize positions omoves xmoves x00 x01 x11 o01 o00 p00 p01 p02 p10 p11 p12 p20 p21 p22 |
	"	p00 := Position x: 0 y: 0.
	p01 := Position x: 0 y: 1.
	p02 := Position x: 0 y: 2.
	p10 := Position x: 1 y: 0.
	p11 := Position x: 1 y: 1.
	p12 := Position x: 1 y: 2.
	p20 := Position x: 2 y: 0.
	p21 := Position x: 2 y: 1.
	p22 := Position x: 2 y: 2.
	x00 := XEvent position: (Position x: 0 y: 0).
	o00 := OEvent position: (Position x: 0 y: 0).
	x01 := XEvent position: (Position x: 0 y: 1).
	o01 := OEvent position: (Position x: 0 y: 1)."
	self axesSize: anInteger.
	positions := OrderedCollection new.
	omoves := OrderedCollection new.
	xmoves := OrderedCollection new.
	1 to: self axesSize do: [ :x | 
		| col |
		col := OrderedCollection new.
		1 to: axesSize do: [ :y | col add: (Position x: x y: y) ].
		positions add: col.
		omoves add: (col collect: [ :p | OEvent position: p ]).
		xmoves add: (col collect: [ :p | XEvent position: p ]) ].
	BP4PEnvironmentScenario initialize.
	bp := BP4PProgram new.
	bp
		addScenario:
			(RulesSquareTakenPossiblePositions
				initialize;
				instance)
		withPriority: 1.
	bp
		addScenario:
			(RulesEnforceTurns
				initialize;
				instance)
		withPriority: 1.
	bp
		addScenario:
			(RulesDetectXWinPossiblePositions
				initialize;
				instance)
		withPriority: 1.
	bp
		addScenario:
			(RulesDetectOWinPossiblePositions
				initialize;
				instance)
		withPriority: 1.
	bp
		addScenario:
			(RulesDetectDrawPossiblePositions 
				initialize;
				instance)
		withPriority: 1.
	bp start.
	(Delay forSeconds: 1) wait.
	BP4PEnvironment send: ((xmoves at: 1) at: 1) toProgram: bp.
	(Delay forSeconds: 10) wait.
	BP4PEnvironment send: ((omoves at: 2) at: 1) toProgram: bp.
	(Delay forSeconds: 1) wait.
	BP4PEnvironment send: ((xmoves at: 1) at: 2) toProgram: bp.
	(Delay forSeconds: 10) wait.
	BP4PEnvironment send: ((omoves at: 2) at: 2) toProgram: bp.
	(Delay forSeconds: 1) wait.
	BP4PEnvironment send: ((xmoves at: 3) at: 1) toProgram: bp.
	(Delay forSeconds: 10) wait.
	BP4PEnvironment send: ((omoves at: 3) at: 2) toProgram: bp.
	(Delay forSeconds: 1) wait.
	BP4PEnvironment send: ((xmoves at: 1) at: 3) toProgram: bp.
	(Delay forSeconds: 10) wait.
	BP4PEnvironment send: ((omoves at: 2) at: 3) toProgram: bp.
	"	bp stop."
	^ bp
]

{ #category : #accessing }
TicTacToeWithPossiblePositions class >> segmentSize [
	segmentSize  ifNil: [ segmentSize  := 3 ].
	^ segmentSize  copy
]

{ #category : #accessing }
TicTacToeWithPossiblePositions class >> takePosition: aPosition [
	possiblePositions remove: aPosition  ifAbsent: [  ]
]
