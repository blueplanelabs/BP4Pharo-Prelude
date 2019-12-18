Class {
	#name : #TicTacToeCreationForm,
	#superclass : #ComposablePresenter,
	#instVars : [
		'axesLabel',
		'segmentLabel',
		'axesField',
		'segmentField',
		'creationButton',
		'finishButton',
		'screen'
	],
	#category : #'BP4Pharo-Test-TicTacToe-GUI'
}

{ #category : #specs }
TicTacToeCreationForm class >> defaultSpec [
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

{ #category : #accessing }
TicTacToeCreationForm >> axesField [
	^ axesField
]

{ #category : #accessing }
TicTacToeCreationForm >> axesField: anObject [
	axesField := anObject
]

{ #category : #accessing }
TicTacToeCreationForm >> axesLabel [
	^ axesLabel
]

{ #category : #accessing }
TicTacToeCreationForm >> axesLabel: anObject [
	axesLabel := anObject
]

{ #category : #accessing }
TicTacToeCreationForm >> creationButton [
	^ creationButton
]

{ #category : #accessing }
TicTacToeCreationForm >> creationButton: anObject [
	creationButton := anObject
]

{ #category : #api }
TicTacToeCreationForm >> extent [
	^ 400 @ (3 * self class toolbarHeight)
]

{ #category : #accessing }
TicTacToeCreationForm >> finishButton [
	^ finishButton
]

{ #category : #accessing }
TicTacToeCreationForm >> finishButton: anObject [
	finishButton := anObject
]

{ #category : #initialization }
TicTacToeCreationForm >> initializePresenter [
	creationButton
		action: [ screen
				label:
					'Created TicTacToe with Axes Size: ' , axesField text , ' , Segment Size: '
						, segmentField text.
			axesLabel disable.
			axesField disable.
			segmentLabel disable.
			segmentField disable.
			creationButton disable.
			finishButton enable.
			TicTacToeWithSegment
				axesSize: axesField text asInteger
				segmentSize: segmentField text asInteger ].
	finishButton action: [  ]
]

{ #category : #initialization }
TicTacToeCreationForm >> initializeWidgets [
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
	screen label: 'Waiting to Create a TicTacToe ...'.

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
TicTacToeCreationForm >> screen [
	^ screen
]

{ #category : #accessing }
TicTacToeCreationForm >> screen: anObject [
	screen := anObject
]

{ #category : #accessing }
TicTacToeCreationForm >> segmentField [
	^ segmentField
]

{ #category : #accessing }
TicTacToeCreationForm >> segmentField: anObject [
	segmentField := anObject
]

{ #category : #accessing }
TicTacToeCreationForm >> segmentLabel [
	^ segmentLabel
]

{ #category : #accessing }
TicTacToeCreationForm >> segmentLabel: anObject [
	segmentLabel := anObject
]
