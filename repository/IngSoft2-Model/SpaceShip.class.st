"
Class: SpaceShip
                                                                                                    
Class SpaceShip
"
Class {
	#name : 'SpaceShip',
	#superclass : 'Object',
	#instVars : [
		'currentPosition',
		'laps',
		'minimumRollRequired',
		'fuelSistem',
		'name',
		'lostTurns',
		'cardsInHand',
		'aPositionToMove'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
SpaceShip class >> named: aName [ 
    ^ self new initializeWtihAName:aName.
]

{ #category : 'comparing' }
SpaceShip >> = anotherSpaceShip [

	^ name = anotherSpaceShip name
]

{ #category : 'action' }
SpaceShip >> actualLapsDone: lapsDone [

	laps := lapsDone
]

{ #category : 'action' }
SpaceShip >> adjustLapBy: anAmount [

	laps := laps + anAmount
]

{ #category : 'testing' }
SpaceShip >> canMoveWith: rolledNumber [

	^ rolledNumber >= minimumRollRequired
]

{ #category : 'testing' }
SpaceShip >> canPlay [

	^ fuelSistem hasFuelToPlay and: [ lostTurns = 0 ]
]

{ #category : 'accessing' }
SpaceShip >> cardsInHand [

	^ cardsInHand
]

{ #category : 'action' }
SpaceShip >> consumesFule [

	fuelSistem consume: 1
]

{ #category : 'accessing' }
SpaceShip >> currentFule [

	^ fuelSistem current
]

{ #category : 'accessing' }
SpaceShip >> currentLap [

	^ laps
]

{ #category : 'accessing' }
SpaceShip >> currentPosition [

	^ currentPosition
]

{ #category : 'initialization' }
SpaceShip >> equipWith: aCard [

	cardsInHand add: aCard
]

{ #category : 'accessing' }
SpaceShip >> fuelSystem [

	^ fuelSistem
]

{ #category : 'action' }
SpaceShip >> goBack: amountToMoveBack onBoardOfSize: maximumSquares [

	| amountOfFuel |
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

{ #category : 'testing' }
SpaceShip >> has: fuel [

	fuelSistem := fuel
]

{ #category : 'testing' }
SpaceShip >> hasFule [

	^ fuelSistem validateCurrentFuleOf: self
]

{ #category : 'initialization' }
SpaceShip >> initializeWtihAName: aName [

	name := aName.
	cardsInHand := OrderedCollection new.
	currentPosition := 0.
	aPositionToMove := 0.
	fuelSistem := 0.
	lostTurns := 0.
	laps := 0.
	minimumRollRequired := 0
]

{ #category : 'action' }
SpaceShip >> losesOneRound [

	lostTurns := 2
]

{ #category : 'action' }
SpaceShip >> losesTwoRounds [

	lostTurns := lostTurns + 1
]

{ #category : 'action' }
SpaceShip >> moveTo: newPosition consuming: aDistance [

	fuelSistem consume: aDistance.

	currentPosition := newPosition.
	fuelSistem hasFuelToPlay ifFalse: [ self losesTwoRounds ]
]

{ #category : 'accessing' }
SpaceShip >> name [

	^ name
]

{ #category : 'action' }
SpaceShip >> preventMovingUntilRollsAtLeast: aNumber [

	minimumRollRequired := aNumber
]

{ #category : 'action' }
SpaceShip >> ranksHigherThan: oponentSpaceship [

	^ self currentLap > oponentSpaceship currentLap or: [
		  self currentLap = oponentSpaceship currentLap and: [
			  self currentPosition > oponentSpaceship currentPosition or: [
				  self currentPosition = oponentSpaceship currentPosition ] ] ]
]

{ #category : 'action' }
SpaceShip >> rechargeFule [

	fuelSistem recharge
]

{ #category : 'removing' }
SpaceShip >> removeCard: aCard [

	cardsInHand remove: aCard
]

{ #category : 'action' }
SpaceShip >> sharesFuleWith: anotherSpaceShip [

	fuelSistem sharesFuleWith: anotherSpaceShip fuelSystem
]

{ #category : 'action' }
SpaceShip >> verifyCanPlayAgain [

	lostTurns = 2 ifFalse: [ ^ self ].
	lostTurns := 0
]
