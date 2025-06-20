"
Board Game
"
Class {
	#name : 'BoardGame',
	#superclass : 'Object',
	#instVars : [
		'maximumSquares',
		'dicesInGameBoard',
		'winnerSystem',
		'specialTiles',
		'sizeInParsec',
		'spaceShips',
		'turnManager'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
BoardGame class >> hasTheMinimumAmountOfSquares: aNumber [

    aNumber < 3 ifTrue: [ Error signal: 'Should have at least 3 squares' ]
]

{ #category : 'instance creation' }
BoardGame class >> withNumberOfSquares: arg1 withSizeInParsec: arg2 [

	self hasTheMinimumAmountOfSquares: arg1
]

{ #category : 'instance creation' }
BoardGame class >> withNumberOfSquares: arg1 withSizeInParsec: arg2 andTurnManager: arg3 [

	self hasTheMinimumAmountOfSquares: arg1.
	^ self new
		  initializationBoardGame: arg1
		  withSizeInParsec: arg2
		  andTurnManager: arg3
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
BoardGame >> initializationBoardGame: arg1 withSizeInParsec: arg2 [

	
]

{ #category : 'initialization' }
BoardGame >> initializationBoardGame: arg1 withSizeInParsec: arg2 andTurnManager: arg3 [

	maximumSquares := arg1.
	sizeInParsec := arg2.
	turnManager := arg3
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

	| spaceShip |
	spaceShip := turnManager spaceShipWhoseTurnItIsFrom: spaceShips.
	spaceShip verifyCanPlayAgain.
	spaceShip canPlay
		ifTrue: [ self move: spaceShip with: dicesInGameBoard ]
			"ifFalse: [ self skipRound ]"
		ifFalse: [ self skipRoundAndRechargeFor: spaceShip ]
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
BoardGame >> skipRound [
| spaceShip |
	spaceShip := turnManager spaceShipWhoseTurnItIsFrom: spaceShips.
	spaceShip losesRound.
	spaceShip losesRound.

	spaceShip  rechargeFule.
	
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
