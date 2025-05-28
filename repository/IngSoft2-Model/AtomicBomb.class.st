"
Moves the spaceship 4 spaces back. In the case that it doesn't have enough fuel, it will send it back to the start.
"
Class {
	#name : 'AtomicBomb',
	#superclass : 'TileEffect',
	#instVars : [
		'tilePosition'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'evaluating' }
AtomicBomb class >> in: aPosition [

^self new initializeAtomicBombIn: aPosition.
]

{ #category : 'action' }
AtomicBomb >> applyConsequenceTo:allSpaceShips [
allSpaceShips do:[:spaceShip|spaceShip moveTo: 0 consuming: 0].


]

{ #category : 'action' }
AtomicBomb >> applyConsequenceTo:allSpaceShips onBoardOfSize: maximumSquares [
allSpaceShips do:[:spaceShip|spaceShip moveTo: 0 consuming: 0].


]

{ #category : 'abstract' }
AtomicBomb >> applyTo: aSpaceShip on: aGameBoard [
	^ 5.
]

{ #category : 'initialization' }
AtomicBomb >> initializeAtomicBombIn: aPosition [

tilePosition:= aPosition.
]

{ #category : 'accessing' }
AtomicBomb >> position [
^tilePosition .
]

{ #category : 'validating' }
AtomicBomb >> validateCreationIn: boardSize and: maximumRolledNumber [


tilePosition > boardSize ifTrue: [
   Error signal: 'Tile position is out of board bounds.'.
].

]
