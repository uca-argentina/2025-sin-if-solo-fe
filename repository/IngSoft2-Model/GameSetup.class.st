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

{ #category : 'creation' }
GameSetup >> createBoardInstanceWith: aDice andWith: aSpaceShips andWith: aWinnerSystem [
	|aBoard aCopyOfSpaceships |
	aBoard := BoardGame
		          withNumberOfSquares: boardSize
		          withWormHoleFrom: wormholeEntrance
		          to: wormholeExit.
	aBoard withDices: { aDice }.
	
	aCopyOfSpaceships := OrderedCollection new.
	aCopyOfSpaceships addAll:  (aSpaceShips collect: [ :player |
		              | copyOfSpaceships |
		              copyOfSpaceships := player copy. 
		              copyOfSpaceships originalSpaceShip: player.
		              copyOfSpaceships ]).
	
	
	aBoard has: aCopyOfSpaceships .
	aBoard follows: aWinnerSystem.
	^aBoard.
]

{ #category : 'creation' }
GameSetup >> createGameInstance [

	| aDice aBoard aSpaceShips aWinnerSystem |
	aDice := RiggedDice withNumberOfFaces: numberOfFaces.
	aDice setNumbersProvider: riggedNumbers.
	
	aSpaceShips := self createSpaceShipsInstance.
	aWinnerSystem := WinnerSystem withMaximunLaps: lapsToWin.
	aBoard:= self createBoardInstanceWith: aDice andWith: aSpaceShips andWith: aWinnerSystem.
	
	board := aBoard.
	spaceShips := aSpaceShips.
	winnerSystem := aWinnerSystem.
	
]

{ #category : 'creation' }
GameSetup >> createSpaceShipsInstance [

	| aSpaceShips  |
	
	aSpaceShips := (1 to: numberOfPlayers) collectWithIndex: [ :i :index |
		| spaceShip |
		spaceShip := SpaceShip inInitialPosition: 0.
		spaceShip initialFule: 8.
		spaceShip turnOrder: index.
		spaceShip
	].
	
	
	
	^ aSpaceShips 
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
