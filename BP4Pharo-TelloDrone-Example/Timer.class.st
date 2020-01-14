Class {
	#name : #Timer,
	#superclass : #Object,
	#category : #'BP4Pharo-TelloDrone-Example'
}

{ #category : #'as yet unclassified' }
Timer class >> secondsInterval: someSeconds forBProgram: aBP4PProgram [
	| tick |
	tick := TickEvent name: 'tick'.
	[ 3
		timesRepeat: [ (Delay forSeconds: someSeconds) wait.
			BP4PEnvironment send: tick toProgram: aBP4PProgram ] ] fork
]
