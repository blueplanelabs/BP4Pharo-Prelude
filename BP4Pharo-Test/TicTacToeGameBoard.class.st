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
	|inst|
	inst := self basicNew .
	inst gameTokens: aPositionsCollection.
	inst bp: aBP4PProgram.
	inst initialize.
	^inst
	
]

{ #category : #accessing }
TicTacToeGameBoard >> bp [
	^ bp
]

{ #category : #accessing }
TicTacToeGameBoard >> bp: anObject [
	bp := anObject
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
			| presenter |
			presenter := self newButton.
			presenter
				action: [ BP4PEnvironment
						send: (ClickEvent position: position)
						toProgram: self bp ].
			self assign: presenter to: ('position_',position name) asSymbol ]
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
					column add: ('position_',(self gameTokens at: index) name) asSymbol.
					index := index + 1 ] ] ].
	^ row
]
