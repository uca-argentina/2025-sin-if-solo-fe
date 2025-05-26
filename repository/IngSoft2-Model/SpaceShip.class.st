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
		'currentFule',
		'numberOfLostTurns',
		'initialFule'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
SpaceShip class >> inInitialPosition: aPosition [

	^ self new initializeSpaceShip: aPosition
]

{ #category : 'accessing' }
SpaceShip >> asOriginalSpaceShip [
^originalSpaceShip.
]

{ #category : 'testing' }
SpaceShip >> canPlay [

    ^ currentFule > 0 and: [ numberOfLostTurns = 0 ]

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
SpaceShip >> initialFule: ainitialFule [
	currentFule := ainitialFule.
	initialFule := ainitialFule.

]

{ #category : 'initialization' }
SpaceShip >> initializeSpaceShip: aPosition [
	laps:=0.
	currentPosition := aPosition.
	numberOfLostTurns:=0.
]

{ #category : 'testing' }
SpaceShip >> isCopyOf: aPlayer [
    ^ originalSpaceShip == aPlayer.
]

{ #category : 'action' }
SpaceShip >> losesTurn [
	
	numberOfLostTurns := numberOfLostTurns + 1.

]

{ #category : 'action' }
SpaceShip >> moveTo: newPosition consuming: aDistance [

	currentFule := currentFule - aDistance.
	currentPosition := newPosition
]

{ #category : 'action' }
SpaceShip >> moveWith: rolledNumber onBoardOfSize: maximumSquares [

	| totalPosition lapsDone newPosition  |
	totalPosition := currentPosition + rolledNumber.
	lapsDone := totalPosition quo: maximumSquares.
	laps := lapsDone.
	newPosition := (totalPosition - 1 rem: maximumSquares) + 1.
	self moveTo: newPosition consuming: rolledNumber.	
	self validateCurrentFule
]

{ #category : 'accessing' }
SpaceShip >> originalSpaceShip: aPlayer [
    originalSpaceShip := aPlayer.
]

{ #category : 'action' }
SpaceShip >> rechargeFule [
currentFule :=initialFule .
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
    self moveTo: 0 consuming:0.
    currentFule := 0.

]

{ #category : 'action' }
SpaceShip >> verifyCanPlayAgain [

	numberOfLostTurns = 2 ifFalse: [ ^ self ].
	numberOfLostTurns := 0.
	self rechargeFule.
]
