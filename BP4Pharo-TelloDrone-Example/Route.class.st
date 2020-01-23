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
Route class >> instanceForCheckPoints: aCheckPointLinkedList [
	"create a Route scenario for these CheckPoints"

	| scenario |
	scenario := self instance.
	scenario instanceForCheckPoints: aCheckPointLinkedList.
	^ scenario
]

{ #category : #accessing }
Route >> instanceForCheckPoints: aCheckPointCollection [

	checkPoints := aCheckPointCollection
]

{ #category : #initialize }
Route >> run: aBP4PProgram [
	| takeoff eoc_changedLocation currentLocation targetCheckPoint fitCourse eoc_land land lastEvent |
	targetCheckPoint := checkPoints first.
	eoc_changedLocation := BP4PEventsOfClass class: ChangedLocationEvent.
	eoc_land := BP4PEventsOfClass class: LandEvent.
	land := LandEvent name: 'finishedRouteLand'.
	takeoff := TakeoffEvent new.
	aBP4PProgram syncRequested: takeoff waited: none blocked: none.
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
