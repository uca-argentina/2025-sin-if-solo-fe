"
GameSetUp
"
Class {
	#name : 'GameSetup',
	#superclass : 'Object',
	#instVars : [
		'numberOfPlayers',
		'boardSize',
		'wormholeEntrance',
		'wormholeExit',
		'lapsToWin',
		'board',
		'spaceShips',
		'winnerSystem',
		'riggedDiceConfigs',
		'maximumRolledNumber',
		'boardSizeInParsec',
		'specialTiles'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
GameSetup >> board [
    ^ board
]

{ #category : 'creation' }
GameSetup >> createBoardInstanceWith: aDices andWith: aSpaceShips andWith: aWinnerSystem [
	|aBoard aCopyOfSpaceships |
	(boardSizeInParsec )ifNil:[boardSizeInParsec :=boardSize ].
	aBoard := BoardGame
		          withNumberOfSquares: boardSize
					withSizeInParsec:boardSizeInParsec
		          withWormHoleFrom: wormholeEntrance
		          to: wormholeExit.
		
	aBoard withDices: aDices .
	
	aCopyOfSpaceships := OrderedCollection new.
	aCopyOfSpaceships addAll:  (aSpaceShips collect: [ :player |
		              | copyOfSpaceships |
		              copyOfSpaceships := player copy. 
		              copyOfSpaceships originalSpaceShip: player.
		              copyOfSpaceships ]).
	
	aBoard has: aCopyOfSpaceships .
	aBoard follows: aWinnerSystem.

	aBoard contains:specialTiles .
	^aBoard.
]

{ #category : 'creation' }
GameSetup >> createDiceInstance [

maximumRolledNumber:=0.

    ^ riggedDiceConfigs collect: [:riggedDiceConfig |
        | aRiggedNumbers aNumberOfFaces aDice |
        aRiggedNumbers := riggedDiceConfig first.
        aNumberOfFaces := riggedDiceConfig second.
			 maximumRolledNumber := maximumRolledNumber +aNumberOfFaces .
        aDice := RiggedDice withNumberOfFaces: aNumberOfFaces.
        aDice setNumbersProvider: aRiggedNumbers.
 			 aDice
    ].



]

{ #category : 'creation' }
GameSetup >> createGameInstance [

	| aDices aBoard aSpaceShips aWinnerSystem |

	aDices:= self createDiceInstance.

	aSpaceShips := self createSpaceShipsInstance.
	aWinnerSystem := WinnerSystem withMaximunLaps: lapsToWin.
	aBoard:= self createBoardInstanceWith: aDices andWith: aSpaceShips andWith: aWinnerSystem.
	board := aBoard.
	spaceShips := aSpaceShips.
	winnerSystem := aWinnerSystem.
	specialTiles ifNotNil: [ self validateSpecialTile. ].
]

{ #category : 'creation' }
GameSetup >> createSpaceShipsInstance [

	| aSpaceShips  |
	
	aSpaceShips := (1 to: numberOfPlayers) collectWithIndex: [ :i :index |
		| spaceShip |
		spaceShip := SpaceShip inInitialPosition: 0.
		spaceShip initialFule: (maximumRolledNumber*2 ).
		spaceShip turnOrder: index.
		spaceShip
	].
	
	
	
	^ aSpaceShips 
]

{ #category : 'accessing' }
GameSetup >> spaceShips [
^spaceShips
]

{ #category : 'validating' }
GameSetup >> validateSpecialTile [

specialTiles do:[:specialTile|specialTile validateCreationIn: boardSize and: maximumRolledNumber].
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
GameSetup >> withBoardsLengthInParsec:aBoardSizeInParsec [

boardSizeInParsec:=aBoardSizeInParsec.
]

{ #category : 'initialization' }
GameSetup >> withMaximumLapsToWin: aLapsToWin [
  lapsToWin := aLapsToWin.
]

{ #category : 'initialization' }
GameSetup >> withNumberOfPlayers: aNumber [
	 numberOfPlayers := aNumber.
 

]

{ #category : 'accessing' }
GameSetup >> withRiggedDiceConfigs: diceConfigs [
    riggedDiceConfigs := diceConfigs.
  
]

{ #category : 'initialization' }
GameSetup >> withRiggedDiceNumbers: aRiggedNumbers andNumberOfFaces: aNumberOfFaces [

	^ { aRiggedNumbers . aNumberOfFaces }.
	
]

{ #category : 'initialization' }
GameSetup >> withSpecialTiles:aSpecialTiles [

specialTiles:=aSpecialTiles.



]
