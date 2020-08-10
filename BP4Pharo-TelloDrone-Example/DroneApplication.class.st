Class {
	#name : #DroneApplication,
	#superclass : #Object,
	#instVars : [
		'bp',
		'vdrone'
	],
	#category : #'BP4Pharo-TelloDrone-Example'
}

{ #category : #'as yet unclassified' }
DroneApplication class >> exampleAltitude [
	| droneApplication location altitude distance canvas border shape path steps |
	location := 0 @ 0.
	droneApplication := DroneApplication runExample.
	path := RSPolyline new.
	steps := OrderedCollection new
		add: 0 @ 0;
		yourself.
	path controlPoints: steps.
	droneApplication
		subscribe: ChangedLocationEvent
		do: [ :cle | 
			distance := cle traveledDistance.
			altitude := cle altitude.
			location := distance @ altitude negated.
			steps add: location.
			path controlPoints: steps ].
	droneApplication
		subscribe: LandEvent
		do: [ :cle | 
			altitude := 0.
			location := distance @ altitude negated.
			steps add: location.
			path controlPoints: steps ].
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
	^ droneApplication
]

{ #category : #example }
DroneApplication class >> exampleBlackBox [
	| bp box |
	bp := DroneApplication run.

	box := TelloDroneBlackBox new.
	box
		openWithSpec;
		bp: bp;
		createSubscriptions
]

{ #category : #'as yet unclassified' }
DroneApplication class >> exampleMap [
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
	bp
		subscribe: StopEvent
		do: [ :le | Transcript crShow: 'Received StopEvent in DroneApplication'.
			[ 
			bp stop ] fork ].
	bp start.
	"	Timer secondsInterval: 2 forBProgram: bp."
	^ bp
]

{ #category : #running }
DroneApplication class >> run: someCheckPoints [
	| bp vdrone  altitudeVariationByStepFunction |
	BP4PEnvironmentScenario initialize.
	bp := BP4PProgram new.
	vdrone := VirtualDrone new.
	vdrone createSubscriptionsToBProgram: bp.

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
				instanceForCheckPoints: someCheckPoints)
		withPriority: 1.
"	bp
		addScenario:
			(AltitudeController
				initialize;
				instanceToFunction: altitudeVariationByStepFunction)
		withPriority: 2."
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

{ #category : #running }
DroneApplication class >> runExample [
	| droneApplication routeScenario checkPoints altitudeVariationScenario altitudeVariationByStepFunction |
	droneApplication := DroneApplication new.
	[droneApplication altitudeMonitor] fork.
	[droneApplication routeMonitor] fork.
	droneApplication start.
	checkPoints := LinkedList withAll: {(200 @ 0)}.
	routeScenario := Route
		initialize;
		instanceForCheckPoints: checkPoints.
	droneApplication addScenario: routeScenario withPriority: 1.
	droneApplication startScenario: routeScenario.
	altitudeVariationByStepFunction := [ :distanceTravaled | 40 * (distanceTravaled * Float pi * 2 / 100) sin ].
	altitudeVariationScenario := AltitudeController
		initialize;
		instanceToFunction: altitudeVariationByStepFunction.
	droneApplication
		addScenario: altitudeVariationScenario
		withPriority: 2.
	droneApplication startScenario: altitudeVariationScenario.
	^ droneApplication
]

{ #category : #adding }
DroneApplication >> addDefaultScenarios [
	bp
		addScenario:
			(Landing
				initialize;
				instance)
		withPriority: 0.5.
	bp
		addScenario:
			(Move
				initialize;
				instance)
		withPriority: 3.
]

{ #category : #adding }
DroneApplication >> addScenario: aScenario withPriority: aPriority [
	bp
		addScenario:
			aScenario
		withPriority: aPriority 
]

{ #category : #monitoring }
DroneApplication >> altitudeMonitor [
	| location altitude distance canvas border shape path steps |
	location := vdrone location.
	path := RSPolyline new.
	steps := OrderedCollection new
		add: 0 @ 0;
		yourself.
	path controlPoints: steps.
	self
		subscribe: ChangedLocationEvent
		do: [ :cle | 
			Transcript crShow: 'Received ChangedLocationEvent in altitudeMonitor'.
			distance := cle traveledDistance.
			altitude := cle altitude.
			location := distance @ altitude negated.
			steps add: location.
			path controlPoints: steps ].
	self
		subscribe: LandEvent
		do: [ :cle | 
			Transcript crShow: 'Received LandEvent in altitudeMonitor'.			
			altitude := 0.
			location := distance @ altitude negated.
			steps add: location.
			path controlPoints: steps ].
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
	^ self
]

{ #category : #monitoring }
DroneApplication >> blackBoxMonitor [
	| box |
	box := TelloDroneBlackBox new.
	box
		openWithSpec;
		bp: bp;
		createSubscriptions
]

{ #category : #initialization }
DroneApplication >> initialize [

	BP4PEnvironmentScenario initialize.
	bp := BP4PProgram new.
	vdrone := VirtualDrone new.
	vdrone createSubscriptionsToBProgram: bp.
	self addDefaultScenarios.
	bp subscribe: StopEvent do: [ :le | [ bp stop ] fork ].

]

{ #category : #adding }
DroneApplication >> removeScenario: aScenario [
	bp endScenario: aScenario
]

{ #category : #monitoring }
DroneApplication >> routeMonitor [
	| location canvas border shape path steps |
	location := vdrone location.
	self
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

{ #category : #initialization }
DroneApplication >> start [
	bp start
]

{ #category : #adding }
DroneApplication >> startScenario: aScenario [
	bp startScenario: aScenario
]

{ #category : #initialization }
DroneApplication >> stop [
	bp stop
]

{ #category : #initialization }
DroneApplication >> subscribe: aBP4PEventClass do: aValuable [
	bp subscribe: aBP4PEventClass do: aValuable
]
