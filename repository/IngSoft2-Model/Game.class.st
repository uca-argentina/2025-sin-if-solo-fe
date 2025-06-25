"
game
"
Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'board',
		'turnManager',
		'cardsInGame',
		'rewardAsignation',
		'lastCardPlayed',
		'spaceShipMoving',
		'dicesInGameBoard',
		'spaceShips',
		'winnerSystem'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
Game class >> withBoard: aBoard andTurnManager: aTurnManager andRewardDistribution: rewardDistribution [

	^ self new
		  initializationGameWithBoard: aBoard
		  andTurnManager: aTurnManager
		  andRewardDistribution: rewardDistribution
]

{ #category : 'action' }
Game >> applyRepeatEffectWith: aSpaceship [

	| spaceShip |
	spaceShip := spaceShips detect: [ :each | each = aSpaceship ].
	board applyEffectOfLastTileTo: spaceShip on: self
]

{ #category : 'action' }
Game >> cardEffectIsPlayed [

	cardsInGame do: [ :card |
		card
			applyEffectTo: spaceShipMoving
			with: dicesInGameBoard
			inGame: self
			onABoard: board ]
]

{ #category : 'accessing' }
Game >> cardsOf: aSpaceShip [

	^ (self spaceShipMatching: aSpaceShip) cardsInHand
]

{ #category : 'accessing' }
Game >> completedLapsBy: aSpaceShip [

	^ (self spaceShipMatching: aSpaceShip) currentLap
]

{ #category : 'accessing' }
Game >> currentFuleOf: aSpaceShip [

	^ (self spaceShipMatching: aSpaceShip) currentFule
]

{ #category : 'accessing' }
Game >> follows: aWinnerSystem [

	winnerSystem := aWinnerSystem.
	winnerSystem withPotentialWinner: spaceShips
]

{ #category : 'testing' }
Game >> has: players [

	spaceShips := players
]

{ #category : 'testing' }
Game >> hasAnAlianceFrom: spaceShip and: anotherSpaceShip [

	| spaceShipToTeamUp |
	spaceShipToTeamUp := self spaceShipMatching: anotherSpaceShip.
	spaceShip sharesFuleWith: spaceShipToTeamUp.
	spaceShipToTeamUp sharesFuleWith: spaceShip
]

{ #category : 'initialization' }
Game >> initializationGameWithBoard: aBoard andTurnManager: aTurnManager andRewardDistribution: rewardDistribution [

	board := aBoard.
	turnManager := aTurnManager.

	cardsInGame := OrderedCollection new.
	rewardAsignation := rewardDistribution
]

{ #category : 'action' }
Game >> move: aSpaceShip forwardBy: rolledNumber [

	| totalPosition newPosition |
	totalPosition := aSpaceShip currentPosition + rolledNumber.
	newPosition := board
		               setLapsAndGetNewPositionFrom: totalPosition
		               for: aSpaceShip.
	aSpaceShip moveTo: newPosition consuming: rolledNumber.
	aSpaceShip hasFule
]

{ #category : 'action' }
Game >> move: aSpaceShip with: dices [

	| rolledNumber |
	winnerSystem thereIsAWinner ifTrue: [ ^ self ].
	rolledNumber := self rolledNumberSumOf: dices.
	spaceShipMoving := aSpaceShip.
	(aSpaceShip canMoveWith: rolledNumber) ifFalse: [ ^ self ].
	self move: aSpaceShip forwardBy: rolledNumber.
	board applySpecialTiletoA: aSpaceShip ofAll: spaceShips.
	self cardEffectIsPlayed.
	rewardAsignation for: aSpaceShip with: dices
]

{ #category : 'action' }
Game >> playNextTurn [

	| spaceShip |
	spaceShip := turnManager spaceShipWhoseTurnItIsFrom: spaceShips.
	turnManager updateTurn: spaceShips.
	spaceShip verifyCanPlayAgain.
	spaceShip canPlay
		ifTrue: [ self move: spaceShip with: dicesInGameBoard ]
		ifFalse: [
			spaceShip losesTwoRounds.
			spaceShip rechargeFule ]
]

{ #category : 'action' }
Game >> playsInstantaneousCard: aCard for: aSpaceship [
    (aCard isInstantaneous and: [ aCard chosenOnIsIn: cardsInGame ])
        ifTrue: [
            aCard isLastBeingPlayedIn: self.
            aCard applyEffectTo: aSpaceship
                 with: dicesInGameBoard
                 inGame: self
                 onABoard: board.
            ^ true
        ].
    ^ false

]

{ #category : 'action' }
Game >> playsPermanentCard: aCard for: aSpaceship [
    (aCard isPermanent and: [ turnManager isAboutToPlay: aSpaceship ])
        ifTrue: [
            cardsInGame add: aCard.
            aSpaceship removeCard: aCard.
            aCard isLastBeingPlayedIn: self.
            ^ true
        ].
    ^ false

]

{ #category : 'action' }
Game >> playsRepeatCard: aCard for: aSpaceship [

	(aCard isInstantaneous not and: [ aCard isPermanent not ]) ifFalse: [
		^ self ].
	aCard addEffectRepetedTo: self by: aSpaceship the: lastCardPlayed.
	aSpaceship removeCard: aCard
]

{ #category : 'accessing' }
Game >> positionOf: aSpaceShip [

	^ (self spaceShipMatching: aSpaceShip) currentPosition
]

{ #category : 'removing' }
Game >> remove: cardToCancel [

	cardsInGame remove: cardToCancel
]

{ #category : 'accessing' }
Game >> rolledNumberSumOf: dices [

	^ (dices collect: [ :dice | dice rolledNumber ]) sum
]

{ #category : 'action' }
Game >> skipNextTurn [

	| spaceShip |
	spaceShip := turnManager spaceShipWhoseTurnItIsFrom: spaceShips.
	turnManager updateTurn: spaceShips.
	spaceShip losesOneRound.
	spaceShip rechargeFule
]

{ #category : 'accessing' }
Game >> spaceShipMatching: aSpaceShip [

	^ spaceShips detect: [ :each | each = aSpaceShip ]
]

{ #category : 'action' }
Game >> upDateLastCardPlayed: aCard [

	lastCardPlayed := aCard
]

{ #category : 'action' }
Game >> with: aSpaceship throws: aCard [

	| spaceShip aSpaceshipToThrowCard |
	aSpaceshipToThrowCard := spaceShips detect: [ :each |
		                         each = aSpaceship ].
	spaceShip := turnManager spaceShipWhoseTurnItIsFrom: spaceShips.
	spaceShipMoving := spaceShip.

	(self playsPermanentCard: aCard for: aSpaceshipToThrowCard) ifTrue: [
		^ self ].
	(self playsInstantaneousCard: aCard for: spaceShip) ifTrue: [ ^ self ].
	self playsRepeatCard: aCard for: spaceShip
]

{ #category : 'accessing' }
Game >> withDices: dices [

	dicesInGameBoard := dices
]
