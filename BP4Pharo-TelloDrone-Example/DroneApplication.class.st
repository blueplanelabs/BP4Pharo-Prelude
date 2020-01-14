Class {
	#name : #DroneApplication,
	#superclass : #Object,
	#category : #'BP4Pharo-TelloDrone-Example'
}

{ #category : #running }
DroneApplication class >> run [
	| bp vdrone checkPoints heightFunction |
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
	heightFunction := [ :distanceTravaled | 40 * distanceTravaled sin ].
	bp
		addScenario:
			(Route
				initialize;
				instanceForDrone: vdrone CheckPoints: checkPoints)
		withPriority: 1.
	bp
		addScenario:
			(AltitudeController
				initialize;
				instanceToFunction: heightFunction)
		withPriority: 2.
	bp
		addScenario:
			(Move
				initialize;
				instanceToDrone: vdrone)
		withPriority: 3.
	bp start.
"	Timer secondsInterval: 2 forBProgram: bp."
	^ bp
]
