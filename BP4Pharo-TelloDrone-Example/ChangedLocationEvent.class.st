Class {
	#name : #ChangedLocationEvent,
	#superclass : #BP4PEvent,
	#instVars : [
		'location',
		'altitude',
		'traveledDistance'
	],
	#category : #'BP4Pharo-TelloDrone-Example'
}

{ #category : #accessing }
ChangedLocationEvent class >> location: aLocation altitude: anAltitude traveledDistance: aDistance [
	^ self new
		location: aLocation;
		altitude: anAltitude ;
		traveledDistance: aDistance;
		yourself
]

{ #category : #'private-creation' }
ChangedLocationEvent >> altitude [
	^ altitude copy
]

{ #category : #'private-creation' }
ChangedLocationEvent >> altitude: anAltitude [
	altitude := anAltitude
]

{ #category : #accessing }
ChangedLocationEvent >> defaultName [
	^ 'ChangedLocation(' , location asString  , ',' , altitude asString , ','
		, traveledDistance asString , ')'
]

{ #category : #accessing }
ChangedLocationEvent >> location [
	^ location copy
]

{ #category : #'private-creation' }
ChangedLocationEvent >> location: aLocation [
	location := aLocation
]

{ #category : #accessing }
ChangedLocationEvent >> name [
	^ name ifNil: [ name := self defaultName ]
]

{ #category : #accessing }
ChangedLocationEvent >> traveledDistance [
^traveledDistance 
]

{ #category : #accessing }
ChangedLocationEvent >> traveledDistance: aDistance [
	traveledDistance := aDistance 
]
