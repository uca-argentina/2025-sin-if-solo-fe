Class {
	#name : 'SpaceShipMovementsTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
SpaceShipMovementsTest >> test0WhenTheGamesBeginsThenTheSpaceShipIsInTheInitialPosition [

|aPlayer1|
aPlayer1:=SpaceShip inInitialPosition: 0.

self assert:aPlayer1 currentPosition equals: 0.
]

{ #category : 'tests' }
SpaceShipMovementsTest >> test1WhenTheSpaceShipMovesThenItsPositionChanges [

 | aPlayer1   |
	aPlayer1:=SpaceShip inInitialPosition: 0.
	aPlayer1 movesTo: 1.
	
	self assert:aPlayer1 currentPosition equals: 1.
]

{ #category : 'tests' }
SpaceShipMovementsTest >> test2WhenTwoSpaceShipsMoveThenTheirPositionChanges [

	| aPlayer1 aPlayer2|

	aPlayer1 := SpaceShip inInitialPosition: 0.
	aPlayer2 := SpaceShip inInitialPosition: 0.

	aPlayer1 movesTo: 4.
	aPlayer2 movesTo: 5.


	self assert: aPlayer1 currentPosition equals: 4.
	self assert: aPlayer2 currentPosition equals: 5.
]
