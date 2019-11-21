Class {
	#name : #BP4PAuctionner,
	#superclass : #Object,
	#instVars : [
		'announcer'
	],
	#category : #BP4Pharo
}

{ #category : #'private - initialization' }
BP4PAuctionner class >> checkIn: anAnnouncer [
	"comment stating purpose of message"

	self new checkIn: anAnnouncer
]

{ #category : #'private - initialization' }
BP4PAuctionner >> checkIn: anAnnouncer [
	announcer := anAnnouncer 
]
