"
Moves the spaceship 4 spaces back. In the case that it doesn't have enough fuel, it will send it back to the start.
"
Class {
	#name : 'BlackHole',
	#superclass : 'TileEffect',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'evaluating' }
BlackHole class >> in: aPosition [
^self new initializeBlackHoleIn: aPosition.
]

{ #category : 'action' }
BlackHole >> applyConsequenceTo: allSpaceShips onBoardOfSize: aBoard [
    
| aSpaceShip|
    
    aSpaceShip := allSpaceShips detect: [ :spaceShip | spaceShip currentPosition = tilePosition ].
	aSpaceShip goBack: 4 onBoardOfSize: (aBoard numberOfSquares ).
  
]

{ #category : 'initialization' }
BlackHole >> initializeBlackHoleIn: aPosition [

tilePosition:=aPosition.
]

{ #category : 'testing' }
BlackHole >> isBlackHole [
^true.
]

{ #category : 'accessing' }
BlackHole >> position [
^tilePosition.
]

{ #category : 'validating' }
BlackHole >> validateCreationIn: boardSize and: maximumRolledNumber [


tilePosition > boardSize ifTrue: [
   Error signal: 'Tile position is out of board bounds.'.
].

]
