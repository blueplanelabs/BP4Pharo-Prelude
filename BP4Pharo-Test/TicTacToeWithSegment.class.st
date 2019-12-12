Class {
	#name : #TicTacToeWithSegment,
	#superclass : #Object,
	#classInstVars : [
		'possiblePositions',
		'axesSize',
		'segmentSize'
	],
	#category : #'BP4Pharo-Test-TicTacToe-SegmentBased'
}

{ #category : #running }
TicTacToeWithSegment class >> addThridOProof [
	| bp |
	BP4PEnvironmentScenario initialize.
	bp := BP4PProgram new.
	bp
		add:
			(UserMove
				initialize;
				instance)
		priority: 0.5.
	bp
		add:
			(RulesSquareTakenPossiblePositions
				initialize;
				instance)
		priority: 1.
	bp
		add:
			(RulesEnforceTurns
				initialize;
				instance)
		priority: 2.
	bp
		add:
			(RulesDetectXWinPossiblePositions
				initialize;
				instance)
		priority: 3.
	bp
		add:
			(RulesDetectOWinPossiblePositions
				initialize;
				instance)
		priority: 4.
	bp
		add:
			(RulesDetectDrawPossiblePositions
				initialize;
				instance)
		priority: 5.
	bp
		add:
			(StrategyDefaultOMovesPossiblePositions
				initialize;
				instance)
		priority: 12.
	bp
		add:
			(StrategyPreventThridXPossiblePositions
				initialize;
				instance)
		priority: 7.
	bp
		add:
			(StrategyAddThridOPossiblePositions
				initialize;
				instance)
		priority: 6.
	bp start.

	"	bp stop."
	^ bp
]

{ #category : #accessing }
TicTacToeWithSegment class >> axesSize [
	axesSize ifNil: [ axesSize := 3 ].
	^axesSize copy
]

{ #category : #accessing }
TicTacToeWithSegment class >> axesSize: anInteger segmentSize: anotherInteger [
	axesSize := anInteger.
	segmentSize := anotherInteger.
	possiblePositions := possiblePositions := Set new.
			1 to: self axesSize do:
				[ :x | 1 to: self axesSize do: [ :y | possiblePositions add: (Position x: x y: y) ] ]
]

{ #category : #running }
TicTacToeWithSegment class >> defaultOMovesProof [
	| bp  |
	BP4PEnvironmentScenario initialize.
	bp := BP4PProgram new.
	bp
		add:
			(UserMove
				initialize;
				instance)
		priority: 0.5.
	bp
		add:
			(RulesSquareTakenPossiblePositions
				initialize;
				instance)
		priority: 1.
	bp
		add:
			(RulesEnforceTurns
				initialize;
				instance)
		priority: 2.
	bp
		add:
			(RulesDetectXWinPossiblePositions
				initialize;
				instance)
		priority: 3.
	bp
		add:
			(RulesDetectOWinPossiblePositions
				initialize;
				instance)
		priority: 4.
	bp
		add:
			(RulesDetectDrawPossiblePositions
				initialize;
				instance)
		priority: 5.
	bp
		add:
			(StrategyDefaultOMovesPossiblePositions
				initialize;
				instance)
		priority: 12.
	bp start.

	"	bp stop."
	^ bp
]

{ #category : #running }
TicTacToeWithSegment class >> detectDrawProof [
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
		add:
			(UserMove
				initialize;
				instance)
		priority: 0.5.
	bp
		add:
			(RulesSquareTakenPossiblePositions
				initialize;
				instance)
		priority: 1.
	bp
		add:
			(RulesEnforceTurns
				initialize;
				instance)
		priority: 2.
	bp
		add:
			(RulesDetectXWinPossiblePositions
				initialize;
				instance)
		priority: 3.
	bp
		add:
			(RulesDetectOWinPossiblePositions
				initialize;
				instance)
		priority: 4.
	bp
		add:
			(RulesDetectDrawPossiblePositions
				initialize;
				instance)
		priority: 5.
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
TicTacToeWithSegment class >> detectOWinSegmentSuccessProof [
	| bp segment |
	segment := Set new
		add: (Position x: 1 y: 1);
		add: (Position x: 2 y: 1);
		yourself.
	BP4PEnvironmentScenario initialize.
	bp := BP4PProgram new.
	bp
		add:
			(RulesDetectOWinSegment
				initialize;
				instanceToSegment: segment)
		priority: 3.
	bp start.
		(Delay forSeconds: 1) wait.
	segment do: [ :position |
	BP4PEnvironment
		send: (OEvent position: position)
		toProgram: bp.
	(Delay forSeconds: 1) wait].
	"	bp stop."
	^ bp
]

{ #category : #running }
TicTacToeWithSegment class >> detectXWinProof [
	| bp segment |
	segment := Set new
		add: (Position x: 1 y: 1);
		add: (Position x: 2 y: 1);
		yourself.
	BP4PEnvironmentScenario initialize.
	bp := BP4PProgram new.
	bp
		add:
			(UserMove
				initialize;
				instance)
		priority: 0.5.
	bp
		add:
			(RulesSquareTakenPossiblePositions
				initialize;
				instance)
		priority: 1.
	bp
		add:
			(RulesEnforceTurns
				initialize;
				instance)
		priority: 2.
	bp
		add:
			(RulesDetectXWinSegment
				initialize;
				instanceToSegment: segment)
		priority: 3.
	bp
		add:
			(StrategyDefaultOMovesPossiblePositions 
				initialize;
				instance)
		priority: 2.
	bp start.
	(Delay forSeconds: 1) wait.
	BP4PEnvironment
		send: (ClickEvent position: (Position x: 1 y: 1))
		toProgram: bp.
	(Delay forSeconds: 1) wait.
	BP4PEnvironment
		send: (ClickEvent position: (Position x: 2 y: 1))
		toProgram: bp.
	(Delay forSeconds: 1) wait.
	"	bp stop."
	^ bp
]

{ #category : #running }
TicTacToeWithSegment class >> detectXWinSegmentInterruptedProof [
	| bp segment |
	segment := Set new
		add: (Position x: 1 y: 1);
		add: (Position x: 2 y: 1);
		yourself.
	BP4PEnvironmentScenario initialize.
	bp := BP4PProgram new.
	bp
		add:
			(RulesDetectXWinSegment
				initialize;
				instanceToSegment: segment)
		priority: 3.
	bp start.
	(Delay forSeconds: 1) wait.
	BP4PEnvironment
		send: (XEvent position: (Position x: 1 y: 1))
		toProgram: bp.
	(Delay forSeconds: 1) wait.
	BP4PEnvironment
		send: (OEvent position: (Position x: 2 y: 1))
		toProgram: bp.
	(Delay forSeconds: 1) wait.
	"	bp stop."
	^ bp
]

{ #category : #running }
TicTacToeWithSegment class >> detectXWinSegmentSuccessProof [
	| bp segment |
	segment := Set new
		add: (Position x: 1 y: 1);
		add: (Position x: 2 y: 1);
		yourself.
	BP4PEnvironmentScenario initialize.
	bp := BP4PProgram new.
	bp
		add:
			(RulesDetectXWinSegment
				initialize;
				instanceToSegment: segment)
		priority: 3.
	bp start.
	(Delay forSeconds: 1) wait.
	segment
		do: [ :position | 
			BP4PEnvironment send: (XEvent position: position) toProgram: bp.
			(Delay forSeconds: 1) wait ].
	"	bp stop."
	^ bp
]

{ #category : #running }
TicTacToeWithSegment class >> enforceTurnProof [
	| bp x00 x01 x02 o01 o00  |

	x00 := XEvent position: (Position x: 0 y: 0).
	x01 := XEvent position: (Position x: 0 y: 1).
	x02 := XEvent position: (Position x: 0 y: 2).
	o00 := OEvent position: (Position x: 0 y: 0).
	o01 := OEvent position: (Position x: 0 y: 1).
	bp := BP4PProgram new.
	bp
		add:
			(UserMove
				initialize;
				instance)
		priority: 0.5.
	bp
		add:
			(RulesSquareTakenPossiblePositions
				initialize;
				instance)
		priority: 1.
	bp
		add:
			(RulesEnforceTurns
				initialize;
				instance)
		priority: 2.
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

{ #category : #'as yet unclassified' }
TicTacToeWithSegment class >> genateAvailabeSegmentsTo: aPosition [
	1 to: self axesSize 
]

{ #category : #accessing }
TicTacToeWithSegment class >> possiblePositions [
	^ possiblePositions copy

]

{ #category : #running }
TicTacToeWithSegment class >> preventThridXProof [
	| bp |
	BP4PEnvironmentScenario initialize.
	bp := BP4PProgram new.
	bp
		add:
			(UserMove
				initialize;
				instance)
		priority: 0.5.
	bp
		add:
			(RulesSquareTakenPossiblePositions
				initialize;
				instance)
		priority: 1.
	bp
		add:
			(RulesEnforceTurns
				initialize;
				instance)
		priority: 2.
	bp
		add:
			(RulesDetectXWinPossiblePositions
				initialize;
				instance)
		priority: 3.
	bp
		add:
			(RulesDetectOWinPossiblePositions
				initialize;
				instance)
		priority: 4.
	bp
		add:
			(RulesDetectDrawPossiblePositions
				initialize;
				instance)
		priority: 5.
	bp
		add:
			(StrategyDefaultOMovesPossiblePositions
				initialize;
				instance)
		priority: 12.
	bp
		add:
			(StrategyPreventThridXPossiblePositions
				initialize;
				instance)
		priority: 7.
	bp start.

	"	bp stop."
	^ bp
]

{ #category : #running }
TicTacToeWithSegment class >> run [
	"TO RUN: write in Playground 
bp:=TicTacToeExample preventThridXProof.
Repeat in each X move(player)
BP4PEnvironment send: ((xmoves at: 1) at: 1) toProgram: bp.
bp stop."

	self runAxesSize: self axesSize
]

{ #category : #running }
TicTacToeWithSegment class >> runAxesSize: anInteger [
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
		add:
			(RulesSquareTakenPossiblePositions
				initialize;
				instance)
		priority: 1.
	bp
		add:
			(RulesEnforceTurns
				initialize;
				instance)
		priority: 1.
	bp
		add:
			(RulesDetectXWinPossiblePositions
				initialize;
				instance)
		priority: 1.
	bp
		add:
			(RulesDetectOWinPossiblePositions
				initialize;
				instance)
		priority: 1.
	bp
		add:
			(RulesDetectDrawPossiblePositions 
				initialize;
				instance)
		priority: 1.
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
TicTacToeWithSegment class >> segmentSize [
	segmentSize  ifNil: [ segmentSize  := 3 ].
	^ segmentSize  copy
]

{ #category : #accessing }
TicTacToeWithSegment class >> takePosition: aPosition [
	possiblePositions remove: aPosition ifAbsent: [  ]
]
