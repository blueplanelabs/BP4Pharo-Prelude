Class {
	#name : #TicTacToeExample,
	#superclass : #Object,
	#category : #'BP4Pharo-Test-TicTacToe'
}

{ #category : #running }
TicTacToeExample class >> run [
	| bp x00 x01 o01 o00 |
	x00 := XEvent position: (Position x: 0 y: 0).
	o00 := OEvent position: (Position x: 0 y: 0).
	x01 := XEvent position: (Position x: 0 y: 1).
	o01 := OEvent position: (Position x: 0 y: 1).
	bp := BP4PProgram new.
	bp
		add:
			(RulesSquareTaken
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
	"	bp stop."
	^ bp
]
