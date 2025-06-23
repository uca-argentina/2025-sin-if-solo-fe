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
^self new initializeBonusCard: aPosition.
]

{ #category : 'action' }
BonusCard >> applyConsequenceTo: allSpaceShips onBoardOfSize: aBoard [
    
    | aSpaceShip |
		aSpaceShip := allSpaceShips detect: [ :spaceShip | spaceShip currentPosition = tilePosition ].
		aBoard givesACardTo: aSpaceShip.
	
  
]

{ #category : 'initialization' }
BonusCard >> initializeBonusCard: aPosition [

tilePosition:=aPosition.

]
