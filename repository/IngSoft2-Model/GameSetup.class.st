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
		'dices',
		'turnManager',
		'deckOfCards',
		'tiles',
		'rewardDistribution'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
GameSetup >> assignsInOrder: aDeckOfCards [

	deckOfCards := aDeckOfCards copy. 

]

{ #category : 'testing' }
GameSetup >> assignsRandomly: aDeckOfCards [

	aDeckOfCards shuffle.
	deckOfCards := aDeckOfCards copy. 

]

{ #category : 'accessing' }
GameSetup >> board [

	^ board
]

{ #category : 'creation' }
GameSetup >> createBoardInstanceWith: aDices andWith: aSpaceShips andWith: aWinnerSystem [

	| aBoard aCopyOfSpaceships |
	boardSizeInParsec ifNil: [ boardSizeInParsec := boardSize ].
	rewardDistribution ifNil:[rewardDistribution := RewardDistribution new.
		 rewardDistribution forDecreaseFuel: 0. rewardDistribution forRestartFuel: 0].
	aBoard := BoardGame
		          withNumberOfSquares: boardSize
		          withSizeInParsec: boardSizeInParsec
		          andTurnManager: turnManager
		          andADeckOfCards: deckOfCards
					andRewardDistribution:rewardDistribution .

	tiles ifNil: [ tiles := OrderedCollection new ].

	deckOfCards ifNil: [ deckOfCards := OrderedCollection new ].

	aBoard withDices: aDices.
	aCopyOfSpaceships := OrderedCollection new.
	
	aCopyOfSpaceships := aSpaceShips collect: [ :each | each copy ].


	aBoard has: aCopyOfSpaceships.
	aBoard follows: aWinnerSystem.

	self fillEmptyPositionsWithNoEffectTile.

	aBoard contains: tiles.
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

	deckOfCards ifNotNil: [
		spaceShips do: [ :spaceShip |
			| card1 card2 |
			card1 := deckOfCards first.
			deckOfCards remove: card1.
			
			card2 := deckOfCards first.
			deckOfCards remove: card2.

			spaceShip equipWith: card1.
			spaceShip equipWith: card2.
		]
	].

	spaceShips do: [ :spaceShip |
		spaceShip has: (Fuel withAnAmount: maximumRolledNumber * 2) ].

]

{ #category : 'action' }
GameSetup >> equip: aSpaceShip with: aCard [

aSpaceShip equipWith: aCard.
 

]

{ #category : 'action' }
GameSetup >> fillEmptyPositionsWithNoEffectTile [
	| occupiedPositions |
	
	
	occupiedPositions := tiles collect: [ :tile | tile position ] as: Set.
	
	0 to: boardSize  do: [ :pos |
		(occupiedPositions includes: pos) ifFalse: [
			tiles add: (NoEffect in: pos)
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

tiles do:[:specialTile|specialTile validateCreationIn: boardSize and: maximumRolledNumber].
]

{ #category : 'accessing' }
GameSetup >> winnerSystem [
^winnerSystem
]

{ #category : 'initialization' }
GameSetup >> withABoardNumberOfSquares: numberOfSqueares andTurnManager: aTurnManager [

	boardSize := numberOfSqueares.
	turnManager := aTurnManager.
]

{ #category : 'creation' }
GameSetup >> withARewardDistribution:aRewardDistribution [
rewardDistribution:=aRewardDistribution.
]

{ #category : 'initialization' }
GameSetup >> withBoardsLengthInMetric:aBoardSizeInParsec [

boardSizeInParsec:=aBoardSizeInParsec asParsecs .
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
GameSetup >> withTiles: someTiles [

	tiles := someTiles asOrderedCollection
]
