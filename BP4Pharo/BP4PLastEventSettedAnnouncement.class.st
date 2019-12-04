Class {
	#name : #BP4PLastEventSettedAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'event'
	],
	#category : #BP4Pharo
}

{ #category : #creation }
BP4PLastEventSettedAnnouncement class >> event: aBP4PEvent [
	^self new event: aBP4PEvent
]

{ #category : #accessing }
BP4PLastEventSettedAnnouncement >> event [
	^ event
]

{ #category : #accessing }
BP4PLastEventSettedAnnouncement >> event: aBP4PEvent [
	event := aBP4PEvent 
]
