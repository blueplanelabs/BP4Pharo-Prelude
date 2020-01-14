Class {
	#name : #FitAltitudeEvent,
	#superclass : #BP4PEvent,
	#instVars : [
		'altitudeVariation'
	],
	#category : #'BP4Pharo-TelloDrone-Example'
}

{ #category : #accessing }
FitAltitudeEvent class >> altitudeVariation: anAltitude [
	^ self new altitudeVariation: anAltitude
]

{ #category : #accessing }
FitAltitudeEvent >> altitudeVariation [
	^ altitudeVariation copy
]

{ #category : #'private-creation' }
FitAltitudeEvent >> altitudeVariation: anAltitude [
	altitudeVariation := anAltitude
]

{ #category : #accessing }
FitAltitudeEvent >> defaultName [
	^ 'FitAltitude(' ,  altitudeVariation asString ,  ')'
]

{ #category : #accessing }
FitAltitudeEvent >> name [
	^ name ifNil: [ name := self defaultName ]
]
