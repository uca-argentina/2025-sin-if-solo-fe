"
Moves the spaceship 4 spaces back. In the case that it doesn't have enough fuel, it will send it back to the start.
"
Class {
	#name : 'BlackHole',
	#superclass : 'TileEffect',
	#instVars : [
		'tilePosition'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'evaluating' }
BlackHole class >> in: aPosition [
^self new initializeBlackHoleIn: aPosition.
]

{ #category : 'action' }
BlackHole >> applyConsequenceTo:allSpaceShips [

| aSpaceShip |
aSpaceShip:= allSpaceShips detect:[:spaceShip | spaceShip currentPosition = tilePosition ].
aSpaceShip moveTo: (aSpaceShip currentPosition - 4) consuming: 4.
aSpaceShip validateCurrentFule.



]

{ #category : 'action' }
BlackHole >> applyConsequenceTo: allSpaceShips onBoardOfSize: maximumSquares [
    
| aSpaceShip aPositionToMove amountOfFuel |
    
    aSpaceShip := allSpaceShips detect: [ :spaceShip | spaceShip currentPosition = tilePosition ].
    aPositionToMove := aSpaceShip currentPosition - 4.
    amountOfFuel := 4.

    (aPositionToMove < 0) ifTrue: [
        aPositionToMove := maximumSquares - (aPositionToMove abs).
        aSpaceShip adjustLapBy: -1.].

    (aSpaceShip currentLap < 0) ifTrue: [
        amountOfFuel := amountOfFuel + (aSpaceShip currentPosition - 4).
        aPositionToMove := 0.
        aSpaceShip adjustLapBy: 1.].

    aSpaceShip moveTo: aPositionToMove consuming: amountOfFuel.
    aSpaceShip validateCurrentFule.

]

{ #category : 'abstract' }
BlackHole >> applyTo: aSpaceShip on: aGameBoard [
	^ 1.
]

{ #category : 'initialization' }
BlackHole >> initializeBlackHoleIn: aPosition [

tilePosition:=aPosition.
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
