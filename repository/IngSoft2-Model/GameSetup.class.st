"
GameSetUp
"
Class {
	#name : 'GameSetup',
	#superclass : 'Object',
	#instVars : [
		'numberOfPlayers',
		'riggedNumbers',
		'numberOfFaces',
		'boardSize',
		'wormholeEntrance',
		'wormholeExit',
		'lapsToWin',
		'board',
		'spaceShips',
		'winnerSystem'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
GameSetup >> board [
    ^ board
]

{ #category : 'accessing' }
GameSetup >> spaceShips [
^spaceShips
]

{ #category : 'accessing' }
GameSetup >> winnerSystem [
^winnerSystem
]

{ #category : 'initialization' }
GameSetup >> withABoardNumberOfSquares: maximumSquares andWithWormHoleFrom: entry to: exit [

	boardSize := maximumSquares.
	wormholeEntrance := entry.
	wormholeExit := exit.
]

{ #category : 'initialization' }
GameSetup >> withMaximumLapsToWin: aLapsToWin [
  lapsToWin := aLapsToWin.
]

{ #category : 'initialization' }
GameSetup >> withNumberOfPlayers: aNumber [
	 numberOfPlayers := aNumber.
 

]

{ #category : 'initialization' }
GameSetup >> withRiggedDiceNumbers: aRiggedNumbers andNumberOfFaces: aNumberOfFaces [

	riggedNumbers := aRiggedNumbers.
	numberOfFaces := aNumberOfFaces.
]
