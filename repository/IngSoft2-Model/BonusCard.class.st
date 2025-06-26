"
B
"
Class {
	#name : 'BonusCard',
	#superclass : 'TileEffect',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'evaluating' }
BonusCard class >> in: aPosition [

self isPositive: aPosition.
^self new initializeBonusCard: aPosition.
]

{ #category : 'testing' }
BonusCard class >> isPositive: aPosition [

(aPosition<0) ifTrue: [Error signal: 'A BonusCard has to be in a positive position' ] 
]

{ #category : 'action' }
BonusCard >> applyConsequenceTo: allSpaceShips onBoardOfSize: aBoard [

	| aSpaceShip |
	aSpaceShip := allSpaceShips detect: [ :spaceShip |
		              spaceShip currentPosition = tilePosition ].
	aBoard givesACardTo: aSpaceShip
]

{ #category : 'action' }
BonusCard >> applyEffectToSpecific: spaceship on: board [

	board givesACardTo: spaceship
]

{ #category : 'initialization' }
BonusCard >> initializeBonusCard: aPosition [

	tilePosition := aPosition
]
