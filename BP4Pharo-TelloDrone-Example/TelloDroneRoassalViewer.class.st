Class {
	#name : #TelloDroneRoassalViewer,
	#superclass : #ComposablePresenter,
	#instVars : [
		'label',
		'visualization',
		'roassalScript',
		'labelText'
	],
	#category : #'BP4Pharo-TelloDrone-Example-TelloDrone-GUI'
}

{ #category : #initialization }
TelloDroneRoassalViewer >> initializeWidgets [
	label := self newLabel.
	"visualization := self instantiate: RoassalPresenter."
	label
		label: 'Roassal Visualization';
		emphasis:  #bold.
	visualization script: [ :view :canvas |  ].
	self focusOrder add: visualization

]
