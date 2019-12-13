Class {
	#name : #DisableEvent,
	#superclass : #BP4PEvent,
	#instVars : [
		'position'
	],
	#category : #'BP4Pharo-Test-TicTacToe-SegmentBased'
}

{ #category : #'instance creation' }
DisableEvent class >> position: aPosition [
	^ self new
		position: aPosition 
]

{ #category : #'instance creation' }
DisableEvent >> defaultName [
	^ 'Disable(' , position name , ')'
]

{ #category : #'instance creation' }
DisableEvent >> name [
	^ name
		ifNil: [ name := self defaultName ]
]

{ #category : #api }
DisableEvent >> position [
	^ position
]

{ #category : #accessing }
DisableEvent >> position: aPosition [
	position := aPosition 
]
