Class {
	#name : #RulesSquareTaken,
	#superclass : #BP4PScenario,
	#category : #'BP4Pharo-Test-TicTacToe'
}

{ #category : #initialize }
RulesSquareTaken >> run: aBP4PProgram [
	"Block further marking of a square already marked by X or O"
	|none move |
	none := BP4PEvent new.
	
	"Wait for any move for a given square"
	aBP4PProgram syncRequested: none waited: move  blocked: none.
	"Block this move"
	aBP4PProgram syncRequested: none waited: none blocked: move
	
]
