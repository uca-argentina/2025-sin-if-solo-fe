"
Class: SpaceShip
                                                                                                    
Class SpaceShip
"
Class {
	#name : 'SpaceShip',
	#superclass : 'Object',
	#instVars : [
		'currentPosition',
		'originalSpaceShip',
		'laps',
		'numberOfOrderToPlay',
		'currentFule'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
SpaceShip class >> inInitialPosition: aPosition [

	^ self new initializePosition: aPosition
]

{ #category : 'accessing' }
SpaceShip >> asOriginalSpaceShip [
^originalSpaceShip.
]

{ #category : 'accessing' }
SpaceShip >> currentFule [
^currentFule 
]

{ #category : 'accessing' }
SpaceShip >> currentLap [
^laps
]

{ #category : 'accessing' }
SpaceShip >> currentPosition [

	^ currentPosition
]

{ #category : 'accessing' }
SpaceShip >> initialFule:initialFule [
currentFule:=initialFule .
]

{ #category : 'initialization' }
SpaceShip >> initializePosition: aPosition [
	laps:=0.
	currentPosition := aPosition
]

{ #category : 'testing' }
SpaceShip >> isCopyOf: aPlayer [
    ^ originalSpaceShip == aPlayer.
]

{ #category : 'action' }
SpaceShip >> moveWith:rolledNumber onBoardOfSize: maximumSquares [
| totalPosition lapsDone newPosition |

	totalPosition := currentPosition + rolledNumber.
	currentFule :=currentFule - rolledNumber.
	lapsDone := totalPosition quo: maximumSquares.
	
	laps:= lapsDone .
	newPosition := ((totalPosition - 1) rem: maximumSquares) + 1.
	self movesTo: newPosition.
	self validateCurrentFule.
]

{ #category : 'action' }
SpaceShip >> movesTo: newPosition [
   
    currentPosition := newPosition.


]

{ #category : 'accessing' }
SpaceShip >> originalSpaceShip: aPlayer [
    originalSpaceShip := aPlayer.
]

{ #category : 'action' }
SpaceShip >> teletransportsTo: aWormHoleSquare [

	currentPosition := aWormHoleSquare
]

{ #category : 'accessing' }
SpaceShip >> turnOrder [
^numberOfOrderToPlay
]

{ #category : 'assignments' }
SpaceShip >> turnOrder: aNumberOfOrderToPlay [
numberOfOrderToPlay:=aNumberOfOrderToPlay.
]

{ #category : 'validating' }
SpaceShip >> validateCurrentFule [

	(currentFule <= 0) ifFalse: [ ^ self ].
	self movesTo: 0.
	currentFule := 0
]
