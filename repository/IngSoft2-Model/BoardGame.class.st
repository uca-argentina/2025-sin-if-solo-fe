"
Board Game
"
Class {
	#name : 'BoardGame',
	#superclass : 'Object',
	#instVars : [
		'maximumSquares',
		'entranceOfWormHole',
		'exitOfWormHole',
		'dicesInGameBoard',
		'winnerSystem',
		'specialTiles',
		'sizeInParsec',
		'spaceShips'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
BoardGame class >> hasTheMinimumAmountOfSquares: aNumber [

	aNumber < 3 ifTrue: [ Error signal: 'Should have at least 3 squares' ]
]

{ #category : 'testing' }
BoardGame class >> is:anExitOfTheWormHole smallerThan:aMaximumSquares [
(anExitOfTheWormHole >=aMaximumSquares )ifTrue: [ 
	Error signal:'The worm hole exit must be smaller than the number of squares' ]
]

{ #category : 'testing' }
BoardGame class >> isANegativeNumber: aNumber [

	aNumber negative ifTrue: [
		Error signal: 'Should be a positive number' ]
]

{ #category : 'instance creation' }
BoardGame class >> withNumberOfSquares: aMaximumSquares withSizeInParsec:boardSizeInParsec [

	self isANegativeNumber: aMaximumSquares.
	self hasTheMinimumAmountOfSquares: aMaximumSquares.
	
	^ self new
		  initializationBoardGame: aMaximumSquares
			withSizeInParsec:boardSizeInParsec.
	

]

{ #category : 'instance creation' }
BoardGame class >> withNumberOfSquares: aMaximumSquares withSizeInParsec:boardSizeInParsec withWormHoleFrom: anEntranceOfWormHole to: anExitOfTheWormHole [

	"self isANegativeNumber: aMaximumSquares.
	self hasTheMinimumAmountOfSquares: aMaximumSquares.
	self isANegativeNumber: anEntranceOfWormHole.
	self isANegativeNumber: anExitOfTheWormHole.
	self is:anExitOfTheWormHole smallerThan:aMaximumSquares.
	^ self new
		  initializationBoardGame: aMaximumSquares
			withSizeInParsec:boardSizeInParsec
		  withWormHoleFrom: anEntranceOfWormHole
		  to: anExitOfTheWormHole.
		"
	

]

{ #category : 'accessing' }
BoardGame >> completedLapsBy: aSpaceShip [

^ (spaceShips detect: [ :each | each = aSpaceShip ]) currentLap
]

{ #category : 'comparing' }
BoardGame >> contains: aSpecialTiles [

	specialTiles := aSpecialTiles
]

{ #category : 'accessing' }
BoardGame >> currentFuleOf: aSpaceShip [

^ (spaceShips detect: [ :each | each = aSpaceShip ])currentFule.
]

{ #category : 'action' }
BoardGame >> distanceFrom: origin to: destination [

	^ (destination - origin) abs + maximumSquares rem: maximumSquares
]

{ #category : 'accessing' }
BoardGame >> follows: aWinnerSystem [

	winnerSystem := aWinnerSystem.
	winnerSystem withPotentialWinner: spaceShips
]

{ #category : 'accessing' }
BoardGame >> has: players [

	spaceShips := players
]

{ #category : 'initialization' }
BoardGame >> initializationBoardGame: aMaximumSquares withSizeInParsec: boardSizeInParsec [ 

	maximumSquares := aMaximumSquares.
	sizeInParsec := boardSizeInParsec
]

{ #category : 'initialization' }
BoardGame >> initializationBoardGame: aMaximumSquares withSizeInParsec: boardSizeInParsec withWormHoleFrom: anEntranceOfWormHole to: anExitOfTheWormHole [

	maximumSquares := aMaximumSquares.
	entranceOfWormHole := anEntranceOfWormHole.
	exitOfWormHole := anExitOfTheWormHole.
	sizeInParsec := boardSizeInParsec
]

{ #category : 'action' }
BoardGame >> move: aSpaceShip forwardBy: rolledNumber [
	| totalPosition lapsDone newPosition  |


	totalPosition := aSpaceShip currentPosition + rolledNumber.
	lapsDone := totalPosition quo: maximumSquares.
	aSpaceShip actualLapsDone: lapsDone .
	
	newPosition := (totalPosition - 1 rem: maximumSquares) + 1.
	
	aSpaceShip moveTo: newPosition consuming: rolledNumber.	
	aSpaceShip hasFule .
]

{ #category : 'action' }
BoardGame >> move: aSpaceShip with: dices [

	| rolledNumber |
	winnerSystem thereIsAWinner ifTrue: [ ^ self ].
	rolledNumber := self rolledNumberSumOf: dices.

	(aSpaceShip canMoveWith: rolledNumber) ifFalse: [
		^ [
		  aSpaceShip losesRound.
		  aSpaceShip losesRound ] ].

	self move: aSpaceShip forwardBy: rolledNumber.
	
	(self specialTileAt: aSpaceShip currentPosition)
		applyConsequenceTo: spaceShips
		onBoardOfSize: self
]

{ #category : 'accessing' }
BoardGame >> numberOfSquares [

	^ maximumSquares
]

{ #category : 'accessing' }
BoardGame >> percentageOf: aTile [

	| count |
	count := (specialTiles select: [ :tile | tile isType: aTile ]) size.
	^ (count / maximumSquares * 100) floor
]

{ #category : 'action' }
BoardGame >> playOneRound [

	spaceShips do: [ :aSpaceShip |
		aSpaceShip verifyCanPlayAgain.
		aSpaceShip canPlay
			ifTrue: [ self move: aSpaceShip with: dicesInGameBoard ]
			ifFalse: [
			self skipRoundAndRechargeFor: aSpaceShip ] ]
]

{ #category : 'accessing' }
BoardGame >> positionOf: aSpaceShip [

^ (spaceShips detect: [ :each | each = aSpaceShip ]) currentPosition.
]

{ #category : 'accessing' }
BoardGame >> rolledNumberSumOf: dices [

	^ (dices collect: [ :dice | dice rolledNumber ]) sum
]

{ #category : 'action' }
BoardGame >> skipRoundAndRechargeFor: aSpaceShip [

	| spaceShipCopy |
	
	spaceShipCopy := (spaceShips detect: [ :each | each = aSpaceShip ]).
	spaceShipCopy losesRound.
	
	spaceShipCopy  rechargeFule
]

{ #category : 'accessing' }
BoardGame >> specialTileAt: position [

	"^ specialTiles detect: [ :tile | tile position = aPosition ]"
	^ specialTiles detect: [ :tile | tile includesA: position ].
]

{ #category : 'action' }
BoardGame >> squaresInParsec: parsecsToMove [

	^ (parsecsToMove * maximumSquares / sizeInParsec) floor
]

{ #category : 'accessing' }
BoardGame >> withDices: dices [

	dicesInGameBoard := dices.

]
