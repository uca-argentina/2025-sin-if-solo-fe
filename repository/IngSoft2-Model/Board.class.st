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
		'exitOfWormHole'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Board class >> withNumberOfSquares: aNumber withWormHoleFrom: aY to:aZ [
	^self new initializationBoardGame: aNumber withWormHoleFrom:aY to: aZ .
]

{ #category : 'accessing' }
Board >> has: players [

spaceShips := OrderedCollection new.

spaceShips := players.
]

{ #category : 'initialization' }
Board >> initializationBoardGame: aNumber withWormHoleFrom:aY to: aZ [
	maximumSquares:= aNumber.
	entranceOfWormHole:= aY.
	exitOfWormHole:=aZ.
]

{ #category : 'action' }
Board >> move:aSpaceShip with:dices [
self validateIsGameOver:aSpaceShip.
aSpaceShip rolls:dices.
self validateInWormHole:aSpaceShip .






]

{ #category : 'accessing' }
Board >> numberOfSquares [
	^maximumSquares .
]

{ #category : 'accessing' }
Board >> positionOf: aPlayer [
^ aPlayer currentPosition.
 
]

{ #category : 'accessing' }
Board >> theWinnerIs [

   ^(spaceShips select: [:spaceShip | spaceShip currentPosition >= self numberOfSquares]) anyOne.

]

{ #category : 'validating existence' }
Board >> thereIsAWinner [
^ spaceShips anySatisfy: [:spaceShip | spaceShip currentPosition >= self numberOfSquares].

]

{ #category : 'validating' }
Board >> validateInWormHole: aSpaceShip [
| posOriginal |
posOriginal := aSpaceShip currentPosition.

(posOriginal = entranceOfWormHole)
    ifTrue: [ aSpaceShip teletransportsTo: exitOfWormHole ].

(posOriginal = exitOfWormHole)
    ifTrue: [ aSpaceShip teletransportsTo: entranceOfWormHole ].

]

{ #category : 'event testing' }
Board >> validateIsGameOver:aSpaceShip [ 

(self thereIsAWinner  ) ifTrue: [
	
	Error signal: 'Game is Over'.]
]
