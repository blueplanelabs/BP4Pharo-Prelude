Class {
	#name : #DroneApplication,
	#superclass : #Object,
	#category : #'BP4Pharo-TelloDrone-Example'
}

{ #category : #running }
DroneApplication class >> run [
	| bp vdrone checkPoints altitudeVariationByStepFunction |
	BP4PEnvironmentScenario initialize.
	bp := BP4PProgram new.
	vdrone := VirtualDrone new.
	vdrone createSubscriptionsToBProgram: bp.
	checkPoints := LinkedList
		withAll:
			{(0 @ 0).
			(200 @ 0).
			(200 @ 200).
			(0 @ 200).
			(0 @ 0)}.
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
	bp start.
	"	Timer secondsInterval: 2 forBProgram: bp."
	^ bp
]
