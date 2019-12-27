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
	bp
		addScenario:
			(StrategyAddThridOPossiblePositions
				initialize;
				instance)
		withPriority: 6.
	bp start.

	"	bp stop."
	^ bp
]

{ #category : #api }
TicTacToeWithSegment class >> axesSize [
	axesSize ifNil: [ axesSize := 3 ].
	^axesSize copy
]

{ #category : #initialization }
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
TicTacToeWithSegment class >> detectOWinSegmentCompletedProof [
	| bp segment |
	segment := Set new
		add: (Position x: 1 y: 1);
		add: (Position x: 2 y: 1);
		yourself.
	BP4PEnvironmentScenario initialize.
	bp := BP4PProgram new.
	bp
		addScenario:
			(RulesDetectOWinSegment
				initialize;
				instanceToSegment: segment)
		withPriority: 3.
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
TicTacToeWithSegment class >> detectOWinSegmentInterruptedProof [
	| bp segment |
	segment := Set new
		add: (Position x: 1 y: 1);
		add: (Position x: 2 y: 1);
		yourself.
	BP4PEnvironmentScenario initialize.
	bp := BP4PProgram new.
	bp
		addScenario:
			(RulesDetectOWinSegment
				initialize;
				instanceToSegment: segment)
		withPriority: 3.
	bp start.
	(Delay forSeconds: 1) wait.
	BP4PEnvironment
		send: (OEvent position: (Position x: 1 y: 1))
		toProgram: bp.
	(Delay forSeconds: 1) wait.
	BP4PEnvironment
		send: (XEvent position: (Position x: 2 y: 1))
		toProgram: bp.
	(Delay forSeconds: 1) wait.
	"	bp stop."
	^ bp
]

{ #category : #running }
TicTacToeWithSegment class >> detectXWinSegmentCompletedProof [
	| bp segment |
	segment := Set new
		add: (Position x: 1 y: 1);
		add: (Position x: 2 y: 1);
		yourself.
	BP4PEnvironmentScenario initialize.
	bp := BP4PProgram new.
	bp
		addScenario:
			(RulesDetectXWinSegment
				initialize;
				instanceToSegment: segment)
		withPriority: 3.
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
TicTacToeWithSegment class >> detectXWinSegmentInterruptedProof [
	| bp segment |
	segment := Set new
		add: (Position x: 1 y: 1);
		add: (Position x: 2 y: 1);
		yourself.
	BP4PEnvironmentScenario initialize.
	bp := BP4PProgram new.
	bp
		addScenario:
			(RulesDetectXWinSegment
				initialize;
				instanceToSegment: segment)
		withPriority: 3.
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
TicTacToeWithSegment class >> enforceTurnProof [
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

{ #category : #running }
TicTacToeWithSegment class >> forceOWinSegmentCompletedProof [
	| bp segment p1 p2 p3 p4 |
	p1 := Position x: 1 y: 1.
	p2 := Position x: 2 y: 1.
	p3 := Position x: 3 y: 1.
	p4 := Position x: 4 y: 1.
	segment := Set new
		add: (Position x: 1 y: 1);
		add: (Position x: 2 y: 1);
		add: (Position x: 3 y: 1);
		add: (Position x: 4 y: 1);
		yourself.
	BP4PEnvironmentScenario initialize.
	bp := BP4PProgram new.
	bp
		addScenario:
			(StrategyForceOWinSegment
				initialize;
				instanceToSegment: segment)
		withPriority: 3.
	bp start.
	(Delay forSeconds: 1) wait.
	BP4PEnvironment send: (OEvent position: p1) toProgram: bp.
	(Delay forSeconds: 1) wait.
	BP4PEnvironment send: (OEvent position: p3) toProgram: bp.
	(Delay forSeconds: 1) wait.
	BP4PEnvironment send: (OEvent position: p4) toProgram: bp.
	(Delay forSeconds: 1) wait.
	bp lastEvent = (OEvent position: p2)
		ifTrue: [ Transcript
				crShow: '========================Correct Proof========================' ]
		ifFalse: [ Transcript
				crShow: '========================Incorrect Proof========================' ].
	bp stop.
	^ bp
]

{ #category : #running }
TicTacToeWithSegment class >> forceOWinSegmentInterruptedProof [
	| bp segment p1 p2 p3 p4 scenario |
	p1 := Position x: 1 y: 1.
	p2 := Position x: 2 y: 1.
	p3 := Position x: 3 y: 1.
	p4 := Position x: 4 y: 1.
	segment := Set new
		add: p1;
		add: p2;
		add: p3;
		add: p4;
		yourself.
	scenario := StrategyForceOWinSegment
		initialize;
		instanceToSegment: segment.
	BP4PEnvironmentScenario initialize.
	bp := BP4PProgram new.
	bp addScenario: scenario withPriority: 3.
	bp start.
	(Delay forSeconds: 1) wait.
	BP4PEnvironment send: (OEvent position: p1) toProgram: bp.
	(Delay forSeconds: 1) wait.
	BP4PEnvironment send: (OEvent position: p2) toProgram: bp.
	(Delay forSeconds: 1) wait.
	BP4PEnvironment send: (XEvent position: p3) toProgram: bp.
	(Delay forSeconds: 1) wait.
	(bp scenarios  includes: scenario)
		ifFalse: [ Transcript
				crShow: '========================Correct Proof========================' ]
		ifTrue: [ Transcript
				crShow: '========================Incorrect Proof========================' ].
	bp stop.
	^ bp
]

{ #category : #running }
TicTacToeWithSegment class >> functionalityGenerateDetectWinScenariosProof [
	| bp |
	RulesDetectXWinSegment initialize.
	RulesDetectOWinSegment initialize.
	BP4PEnvironmentScenario initialize.
	bp := BP4PProgram new.
	bp
		addScenario:
			(RulesSquareTakenSegment
				initialize;
				instance)
		withPriority: 1.
	bp
		addScenario:
			(TicTacToeActuatorSegment
				initialize;
				instance)
		withPriority: 2.
	bp
		addScenario:
			(FunctionalityGenerateDetectWinScenariosSegment
				initialize;
				instance)
		withPriority: 3.

	bp start.

	"	bp stop."
	^ bp
]

{ #category : #running }
TicTacToeWithSegment class >> functionalityGenerateForceOWinScenariosProof [
	| bp p1 scenarioNames |
	p1 := Position x: 1 y: 1.
	self axesSize: 4 segmentSize: 4.
	scenarioNames := Set new
		add: 'StrategyForceOWinSegment0';
		add: 'StrategyForceOWinSegment1';
		add: 'StrategyForceOWinSegment2';
		yourself.
	BP4PEnvironmentScenario initialize.
	bp := BP4PProgram new.
	bp
		addScenario:
			(TicTacToeActuatorSegment
				initialize;
				instance)
		withPriority: 2.
	bp
		addScenario:
			(FunctionalityGenerateForceOWinScenariosSegment
				initialize;
				instanceWithGeneratedScenariosPriority: 6)
		withPriority: 3.
	bp start.
	(Delay forSeconds: 1) wait.
	BP4PEnvironment send: (OEvent position: p1) toProgram: bp.
	(Delay forSeconds: 1) wait.
	((bp scenarios collect: [ :scenario | scenario name ]) asSet
		includesAll: scenarioNames)
		ifTrue: [ Transcript
				crShow: '========================Correct Proof========================' ]
		ifFalse: [ Transcript
				crShow: '========================Incorrect Proof========================' ].
	bp stop.
	^ bp
]

{ #category : #running }
TicTacToeWithSegment class >> functionalityGeneratePreventXWinScenariosProof [
	| bp |
	BP4PEnvironmentScenario initialize.
	bp := BP4PProgram new.
	bp
		addScenario:
			(RulesSquareTakenSegment
				initialize;
				instance)
		withPriority: 1.
	bp
		addScenario:
			(TicTacToeActuatorSegment
				initialize;
				instance)
		withPriority: 2.
	bp
		addScenario:
			(FunctionalityGeneratePreventXWinScenariosSegment
				initialize;
				instance)
		withPriority: 3.
	bp start.
	

	"	bp stop."
	^ bp
]

{ #category : #api }
TicTacToeWithSegment class >> generateAvailabeSegmentsTo: aPosition [
	"Get the segments that are fully available according to the possiblePositions on TicTacToe"

	| segments |
"	(TicTacToeWithSegment possiblePositions includes: aPosition)
		ifFalse: [ ^ nil ]."
	segments := Set new.
	1 to: self segmentSize do: [ :i | 
		| horizontalSegment verticalSegment firstDiagonal secondDiagonal |
		horizontalSegment := Set new.
		verticalSegment := Set new.
		firstDiagonal := Set new.
		secondDiagonal := Set new.
		1 to: self segmentSize do: [ :j | 
			horizontalSegment add: (aPosition translateBy: (j - i) @ 0).
			verticalSegment add: (aPosition translateBy: 0 @ (j - i)).
			firstDiagonal add: (aPosition translateBy: (j - i) @ (j - i)).
			secondDiagonal add: (aPosition translateBy: (i - j) @ (j - i)) ].
		segments
			add: horizontalSegment;
			add: verticalSegment;
			add: firstDiagonal;
			add: secondDiagonal;
			yourself ].
	"Remove current position of the segments to check"
	segments do: [ :segment | segment remove: aPosition asPoint ].
	"Remove segments that are not fully available"
	segments := segments
		select: [ :segment | 
			segment
				= (TicTacToeWithSegment possiblePositions intersection: segment) ].
	^ segments
]

{ #category : #api }
TicTacToeWithSegment class >> numAvailabeSegmentsTo: aPosition [
	"Return the number of segments that are fully available according to the possiblePositions on TicTacToe"
	^(self generateAvailabeSegmentsTo: aPosition) size.

]

{ #category : #api }
TicTacToeWithSegment class >> possiblePositions [
	^ possiblePositions copy

]

{ #category : #running }
TicTacToeWithSegment class >> preventThridXProof [
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
TicTacToeWithSegment class >> preventXWinSegmentCompletedProof [
	| bp segment p1 p2 p3 p4 |
	p1 := Position x: 1 y: 1.
	p2 := Position x: 2 y: 1.
	p3 := Position x: 3 y: 1.
	p4 := Position x: 4 y: 1.
	segment := Set new
		add: p1;
		add: p2;
		add: p3;
		add: p4;
		yourself.
	BP4PEnvironmentScenario initialize.
	bp := BP4PProgram new.
	bp
		addScenario:
			(StrategyPreventXWinSegment
				initialize;
				instanceToSegment: segment)
		withPriority: 3.
	bp start.
	(Delay forSeconds: 1) wait.
	BP4PEnvironment send: (XEvent position: p1) toProgram: bp.
	(Delay forSeconds: 1) wait.
	BP4PEnvironment send: (XEvent position: p3) toProgram: bp.
	(Delay forSeconds: 1) wait.
	BP4PEnvironment send: (XEvent position: p4) toProgram: bp.
	(Delay forSeconds: 1) wait.
	bp lastEvent = (OEvent position: p2)
		ifTrue: [ Transcript
				crShow: '========================Correct Proof========================' ]
		ifFalse: [ Transcript
				crShow: '========================Incorrect Proof========================' ].
	bp stop.
	^ bp
]

{ #category : #running }
TicTacToeWithSegment class >> preventXWinSegmentInterruptedProof [
	| bp segment p1 p2 p3 p4 scenario |
	p1 := Position x: 1 y: 1.
	p2 := Position x: 2 y: 1.
	p3 := Position x: 3 y: 1.
	p4 := Position x: 4 y: 1.
	segment := Set new
		add: p1;
		add: p2;
		add: p3;
		add: p4;
		yourself.
	scenario := StrategyPreventXWinSegment
		initialize;
		instanceToSegment: segment.
	BP4PEnvironmentScenario initialize.
	bp := BP4PProgram new.
	bp addScenario: scenario withPriority: 3.
	bp start.
	(Delay forSeconds: 1) wait.
	BP4PEnvironment send: (XEvent position: p1) toProgram: bp.
	(Delay forSeconds: 1) wait.
	BP4PEnvironment send: (XEvent position: p2) toProgram: bp.
	(Delay forSeconds: 1) wait.
	BP4PEnvironment send: (OEvent position: p3) toProgram: bp.
	(Delay forSeconds: 1) wait.
	(bp processes keys includes: scenario)
		ifFalse: [ Transcript
				crShow: '========================Correct Proof========================' ]
		ifTrue: [ Transcript
				crShow: '========================Incorrect Proof========================' ].
	bp stop.
	^ bp
]

{ #category : #running }
TicTacToeWithSegment class >> run [
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
			(RulesSquareTakenSegment
				initialize;
				instance)
		withPriority: 1.
	bp
		addScenario:
			(TicTacToeActuatorSegment
				initialize;
				instance)
		withPriority: 2.
	bp
		addScenario:
			(RulesEnforceTurns
				initialize;
				instance)
		withPriority: 3.
	bp
		addScenario:
			(FunctionalityGenerateDetectWinScenariosSegment
				initialize;
				instanceWithGeneratedScenariosPriority: 6)
		withPriority: 4.
	bp
		addScenario:
			(RulesDetectDrawSegment
				initialize;
				instance)
		withPriority: 5.

	bp
		addScenario:
			(FunctionalityGenerateForceOWinScenariosSegment
				initialize;
				instanceWithGeneratedScenariosPriority: 20)
		withPriority: 10.
	bp
		addScenario:
			(FunctionalityGeneratePreventXWinScenariosSegment
				initialize;
				instanceWithGeneratedScenariosPriority: 21)
		withPriority: 11.
	bp
		addScenario:
			(FunctionalityGeneratePreventXForkTISScenariosSegment
				initialize;
				instanceWithGeneratedScenariosPriority: 22)
		withPriority: 12.
	bp
		addScenario:
			(StrategyDefaultOMovesSegment
				initialize;
				instance)
		withPriority: 30.
	bp start.

	"	bp stop."
	^ bp
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

{ #category : #api }
TicTacToeWithSegment class >> segmentSize [
	segmentSize  ifNil: [ segmentSize  := 3 ].
	^ segmentSize  copy
]

{ #category : #running }
TicTacToeWithSegment class >> squareTakenSegmentProof [
	| bp |
	BP4PEnvironmentScenario initialize.
	bp := BP4PProgram new.
	bp
		addScenario:
			(RulesSquareTakenSegment
				initialize;
				instance)
		withPriority: 1.
	bp
		addScenario:
			(TicTacToeActuatorSegment
				initialize;
				instance)
		withPriority: 2.
	bp start.

	BP4PEnvironment
		send: (MoveEvent position: (Position x: 1 y: 1))
		toProgram: bp.

	BP4PEnvironment
		send: (XEvent position: (Position x: 2 y: 2))
		toProgram: bp.
	BP4PEnvironment
		send: (OEvent position: (Position x: 3 y: 3))
		toProgram: bp.
	"	bp stop."
	^ bp
]

{ #category : #running }
TicTacToeWithSegment class >> strategyCompleteOSegmentCompletedProof [
	| bp segment p1 p2 p3 p4 scenario success |
	TicTacToeWithSegment axesSize: 5 segmentSize: 5.
	p1 := Position x: 1 y: 1.
	p2 := Position x: 2 y: 1.
	p3 := Position x: 3 y: 1.
	p4 := Position x: 4 y: 1.
	segment := Set new
		add: (Position x: 1 y: 1);
		add: (Position x: 2 y: 1);
		add: (Position x: 3 y: 1);
		add: (Position x: 4 y: 1);
		yourself.
	BP4PEnvironmentScenario initialize.
	bp := BP4PProgram new.
	scenario := StrategyCompleteOSegment
		initialize;
		instanceToSegment: segment.
	bp addScenario: scenario withPriority: 3.
	bp start.
	bp announcer
		subscribe: BP4PEndScenarioAnnouncement
		do: [ :event | 
			((bp getPriorityOfScenario: event scenario) round: 2) = (3 - (0.01 * 4))
				ifTrue: [ Transcript
						crShow: '========================Correct Proof========================' ]
				ifFalse: [ Transcript
						crShow: '========================Incorrect Proof========================' ] ].

	"and: [ ((bp scenarioPriority: self) = 3) - (0.01 * 3) ]
	bp stop."
	^ bp
]

{ #category : #running }
TicTacToeWithSegment class >> strategyPreventXForkTwoIntersectedSegmentsCompletedProof [
	| bp segment1 segment2 p1 p2 p3 p4 p5 p6 p7 p8 |
	TicTacToeWithSegment axesSize: 5 segmentSize: 5.
	"firstSegment"
	p1 := Position x: 1 y: 1.
	p2 := Position x: 2 y: 1.
	p3 := Position x: 3 y: 1.
	p4 := Position x: 4 y: 1.
	segment1 := Set new
		add: p1;
		add: p2;
		add: p3;
		add: p4;
		yourself.
	"secondSegment"
	p5 := Position x: 3 y: 1.
	p6 := Position x: 3 y: 2.
	p7 := Position x: 3 y: 3.
	p8 := Position x: 3 y: 4.
	segment2 := Set new
		add: p5;
		add: p6;
		add: p7;
		add: p8;
		yourself.
	BP4PEnvironmentScenario initialize.
	bp := BP4PProgram new.
	bp
		addScenario:
			(StrategyPreventXForkTwoIntersectedSegments
				initialize;
				instanceToSegment: segment1 andSegment: segment2)
		withPriority: 3.
	bp start.
	(Delay forSeconds: 1) wait.
	BP4PEnvironment send: (XEvent position: p1) toProgram: bp.
	(Delay forSeconds: 1) wait.
	BP4PEnvironment send: (XEvent position: p6) toProgram: bp.
	(Delay forSeconds: 1) wait.
	BP4PEnvironment send: (XEvent position: p2) toProgram: bp.
	(Delay forSeconds: 1) wait.
	BP4PEnvironment send: (XEvent position: p7) toProgram: bp.
	(Delay forSeconds: 3) wait.
	bp lastEvent = (OEvent position: p3)
		ifTrue: [ Transcript
				crShow: '========================Correct Proof========================' ]
		ifFalse: [ Transcript
				crShow: '========================Incorrect Proof========================' ].
	bp stop.
	^ bp
]

{ #category : #running }
TicTacToeWithSegment class >> strategyPreventXForkTwoIntersectedSegmentsInterruptedByMoveIntersectionProof [
	| bp segment1 segment2 p1 p2 p3 p4 p5 p6 p7 p8 scenario |
	TicTacToeWithSegment axesSize: 5 segmentSize: 5.
	"firstSegment"
	p1 := Position x: 1 y: 1.
	p2 := Position x: 2 y: 1.
	p3 := Position x: 3 y: 1.
	p4 := Position x: 4 y: 1.
	segment1 := Set new
		add: p1;
		add: p2;
		add: p3;
		add: p4;
		yourself.
	"secondSegment"
	p5 := Position x: 3 y: 1.
	p6 := Position x: 3 y: 2.
	p7 := Position x: 3 y: 3.
	p8 := Position x: 3 y: 4.
	segment2 := Set new
		add: p5;
		add: p6;
		add: p7;
		add: p8;
		yourself.
	BP4PEnvironmentScenario initialize.
	bp := BP4PProgram new.
	scenario := StrategyPreventXForkTwoIntersectedSegments
		initialize;
		instanceToSegment: segment1 andSegment: segment2.
	bp addScenario: scenario withPriority: 3.
	bp start.
	(Delay forSeconds: 1) wait.
	BP4PEnvironment send: (XEvent position: p1) toProgram: bp.
	(Delay forSeconds: 1) wait.
	BP4PEnvironment send: (XEvent position: p6) toProgram: bp.
	(Delay forSeconds: 1) wait.
	BP4PEnvironment send: (XEvent position: p3) toProgram: bp.
	(Delay forSeconds: 1) wait.
	BP4PEnvironment send: (XEvent position: p7) toProgram: bp.
	(Delay forSeconds: 3) wait.
	(bp processes keys includes: scenario)
		ifFalse: [ Transcript
				crShow: '========================Correct Proof========================' ]
		ifTrue: [ Transcript
				crShow: '========================Incorrect Proof========================' ].
	bp stop.
	^ bp
]

{ #category : #running }
TicTacToeWithSegment class >> strategyPreventXForkTwoIntersectedSegmentsInterruptedByOProof [
	| bp segment1 segment2 p1 p2 p3 p4 p5 p6 p7 p8 scenario |
	TicTacToeWithSegment axesSize: 5 segmentSize: 5.
	"firstSegment"
	p1 := Position x: 1 y: 1.
	p2 := Position x: 2 y: 1.
	p3 := Position x: 3 y: 1.
	p4 := Position x: 4 y: 1.
	segment1 := Set new
		add: p1;
		add: p2;
		add: p3;
		add: p4;
		yourself.
	"secondSegment"
	p5 := Position x: 3 y: 1.
	p6 := Position x: 3 y: 2.
	p7 := Position x: 3 y: 3.
	p8 := Position x: 3 y: 4.
	segment2 := Set new
		add: p5;
		add: p6;
		add: p7;
		add: p8;
		yourself.
	BP4PEnvironmentScenario initialize.
	bp := BP4PProgram new.
	scenario := StrategyPreventXForkTwoIntersectedSegments
		initialize;
		instanceToSegment: segment1 andSegment: segment2.
	bp addScenario: scenario withPriority: 3.
	bp start.
	(Delay forSeconds: 1) wait.
	BP4PEnvironment send: (XEvent position: p1) toProgram: bp.
	(Delay forSeconds: 1) wait.
	BP4PEnvironment send: (XEvent position: p6) toProgram: bp.
	(Delay forSeconds: 1) wait.
	BP4PEnvironment send: (XEvent position: p2) toProgram: bp.
	(Delay forSeconds: 1) wait.
	BP4PEnvironment send: (XEvent position: p7) toProgram: bp.
	(Delay forSeconds: 3) wait.
	(bp processes keys includes: scenario)
		ifFalse: [ Transcript
				crShow: '========================Correct Proof========================' ]
		ifTrue: [ Transcript
				crShow: '========================Incorrect Proof========================' ].
	bp stop.
	^ bp
]

{ #category : #api }
TicTacToeWithSegment class >> takePosition: aPosition [
	possiblePositions
		remove: aPosition
		ifAbsent: [ Transcript
				crShow: 'Position to take not possible: ' , aPosition printString, ' in possiblePositions ', possiblePositions printString  ].
	Transcript crShow: 'Taked position: ' , aPosition printString,' in possiblePositions ', possiblePositions printString
]
