Class {
	#name : #BP4POutOfSyncScenarioAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'scenarioName'
	],
	#category : #BP4Pharo
}

{ #category : #creation }
BP4POutOfSyncScenarioAnnouncement class >> scenario: aScenarioName [
	"create a new announcement of outOfSumcScenario added with name"

	^ self new scenario: aScenarioName
]

{ #category : #accessing }
BP4POutOfSyncScenarioAnnouncement >> scenario [
	^ scenarioName
]

{ #category : #creation }
BP4POutOfSyncScenarioAnnouncement >> scenario: aScenarioName [
	scenarioName := aScenarioName
]
