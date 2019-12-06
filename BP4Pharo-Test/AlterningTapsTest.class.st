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
		add: (DisplayEvents initialize ;instance) priority: 1;
		add: (AddHotFiveTimes initialize ;instance) priority: 2;
		add: (AddColdFiveTimes initialize ;instance) priority: 3;
		add: (Interleave initialize ;instance) priority: 4.
	bp start
]
