Class {
	#name : #BP4PScenario,
	#superclass : #Object,
	#instVars : [
		'name',
		'priority',
		'blockToRun',
		'announcer'
	],
	#classInstVars : [
		'DefaultPriority'
	],
	#category : #BP4Pharo
}

{ #category : #creation }
BP4PScenario class >> defaultPriority [
	^ DefaultPriority ifNil: [ DefaultPriority := 10 ]
]

{ #category : #creation }
BP4PScenario class >> initialize [
	DefaultPriority := 20
]

{ #category : #creation }
BP4PScenario class >> name: aScenarioName priority: aPriority [
	"create a scenario with a name and a priority"

	^ self new name: aScenarioName priority: aPriority
]

{ #category : #creation }
BP4PScenario class >> name: aScenarioName priority: aPriority valuable: aBlock [
	"create a scenario with a name, a priority and aBlock with a BP4PProgram as argument"

	^ self new name: aScenarioName priority: aPriority valuable: aBlock
]

{ #category : #creation }
BP4PScenario class >> name: aScenarioName valuable: aBlock [
	"create a scenario with a name, default priority and aBlock with a BP4PProgram as argument"

	^ self new name: aScenarioName priority: self defaultPriority valuable: aBlock
]

{ #category : #accessing }
BP4PScenario >> announcer [
	^ announcer
]

{ #category : #accessing }
BP4PScenario >> announcer: anObject [
	announcer := anObject
]

{ #category : #accessing }
BP4PScenario >> name [
	^ name
]

{ #category : #initialize }
BP4PScenario >> name: aScenarioName priority: aPriority [
	"set name, priority of the scenario"

	name := aScenarioName.
	priority := aPriority.

]

{ #category : #initialize }
BP4PScenario >> name: aScenarioName priority: aPriority valuable: aBlock [
	"set name, priority and run of the scenario"

	name := aScenarioName.
	priority := aPriority.
	"	runnable := aBlock
	Probando si se puede cambiar el outerContext para poder referenciar al scenario"
	blockToRun := aBlock 
]

{ #category : #initialize }
BP4PScenario >> printOn: aStream [
	super printOn: aStream.
	aStream nextPutAll: ' with name '.
	name printOn: aStream.

]

{ #category : #accessing }
BP4PScenario >> priority [
	^ priority
]

{ #category : #accessing }
BP4PScenario >> priority: anInteger [
	priority:= anInteger
]

{ #category : #initialize }
BP4PScenario >> run: aBP4PProgram [
	blockToRun value: aBP4PProgram 
]

{ #category : #initialize }
BP4PScenario >> valuable [
	"	Here will be the Scenario Program in subclasses of BP4PScenario.
		It must be a block with one arg for aBP4PProgram.	
	"

	^ [ :bp | |endScenarioAnnouncement|
	self run: bp.
	endScenarioAnnouncement := BP4PEndScenarioAnnouncement scenario: self name.
	self announcer
		announce: (endScenarioAnnouncement).
	Transcript
		crShow: 'Announced ' , endScenarioAnnouncement printString. ]
]
