Class {
	#name : #DroneApplication,
	#superclass : #Object,
	#category : #'BP4Pharo-TelloDrone-Example'
}

{ #category : #'as yet unclassified' }
DroneApplication class >> exampleAltitude [
	| bp location altitude distance canvas border shape path steps |
	location := 0 @ 0.
	bp := DroneApplication run.
	path := RSPolyline new.
	steps := OrderedCollection new
		add: 0 @ 0;
		yourself.
	path controlPoints: steps.
	bp
		subscribe: ChangedLocationEvent
		do: [ :cle | 
			distance := cle traveledDistance.
			altitude := cle altitude.
			location := distance @ altitude negated.
			steps add: location.
			path controlPoints: steps ].
	bp
		subscribe: LandEvent
		do: [ :cle | 
			altitude := 0.
			location := distance @ altitude negated.
			steps add: location.
			path controlPoints: steps. ].
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
	canvas add: path.
	canvas newAnimation repeat
		onStepDo: [ :t | 
			shape matrix
				loadIdentity;
				translateBy: location.
			path update ].
	canvas open.

	"Erase when run correctly"
	^ bp
]

{ #category : #running }
DroneApplication class >> run [
	| bp vdrone checkPoints altitudeVariationByStepFunction |
	BP4PEnvironmentScenario initialize.
	bp := BP4PProgram new.
	vdrone := VirtualDrone new.
	vdrone createSubscriptionsToBProgram: bp.
	checkPoints := LinkedList withAll: {(50 @ 0)}.
	altitudeVariationByStepFunction := [ :distanceTravaled | 40 * (distanceTravaled * Float pi * 2 / 100) sin ].
	bp
		addScenario:
			(Landing
				initialize;
				instance)
		withPriority: 0.5.
	bp
		addScenario:
			(Route
				initialize;
				instanceForCheckPoints: checkPoints)
		withPriority: 1.
	bp
		addScenario:
			(AltitudeController
				initialize;
				instanceToFunction: altitudeVariationByStepFunction)
		withPriority: 2.
	bp
		addScenario:
			(Move
				initialize;
				instance)
		withPriority: 3.
	bp subscribe: StopEvent do: [ :le | [ bp stop ] fork ].
	bp start.
	"	Timer secondsInterval: 2 forBProgram: bp."
	^ bp
]
