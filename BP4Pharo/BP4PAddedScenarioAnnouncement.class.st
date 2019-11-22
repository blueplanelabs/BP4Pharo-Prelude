Class {
	#name : #BP4PAddedScenarioAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'scenario',
		'priority'
	],
	#category : #BP4Pharo
}

{ #category : #creation }
BP4PAddedScenarioAnnouncement class >> scenario: aScenarioName priority: aPriority [
	"create a new announcement of scenario added with name and priority"

	^ self new
		scenario: aScenarioName
		priority: aPriority
]

{ #category : #printing }
BP4PAddedScenarioAnnouncement >> printOn: aStream [
	super printOn: aStream.
	aStream nextPutAll: ' with scenario '.
	scenario printOn: aStream.
	aStream nextPutAll: ' priority '.
	priority printOn: aStream.
]

{ #category : #accessing }
BP4PAddedScenarioAnnouncement >> priority [
	^ priority
]

{ #category : #accessing }
BP4PAddedScenarioAnnouncement >> scenario [
	^ scenario
]

{ #category : #creating }
BP4PAddedScenarioAnnouncement >> scenario: aScenarioName priority: aPriority [
	"set the name and priority of the scenario added"

	scenario := aScenarioName.
	priority := aPriority .
]
