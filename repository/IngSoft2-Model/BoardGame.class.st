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
		'aCopyOfSpaceships',
		'winnerSystem',
		'maxNumberOfDiceFaces'
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
BoardGame >> currentFuleOf: aPlayer [
    ^ (aCopyOfSpaceships detect: [ :copyOfSpaceship | copyOfSpaceship isCopyOf: aPlayer ]) currentFule.

]

{ #category : 'action' }
BoardGame >> distanceFrom: origin to: destination [
    ^ ((destination - origin + maximumSquares) rem: maximumSquares)
]

{ #category : 'accessing' }
BoardGame >> follows:aWinnerSystem [

winnerSystem:=aWinnerSystem .
winnerSystem withPotentialWinner: aCopyOfSpaceships .
]

{ #category : 'accessing' }
BoardGame >> has: players [
aCopyOfSpaceships :=players .


	
	
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
	winnerSystem thereIsAWinner ifTrue:  [ ^ self] .
	rolledNumber := self rolledNumberSumOf: dices.
	aSpaceShip moveWith:rolledNumber onBoardOfSize: maximumSquares.

	self validateInWormHole: aSpaceShip
]

{ #category : 'accessing' }
BoardGame >> numberOfSquares [

	^ maximumSquares
]

{ #category : 'action' }
BoardGame >> playOneRound [

	aCopyOfSpaceships do: [ :aSpaceShip |
		aSpaceShip verifyCanPlayAgain.
		aSpaceShip canPlay
			ifTrue: [ self move: aSpaceShip with: dicesInGameBoard ]
			ifFalse: [ aSpaceShip losesTurn ] ]
]

{ #category : 'accessing' }
BoardGame >> positionOf: aPlayer [
    ^ (aCopyOfSpaceships detect: [ :copyOfSpaceship | copyOfSpaceship isCopyOf: aPlayer ]) currentPosition.

]

{ #category : 'accessing' }
BoardGame >> rolledNumberSumOf: dices [

 ^(dices collect: [ :dice | dice rolledNumber ]) sum
]

{ #category : 'validating' }
BoardGame >> validateInWormHole: aSpaceShip [

	| originalPosition destination distance |
	originalPosition := aSpaceShip currentPosition.
	originalPosition = entranceOfWormHole ifTrue: [
		destination := exitOfWormHole.
		distance := self distanceFrom: originalPosition to: destination.
		aSpaceShip moveTo: destination consuming: distance ].

	originalPosition = exitOfWormHole ifFalse: [ ^ self ].
	destination := entranceOfWormHole.
	distance := self distanceFrom: originalPosition to: destination.
	aSpaceShip moveTo: destination consuming: distance
]

{ #category : 'accessing' }
BoardGame >> withDices:dices [

dicesInGameBoard:=dices.
maxNumberOfDiceFaces := (dicesInGameBoard collect: [:dice | dice numberOfFaces]) max.
]
