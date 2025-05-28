"
Moves the spaceship 4 spaces back. In the case that it doesn't have enough fuel, it will send it back to the start.
"
Class {
	#name : 'MoonWalk',
	#superclass : 'TileEffect',
	#instVars : [
		'amountToMoveBack',
		'tilePosition'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
MoonWalk class >> in:aPosition moveBack:anAmount [
^self new initializeMoonWalkIn: aPosition moveBack:anAmount.
]

{ #category : 'action' }
MoonWalk >> applyConsequenceTo: allSpaceShips onBoardOfSize: maximumSquares [

| affectedShips |

	affectedShips := allSpaceShips reject: [ :ship | ship currentPosition = tilePosition ].

	affectedShips do: [ :ship |
		ship goBack: amountToMoveBack onBoardOfSize: maximumSquares ].

]

{ #category : 'initialization' }
MoonWalk >> initializeMoonWalkIn: aPosition moveBack:anAmount [
tilePosition:=aPosition .
amountToMoveBack:=anAmount.

]

{ #category : 'accessing' }
MoonWalk >> position [
^tilePosition .
]

{ #category : 'validating' }
MoonWalk >> validateCreationIn: boardSize and: maximumRolledNumber [

tilePosition > boardSize ifTrue: [
   Error signal: 'Tile position is out of board bounds.'.
].

]
