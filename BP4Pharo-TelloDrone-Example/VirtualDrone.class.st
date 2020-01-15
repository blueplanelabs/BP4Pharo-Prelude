Class {
	#name : #VirtualDrone,
	#superclass : #BP4PScenario,
	#instVars : [
		'location',
		'altitude',
		'cruiseAltitude',
		'originalLocation',
		'course',
		'defaultCourse',
		'traveledDistance',
		'altitudeVariation',
		'defaultStepTraveledDistance',
		'stepTraveledDistance',
		'traveledVelocity',
		'defaultTraveledVelocity'
	],
	#category : #'BP4Pharo-TelloDrone-Example'
}

{ #category : #accessing }
VirtualDrone >> altitude [
	altitude ifNil: [ altitude := self cruiseAltitude ].
	^altitude copy
]

{ #category : #accessing }
VirtualDrone >> altitude: anAltitude [
	altitude := anAltitude 
]

{ #category : #accessing }
VirtualDrone >> altitudeVariation [
	altitudeVariation ifNil: [ altitudeVariation := 0 ].
	^altitudeVariation copy
]

{ #category : #accessing }
VirtualDrone >> course [
	course ifNil: [ course := self defaultCourse  ].
	^ course copy
]

{ #category : #'private-initialization' }
VirtualDrone >> createSubscriptionsToBProgram: aBP4PProgram [
	aBP4PProgram
		subscribe: FitCourseEvent
		do: [ :fitCourseEvent | course := fitCourseEvent course ].
	aBP4PProgram
		subscribe: FitAltitudeEvent
		do:
			[ :fitAltitudeEvent | altitudeVariation := fitAltitudeEvent altitudeVariation ].
	aBP4PProgram
		subscribe: RequestedMoveEvent
		do: [ :requestedMove | 
			| changedLocation time |
			self
				location: self location + (self course * self stepTraveledDistance).
			self altitude: self altitude + self altitudeVariation.
			course = self defaultCourse
				ifFalse: [ self
						traveledDistance: self traveledDistance + self stepTraveledDistance ].
			time := self stepTraveledDistance / self traveledVelocity.
			[ (Delay forSeconds: time) wait.
			changedLocation := ChangedLocationEvent
				location: self location
				altitude: self altitude
				traveledDistance: self traveledDistance.
			BP4PEnvironment send: changedLocation toProgram: aBP4PProgram ]
				fork ]
]

{ #category : #accessing }
VirtualDrone >> cruiseAltitude [
	cruiseAltitude ifNil: [ cruiseAltitude := 120 ].
	^cruiseAltitude copy
]

{ #category : #accessing }
VirtualDrone >> defaultCourse [
	defaultCourse ifNil: [ defaultCourse := Location x: 0 y: 0 ].
	^defaultCourse copy
	
]

{ #category : #accessing }
VirtualDrone >> defaultStepTraveledDistance [
	defaultStepTraveledDistance 
		ifNil: [ defaultStepTraveledDistance  := 10 ].
	^ defaultStepTraveledDistance  copy
]

{ #category : #accessing }
VirtualDrone >> defaultTraveledVelocity [
	defaultTraveledVelocity ifNil: [ defaultTraveledVelocity := 5 ].
	^defaultTraveledVelocity copy
]

{ #category : #accessing }
VirtualDrone >> location [
	location ifNil: [ location := self originalLocation ].
	^ location copy
]

{ #category : #accessing }
VirtualDrone >> location: aLocation [
	location := aLocation
]

{ #category : #accessing }
VirtualDrone >> originalLocation [
	originalLocation ifNil: [ originalLocation := Location x: 0 y: 0 ].
	^ originalLocation  copy
]

{ #category : #'as yet unclassified' }
VirtualDrone >> stepTraveledDistance [
	stepTraveledDistance
		ifNil: [ stepTraveledDistance := self defaultStepTraveledDistance ].
	^ stepTraveledDistance
]

{ #category : #accessing }
VirtualDrone >> traveledDistance [ 
	^ traveledDistance  copy ifNil: [ traveledDistance  := 0 ]
]

{ #category : #accessing }
VirtualDrone >> traveledDistance: aDistance [
	traveledDistance := aDistance
]

{ #category : #accessing }
VirtualDrone >> traveledVelocity [
	traveledVelocity ifNil: [ traveledVelocity := self defaultTraveledVelocity ].
	^ traveledVelocity copy
]
