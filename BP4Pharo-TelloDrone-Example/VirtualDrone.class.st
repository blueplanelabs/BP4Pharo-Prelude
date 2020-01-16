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

{ #category : #'as yet unclassified' }
VirtualDrone class >> exampleAltitude [
	| bp location altitude distance canvas border shape path steps |
	location := 0 @ 0.
	bp := DroneApplication run.
	bp
		subscribe: ChangedLocationEvent
		do: [ :cle | 
			distance := cle traveledDistance.
			altitude := cle altitude.
			location := distance @ altitude negated ].
	bp
		subscribe: LandEvent 
		do: [ :cle | 

			altitude := 0.
			location := distance @ altitude negated ].
	canvas := RSCanvas new.
	canvas extent: 100 @ 100.
	border := RSBorder new width: 4.
	shape := RSEllipse new
		border: border;
		color: Color black;
		extent: 5 asPoint;
		position: 0 @ 0;
		yourself.
	canvas add: shape.
	path := RSPolyline new.
	steps := OrderedCollection new
		add: 0 @ 0;
		yourself.
	path controlPoints: steps.
	canvas add: path.
	canvas newAnimation repeat
		onStepDo: [ :t | 
			shape matrix
				loadIdentity;
				translateBy: location.
			steps add: location.
			path controlPoints: steps.
			path update ].
	canvas open
]

{ #category : #example }
VirtualDrone class >> exampleBlackBox [
	| bp box |
	bp := DroneApplication run.
	bp subscribe: LandEvent do: [ :land | bp stop ].
	box := TelloDroneBlackBox new.
	box
		openWithSpec;
		bp: bp;
		createSubscriptions
]

{ #category : #'as yet unclassified' }
VirtualDrone class >> exampleMap [
	| bp location canvas border shape path steps |
	location := 0 @ 0.
	bp := DroneApplication run.
	bp
		subscribe: ChangedLocationEvent
		do: [ :cle | location := cle location x @ cle location y negated ].
	canvas := RSCanvas new.
	canvas extent: 100 @ 100.
	border := RSBorder new width: 4.
	shape := RSEllipse new
		border: border;
		color: Color black;
		extent: 5 asPoint;
		position: 0 @ 0;
		yourself.
	canvas add: shape.
	path := RSPolyline new.
	steps := OrderedCollection new
		add: 0 @ 0;
		yourself.
	path controlPoints: steps.
	canvas add: path.
	canvas newAnimation repeat
		onStepDo: [ :t | 
			shape matrix
				loadIdentity;
				translateBy: location.
			steps add: location.
			path controlPoints: steps.
			path update ].
	canvas open
]

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
