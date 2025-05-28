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
		'specialTiles',
		'tilesSetedPositions'
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
GameSetup >> withAdistribution [ 

| avaliblePosition atomicCount hyperJumpCount moonWalkCount hyperGravityCount blackHoleCount |

avaliblePosition := OrderedCollection new.
1 to: boardSize do: [:aNumber | avaliblePosition add: aNumber ].

avaliblePosition := avaliblePosition shuffle .
atomicCount := (boardSize * 0.02) floor.
hyperJumpCount := (boardSize * 0.08) floor.
moonWalkCount := (boardSize * 0.10) floor.
hyperGravityCount := (boardSize * 0.20) floor.
blackHoleCount := (boardSize * 0.20) floor.

specialTiles := OrderedCollection new.

1 to: atomicCount do: [:aCount |
    | pos |
    pos := avaliblePosition removeFirst.
    specialTiles add: (AtomicBomb in: pos).
].

1 to: hyperJumpCount do: [:aCount |
    | pos |
    pos := avaliblePosition removeFirst.
    specialTiles add: (HyperJump in: pos parsecToMove: {1. 9 .7}).
].

1 to: moonWalkCount do: [:aCount |
    | pos |
    pos := avaliblePosition removeFirst.
    specialTiles add: (MoonWalk in: pos moveBack:aCount).
].

1 to: hyperGravityCount do: [:aCount |
    | pos |
    pos := avaliblePosition removeFirst.
    specialTiles add: (HyperGravity in: pos requiringMinimumRoll:1 ).
].
1 to: blackHoleCount do: [:aCount |
    | pos |
    pos := avaliblePosition removeFirst.
    specialTiles add: (BlackHole in: pos).
].



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

{ #category : 'initialization' }
GameSetup >> withSpecialTilesPosition: positions [

tilesSetedPositions:= OrderedCollection new.
tilesSetedPositions:= positions.




]
