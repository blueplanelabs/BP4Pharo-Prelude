Class {
	#name : #VirtualDrone,
	#superclass : #BP4PScenario,
	#instVars : [
		'location',
		'altitude',
		'originalLocation',
		'course',
		'traveledDistance',
		'altitudeVariation',
		'stepTraveledDistance',
		'travelVelocity'
	],
	#classVars : [
		'CruiseAltitude',
		'DefaultCourse',
		'DefaultStepTravelDistance',
		'DefaultTravelVelocity',
		'GroundAltitude',
		'OriginLocation'
	],
	#category : #'BP4Pharo-TelloDrone-Example'
}

{ #category : #'class initialization' }
VirtualDrone class >> initialize [
	GroundAltitude := 0.
	CruiseAltitude := 120.
	DefaultCourse := Location x: 0 y: 0.
	DefaultStepTravelDistance := 10.
	DefaultTravelVelocity := 5.
	OriginLocation := Location x: 0 y: 0
]

{ #category : #accessing }
VirtualDrone >> altitude [
	altitude ifNil: [ altitude := GroundAltitude ].
	^ altitude copy
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
	course ifNil: [ course := DefaultCourse  ].
	^ course copy
]

{ #category : #'private-initialization' }
VirtualDrone >> createSubscriptionsToBProgram: aBP4PProgram [
	aBP4PProgram
		subscribe: TakeoffEvent
		do: [ self altitude: CruiseAltitude ].
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
			self altitude: CruiseAltitude  + self altitudeVariation.
			course = DefaultCourse
				ifFalse: [ self
						traveledDistance: self traveledDistance + self stepTraveledDistance ].
			time := self stepTraveledDistance / self travelVelocity.
			[ (Delay forSeconds: time) wait.
			changedLocation := ChangedLocationEvent
				location: self location
				altitude: self altitude
				traveledDistance: self traveledDistance.
			BP4PEnvironment send: changedLocation toProgram: aBP4PProgram ]
				fork ]
]

{ #category : #accessing }
VirtualDrone >> location [
	location ifNil: [ location := OriginLocation ].
	^ location copy
]

{ #category : #accessing }
VirtualDrone >> location: aLocation [
	location := aLocation
]

{ #category : #'as yet unclassified' }
VirtualDrone >> stepTraveledDistance [
	stepTraveledDistance
		ifNil: [ stepTraveledDistance := DefaultStepTravelDistance ].
	^ stepTraveledDistance
]

{ #category : #accessing }
VirtualDrone >> travelVelocity [
	travelVelocity
		ifNil: [ travelVelocity := DefaultTravelVelocity ].
	^ travelVelocity copy
]

{ #category : #accessing }
VirtualDrone >> traveledDistance [ 
	^ traveledDistance  copy ifNil: [ traveledDistance  := 0 ]
]

{ #category : #accessing }
VirtualDrone >> traveledDistance: aDistance [
	traveledDistance := aDistance
]
