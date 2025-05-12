"
Board Game
"
Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'maximumSquares',
		'spaceShips',
		'wormhole'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Board class >> withNumberOfSquares: aNumber [ 
	^self new initializationBoardGame: aNumber .
]

{ #category : 'wormhole' }
Board >> applyWormholeTo: aSpaceship [
	| position newPosition |
	wormhole ifNil: [ ^ self ].
	
	position := aSpaceship currentPosition.
	(wormhole hasEndAt: position) ifFalse: [ ^ self ].
	
	newPosition := wormhole transportFrom: position.
	aSpaceship moveTo: newPosition.
]

{ #category : 'accessing' }
Board >> has: players [

spaceShips := OrderedCollection new.

spaceShips := players.
]

{ #category : 'initialization' }
Board >> initializationBoardGame: aNumber [
	maximumSquares:= aNumber.
	wormhole := nil.
]

{ #category : 'action' }
Board >> move: aSpaceShip with: dices [

	self validateIsGameOver: aSpaceShip.
	aSpaceShip rolls: dices.
	self applyWormholeTo: aSpaceShip.
]

{ #category : 'accessing' }
Board >> numberOfSquares [
	^maximumSquares .
]

{ #category : 'accessing' }
Board >> positionOf: aPlayer [
^ aPlayer currentPosition.
 
]

{ #category : 'wormhole' }
Board >> setWormhole: aWormhole [
	wormhole := aWormhole.
]

{ #category : 'accessing' }
Board >> theWinnerIs [

   ^(spaceShips select: [:spaceShip | spaceShip currentPosition >= self numberOfSquares]) anyOne.

]

{ #category : 'validating existence' }
Board >> thereIsAWinner [
^ spaceShips anySatisfy: [:spaceShip | spaceShip currentPosition >= self numberOfSquares].

]

{ #category : 'event testing' }
Board >> validateIsGameOver:aSpaceShip [ 

(self thereIsAWinner  ) ifTrue: [
	Error signal: 'Game is Over']
]
