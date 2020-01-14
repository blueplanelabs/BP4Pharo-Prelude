Class {
	#name : #FitCourseEvent,
	#superclass : #BP4PEvent,
	#instVars : [
		'course'
	],
	#category : #'BP4Pharo-TelloDrone-Example'
}

{ #category : #accessing }
FitCourseEvent class >> course: aNormalizedLocation [
	^self new course: aNormalizedLocation
]

{ #category : #accessing }
FitCourseEvent >> course [
	^ course copy
]

{ #category : #'private-creation' }
FitCourseEvent >> course: aLocation [
	course := aLocation
]

{ #category : #accessing }
FitCourseEvent >> defaultName [
	^ 'FitCourse(' , course asString , ')'
]

{ #category : #accessing }
FitCourseEvent >> name [
	^ name ifNil: [ name := self defaultName ]
]
