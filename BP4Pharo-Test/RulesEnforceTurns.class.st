Class {
	#name : #RulesEnforceTurns,
	#superclass : #BP4PEnvironmentScenario,
	#category : #'BP4Pharo-Test-TicTacToe-Core'
}

{ #category : #initialize }
RulesEnforceTurns >> run: aBP4PProgram [
	"Alternately block O moves while waiting for X moves, and vice versa (we assume that X always plays first)."

	| xmove omove waitedEvent blockedEvent oldBlockedEvent oldWaitedEvent|
	xmove := BP4PEventsOfClass class: XEvent.
	omove := BP4PEventsOfClass class: OEvent.
	"Wait first for X moves and block O moves"
	waitedEvent := xmove.
	blockedEvent := omove.
	[ true ]
		whileTrue: [ 
			oldWaitedEvent :=waitedEvent .
			oldBlockedEvent :=blockedEvent .
			aBP4PProgram
				syncRequested: none
				waited: waitedEvent
				blocked: blockedEvent.
			"Change the waitedEvent and blockedEvent each time"
			waitedEvent := oldBlockedEvent.
			blockedEvent := oldWaitedEvent. ]
]
