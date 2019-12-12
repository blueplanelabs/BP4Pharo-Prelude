Class {
	#name : #UserMove,
	#superclass : #BP4PEnvironmentScenario,
	#category : #'BP4Pharo-Test-TicTacToe-Core'
}

{ #category : #initialize }
UserMove >> run: aBP4PProgram [
	"Handle ClickEvent."

	| click xmove |
	click := BP4PEventsOfClass class: ClickEvent.
	[ true ] whileTrue: [
	aBP4PProgram syncRequested: none waited: click blocked: none.
	xmove := XEvent position: aBP4PProgram lastEvent position.
	aBP4PProgram syncRequested: xmove waited: none blocked: none]
]
