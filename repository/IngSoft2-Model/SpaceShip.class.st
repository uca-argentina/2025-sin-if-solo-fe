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
		'minimumRollRequired',
		'fuelSistem',
		'turn'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
SpaceShip class >> withA: position andTurn: anOrderNumber startingWith: aFuel [
    ^ self new initializeWithA: position andTurn: anOrderNumber startingWith: aFuel
]

{ #category : 'action' }
SpaceShip >> adjustLapBy: anAmount [
laps:=laps+anAmount.
]

{ #category : 'accessing' }
SpaceShip >> asOriginalSpaceShip [
^originalSpaceShip.
]

{ #category : 'testing' }
SpaceShip >> canMoveWith: rolledNumber [

    ^ rolledNumber >= minimumRollRequired .
]

{ #category : 'testing' }
SpaceShip >> canPlay [

    ^ fuelSistem current > 0 and: [ turn numberOfLostTurns = 0 ]

]

{ #category : 'accessing' }
SpaceShip >> currentFule [
^fuelSistem current 
]

{ #category : 'accessing' }
SpaceShip >> currentLap [
^laps
]

{ #category : 'accessing' }
SpaceShip >> currentPosition [

	^ currentPosition
]

{ #category : 'action' }
SpaceShip >> goBack: amountToMoveBack onBoardOfSize: maximumSquares [

	| aPositionToMove amountOfFuel |
	amountOfFuel := amountToMoveBack.
	aPositionToMove := self currentPosition - amountToMoveBack.

	aPositionToMove < 0 ifTrue: [
		aPositionToMove := maximumSquares - aPositionToMove abs.
		self adjustLapBy: -1 ].

	self currentLap < 0 ifTrue: [
		amountOfFuel := amountOfFuel
		                + (self currentPosition - amountToMoveBack).
		aPositionToMove := 0.
		self adjustLapBy: 1 ].

	self moveTo: aPositionToMove consuming: amountOfFuel.
	fuelSistem validateCurrentFuleOf: self 
]

{ #category : 'initialization' }
SpaceShip >> initializeWithA: position andTurn: aTurn startingWith: aFuel [

    currentPosition := position.
    turn:= aTurn .
    fuelSistem := aFuel.
    laps := 0.
    minimumRollRequired := 0.


]

{ #category : 'testing' }
SpaceShip >> isCopyOf: aPlayer [
    ^ originalSpaceShip == aPlayer.
]

{ #category : 'action' }
SpaceShip >> losesRound [
  turn roundLosed.


]

{ #category : 'action' }
SpaceShip >> moveTo: newPosition consuming: aDistance [
	
	fuelSistem consume: aDistance.
	
	currentPosition := newPosition.
	
	fuelSistem hasFuel ifFalse: [self losesRound ] .

]

{ #category : 'action' }
SpaceShip >> moveWith: rolledNumber onBoardOfSize: maximumSquares [
 | totalPosition lapsDone newPosition  |


	totalPosition := currentPosition + rolledNumber.
	lapsDone := totalPosition quo: maximumSquares.
	laps := lapsDone.
	
	newPosition := (totalPosition - 1 rem: maximumSquares) + 1.
	
	self moveTo: newPosition consuming: rolledNumber.	
	fuelSistem validateCurrentFuleOf: self.
]

{ #category : 'accessing' }
SpaceShip >> originalSpaceShip: aPlayer [
    originalSpaceShip := aPlayer.
]

{ #category : 'action' }
SpaceShip >> preventMovingUntilRollsAtLeast: aNumber [
    minimumRollRequired := aNumber.

]

{ #category : 'action' }
SpaceShip >> ranksHigherThan: oponentSpaceship [

	^ self currentLap > oponentSpaceship currentLap or: [
		  self currentLap = oponentSpaceship currentLap and: [
			  self currentPosition > oponentSpaceship currentPosition or: [
				  self currentPosition = oponentSpaceship currentPosition and: [
					  (self turnOrder) < oponentSpaceship turnOrder ] ] ] ]
]

{ #category : 'action' }
SpaceShip >> rechargeFule [ 

fuelSistem recharge 
]

{ #category : 'accessing' }
SpaceShip >> turnOrder [
^ turn turnOrder 
]

{ #category : 'action' }
SpaceShip >> verifyCanPlayAgain [
	turn lostTurnsVerifier.


]
