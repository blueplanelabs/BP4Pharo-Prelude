Class {
	#name : #TicTacToeGameBoard,
	#superclass : #DynamicComposablePresenter,
	#instVars : [
		'bp',
		'gameTokens'
	],
	#category : #'BP4Pharo-Test-TicTacToe-GUI'
}

{ #category : #creation }
TicTacToeGameBoard class >> withPositions: aPositionsCollection andBP: aBP4PProgram [
	| inst |
	inst := self basicNew.
	"Created gameTokens with aPositionsCollection sorted"
	inst
		gameTokens:
			(aPositionsCollection asOrderedCollection
				sort: [ :a :b | 
					a x = b x
						ifTrue: [ a y < b y ]
						ifFalse: [ a x < b x ] ]).
	inst bp: aBP4PProgram.
	inst initialize.
	inst createSubscriptions .

	^ inst
]

{ #category : #accessing }
TicTacToeGameBoard >> bp [
	^ bp
]

{ #category : #accessing }
TicTacToeGameBoard >> bp: anObject [
	bp := anObject
]

{ #category : #'private - initialization' }
TicTacToeGameBoard >> createSubscriptions [
	self bp
		subscribe: XEvent
		do: [ :xevent | (xevent position asSymbol value: self) label: 'X' ].
	self bp
		subscribe: OEvent
		do: [ :oevent | (oevent position asSymbol value: self) label: 'O' ]
]

{ #category : #api }
TicTacToeGameBoard >> extent [
	^ 400 @ 400
]

{ #category : #accessing }
TicTacToeGameBoard >> gameTokens [
	^ gameTokens
]

{ #category : #accessing }
TicTacToeGameBoard >> gameTokens: anObject [
	gameTokens := anObject
]

{ #category : #initialization }
TicTacToeGameBoard >> initializeWidgets [
	self gameTokens
		do: [ :position | 
			| presenter instVarName |
			presenter := self newButton.
			instVarName := position asSymbol.
			presenter
				action: [ BP4PEnvironment
						send: (ClickEvent position: position)
						toProgram: self bp ].
			self assign: presenter to: instVarName ]
]

{ #category : #accessing }
TicTacToeGameBoard >> layout [
	| row index |
	index := 1.
	row := SpecRowLayout composed.
	1 to: TicTacToeWithSegment axesSize do: [ :i | 
		row
			newColumn: [ :column | 
				1 to: TicTacToeWithSegment axesSize do: [ :j | 
					column add: ( (self gameTokens at: index) ) asSymbol.
					index := index + 1 ] ] ].
	^ row
]
