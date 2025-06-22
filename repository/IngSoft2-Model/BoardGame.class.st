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
		'turnManager',
		'deckOfCards',
		'cardsInGame'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
BoardGame class >> hasTheMinimumAmountOfSquares: aNumber [

    aNumber < 3 ifTrue: [ Error signal: 'Should have at least 3 squares' ]
]

{ #category : 'instance creation' }
BoardGame class >> withNumberOfSquares: aNumberOfSquares withSizeInParsec: aSizeInParsec andTurnManager: aTurnManager andADeckOfCards: deckOfCards [

	self hasTheMinimumAmountOfSquares: aNumberOfSquares.
	^ self new
		  initializationBoardGame: aNumberOfSquares
		  withSizeInParsec: aSizeInParsec
		  andTurnManager: aTurnManager
		andADeckOfCards: deckOfCards.
		
]

{ #category : 'action' }
BoardGame >> cardEffectIsPlayed [
	|spaceShip|
	spaceShip:= turnManager spaceShipWhoseTurnItIsFrom:spaceShips.
	cardsInGame do: [ :card |
		card applyEffectTo: spaceShip  with: dicesInGameBoard in:self ].
]

{ #category : 'accessing' }
BoardGame >> cardsInGame [
^cardsInGame.
]

{ #category : 'accessing' }
BoardGame >> cardsOf:  aSpaceShip [

^ (spaceShips detect: [ :each | each = aSpaceShip ]) cardsInHand.
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

{ #category : 'action' }
BoardGame >> givesACardTo: aSpaceShip [

| assignedCard |
assignedCard:= deckOfCards atRandom.
deckOfCards remove: assignedCard.
aSpaceShip equipWith: assignedCard.
]

{ #category : 'accessing' }
BoardGame >> has: players [

	spaceShips := players
]

{ #category : 'testing' }
BoardGame >> hasAnAlianceFrom:spaceShip and:anotherSpaceShip [

|spaceShipToTeamUp|
spaceShipToTeamUp := spaceShips detect: [ :each | each = anotherSpaceShip ].
spaceShip sharesFuleWith:spaceShipToTeamUp .
spaceShipToTeamUp sharesFuleWith:spaceShip .




]

{ #category : 'initialization' }
BoardGame >> initializationBoardGame: aMaxiumSquares withSizeInParsec: aSizeInParsec andTurnManager: aTurnManager andADeckOfCards: adeckOfCards [

	maximumSquares := aMaxiumSquares.
	sizeInParsec := aSizeInParsec.
	turnManager := aTurnManager.
	deckOfCards:= adeckOfCards.
	cardsInGame:= OrderedCollection new.
]

{ #category : 'action' }
BoardGame >> move: aSpaceShip forwardBy: rolledNumber [

	| totalPosition newPosition |
	totalPosition := aSpaceShip currentPosition + rolledNumber.
	newPosition := self
		               setLapsAndGetNewPositionFrom: totalPosition
		               for: aSpaceShip.

	aSpaceShip moveTo: newPosition consuming: rolledNumber.

	aSpaceShip hasFule
]

{ #category : 'action' }
BoardGame >> move: aSpaceShip with: dices [

	| rolledNumber |
	winnerSystem thereIsAWinner ifTrue: [ ^ self ].
	rolledNumber := self rolledNumberSumOf: dices.

	(aSpaceShip canMoveWith: rolledNumber)ifFalse: [ ^self ].
	"self cardEffectIsPlayed."
	self move: aSpaceShip forwardBy: rolledNumber.
	self cardEffectIsPlayed.
	
	(self specialTileAt: aSpaceShip currentPosition)
		applyConsequenceTo: spaceShips
		onBoardOfSize: self.
		
]

{ #category : 'accessing' }
BoardGame >> numberOfSquares [

	^ maximumSquares
]

{ #category : 'action' }
BoardGame >> playNextTurn [

	| spaceShip |
	turnManager updateTurn: spaceShips.
	spaceShip := turnManager spaceShipWhoseTurnItIsFrom: spaceShips.

	spaceShip verifyCanPlayAgain.

	spaceShip canPlay
		ifTrue: [
			
			self move: spaceShip with: dicesInGameBoard ]
		ifFalse: [
			spaceShip losesTwoRounds.
			spaceShip rechargeFule ]
]

{ #category : 'action' }
BoardGame >> playerThrows: aCard [

	| spaceShip |
	spaceShip := turnManager spaceShipWhoseTurnItIsFrom: spaceShips.
	(spaceShip isEquipedWith: aCard) ifTrue: [cardsInGame add: aCard.  spaceShip removeCard: aCard.].
	(aCard isInstantaneous)
			ifTrue: [ aCard applyEffectTo: spaceShip with: dicesInGameBoard in: self.  ].
	self playNextTurn .
		
]

{ #category : 'accessing' }
BoardGame >> positionOf: aSpaceShip [

^ (spaceShips detect: [ :each | each = aSpaceShip ]) currentPosition.
]

{ #category : 'removing' }
BoardGame >> remove: cardToCancel [

cardsInGame remove: cardToCancel.
]

{ #category : 'accessing' }
BoardGame >> rolledNumberSumOf: dices [

	^ (dices collect: [ :dice | dice rolledNumber ]) sum
]

{ #category : 'action' }
BoardGame >> setLapsAndGetNewPositionFrom:totalPosition for:aSpaceShip [
|lapsDone newPosition|
lapsDone := totalPosition quo: maximumSquares.
	
	aSpaceShip actualLapsDone: lapsDone .
	newPosition := (totalPosition - 1 rem: maximumSquares) + 1.
	^newPosition .
	
]

{ #category : 'action' }
BoardGame >> skipNextTurn [
| spaceShip |
	turnManager updateTurn:spaceShips. 
	spaceShip := turnManager spaceShipWhoseTurnItIsFrom: spaceShips .
	spaceShip losesOneRound.
	spaceShip  rechargeFule.
	
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
