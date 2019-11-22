Class {
	#name : #BP4PSelectedEventAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'event'
	],
	#category : #BP4Pharo
}

{ #category : #creation }
BP4PSelectedEventAnnouncement class >> event: aBP4PEvent [
	^self new event: aBP4PEvent
]

{ #category : #accessing }
BP4PSelectedEventAnnouncement >> event [
	^ event
]

{ #category : #accessing }
BP4PSelectedEventAnnouncement >> event: aBP4PEvent [
	event := aBP4PEvent 
]
