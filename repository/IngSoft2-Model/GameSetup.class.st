"
GameSetUp
"
Class {
	#name : 'GameSetup',
	#superclass : 'Object',
	#instVars : [
		'boardSize',
		'lapsToWin',
		'board',
		'spaceShips',
		'winnerSystem',
		'maximumRolledNumber',
		'boardSizeInParsec',
		'specialTiles',
		'dices',
		'turnManager'
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
                  withSizeInParsec: boardSizeInParsec andTurnManager: turnManager .

    specialTiles ifNil: [ specialTiles := OrderedCollection new ].

    aBoard withDices: aDices .
	aCopyOfSpaceships :=OrderedCollection new.
    aCopyOfSpaceships := aSpaceShips collect: [ :each | each copy ].

    aBoard has: aCopyOfSpaceships.
    aBoard follows: aWinnerSystem.

    self fillEmptyPositionsWithNoEffectTile.

    aBoard contains: specialTiles.
    ^ aBoard
]

{ #category : 'creation' }
GameSetup >> createGameInstance [

	| aBoard aWinnerSystem |
	self createSpaceShipsInstance.
	aWinnerSystem := WinnerSystem withMaximunLaps: lapsToWin.

	aBoard := self
		          createBoardInstanceWith: dices
		          andWith: spaceShips 
		          andWith: aWinnerSystem.
	board := aBoard.
	winnerSystem := aWinnerSystem.
	self validateSpecialTileCreation
]

{ #category : 'creation' }
GameSetup >> createSpaceShipsInstance [

	spaceShips do: [ :arg1 |
		arg1 has: (Fuel withAnAmount: maximumRolledNumber * 2) ]
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

{ #category : 'validating' }
GameSetup >> validateSpecialTileCreation [

specialTiles do:[:specialTile|specialTile validateCreationIn: boardSize and: maximumRolledNumber].
]

{ #category : 'accessing' }
GameSetup >> winnerSystem [
^winnerSystem
]

{ #category : 'initialization' }
GameSetup >> withABoardNumberOfSquares: maximumSquares [ 
	boardSize := maximumSquares.
	
]

{ #category : 'initialization' }
GameSetup >> withABoardNumberOfSquares: maximumSquares andTurnManager: aTurnManager [
	boardSize := maximumSquares.
	turnManager:=aTurnManager .
	
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

{ #category : 'creation' }
GameSetup >> withPlayers: someSpaceShips [ 

spaceShips:= someSpaceShips.



]

{ #category : 'initialization' }
GameSetup >> withSpecialTiles:aSpecialTiles [

specialTiles := aSpecialTiles asOrderedCollection.





]
