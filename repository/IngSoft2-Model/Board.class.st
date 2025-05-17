"
Board Game
"
Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'maximumSquares',
		'spaceShips',
		'entranceOfWormHole',
		'exitOfWormHole',
		'dicesInGameBoard'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
Board class >> hasTheMinimumAmountOfSquares: aNumber [

	aNumber < 3 ifTrue: [ Error signal: 'Should have at least 3 squares' ]
]

{ #category : 'testing' }
Board class >> isANegativeNumber: aNumber [

	aNumber negative ifTrue: [
		Error signal: 'Should be a positive number' ]
]

{ #category : 'instance creation' }
Board class >> withNumberOfSquares: aMaximumSquares withWormHoleFrom: anEntranceOfWormHole to: anExitOfTheWormHole [

	self isANegativeNumber: aMaximumSquares.
	self hasTheMinimumAmountOfSquares: aMaximumSquares.
	self isANegativeNumber: anEntranceOfWormHole.
	self isANegativeNumber: anExitOfTheWormHole.
	^ self new
		  initializationBoardGame: aMaximumSquares
		  withWormHoleFrom: anEntranceOfWormHole
		  to: anExitOfTheWormHole
]

{ #category : 'accessing' }
Board >> has: players [

	spaceShips := OrderedCollection new.
	spaceShips := players
]

{ #category : 'initialization' }
Board >> initializationBoardGame: aNumber withWormHoleFrom: aY to: aZ [

	maximumSquares := aNumber.
	entranceOfWormHole := aY.
	exitOfWormHole := aZ
]

{ #category : 'action' }
Board >> move: aSpaceShip with: dices [

	self validateIsGameOver: aSpaceShip.
	aSpaceShip rolls: dices.
	self validateInWormHole: aSpaceShip
]

{ #category : 'accessing' }
Board >> numberOfSquares [

	^ maximumSquares
]

{ #category : 'accessing' }
Board >> positionOf: aPlayer [

	^ aPlayer currentPosition
]

{ #category : 'accessing' }
Board >> theWinnerIs [ 

	^ (spaceShips select: [ :spaceShip |
		   spaceShip currentPosition >= self numberOfSquares ]) anyOne.
]

{ #category : 'validating existence' }
Board >> thereIsAWinner [

	^ spaceShips anySatisfy: [ :spaceShip |
		  spaceShip currentPosition >= self numberOfSquares ]
]

{ #category : 'validating' }
Board >> validateInWormHole: aSpaceShip [

	| originalPosition |
	originalPosition := aSpaceShip currentPosition.

	originalPosition = entranceOfWormHole ifTrue: [
		aSpaceShip teletransportsTo: exitOfWormHole ].

	originalPosition = exitOfWormHole ifTrue: [
		aSpaceShip teletransportsTo: entranceOfWormHole ]
]

{ #category : 'event testing' }
Board >> validateIsGameOver: aSpaceShip [

	self thereIsAWinner ifTrue: [ Error signal: 'Game is Over' ]
]
