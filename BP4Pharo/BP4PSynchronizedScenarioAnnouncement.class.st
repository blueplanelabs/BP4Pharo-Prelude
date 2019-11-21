Class {
	#name : #BP4PSynchronizedScenarioAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'scenario',
		'requestedEvents',
		'waitedEvents',
		'blockedEvents'
	],
	#category : #BP4Pharo
}

{ #category : #creation }
BP4PSynchronizedScenarioAnnouncement class >> scenario: aScenarioName requested: rEvents waited: wEvents blocked: bEvents [
	"create a new announcement of scenario synchronizated with name and events requested, waited and
	blocked"

	^ self new scenario: aScenarioName requested: rEvents waited: wEvents blocked: bEvents
]

{ #category : #accessing }
BP4PSynchronizedScenarioAnnouncement >> blockedEvents [
	^ blockedEvents
]

{ #category : #printing }
BP4PSynchronizedScenarioAnnouncement >> printOn: aStream [
	super printOn: aStream.
	aStream nextPutAll: ' with scenario '.
	scenario printOn: aStream.
	aStream nextPutAll: ' request '.
	requestedEvents printOn: aStream.
	aStream nextPutAll: ' wait '.
	waitedEvents printOn: aStream.
	aStream nextPutAll: ' block '.
	blockedEvents printOn: aStream
]

{ #category : #accessing }
BP4PSynchronizedScenarioAnnouncement >> requestedEvents [
	^ requestedEvents
]

{ #category : #accessing }
BP4PSynchronizedScenarioAnnouncement >> scenario [
	^ scenario
]

{ #category : #creation }
BP4PSynchronizedScenarioAnnouncement >> scenario: aScenarioName requested: rEvents waited: wEvents blocked: bEvents [

	scenario := aScenarioName.
	requestedEvents := rEvents.
	waitedEvents := wEvents .
	blockedEvents := bEvents
]

{ #category : #accessing }
BP4PSynchronizedScenarioAnnouncement >> waitedEvents [
	^ waitedEvents
]
