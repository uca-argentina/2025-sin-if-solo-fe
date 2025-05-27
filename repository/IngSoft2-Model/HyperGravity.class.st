"
Moves the spaceship 4 spaces back. In the case that it doesn't have enough fuel, it will send it back to the start.
"
Class {
	#name : 'HyperGravity',
	#superclass : 'TileEffect',
	#instVars : [
		'tilePosition',
		'minimumRollValue'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'abstract' }
HyperGravity >> applyTo: aSpaceShip on: aGameBoard [
	^ 3.
]

{ #category : 'initialization' }
HyperGravity >> initializeHyperGravityWith:aPosition requiringMinimumRoll: aValue [
tilePosition:=aPosition .
minimumRollValue:=aValue .
]
