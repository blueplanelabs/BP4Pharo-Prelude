Class {
	#name : #AlterningTapsTest,
	#superclass : #TestCase,
	#category : #'BP4Pharo-Test'
}

{ #category : #'as yet unclassified' }
AlterningTapsTest >> alternatingTaps [
	| bp |
	bp := BP4PProgram new.
	bp
		add: (DisplayEvents name: 'display' priority: 1);
		add: (AddHotFiveTimes name: 'hotfive' priority: 2);
		add: (AddColdFiveTimes name: 'coldfive' priority: 3);
		add: (Interleave name: 'interleave' priority: 4);
		yourself.
	bp start
]
