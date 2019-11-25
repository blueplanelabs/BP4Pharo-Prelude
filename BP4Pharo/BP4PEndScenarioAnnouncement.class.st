Class {
	#name : #BP4PEndScenarioAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'scenarioName'
	],
	#category : #BP4Pharo
}

{ #category : #creation }
BP4PEndScenarioAnnouncement class >> scenario: aScenarioName [
	"create a new announcement of endScenario with name"

	^ self new scenario: aScenarioName
]

{ #category : #printing }
BP4PEndScenarioAnnouncement >> printOn: aStream [
	super printOn: aStream.
	aStream nextPutAll: ' with scenario '.
	scenarioName printOn: aStream
]

{ #category : #accessing }
BP4PEndScenarioAnnouncement >> scenario [
	^ scenarioName
]

{ #category : #creation }
BP4PEndScenarioAnnouncement >> scenario: aScenarioName [
	scenarioName := aScenarioName
]
