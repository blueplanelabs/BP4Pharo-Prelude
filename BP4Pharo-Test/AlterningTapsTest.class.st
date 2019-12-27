Class {
	#name : #AlterningTapsTest,
	#superclass : #TestCase,
	#category : #'BP4Pharo-Test-AlterningTaps'
}

{ #category : #'as yet unclassified' }
AlterningTapsTest >> alternatingTaps [
	| bp |
	bp := BP4PProgram new.
	bp
		addScenario: (DisplayEvents initialize ;instance) withPriority: 1;
		addScenario: (AddHotFiveTimes initialize ;instance) withPriority: 2;
		addScenario: (AddColdFiveTimes initialize ;instance) withPriority: 3;
		addScenario: (Interleave initialize ;instance) withPriority: 4.
	bp start
]
