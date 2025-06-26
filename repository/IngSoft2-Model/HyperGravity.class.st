"
Moves the spaceship 4 spaces back. In the case that it doesn't have enough fuel, it will send it back to the start.
"
Class {
	#name : 'HyperGravity',
	#superclass : 'TileEffect',
	#instVars : [
		'minimumRollValue'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
HyperGravity class >> in: aPosition requiringMinimumRoll: aValue [

^self new initializeHyperGravityWith:aPosition requiringMinimumRoll: aValue.
]

{ #category : 'action' }
HyperGravity >> applyConsequenceTo: allSpaceShips onBoardOfSize: aBoard [

	| aSpaceShip |
	aSpaceShip := allSpaceShips detect: [ :spaceShip |
		              spaceShip currentPosition = tilePosition ].
	aSpaceShip preventMovingUntilRollsAtLeast: minimumRollValue
]

{ #category : 'action' }
HyperGravity >> applyEffectToSpecific: spaceship on: board [

	spaceship preventMovingUntilRollsAtLeast: minimumRollValue
]

{ #category : 'initialization' }
HyperGravity >> initializeHyperGravityWith: aPosition requiringMinimumRoll: aValue [

	tilePosition := aPosition.
	minimumRollValue := aValue
]

{ #category : 'validating' }
HyperGravity >> validateCreationIn: boardSize and: maximumRolledNumber [

	super validateCreationIn: boardSize and: maximumRolledNumber.

	minimumRollValue > maximumRolledNumber ifTrue: [
		Error signal:
			'The Requiring Minimum Roll Must Be Less Than Maximum Rolled Number' ]
]
