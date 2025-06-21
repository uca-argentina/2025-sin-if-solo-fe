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
GameSetup >> withABoardNumberOfSquares: maximumSquares andTurnManager: aTurnManager [
	boardSize := maximumSquares.
	turnManager:=aTurnManager .
	
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
