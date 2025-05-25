"
GameSetUp
"
Class {
	#name : 'GameSetup',
	#superclass : 'Object',
	#instVars : [
		'spaceShips',
		'board',
		'dices',
		'winnerSystem'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
GameSetup >> board [
^board.
]

{ #category : 'accessing' }
GameSetup >> spaceShips [
^spaceShips.
]

{ #category : 'accessing' }
GameSetup >> winnerSystem [
^winnerSystem.
]

{ #category : 'initialization' }
GameSetup >> withABoardNumberOfSquares: maximumSquares andWithWormHoleFrom:entry to: exit [

board := BoardGame withNumberOfSquares: maximumSquares withWormHoleFrom: entry to: exit.
board has:spaceShips .
board withDices: dices.
]

{ #category : 'initialization' }
GameSetup >> withMaximumLapsToWin: lapsToWin [
winnerSystem:=WinnerSystem withMaximunLaps: lapsToWin.
board follows: (winnerSystem ).
]

{ #category : 'initialization' }
GameSetup >> withNumberOfPlayers: numberOfPlayers [

	spaceShips := (1 to: numberOfPlayers) collect: [:numberOfSpaceShips |( SpaceShip inInitialPosition: 0) ].
	
	spaceShips do:[:spaceShip| spaceShip initialFule:8].
]

{ #category : 'initialization' }
GameSetup >> withRiggedDiceNumbers:riggedNumbers andNumberOfFaces:numberOfFaces [
| dice |
	dice := RiggedDice withNumberOfFaces: numberOfFaces .
	dice setNumbersProvider: riggedNumbers .
	dices := { dice }.
	^ self
]
