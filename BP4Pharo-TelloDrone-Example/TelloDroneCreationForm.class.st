Class {
	#name : #TelloDroneCreationForm,
	#superclass : #ComposablePresenter,
	#instVars : [
		'startButton',
		'stopButton',
		'checkPointLabel',
		'xLabel',
		'xInput',
		'yLabel',
		'yInput',
		'addButton',
		'finishButton',
		'checkPoints',
		'bp'
	],
	#category : #'BP4Pharo-TelloDrone-Example-TelloDrone-GUI'
}

{ #category : #specs }
TelloDroneCreationForm class >> defaultSpec [
	^ SpecColumnLayout composed
		newRow: [ :row | 
			row
				add: #startButton;
				add: #stopButton ]
			height: self toolbarHeight;
		newRow: [ :row | 
			row
				add: #checkPointLabel;
				add: #xLabel;
				add: #xInput;
				add: #yLabel;
				add: #yInput;
				add: #addButton ]
			height: self toolbarHeight;
		newRow: [ :row | row add: #finishButton ]
			height: self toolbarHeight;
		yourself
]

{ #category : #accessing }
TelloDroneCreationForm >> addButton [
	^ addButton
]

{ #category : #accessing }
TelloDroneCreationForm >> addButton: anObject [
	addButton := anObject
]

{ #category : #accessing }
TelloDroneCreationForm >> checkPointLabel [
	^ checkPointLabel 
]

{ #category : #accessing }
TelloDroneCreationForm >> checkPointLabel: anObject [
	checkPointLabel := anObject
]

{ #category : #accessing }
TelloDroneCreationForm >> checkPoints [
	^ checkPoints ifNil: [ checkPoints := OrderedCollection new ] 
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

{ #category : #accessing }
TelloDroneCreationForm >> finishButton [
	^ finishButton
]

{ #category : #accessing }
TelloDroneCreationForm >> finishButton: anObject [
	finishButton := anObject
]

{ #category : #initialization }
TelloDroneCreationForm >> initializePresenter [
	startButton
		action: [ startButton disable.
			stopButton enable.
			checkPointLabel enable.
			xLabel enable.
			xInput enable.
			finishButton enable ].
	stopButton
		action: [ startButton enable.
			stopButton disable.
			checkPointLabel disable.
			xLabel disable.
			xInput
				text: '';
				disable.
			yLabel disable.
			yInput
				text: '';
				disable.
			addButton disable.
			finishButton disable.
			checkPoints := nil ].
	xInput
		whenTextIsAccepted: [ xLabel disable.
			xInput disable.
			yLabel enable.
			yInput enable.
			finishButton disable ].
	yInput
		whenTextIsAccepted: [ yLabel disable.
			yInput disable.
			addButton enable ].
	addButton
		action: [ self checkPoints add: xInput text asInteger @ yInput text asInteger.
			xLabel enable.
			xInput
				text: '';
				enable.
			yInput text: ''.
			finishButton enable.
			addButton disable ].
	finishButton action: [ xLabel disable.
			xInput disable ].
]

{ #category : #initialization }
TelloDroneCreationForm >> initializeWidgets [
	"widget instantiation"

	startButton := self newButton.
	stopButton := self newButton.
	checkPointLabel := self newLabel.
	xLabel := self newLabel.
	xInput := self newTextInput.
	yLabel := self newLabel.
	yInput := self newTextInput.
	addButton := self newButton.
	finishButton := self newButton.

	"widget configuration"
	startButton label: 'START'.
	stopButton
		label: 'STOP';
		disable.
	checkPointLabel
		label: 'CheckPoint: ';
		disable.
	xLabel
		label: 'X: ';
		disable.
	xInput disable.
	yLabel
		label: 'Y: ';
		disable.
	yInput disable.
	addButton
		label: 'ADD';
		disable.
	finishButton
		label: 'FINISH';
		disable.


	"specification of order of focus"
	self focusOrder
		add: startButton;
		add: stopButton;
		add: xInput;
		add: yInput;
		add: addButton;
		add: finishButton
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

{ #category : #api }
TelloDroneCreationForm >> title [ 
	^ 'CreationForm'
]

{ #category : #initialization }
TelloDroneCreationForm >> whenGameFinishedDo: aBlock [
	finishButton whenActionPerformedDo: aBlock
]

{ #category : #initialization }
TelloDroneCreationForm >> whenTelloDroneCreatedDo: aBlock [
	finishButton whenActionPerformedDo: aBlock
]

{ #category : #accessing }
TelloDroneCreationForm >> xInput [
	^ xInput
]

{ #category : #accessing }
TelloDroneCreationForm >> xInput: anObject [
	xInput := anObject
]

{ #category : #accessing }
TelloDroneCreationForm >> xLabel [
	^ xLabel
]

{ #category : #accessing }
TelloDroneCreationForm >> xLabel: anObject [
	xLabel := anObject
]

{ #category : #accessing }
TelloDroneCreationForm >> yInput [
	^ yInput
]

{ #category : #accessing }
TelloDroneCreationForm >> yInput: anObject [
	yInput := anObject
]

{ #category : #accessing }
TelloDroneCreationForm >> yLabel [
	^ yLabel
]

{ #category : #accessing }
TelloDroneCreationForm >> yLabel: anObject [
	yLabel := anObject
]
