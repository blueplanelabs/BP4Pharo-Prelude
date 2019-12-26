Class {
	#name : #GenerateCompleteOSegmentScenariosEvent,
	#superclass : #BP4PEvent,
	#instVars : [
		'position',
		'priority'
	],
	#category : #'BP4Pharo-Test-TicTacToe-SegmentBased'
}

{ #category : #'instance creation' }
GenerateCompleteOSegmentScenariosEvent class >> position: aPosition priority: aPriority [
	^ self new position: aPosition priority: aPriority 
]

{ #category : #'instance creation' }
GenerateCompleteOSegmentScenariosEvent >> defaultName [
	^ 'CompleteOSegment(' , position name , ' , ' , priority asString , ')'
]

{ #category : #'instance creation' }
GenerateCompleteOSegmentScenariosEvent >> name [
	^ name
		ifNil: [ name := self defaultName ]
]

{ #category : #api }
GenerateCompleteOSegmentScenariosEvent >> position [
	^ position
]

{ #category : #accessing }
GenerateCompleteOSegmentScenariosEvent >> position: aPosition priority: aPriority [
	position := aPosition.
	priority:= aPriority 
]

{ #category : #api }
GenerateCompleteOSegmentScenariosEvent >> priority [
	^ priority
]
