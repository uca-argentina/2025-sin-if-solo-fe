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
		'maximumRolledNumber',
		'boardSizeInParsec',
		'specialTiles',
		'dices'
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

	| aBoard aCopyOfSpaceships |
	boardSizeInParsec ifNil: [ boardSizeInParsec := boardSize ].
	aBoard := BoardGame
		          withNumberOfSquares: boardSize
		          withSizeInParsec: boardSizeInParsec
		          withWormHoleFrom: wormholeEntrance
		          to: wormholeExit.
	specialTiles ifNil: [ specialTiles := OrderedCollection new ].

	specialTiles add:( WormHole from:wormholeEntrance to:wormholeExit).
	specialTiles add:( WormHole from:wormholeExit to:wormholeEntrance ).
	
	aBoard withDices: aDices .

	aCopyOfSpaceships := OrderedCollection new.
	aCopyOfSpaceships addAll: (aSpaceShips collect: [ :player |
			 | copyOfSpaceships |
			 copyOfSpaceships := player copy.
			 copyOfSpaceships originalSpaceShip: player.
			 copyOfSpaceships ]).

	aBoard has: aCopyOfSpaceships.
	aBoard follows: aWinnerSystem.
	
	self fillEmptyPositionsWithNoEffectTile.

	aBoard contains: specialTiles.
	^ aBoard
]

{ #category : 'creation' }
GameSetup >> createGameInstance [

	| aBoard aSpaceShips aWinnerSystem |
	aSpaceShips := self createSpaceShipsInstance.
	aWinnerSystem := WinnerSystem withMaximunLaps: lapsToWin.

	aBoard := self
		          createBoardInstanceWith: dices
		          andWith: aSpaceShips
		          andWith: aWinnerSystem.
	board := aBoard.
	spaceShips := aSpaceShips.
	winnerSystem := aWinnerSystem.
	self validateSpecialTileCreation
]

{ #category : 'creation' }
GameSetup >> createSpaceShipsInstance [
    ^ (1 to: numberOfPlayers) collectWithIndex: [ :i :index |
        SpaceShip 
            withA: 0 
            andTurn: index 
				startingWith: (Fuel withAnAmount: (maximumRolledNumber *2))
            "startingWith: (maximumRolledNumber * 2)"
    ].

]

{ #category : 'action' }
GameSetup >> fillEmptyPositionsWithNoEffectTile [
	| occupiedPositions |
	
	
	occupiedPositions := specialTiles collect: [ :tile | tile position ] as: Set.
	
	0 to: boardSize  do: [ :pos |
		(occupiedPositions includes: pos) ifFalse: [
			specialTiles add: (NoEffect in: pos)
		]
	].

]

{ #category : 'accessing' }
GameSetup >> maximumRollFromDices [
	| total |
	total := 0.
	dices do: [:aDice | total := total + aDice numberOfFaces ].
	
	^ total
]

{ #category : 'accessing' }
GameSetup >> spaceShips [
^spaceShips
]

{ #category : 'validating' }
GameSetup >> validateSpecialTileCreation [

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

{ #category : 'accessing' }
GameSetup >> withDices:someDices [
dices:=someDices .
maximumRolledNumber :=self maximumRollFromDices.
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
GameSetup >> withSpecialTiles:aSpecialTiles [

specialTiles := aSpecialTiles asOrderedCollection.





]
