Class {
	#name : #TelloDroneCreationForm,
	#superclass : #ComposablePresenter,
	#instVars : [
		'startButton',
		'stopButton'
	],
	#category : #'BP4Pharo-TelloDrone-Example-TelloDrone-GUI'
}

{ #category : #specs }
TelloDroneCreationForm class >> defaultSpec [
	^ SpecColumnLayout composed
		newRow: [ :row | 
			row
				add: #axesLabel;
				add: #axesField;
				add: #segmentLabel;
				add: #segmentField ]
			height: self toolbarHeight;
		newRow: [ :row | 
			row
				add: #creationButton;
				add: #finishButton ]
			height: self toolbarHeight;
		newRow: [ :row | row add: #screen ] height: self toolbarHeight;
		yourself
]

{ #category : #'private ' }
TelloDroneCreationForm >> createdGameLabelText [
	^ 'Created TicTacToe with Axes Size: ' , self axesField text
						, ' , Segment Size: ' , self segmentField text
]

{ #category : #'private ' }
TelloDroneCreationForm >> defaultLabelText [
^'Waiting to Create a TicTacToe ...'.
]

{ #category : #api }
TelloDroneCreationForm >> extent [
	^ 400 @ (3 * self class toolbarHeight)
]

{ #category : #initialization }
TelloDroneCreationForm >> initializePresenter [
	creationButton
		action: [ screen label: self createdGameLabelText.
			axesLabel disable.
			axesField disable.
			segmentLabel disable.
			segmentField disable.
			creationButton disable.
			finishButton enable.
			TicTacToeWithSegment
				axesSize: axesField text asInteger
				segmentSize: segmentField text asInteger.
			self bp: TicTacToeWithSegment run ].
	finishButton
		action: [ screen label: self defaultLabelText.
			axesLabel enable.
			axesField enable.
			segmentLabel enable.
			segmentField enable.
			creationButton enable.
			finishButton disable.
			bp stop ]
]

{ #category : #initialization }
TelloDroneCreationForm >> initializeWidgets [
	"widget instantiation"

	axesLabel := self newLabel.
	axesField := self newTextInput.
	segmentLabel := self newLabel.
	segmentField := self newTextInput.
	creationButton := self newButton.
	finishButton := self newButton.
	screen := self newLabel.

	"widget configuration"
	axesLabel label: 'Axes Size:'.
	axesField acceptOnCR: true.
	segmentLabel label: 'Segment Size:'.
	segmentField acceptOnCR: true.
	creationButton label: 'OK'.
	finishButton
		label: 'Finish';
		disable.
	screen label: self defaultLabelText.

	"specification of order of focus"
	self focusOrder
		add: axesLabel;
		add: axesField;
		add: segmentLabel;
		add: segmentField;
		add: creationButton;
		add: finishButton;
		add: screen
]

{ #category : #accessing }
TelloDroneCreationForm >> startButton [
	^ startButton
]

{ #category : #accessing }
TelloDroneCreationForm >> startButton: anObject [
	startButton := anObject
]

{ #category : #accessing }
TelloDroneCreationForm >> stopButton [
	^ stopButton
]

{ #category : #accessing }
TelloDroneCreationForm >> stopButton: anObject [
	stopButton := anObject
]

{ #category : #initialization }
TelloDroneCreationForm >> whenGameCreatedDo: aBlock [
creationButton whenActionPerformedDo: aBlock
]

{ #category : #initialization }
TelloDroneCreationForm >> whenGameFinishedDo: aBlock [
	finishButton whenActionPerformedDo: aBlock
]
