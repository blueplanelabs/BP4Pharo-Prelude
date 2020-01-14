Class {
	#name : #Route,
	#superclass : #BP4PScenario,
	#instVars : [
		'drone',
		'checkPoints'
	],
	#category : #'BP4Pharo-TelloDrone-Example'
}

{ #category : #'as yet unclassified' }
Route class >> instanceForDrone: aDrone CheckPoints: aCheckPointLinkedList [
	"create a Route scenario for these CheckPoints"

	| scenario |
	scenario := self instance.
	scenario instanceForDrone: aDrone checkPoints: aCheckPointLinkedList.
	^ scenario
]

{ #category : #accessing }
Route >> instanceForDrone: aDrone checkPoints: aCheckPointCollection [
	drone:= aDrone.
	checkPoints := aCheckPointCollection
]

{ #category : #initialize }
Route >> run: aBP4PProgram [
	| eoc_changedLocation currentLocation targetCheckPoint fitCourse  eoc_land land lastEvent |
	targetCheckPoint := checkPoints first.
	eoc_changedLocation := BP4PEventsOfClass class: ChangedLocationEvent.
	eoc_land := BP4PEventsOfClass class: LandEvent.
	land := LandEvent name: 'requestedLand'.
	[ true ]
		whileTrue: [ aBP4PProgram
				syncRequested: none
				waited: eoc_changedLocation , eoc_land
				blocked: none.
			lastEvent := aBP4PProgram lastEvent.
			(lastEvent belongsTo: LandEvent)
				ifTrue: [ ^ self ].
			currentLocation := lastEvent location.
			(currentLocation dist: targetCheckPoint) < 10
				ifTrue: [ checkPoints removeFirst.
					checkPoints isEmpty
						ifTrue: [ aBP4PProgram syncRequested: land waited: none blocked: none.
							^ self ].
					targetCheckPoint := checkPoints first ].
			fitCourse := FitCourseEvent
				course: (targetCheckPoint - currentLocation) normalized.
			aBP4PProgram
				syncRequested: fitCourse
				waited: eoc_land
				blocked: none.
			(aBP4PProgram lastEvent belongsTo: LandEvent)
				ifTrue: [ ^ self ] ]
]
