Class {
	#name : #Landing,
	#superclass : #BP4PScenario,
	#category : #'BP4Pharo-TelloDrone-Example'
}

{ #category : #initialize }
Landing >> run: aBP4PProgram [
	| eoc_land all stop |
	all := BP4PEventsOfClass class: BP4PEvent.
	stop := StopEvent  name: 'stop'.
	eoc_land := BP4PEventsOfClass class: LandEvent.
	all := BP4PEventsOfClass class: BP4PEvent.
	aBP4PProgram syncRequested: none waited: eoc_land blocked: none.
	aBP4PProgram syncRequested: stop waited: none blocked: none.
	aBP4PProgram syncRequested: none waited: none blocked: all
]
