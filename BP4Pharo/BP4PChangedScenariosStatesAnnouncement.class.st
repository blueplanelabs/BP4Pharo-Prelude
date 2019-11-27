Class {
	#name : #BP4PChangedScenariosStatesAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'event'
	],
	#category : #BP4Pharo
}

{ #category : #creation }
BP4PChangedScenariosStatesAnnouncement class >> event: aBP4PEvent [
	^self new event: aBP4PEvent
]

{ #category : #accessing }
BP4PChangedScenariosStatesAnnouncement >> event [
	^ event
]

{ #category : #accessing }
BP4PChangedScenariosStatesAnnouncement >> event: aBP4PEvent [
	event := aBP4PEvent 
]
