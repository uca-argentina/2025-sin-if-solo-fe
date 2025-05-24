"
Board Game
"
Class {
	#name : 'BoardGame',
	#superclass : 'Object',
	#instVars : [
		'maximumSquares',
		'spaceShips',
		'entranceOfWormHole',
		'exitOfWormHole',
		'dicesInGameBoard',
		'aCopyOfSpaceships',
		'ruleBook'
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
BoardGame class >> withNumberOfSquares: aMaximumSquares withWormHoleFrom: anEntranceOfWormHole to: anExitOfTheWormHole [

	self isANegativeNumber: aMaximumSquares.
	self hasTheMinimumAmountOfSquares: aMaximumSquares.
	self isANegativeNumber: anEntranceOfWormHole.
	self isANegativeNumber: anExitOfTheWormHole.
	self is:anExitOfTheWormHole smallerThan:aMaximumSquares.
	^ self new
		  initializationBoardGame: aMaximumSquares
		  withWormHoleFrom: anEntranceOfWormHole
		  to: anExitOfTheWormHole
		
	

]

{ #category : 'accessing' }
BoardGame >> completedLapsBy: aSpaceShip [
 ^(aCopyOfSpaceships detect: [ :copyOfSpaceship | copyOfSpaceship isCopyOf: aSpaceShip ]) currentLap.
]

{ #category : 'accessing' }
BoardGame >> follows:aRuleBook [
ruleBook:=aRuleBook.
]

{ #category : 'accessing' }
BoardGame >> has: players [
    spaceShips := players collect: [ :player | 
        | copyOfSpaceships |
        copyOfSpaceships := player copy.
        copyOfSpaceships originalSpaceShip: player.
        copyOfSpaceships
    ].
    aCopyOfSpaceships := OrderedCollection new.
    aCopyOfSpaceships addAll: spaceShips.

]

{ #category : 'initialization' }
BoardGame >> initializationBoardGame: aNumber withWormHoleFrom: aY to: aZ [

	maximumSquares := aNumber.
	entranceOfWormHole := aY.
	exitOfWormHole := aZ
]

{ #category : 'action' }
BoardGame >> move: aSpaceShip with: dices [

	| rolledNumber |
	self thereIsAWinner ifTrue: [ ^ self ].
	rolledNumber := self rolledNumberSumOf: dices.
	aSpaceShip moveWith:rolledNumber onBoardOfSize: maximumSquares.
	"rolledNumber := self rolledNumberSumOf: dices.
	newPosition := aSpaceShip currentPosition + rolledNumber.
	lapsCompleted := newPosition // maximumSquares.
	aSpaceShip incrementLapsBy: lapsCompleted.
	
	newPositionToMove := ((newPosition - 1) \\ maximumSquares) + 1.
	aSpaceShip movesTo: newPositionToMove."
	self validateInWormHole: aSpaceShip
]

{ #category : 'accessing' }
BoardGame >> numberOfSquares [

	^ maximumSquares
]

{ #category : 'action' }
BoardGame >> playOneRound [

	aCopyOfSpaceships do: [ :aCopyOfSpaceship |
		self move: self spaceshipWhosTurnItIs with: dicesInGameBoard ]
]

{ #category : 'accessing' }
BoardGame >> positionOf: aPlayer [
    ^ (aCopyOfSpaceships detect: [ :copyOfSpaceship | copyOfSpaceship isCopyOf: aPlayer ]) currentPosition.

]

{ #category : 'sorting' }
BoardGame >> ranking [
|sortedSpaceships|
sortedSpaceships := aCopyOfSpaceships copy.
sortedSpaceships sort: [:spaceShip1 :spaceShip2 | 
  (spaceShip1 currentLap > spaceShip2 currentLap) 
  or: [(spaceShip1 currentLap = spaceShip2 currentLap) and: [spaceShip1 currentPosition > spaceShip2 currentPosition]]
].
^sortedSpaceships .
]

{ #category : 'accessing' }
BoardGame >> rolledNumberSumOf: dices [

 ^(dices collect: [ :dice | dice rolledNumber ]) sum
]

{ #category : 'accessing' }
BoardGame >> spaceshipWhosTurnItIs [ 

	| nextSpaceship |
	nextSpaceship:=aCopyOfSpaceships first.
	aCopyOfSpaceships add: nextSpaceship.
	aCopyOfSpaceships removeFirst.
	^nextSpaceship.
]

{ #category : 'accessing' }
BoardGame >> theBronzeWinnerIs [
^(self ranking third)asOriginalSpaceShip.
]

{ #category : 'accessing' }
BoardGame >> theGoldWinnerIs [
    ^ (self ranking first) asOriginalSpaceShip.

]

{ #category : 'accessing' }
BoardGame >> theSilverWinnerIs [
^(self ranking second) asOriginalSpaceShip.
]

{ #category : 'validating' }
BoardGame >> thereIsAWinner [
 ^ spaceShips anySatisfy: [:spaceShip | ruleBook hasReachedWinningLapCount:(spaceShip currentLap )]
]

{ #category : 'validating' }
BoardGame >> validateInWormHole: aSpaceShip [

	| originalPosition |
	originalPosition := aSpaceShip currentPosition.

	originalPosition = entranceOfWormHole ifTrue: [
		aSpaceShip teletransportsTo: exitOfWormHole ].

	originalPosition = exitOfWormHole ifTrue: [
		aSpaceShip teletransportsTo: entranceOfWormHole ]
]

{ #category : 'accessing' }
BoardGame >> withDices:dices [
dicesInGameBoard:=dices.
]
