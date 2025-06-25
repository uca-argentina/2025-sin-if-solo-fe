"
Moves the spaceship 4 spaces back. In the case that it doesn't have enough fuel, it will send it back to the start.
"
Class {
	#name : 'AtomicBomb',
	#superclass : 'TileEffect',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'evaluating' }
AtomicBomb class >> in: aPosition [

^self new initializeAtomicBombIn: aPosition.
]

{ #category : 'action' }
AtomicBomb >> applyConsequenceTo: allSpaceShips onBoardOfSize: aBoard [

	allSpaceShips do: [ :spaceShip | spaceShip moveTo: 0 consuming: 0 ]
]

{ #category : 'action' }
AtomicBomb >> applyEffectToSpecific: spaceship on: board [

	spaceship moveTo: 0 consuming: 0
]

{ #category : 'initialization' }
AtomicBomb >> initializeAtomicBombIn: aPosition [

	tilePosition := aPosition
]
