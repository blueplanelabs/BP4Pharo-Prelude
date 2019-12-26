Class {
	#name : #TicTacToePlayground,
	#superclass : #ComposablePresenter,
	#instVars : [
		'creation',
		'view'
	],
	#category : #'BP4Pharo-Test-TicTacToe-GUI'
}

{ #category : #specs }
TicTacToePlayground class >> defaultSpec [
	^ SpecColumnLayout composed
	newRow: [ :row | row add: #creation ];
	newRow: [ :row | row add: #view ];
	yourself
]

{ #category : #playing }
TicTacToePlayground class >> play [ 
<script>
TicTacToePlayground new openWithSpec 
]

{ #category : #accessing }
TicTacToePlayground >> creation [
	^ creation
]

{ #category : #accessing }
TicTacToePlayground >> creation: anObject [
	creation := anObject
]

{ #category : #'private - layout' }
TicTacToePlayground >> defaultView [
	| cm |
	cm := self newLabel.
	cm label: 'Waiting for the creation of the game ...'.
	^ cm
]

{ #category : #api }
TicTacToePlayground >> extent [
	^ 400@500
]

{ #category : #'private - layout' }
TicTacToePlayground >> gameBoardView [
	| presenter |
	presenter := TicTacToeGameBoard withPositions: TicTacToeWithSegment possiblePositions  andBP: creation bp.
	presenter owner: self.
	^ presenter
]

{ #category : #initialization }
TicTacToePlayground >> initializePresenter [
	creation
		whenGameCreatedDo: [ view := self gameBoardView.
			self needRebuild: false.
			self buildWithSpec ].
	creation whenGameFinishedDo: [ view:=self defaultView.
			self needRebuild: false.
			self buildWithSpec ]
]

{ #category : #initialization }
TicTacToePlayground >> initializeWidgets [
	"widget instantiation"

	creation := self instantiate: TicTacToeCreationForm.
	view := self defaultView.
	
	"widget configuration"
 
]

{ #category : #api }
TicTacToePlayground >> title [ 
^'TicTacToe'
]

{ #category : #accessing }
TicTacToePlayground >> view [
	^ view
]

{ #category : #accessing }
TicTacToePlayground >> view: anObject [
	view := anObject
]
