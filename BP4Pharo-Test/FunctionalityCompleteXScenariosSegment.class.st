Class {
	#name : #FunctionalityCompleteXScenariosSegment,
	#superclass : #BP4PScenario,
	#instVars : [
		'generatedScenarioPriority'
	],
	#category : #'BP4Pharo-Test-TicTacToe-SegmentBased'
}

{ #category : #creation }
FunctionalityCompleteXScenariosSegment class >> instanceWithGeneratedScenariosPriority: aPriority [
	"create a instance with a priority for the generated scenarios"

	| scenario |
	scenario := self instance.
	scenario generatedScenarioPriority: aPriority.
	^ scenario
]

{ #category : #accessing }
FunctionalityCompleteXScenariosSegment >> generatedScenarioPriority [ 
^generatedScenarioPriority 
]

{ #category : #accessing }
FunctionalityCompleteXScenariosSegment >> generatedScenarioPriority: aPriority [
	generatedScenarioPriority := aPriority 
]

{ #category : #initialize }
FunctionalityCompleteXScenariosSegment >> run: aBP4PProgram [
	"Generate PreventXForkTwoIntersectedSegments scenarios to be monitored with the available segments intersected for each X move and following X moves"

	| move xmove originalXMove originalXSegments newScenario generatePreventXForkTISScenarios |
	move := BP4PEventsOfClass class: MoveEvent.
	xmove := BP4PEventsOfClass class: XEvent.
	"Wait for any X move"
	aBP4PProgram syncRequested: none waited: xmove blocked: none.
	"Add a new scenario like this to wait and block again a new move. PRECHART"
	newScenario := self class
		instanceWithGeneratedScenariosPriority: self generatedScenarioPriority.
	aBP4PProgram
		add: newScenario priority: self priority;
		startScenario: newScenario.
	"Keep the available segments for the original X move position"
	originalXMove := aBP4PProgram lastEvent.
	originalXSegments := TicTacToeWithSegment
		generateAvailabeSegmentsTo: originalXMove position.
	"Wait for following moves until no segments size>=2"
	[ originalXSegments anySatisfy: [ :segment | segment size >= 2 ] ]
		whileTrue: [ aBP4PProgram syncRequested: none waited: move blocked: none.
			"If O move update the available original X segments. Some segment can have been anulated"
			(aBP4PProgram lastEvent belongsTo: OEvent)
				ifTrue: [ originalXSegments := originalXSegments
						select: [ :segment | segment noneSatisfy: [ :p | p=aBP4PProgram lastEvent position] ] ].
			"If X move update the positions of available original segments and request GeneratePreventXForkTISScenariosEvent"
			(aBP4PProgram lastEvent belongsTo: XEvent)
				ifTrue: [ originalXSegments
						do: [ :oxs | oxs remove: aBP4PProgram lastEvent position ifAbsent: [  ] ].
					"Request a GeneratePreventXForkTISScenariosEvent for the monitored originalXSegments and the worked position"
					generatePreventXForkTISScenarios := GeneratePreventXForkTISScenariosEvent
						position: aBP4PProgram lastEvent position
						segments: originalXSegments
						priority: self generatedScenarioPriority.
					aBP4PProgram
						syncRequested: generatePreventXForkTISScenarios
						waited: none
						blocked: none ] ]
]
