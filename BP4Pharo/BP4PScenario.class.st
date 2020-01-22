Class {
	#name : #BP4PScenario,
	#superclass : #Object,
	#instVars : [
		'name',
		'priority',
		'blockToRun',
		'announcer'
	],
	#classVars : [
		'none'
	],
	#classInstVars : [
		'Iterator'
	],
	#category : #BP4Pharo
}

{ #category : #private }
BP4PScenario class >> increaseIterator [
	Iterator := self iterator + 1
]

{ #category : #'class initialization' }
BP4PScenario class >> initialize [
	none := BP4PEvent none.
	Iterator := 0
]

{ #category : #creation }
BP4PScenario class >> instance [
	"create a scenario with a automatic name"

	"Fix name and increaseIterator for the next instance"

	| scenario |
	scenario := self new.
	scenario name.
	self increaseIterator.
	^ scenario
]

{ #category : #creation }
BP4PScenario class >> instanceWithValuable: aBlock [
	"create a scenario with automatic name and aBlock with a BP4PProgram as argument"

	| scenario |
	scenario := self new.
	scenario name: scenario name valuable: aBlock.
	self increaseIterator.
	^ scenario
]

{ #category : #private }
BP4PScenario class >> iterator [
	^Iterator ifNil: [ Iterator := 0 ]
]

{ #category : #creation }
BP4PScenario class >> name: aScenarioName [
	"create a scenario with a name"

	^ self new name: aScenarioName
]

{ #category : #creation }
BP4PScenario class >> name: aScenarioName valuable: aBlock [
	"create a scenario with a name, default priority and aBlock with a BP4PProgram as argument"

	^ self new
		name: aScenarioName
		valuable: aBlock
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
		ifNil: [ name := self className asString , self class iterator asString ]
]

{ #category : #initialize }
BP4PScenario >> name: aScenarioName [
	"set name"

	name := aScenarioName
]

{ #category : #initialize }
BP4PScenario >> name: aScenarioName valuable: aBlock [
	"set name and blockToRun of the scenario"

	name := aScenarioName.

	blockToRun := aBlock
]

{ #category : #initialize }
BP4PScenario >> printOn: aStream [
	super printOn: aStream.
	aStream nextPutAll: ' with name '.
	self name printOn: aStream
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

	^ [ :bp | 
	| endScenarioAnnouncement |
	self run: bp.
	endScenarioAnnouncement := BP4PEndScenarioAnnouncement
		scenario: self name.
	Transcript crShow: 'Announced ' , endScenarioAnnouncement printString.
	[self announcer announce: endScenarioAnnouncement] fork ]
]
