Class {
	#name : #TicTacToeExample,
	#superclass : #Object,
	#category : #'BP4Pharo-Test-TicTacToe'
}

{ #category : #running }
TicTacToeExample class >> detectXWinProof [
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
		add:
			(RulesSquareTaken
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
			(RulesDetectXWin
				initialize;
				instance)
		priority: 1.
	bp start.
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
TicTacToeExample class >> enforceTurnProof [
	| bp x00 x01 x02 o01 o00 p00 p01 p02 p10 p11 p12 p20 p21 p22 |
	p00 := Position x: 0 y: 0.
	p01 := Position x: 0 y: 1.
	p02 := Position x: 0 y: 2.
	p10 := Position x: 1 y: 0.
	p11 := Position x: 1 y: 1.
	p12 := Position x: 1 y: 2.
	p20 := Position x: 2 y: 0.
	p21 := Position x: 2 y: 1.
	p22 := Position x: 2 y: 2.
	x00 := XEvent position: (Position x: 0 y: 0).
	x01 := XEvent position: (Position x: 0 y: 1).
	x02 := XEvent position: (Position x: 0 y: 2).
	o00 := OEvent position: (Position x: 0 y: 0).

	o01 := OEvent position: (Position x: 0 y: 1).
	bp := BP4PProgram new.
	bp
		add:
			(RulesSquareTaken
				initialize;
				instance)
		priority: 1.
	bp
		add:
			(RulesEnforceTurns
				initialize;
				instance)
		priority: 1.
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

{ #category : #running }
TicTacToeExample class >> run [
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
		add:
			(RulesSquareTaken
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
			(RulesDetectXWin
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
