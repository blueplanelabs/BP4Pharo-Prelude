Class {
	#name : #BP4PChangedScenarioPriorityAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'scenario',
		'priority'
	],
	#category : #BP4Pharo
}

{ #category : #creation }
BP4PChangedScenarioPriorityAnnouncement class >> scenario: aScenarioName priority: aPriority [
	"create a new announcement of scenario added with name and priority"

	^ self new
		scenario: aScenarioName
		priority: aPriority
]

{ #category : #printing }
BP4PChangedScenarioPriorityAnnouncement >> printOn: aStream [
	super printOn: aStream.
	aStream nextPutAll: ' to scenario '.
	self scenario printOn: aStream.
	aStream nextPutAll: 'new priority '.
	self priority printOn: aStream
]

{ #category : #accessing }
BP4PChangedScenarioPriorityAnnouncement >> priority [
	^ priority
]

{ #category : #accessing }
BP4PChangedScenarioPriorityAnnouncement >> scenario [
	^ scenario
]

{ #category : #creating }
BP4PChangedScenarioPriorityAnnouncement >> scenario: aScenarioName priority: aPriority [
	"set the name and priority of the scenario added"

	scenario := aScenarioName.
	priority := aPriority .
]
